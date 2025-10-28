#include "Solver.h"
#include "utils/Logger.h"
#include "utils/Config.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cstdio>
#include <cstdlib>
#include <csignal>
#include <filesystem>
#include <fstream>
#include <stdexcept>
#include <sstream>
#include <string>
#include <vector>

#include <sys/wait.h>
#include <unistd.h>

namespace strp {

ExternalSolver::ExternalSolver(SolverType type, int timeoutSeconds)
    : solverType(type), timeout(timeoutSeconds) {
    solverPath = getSolverPath();
    DEBUG("ExternalSolver initialized with type: ", static_cast<int>(type), " and timeout: ", timeout);
}

ExternalSolver::~ExternalSolver() = default;

std::string ExternalSolver::getSolverPath() const {
    std::filesystem::path scriptPath;

    switch (solverType) {
        case SolverType::Z3:
            scriptPath = strp::config::z3ScriptPath();
            break;
        case SolverType::CVC5:
            scriptPath = strp::config::cvc5ScriptPath();
            break;
        case SolverType::OSTRICH:
            scriptPath = strp::config::ostrichScriptPath();
            break;
        case SolverType::Z3_NOODLER:
            scriptPath = strp::config::z3NoodlerScriptPath();
            break;
        default:
            throw std::runtime_error("Unknown solver type");
    }

    if (scriptPath.empty() || !std::filesystem::exists(scriptPath)) {
        std::stringstream ss;
        ss << "Solver launcher not found at '" << scriptPath.string() << std::endl;
        throw std::runtime_error(ss.str());
    }

    return scriptPath.string();
}

std::string ExternalSolver::createTempFile(const std::string& content) const {
    char tempTemplate[] = "/tmp/smt2_XXXXXX";
    int fd = mkstemp(tempTemplate);
    if (fd == -1) {
        ERROR("Failed to create temporary file");
        throw std::runtime_error("Failed to create temporary file");
    }

    std::string tempFile(tempTemplate);
    tempFile += ".smt2";

    close(fd);
    unlink(tempTemplate);

    std::ofstream file(tempFile);
    if (!file.is_open()) {
        ERROR("Failed to open temporary file: ", tempFile);
        throw std::runtime_error("Failed to open temporary file");
    }

    file << content;
    file.close();

    DEBUG("Created temporary file: ", tempFile);
    return tempFile;
}

void ExternalSolver::deleteTempFile(const std::string& filename) const {
    if (std::remove(filename.c_str()) != 0) {
        WARN("Failed to delete temporary file: ", filename);
    } else {
        DEBUG("Deleted temporary file: ", filename);
    }
}

SatResult ExternalSolver::executeExternalSolver(const std::string& tempFile) const {
    std::string command = solverPath + " " + std::to_string(timeout) + " " + tempFile;
    DEBUG("Executing command: ", command);

    std::array<char, 128> buffer;
    std::string result;

    FILE* pipe = popen(command.c_str(), "r");
    if (!pipe) {
        ERROR("Failed to execute external solver");
        return SatResult::ERROR;
    }

    while (fgets(buffer.data(), buffer.size(), pipe) != nullptr) {
        result += buffer.data();
    }

    int waitStatus = pclose(pipe);
    if (waitStatus == -1) {
        ERROR("Failed to retrieve external solver status");
        return SatResult::ERROR;
    }

    int exitCode = -1;
    int signalNumber = 0;
    if (WIFEXITED(waitStatus)) {
        exitCode = WEXITSTATUS(waitStatus);
    }
    if (WIFSIGNALED(waitStatus)) {
        signalNumber = WTERMSIG(waitStatus);
    }

    DEBUG("External solver output: ", result);
    DEBUG("External solver wait status: ", waitStatus, " exit code: ", exitCode, " signal: ", signalNumber);

    std::string normalizedResult = result;
    std::transform(normalizedResult.begin(), normalizedResult.end(), normalizedResult.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });

    auto containsToken = [&](const std::string& token) {
        return normalizedResult.find(token) != std::string::npos;
    };

    bool timeoutDetected = false;
    if (exitCode == 124 || exitCode == 137 || exitCode == 143) {
        timeoutDetected = true;
    }
    if (signalNumber == SIGTERM || signalNumber == SIGKILL) {
        timeoutDetected = true;
    }

    if (timeoutDetected) {
        WARN("External solver timeout");
        return SatResult::UNKNOWN;
    }

    if (containsToken("unsat")) {
        return SatResult::UNSAT;
    }
    if (containsToken("sat")) {
        return SatResult::SAT;
    }
    if (containsToken("unknown")) {
        return SatResult::UNKNOWN;
    }

    return SatResult::ERROR;
}

std::string ExternalSolver::buildCurrentFormula() const {
    std::stringstream ss;
    ss << currentFormula;
    for (const auto& assertion : currentAssertions) {
        ss << assertion << "\n";
    }
    return ss.str();
}

SatResult ExternalSolver::checkSat(const std::string& formula) {
    currentFormula = formula;
    currentAssertions.clear();

    std::string tempFile = createTempFile(formula);
    SatResult result = executeExternalSolver(tempFile);
    deleteTempFile(tempFile);

    return result;
}

SatResult ExternalSolver::checkSatIncremental(const std::string& assertion) {
    currentAssertions.push_back(assertion);

    std::string fullFormula = buildCurrentFormula();
    std::string tempFile = createTempFile(fullFormula);
    SatResult result = executeExternalSolver(tempFile);
    deleteTempFile(tempFile);

    return result;
}

void ExternalSolver::addAssertion(const std::string& assertion) {
    currentAssertions.push_back(assertion);
    DEBUG("Added assertion: ", assertion);
}

SatResult ExternalSolver::checkSat() {
    std::string fullFormula = buildCurrentFormula();
    std::string tempFile = createTempFile(fullFormula);
    SatResult result = executeExternalSolver(tempFile);
    deleteTempFile(tempFile);

    return result;
}

void ExternalSolver::push() {
    DEBUG("External solver push() - not implemented for external solvers");
}

void ExternalSolver::pop() {
    if (!currentAssertions.empty()) {
        currentAssertions.pop_back();
        DEBUG("External solver pop() - removed last assertion");
    }
}

void ExternalSolver::reset() {
    currentAssertions.clear();
    currentFormula.clear();
    DEBUG("External solver reset");
}

std::string ExternalSolver::getModel() {
    std::string fullFormula = buildCurrentFormula();

    // Remove any existing (exit) commands that would prevent get-model from running
    size_t exitPos = fullFormula.find("(exit)");
    while (exitPos != std::string::npos) {
        fullFormula.erase(exitPos, 6);
        exitPos = fullFormula.find("(exit)");
    }

    // Add get-model if not present
    if (fullFormula.find("(get-model)") == std::string::npos) {
        fullFormula += "\n(get-model)\n";
    }

    std::string tempFile = createTempFile(fullFormula);

    std::string command = solverPath + " " + std::to_string(timeout) + " " + tempFile;
    DEBUG("Executing command for model: ", command);

    std::array<char, 128> buffer;
    std::string result;

    FILE* pipe = popen(command.c_str(), "r");
    if (!pipe) {
        ERROR("Failed to execute external solver for model");
        deleteTempFile(tempFile);
        return "";
    }

    while (fgets(buffer.data(), buffer.size(), pipe) != nullptr) {
        result += buffer.data();
    }

    pclose(pipe);
    deleteTempFile(tempFile);

    DEBUG("Raw solver output for model: ", result);

    // Extract model from various output formats
    size_t modelStart = std::string::npos;

    // Look for standard SMT-LIB model format: "(\n  (define-fun ...)"
    size_t stdModelStart = result.find("(\n  (define-fun");
    if (stdModelStart != std::string::npos) {
        modelStart = stdModelStart;
    } else {
        // Look for alternative format: "(define-fun"
        size_t altModelStart = result.find("(define-fun");
        if (altModelStart != std::string::npos) {
            modelStart = altModelStart;
        } else {
            // Look for OSTRICH format: "(model"
            size_t ostrichModelStart = result.find("(model");
            if (ostrichModelStart != std::string::npos) {
                modelStart = ostrichModelStart;
            } else {
                // Look for any opening parenthesis after "sat"
                size_t satPos = result.find("sat");
                if (satPos != std::string::npos) {
                    size_t afterSat = result.find("(", satPos);
                    if (afterSat != std::string::npos) {
                        modelStart = afterSat;
                    }
                }
            }
        }
    }

    if (modelStart != std::string::npos) {
        std::string model = result.substr(modelStart);

        // Clean up extra output from ostrich (like timing info)
        size_t endPos = model.rfind(")");
        if (endPos != std::string::npos) {
            model = model.substr(0, endPos + 1);
        }

        DEBUG("Extracted model: ", model);
        return model;
    }

    DEBUG("No model found in output: ", result);
    return "";
}

std::string ExternalSolver::getUnsatCore() {
    DEBUG("External solver getUnsatCore() - limited support");
    return "";
}

void dumpSMTLIB2(const SMTParser::NodePtr& node, std::stringstream& ss) {
    if (node->isLeaf()) {
        ss << node->getName();
    } else {
        ss << "(" << SMTParser::kindToString(node->getKind());
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            ss << " ";
            dumpSMTLIB2(node->getChild(i), ss);
        }
        ss << ")";
    }
}

} // namespace strp

#include "Solver.h"
#include "utils/Config.h"
#include "utils/Logger.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cerrno>
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

#include <sys/wait.h>
#include <unistd.h>

namespace strp {

namespace {
struct ExternalProcessResult {
  std::string output;
  int waitStatus = -1;
  int exitCode = -1;
  int signalNumber = 0;
};

ExternalProcessResult runExternalProcess(const std::vector<std::string> &argv) {
  if (argv.empty()) {
    throw std::runtime_error("runExternalProcess: empty argv");
  }

  int pipefd[2];
  if (pipe(pipefd) != 0) {
    throw std::runtime_error("Failed to create pipe for external solver");
  }

  pid_t pid = fork();
  if (pid < 0) {
    close(pipefd[0]);
    close(pipefd[1]);
    throw std::runtime_error("Failed to fork for external solver");
  }

  if (pid == 0) {
    // Child process: redirect stdout/stderr to pipe, then exec.
    dup2(pipefd[1], STDOUT_FILENO);
    dup2(pipefd[1], STDERR_FILENO);
    close(pipefd[0]);
    close(pipefd[1]);

    std::vector<char *> args;
    args.reserve(argv.size() + 1);
    for (const auto &arg : argv) {
      args.push_back(const_cast<char *>(arg.c_str()));
    }
    args.push_back(nullptr);

    execv(args[0], args.data());

    // If execv fails, write a short message to the redirected stderr and exit.
    const char *err = std::strerror(errno);
    std::string msg = "Failed to exec external solver: ";
    msg += (err ? err : "unknown error");
    msg += "\n";
    (void)write(STDERR_FILENO, msg.c_str(), msg.size());
    _exit(127);
  }

  // Parent process: read combined stdout/stderr from pipe.
  close(pipefd[1]);

  std::string output;
  std::array<char, 4096> buffer;
  while (true) {
    ssize_t n = read(pipefd[0], buffer.data(), buffer.size());
    if (n > 0) {
      output.append(buffer.data(), static_cast<size_t>(n));
      continue;
    }
    if (n == 0) {
      break;
    }
    if (errno == EINTR) {
      continue;
    }
    break;
  }
  close(pipefd[0]);

  int status = -1;
  if (waitpid(pid, &status, 0) < 0) {
    status = -1;
  }

  ExternalProcessResult result;
  result.output = std::move(output);
  result.waitStatus = status;
  if (status != -1) {
    if (WIFEXITED(status)) {
      result.exitCode = WEXITSTATUS(status);
    }
    if (WIFSIGNALED(status)) {
      result.signalNumber = WTERMSIG(status);
    }
  }
  return result;
}
} // namespace

ExternalSolver::ExternalSolver(SolverType type, int timeoutSeconds)
    : solverType(type), timeout(timeoutSeconds) {
  solverPath = getSolverPath();
  DEBUG("ExternalSolver initialized with type: ", static_cast<int>(type),
        " and timeout: ", timeout);
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

std::string ExternalSolver::createTempFile(const std::string &content) const {
  char tempTemplate[] = "/tmp/smt2_XXXXXX.smt2";
  int fd = mkstemps(tempTemplate, 5);
  if (fd == -1) {
    ERROR("Failed to create temporary file");
    throw std::runtime_error("Failed to create temporary file");
  }

  std::string tempFile(tempTemplate);

  const char *data = content.data();
  size_t remaining = content.size();
  while (remaining > 0) {
    ssize_t written = write(fd, data, remaining);
    if (written < 0) {
      if (errno == EINTR) {
        continue;
      }
      close(fd);
      ERROR("Failed to write to temporary file: ", tempFile);
      throw std::runtime_error("Failed to write to temporary file");
    }
    data += written;
    remaining -= static_cast<size_t>(written);
  }

  close(fd);

  DEBUG("Created temporary file: ", tempFile);
  return tempFile;
}

void ExternalSolver::deleteTempFile(const std::string &filename) const {
  const char *keepEnv = std::getenv("STRP_KEEP_TEMP_SMT");
  if (keepEnv && std::string_view(keepEnv) == "1") {
    DEBUG(
        "Skipping deletion of temporary SMT file due to STRP_KEEP_TEMP_SMT=1: ",
        filename);
    return;
  }

  if (std::remove(filename.c_str()) != 0) {
    WARN("Failed to delete temporary file: ", filename);
  } else {
    DEBUG("Deleted temporary file: ", filename);
  }
}

SatResult
ExternalSolver::executeExternalSolver(const std::string &tempFile) const {
  std::vector<std::string> argv = {solverPath, std::to_string(timeout),
                                   tempFile};
  DEBUG("Executing external solver: ", solverPath, " ", timeout, " ", tempFile);

  ExternalProcessResult procResult;
  try {
    procResult = runExternalProcess(argv);
  } catch (const std::exception &e) {
    ERROR("Failed to execute external solver: ", e.what());
    return SatResult::ERROR;
  }

  DEBUG("External solver output: ", procResult.output);
  DEBUG("External solver wait status: ", procResult.waitStatus,
        " exit code: ", procResult.exitCode,
        " signal: ", procResult.signalNumber);

  std::string normalizedResult = procResult.output;
  std::transform(normalizedResult.begin(), normalizedResult.end(),
                 normalizedResult.begin(), [](unsigned char ch) {
                   return static_cast<char>(std::tolower(ch));
                 });

  bool timeoutDetected = false;
  if (procResult.exitCode == 124 || procResult.exitCode == 137 ||
      procResult.exitCode == 143) {
    timeoutDetected = true;
  }
  if (procResult.signalNumber == SIGTERM ||
      procResult.signalNumber == SIGKILL) {
    timeoutDetected = true;
  }

  if (timeoutDetected) {
    WARN("External solver timeout");
    return SatResult::UNKNOWN;
  }

  std::stringstream ss(normalizedResult);
  std::string line;
  while (std::getline(ss, line)) {
    size_t first = line.find_first_not_of(" \t\r\n");
    if (first == std::string::npos)
      continue;
    size_t last = line.find_last_not_of(" \t\r\n");
    std::string trimmed = line.substr(first, (last - first + 1));

    if (trimmed == "sat")
      return SatResult::SAT;
    if (trimmed == "unsat")
      return SatResult::UNSAT;
    if (trimmed == "unknown")
      return SatResult::UNKNOWN;

    if (trimmed.find("(error") == 0 || trimmed.find("error:") == 0) {
      ERROR("External solver reported errors in output: ", trimmed);
      return SatResult::ERROR;
    }
  }

  ERROR("External solver did not return a valid status. Output: ",
        procResult.output);
  return SatResult::ERROR;
}

std::string ExternalSolver::buildCurrentFormula() const {
  std::stringstream ss;
  ss << currentFormula;
  for (const auto &assertion : currentAssertions) {
    ss << assertion << "\n";
  }
  return ss.str();
}

SatResult ExternalSolver::checkSat(const std::string &formula) {
  currentFormula = formula;
  currentAssertions.clear();

  std::string tempFile = createTempFile(formula);
  SatResult result = executeExternalSolver(tempFile);
  deleteTempFile(tempFile);

  return result;
}

SatResult ExternalSolver::checkSatIncremental(const std::string &assertion) {
  currentAssertions.push_back(assertion);

  std::string fullFormula = buildCurrentFormula();
  std::string tempFile = createTempFile(fullFormula);
  SatResult result = executeExternalSolver(tempFile);
  deleteTempFile(tempFile);

  return result;
}

void ExternalSolver::addAssertion(const std::string &assertion) {
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

  // Remove any existing (exit) commands that would prevent get-model from
  // running
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

  std::vector<std::string> argv = {solverPath, std::to_string(timeout),
                                   tempFile};
  DEBUG("Executing external solver for model: ", solverPath, " ", timeout, " ",
        tempFile);

  ExternalProcessResult procResult;
  try {
    procResult = runExternalProcess(argv);
  } catch (const std::exception &e) {
    ERROR("Failed to execute external solver for model: ", e.what());
    deleteTempFile(tempFile);
    return "";
  }

  deleteTempFile(tempFile);

  std::string result = std::move(procResult.output);
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

void dumpSMTLIB2(const SMTParser::NodePtr &node, std::stringstream &ss) {
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

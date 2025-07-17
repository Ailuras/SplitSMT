#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "Context.h"
#include "Split.h"

struct Args {
    std::string inputFile;
    std::string outputFile;
    strp::utils::LogLevel logLevel;
    strp::SolverType solverType;
    bool showHelp;
};

void printUsage() {
    std::cout << "Usage: strprocessor <input_file> [output_file] [-l <log_level>] [-s <solver>] [-h]" << std::endl;
    std::cout << "  <input_file>      Input SMT2 file" << std::endl;
    std::cout << "  [output_file]     Output file (optional)" << std::endl;
    std::cout << "  -l, --level       Set logging level (default: 40, error level)" << std::endl;
    std::cout << "  -s, --solver      Set solver type (default: z3)" << std::endl;
    std::cout << "                    Built-in solvers:" << std::endl;
    std::cout << "                      z3      - Z3 solver (API)" << std::endl;
    std::cout << "                      cvc5    - CVC5 solver (API)" << std::endl;
    std::cout << "                    External solvers:" << std::endl;
    std::cout << "                      ext-z3      - External Z3 solver" << std::endl;
    std::cout << "                      ext-cvc5    - External CVC5 solver" << std::endl;
    std::cout << "                      ext-ostrich - External Ostrich solver" << std::endl;
    std::cout << "                      ext-z3-noodler - External Z3-Noodler solver" << std::endl;
    std::cout << "  -h, --help        Show this help message" << std::endl;
}

void parseArgs(int argc, char* argv[], Args& args) {
    args.inputFile = "";
    args.outputFile = "";
    args.logLevel = strp::utils::LogLevel::ERROR;
    args.solverType = strp::SolverType::Z3;
    args.showHelp = false;
    
    if (argc < 2) {
        args.showHelp = true;
        return;
    }
    
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "-h" || arg == "--help") {
            args.showHelp = true;
            return;
        } else if (arg == "-l" || arg == "--level") {
            if (i + 1 < argc) {
                int level = std::atoi(argv[++i]);
                if (level >= 40) args.logLevel = strp::utils::LogLevel::ERROR;
                else if (level >= 30) args.logLevel = strp::utils::LogLevel::WARNING;
                else if (level >= 20) args.logLevel = strp::utils::LogLevel::INFO;
                else if (level >= 15) args.logLevel = strp::utils::LogLevel::DEBUG;
                else if (level >= 14) args.logLevel = strp::utils::LogLevel::LOG1;
                else if (level >= 13) args.logLevel = strp::utils::LogLevel::LOG2;
                else if (level >= 12) args.logLevel = strp::utils::LogLevel::LOG3;
                else if (level >= 11) args.logLevel = strp::utils::LogLevel::LOG4;
                else args.logLevel = strp::utils::LogLevel::LOG5;
            }
        } else if (arg == "-s" || arg == "--solver") {
            if (i + 1 < argc) {
                std::string solver = argv[++i];
                if (solver == "z3") {
                    args.solverType = strp::SolverType::Z3;
                } else if (solver == "cvc5") {
                    args.solverType = strp::SolverType::CVC5;
                } else if (solver == "ext-z3") {
                    args.solverType = strp::SolverType::EXTERNAL_Z3;
                } else if (solver == "ext-cvc5") {
                    args.solverType = strp::SolverType::EXTERNAL_CVC5;
                } else if (solver == "ext-ostrich") {
                    args.solverType = strp::SolverType::EXTERNAL_OSTRICH;
                } else if (solver == "ext-z3-noodler") {
                    args.solverType = strp::SolverType::EXTERNAL_Z3_NOODLER;
                } else {
                    std::cerr << "Warning: Unknown solver '" << solver << "', using z3" << std::endl;
                    std::cerr << "Available solvers: z3, cvc5, ext-z3, ext-cvc5, ext-ostrich, ext-z3-noodler" << std::endl;
                    args.solverType = strp::SolverType::Z3;
                }
            }
        } else if (args.inputFile.empty()) {
            args.inputFile = arg;
        } else if (args.outputFile.empty()) {
            args.outputFile = arg;
        }
    }
    
    if (args.inputFile.empty() && !args.showHelp) {
        std::cerr << "Error: Input file required" << std::endl;
        args.showHelp = true;
    }
}

void setupLogging(const Args& args) {
    LOGGER.setLevel(args.logLevel);
    DEBUG("Input file: ", args.inputFile);
    if (!args.outputFile.empty()) {
        DEBUG("Output file: ", args.outputFile);
    }
    
    std::string solverName;
    switch (args.solverType) {
        case strp::SolverType::Z3:
            solverName = "Z3 (API)";
            break;
        case strp::SolverType::CVC5:
            solverName = "CVC5 (API)";
            break;
        case strp::SolverType::EXTERNAL_Z3:
            solverName = "External Z3";
            break;
        case strp::SolverType::EXTERNAL_CVC5:
            solverName = "External CVC5";
            break;
        case strp::SolverType::EXTERNAL_OSTRICH:
            solverName = "External Ostrich";
            break;
        case strp::SolverType::EXTERNAL_Z3_NOODLER:
            solverName = "External Z3-Noodler";
            break;
        default:
            solverName = "Unknown";
            break;
    }
    DEBUG("Solver type: ", solverName);
}

bool parseInputFile(const std::string& inputFile, strp::Context& context) {
    if (context.parseFile(inputFile)) {
        INFO("Successfully parsed input file");
        return true;
    } else {
        ERROR("Failed to parse file: ", inputFile);
        return false;
    }
}

int main(int argc, char* argv[]) {
    Args args;
    parseArgs(argc, argv, args);
    if (args.showHelp) {
        printUsage();
        return 0;
    }
    setupLogging(args);
    
    try {
        auto& context = strp::Context::getInstance();
        if (parseInputFile(args.inputFile, context)) {
            // strp::splitSolver solver(args.solverType);
            // solver.solve();
        } else {
            return 1;
        }
    } catch (const std::exception& e) {
        ERROR("Error processing file: ", e.what());
        return 1;
    }

    return 0;
}
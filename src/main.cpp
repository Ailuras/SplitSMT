#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "Context.h"
#include "Solver.h"

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
    std::cout << "  -s, --solver      Set solver type: z3 or cvc5 (default: z3)" << std::endl;
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
                } else {
                    std::cerr << "Warning: Unknown solver '" << solver << "', using z3" << std::endl;
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
    DEBUG("Solver type: ", (args.solverType == strp::SolverType::Z3 ? "Z3" : "CVC5"));
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
            strp::splitSolver solver(args.solverType);
            solver.setMaxIterations(10);
            solver.solve();
        } else {
            return 1;
        }
    } catch (const std::exception& e) {
        ERROR("Error processing file: ", e.what());
        return 1;
    }

    return 0;
}
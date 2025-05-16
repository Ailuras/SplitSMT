#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "Parser.h"
#include "Context.h"

void printUsage() {
    std::cout << "Usage: strprocessor <input_file> [output_file] [-l <log_level>]" << std::endl;
    std::cout << "  <input_file>      Input SMT2 file" << std::endl;
    std::cout << "  [output_file]     Output file (optional)" << std::endl;
    std::cout << "  -l, --level       Set logging level (default: 20, info level)" << std::endl;
}

struct Args {
    std::string inputFile;
    std::string outputFile;
    strp::utils::LogLevel logLevel;
};

void parseArgs(int argc, char* argv[], Args& args) {
    if (argc < 2) {
        std::cerr << "Error: Input file required" << std::endl;
        printUsage();
        exit(1);
    }
    args.inputFile = argv[1];
    args.outputFile = "";
    args.logLevel = strp::utils::LogLevel::INFO;
    for (int i = 2; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "-l" || arg == "--level") {
            if (i + 1 < argc) {
                int level = std::atoi(argv[++i]);
                // Map numeric levels to LogLevel enum
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
        } else if (args.outputFile.empty()) {
            args.outputFile = arg;
        }
    }
}

void setupLogging(const Args& args) {
    LOGGER.setLevel(args.logLevel);
    DEBUG("Input file: ", args.inputFile);
    if (!args.outputFile.empty()) {
        DEBUG("Output file: ", args.outputFile);
    }
}

void processInput(const std::string& inputFile, strp::Context& context) {
    auto& parser = strp::Parser::getInstance();
    if (parser.parseFile(inputFile)) {
        context.addInfo();
    } else {
        ERROR("Failed to parse file: ", inputFile);
    }
}

int main(int argc, char* argv[]) {
    Args args;
    parseArgs(argc, argv, args);
    setupLogging(args);
    try {
        auto& context = strp::Context::getInstance();
        processInput(args.inputFile, context);
    } catch (const std::exception& e) {
        ERROR("Error processing file: ", e.what());
        return 1;
    }
    return 0;
}
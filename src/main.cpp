#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "Parser.h"
#include "Context.h"
#include "Solver.h"
#include "IncrementalSolver.h"

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
    std::cout << "  -l, --level       Set logging level (default: 20, info level)" << std::endl;
    std::cout << "  -s, --solver      Set solver type: z3 or cvc5 (default: z3)" << std::endl;
    std::cout << "  -h, --help        Show this help message" << std::endl;
}

void parseArgs(int argc, char* argv[], Args& args) {
    args.inputFile = "";
    args.outputFile = "";
    args.logLevel = strp::utils::LogLevel::INFO;
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
    auto& parser = strp::Parser::getInstance();
    if (parser.parseFile(inputFile)) {
        context.addInfo();
        INFO("Successfully parsed input file");
        return true;
    } else {
        ERROR("Failed to parse file: ", inputFile);
        return false;
    }
}

void runIncrementalDemo(strp::SolverType solverType) {
    INFO("Running incremental solver demo with real parsed data...");
    strp::IncrementalSolver solver(solverType);
    solver.setMaxIterations(10);
    
    int clauseIndex = 0;
    auto clauseGenerator = [&clauseIndex](strp::Context& ctx, strp::SatResult lastResult) -> std::string {
        auto clauses = ctx.getClauses();
        if (lastResult == strp::SatResult::SAT && clauseIndex < static_cast<int>(clauses.size())) {
            std::string clauseStr = clauses[clauseIndex].toSMT();
            clauseIndex++;
            INFO("Adding clause ", clauseIndex, ": ", clauseStr.substr(0, 100), "...");
            return clauseStr;
        }
        return "";
    };
    
    auto analysisFunction = [&clauseIndex](strp::Context& ctx, strp::SatResult result, const std::string& model) -> bool {
        (void)model;
        auto clauses = ctx.getClauses();
        if (result == strp::SatResult::SAT) {
            if (clauseIndex < static_cast<int>(clauses.size())) {
                INFO("Current result is SAT, continuing to add more clauses (", clauseIndex, "/", clauses.size(), ")");
                return true;
            } else {
                INFO("All clauses added and result is still SAT");
                return false;
            }
        } else if (result == strp::SatResult::UNSAT) {
            INFO("Result became UNSAT after adding clause ", clauseIndex, ", stopping iteration");
            return false;
        }
        return true;
    };
    
    solver.setClauseGenerator(clauseGenerator);
    solver.setAnalysisFunction(analysisFunction);
    
    strp::SatResult finalResult = solver.solve();
    
    auto& context = solver.getContext();
    INFO("Demo completed. Final result: ", 
         finalResult == strp::SatResult::SAT ? "SAT" : 
         finalResult == strp::SatResult::UNSAT ? "UNSAT" : 
         finalResult == strp::SatResult::UNKNOWN ? "UNKNOWN" : "ERROR");
    INFO("Total iterations: ", solver.getIterationCount());
    auto addedClauses = solver.getAddedClauses();
    INFO("Added ", addedClauses.size(), " clauses during solving");
    for (size_t i = 0; i < addedClauses.size(); ++i) {
        INFO("  Clause ", i+1, ": ", addedClauses[i].substr(0, 100), "...");
    }
    INFO("Final context contains: ", context.getVarCount(), " vars, ", context.getClauseCount(), " clauses");
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
        strp::Check checker(args.solverType);
        auto& context = strp::Context::getInstance();
        
        if (parseInputFile(args.inputFile, context)) {
            runIncrementalDemo(args.solverType);
        } else {
            return 1;
        }
    } catch (const std::exception& e) {
        ERROR("Error processing file: ", e.what());
        return 1;
    }
    return 0;
}
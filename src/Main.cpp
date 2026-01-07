#include "core/Context.h"
#include "core/Fallback.h"
#include "core/Split.h"
#include "utils/Logger.h"
#include <cstdlib>
#include <iostream>
#include <string>

struct Args {
  std::string inputFile;
  std::string outputFile;
  std::string genOutputFile;
  strp::utils::LogLevel logLevel;
  strp::SolverType solverType;
  int timeout;
  bool showHelp;
  bool genOnly;
};

void printUsage() {
  std::cout
      << "Usage: strprocessor <input_file> [output_file] [-l <log_level>] [-s "
         "<solver>] [-t <timeout>] [--gen <gen_output>] [-h]"
      << std::endl;
  std::cout << "  <input_file>      Input SMT2 file" << std::endl;
  std::cout << "  [output_file]     Output file (optional)" << std::endl;
  std::cout
      << "  -l, --level       Set logging level (default: 40, error level)"
      << std::endl;
  std::cout << "  -s, --solver      Set solver type (default: z3-noodler)"
            << std::endl;
  std::cout << "  -t, --timeout     Set timeout in seconds (default: 30)"
            << std::endl;
  std::cout << "                    Available solvers:" << std::endl;
  std::cout << "                      z3          - Z3 solver" << std::endl;
  std::cout << "                      cvc5        - CVC5 solver" << std::endl;
  std::cout << "                      ostrich     - Ostrich solver"
            << std::endl;
  std::cout << "                      z3-noodler  - Z3-Noodler solver"
            << std::endl;
  std::cout
      << "  --gen             Generate rewritten SMT2 file without solving"
      << std::endl;
  std::cout << "  -h, --help        Show this help message" << std::endl;
}

void parseArgs(int argc, char *argv[], Args &args) {
  args.inputFile = "";
  args.outputFile = "";
  args.genOutputFile = "";
  args.logLevel = strp::utils::LogLevel::ERROR;
  args.solverType = strp::SolverType::Z3_NOODLER;
  args.timeout = 30; // Default timeout
  args.showHelp = false;
  args.genOnly = false;

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
        if (level >= 40)
          args.logLevel = strp::utils::LogLevel::ERROR;
        else if (level >= 30)
          args.logLevel = strp::utils::LogLevel::WARNING;
        else if (level >= 20)
          args.logLevel = strp::utils::LogLevel::INFO;
        else if (level >= 15)
          args.logLevel = strp::utils::LogLevel::DEBUG;
        else if (level >= 14)
          args.logLevel = strp::utils::LogLevel::LOG1;
        else if (level >= 13)
          args.logLevel = strp::utils::LogLevel::LOG2;
        else if (level >= 12)
          args.logLevel = strp::utils::LogLevel::LOG3;
        else if (level >= 11)
          args.logLevel = strp::utils::LogLevel::LOG4;
        else
          args.logLevel = strp::utils::LogLevel::LOG5;
      }
    } else if (arg == "-s" || arg == "--solver") {
      if (i + 1 < argc) {
        std::string solver = argv[++i];
        if (solver.rfind("ext-", 0) == 0) {
          std::cerr << "Warning: solver names no longer use the 'ext-' prefix; "
                       "interpreting '"
                    << solver << "' as '" << solver.substr(4) << "'."
                    << std::endl;
          solver = solver.substr(4);
        }

        if (solver == "z3") {
          args.solverType = strp::SolverType::Z3;
        } else if (solver == "cvc5") {
          args.solverType = strp::SolverType::CVC5;
        } else if (solver == "ostrich") {
          args.solverType = strp::SolverType::OSTRICH;
        } else if (solver == "z3-noodler") {
          args.solverType = strp::SolverType::Z3_NOODLER;
        } else {
          std::cerr << "Warning: Unknown solver '" << solver
                    << "', using z3-noodler" << std::endl;
          std::cerr << "Available solvers: z3, cvc5, ostrich, z3-noodler"
                    << std::endl;
          args.solverType = strp::SolverType::Z3_NOODLER;
        }
      }
    } else if (arg == "-t" || arg == "--timeout") {
      if (i + 1 < argc) {
        args.timeout = std::atoi(argv[++i]);
      }
    } else if (arg == "--gen") {
      args.genOnly = true;
      if (i + 1 < argc) {
        args.genOutputFile = argv[++i];
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

  if (args.genOnly && args.genOutputFile.empty()) {
    std::cerr << "Error: Output file required for --gen option" << std::endl;
    args.showHelp = true;
  }
}

void setupLogging(const Args &args) {
  LOGGER.setLevel(args.logLevel);
  DEBUG("Input file: ", args.inputFile);
  if (!args.outputFile.empty()) {
    DEBUG("Output file: ", args.outputFile);
  }

  std::string solverName;
  switch (args.solverType) {
  case strp::SolverType::Z3:
    solverName = "Z3";
    break;
  case strp::SolverType::CVC5:
    solverName = "CVC5";
    break;
  case strp::SolverType::OSTRICH:
    solverName = "Ostrich";
    break;
  case strp::SolverType::Z3_NOODLER:
    solverName = "Z3-Noodler";
    break;
  default:
    solverName = "Unknown";
    break;
  }
  DEBUG("Solver type: ", solverName);
  DEBUG("Timeout: ", args.timeout, " seconds");
}

bool parseInputFile(const std::string &inputFile, strp::Context &context) {
  if (context.parseFile(inputFile)) {
    INFO("Successfully parsed input file");
    return true;
  } else {
    ERROR("Failed to parse file: ", inputFile);
    return false;
  }
}

int main(int argc, char *argv[]) {
  Args args;
  parseArgs(argc, argv, args);
  if (args.showHelp) {
    printUsage();
    return 0;
  }
  setupLogging(args);

  try {
    auto &context = strp::Context::getInstance();
    if (parseInputFile(args.inputFile, context)) {
      auto &fallbackMgr = strp::FallbackManager::getInstance();

      if (args.genOnly) {
        if (fallbackMgr.isFallbackRequired()) {
          ERROR("Cannot generate output for fallback cases");
          return 1;
        }
        strp::SplitSolver solver(args.solverType, strp::Context::getInstance(),
                                 args.timeout);
        bool success = solver.generateOnly(args.genOutputFile);
        return success ? 0 : 1;
      }

      if (fallbackMgr.isFallbackRequired()) {
        INFO("Executing fallback pipeline for input: ", args.inputFile);
        strp::SatResult result =
            fallbackMgr.executeFallback(args.solverType, args.timeout);
        INFO("Final result: ", result == strp::SatResult::SAT       ? "SAT"
                               : result == strp::SatResult::UNSAT   ? "UNSAT"
                               : result == strp::SatResult::UNKNOWN ? "UNKNOWN"
                                                                    : "ERROR");

        if (context.hasTask(strp::TaskType::CHECK_SAT)) {
          if (result == strp::SatResult::SAT) {
            std::cout << "sat" << std::endl;
          } else if (result == strp::SatResult::UNSAT) {
            std::cout << "unsat" << std::endl;
          } else {
            std::cout << "unknown" << std::endl;
          }
        }

        return result == strp::SatResult::ERROR ? 1 : 0;
      }

      strp::SplitSolver solver(args.solverType, strp::Context::getInstance(),
                               args.timeout);
      strp::SatResult result = solver.solve();
      return result == strp::SatResult::ERROR ? 1 : 0;
    } else {
      return 1;
    }
  } catch (const std::exception &e) {
    ERROR("Error processing file: ", e.what());
    return 1;
  }

  return 0;
}

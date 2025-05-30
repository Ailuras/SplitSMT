#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "parser.h"
#include "Context.h"
#include "Solver.h"

int main(int argc, char* argv[]) {
    // 设置日志级别
    LOGGER.setLevel(strp::utils::LogLevel::DEBUG);
    
    try {
        auto& context = strp::Context::getInstance();
        
        std::string testInput = R"(
(set-logic QF_S)
(set-info :status sat)
(declare-const x String)
(declare-const y String)
(declare-const z String)
(assert (= x (str.split_at "hello,world" "," 0)))
(assert (= y (str.split_at "apple,banana,cherry" "," 1)))
(assert (= z (str.split_at "one;two;three;four" ";" 2)))
(assert (= (str.num_splits "one;two;three;four" ";") 4))
(assert (= (str.num_splits "a,b,c" ",") 3))
(check-sat)
)";

        std::cout << "=== Testing Split Replacement Functions ===" << std::endl;
        std::cout << "Original input:" << std::endl;
        std::cout << testInput << std::endl;
        
        if (!context.parseString(testInput)) {
            std::cerr << "Failed to parse test input" << std::endl;
            return 1;
        }
        
        std::cout << "\n=== Before Replacement ===" << std::endl;
        auto splitAtConstNodes = context.getSplitAtConstNodes();
        auto numSplitsConstNodes = context.getNumSplitsConstNodes();
        
        std::cout << "SplitAt const nodes found: " << splitAtConstNodes.size() << std::endl;
        for (size_t i = 0; i < splitAtConstNodes.size(); ++i) {
            std::cout << "  SplitAtConst[" << i << "]: " << context.getSource(splitAtConstNodes[i]) << std::endl;
        }
        
        std::cout << "NumSplits const nodes found: " << numSplitsConstNodes.size() << std::endl;
        for (size_t i = 0; i < numSplitsConstNodes.size(); ++i) {
            std::cout << "  NumSplitsConst[" << i << "]: " << context.getSource(numSplitsConstNodes[i]) << std::endl;
        }
        
        std::cout << "\nOriginal SMTLIB2:" << std::endl;
        std::cout << context.getSMTLIB2(true) << std::endl;
        
        std::cout << "\n=== Applying Replacements ===" << std::endl;
        strp::splitSolver solver(strp::SolverType::Z3);
        solver.rewriteFormula(context);
        
        std::cout << "\n=== After Replacement ===" << std::endl;
        std::cout << "Modified SMTLIB2 (from parser):" << std::endl;
        std::cout << context.getSMTLIB2(true) << std::endl;
        
        std::cout << "Modified SMTLIB2 (from context structures):" << std::endl;
        std::cout << context.getSMTLIB2(false) << std::endl;
        
        std::cout << "\n=== Verification: Check if split nodes still exist ===" << std::endl;
        auto splitAtNodesAfter = context.getSplitAtNodes();
        auto numSplitsNodesAfter = context.getNumSplitsNodes();
        std::cout << "SplitAt nodes after replacement: " << splitAtNodesAfter.size() << std::endl;
        std::cout << "NumSplits nodes after replacement: " << numSplitsNodesAfter.size() << std::endl;
        
        if (splitAtNodesAfter.empty() && numSplitsNodesAfter.empty()) {
            std::cout << "✅ SUCCESS: All split nodes have been replaced!" << std::endl;
        } else {
            std::cout << "❌ WARNING: Some split nodes still exist after replacement" << std::endl;
        }
        
        std::cout << "\n=== Testing the solver ===" << std::endl;
        strp::SatResult result = solver.checkSat();
        switch (result) {
            case strp::SatResult::SAT:
                std::cout << "Result: SAT" << std::endl;
                std::cout << "Model: " << solver.getModel() << std::endl;
                break;
            case strp::SatResult::UNSAT:
                std::cout << "Result: UNSAT" << std::endl;
                break;
            case strp::SatResult::UNKNOWN:
                std::cout << "Result: UNKNOWN" << std::endl;
                break;
            case strp::SatResult::ERROR:
                std::cout << "Result: ERROR" << std::endl;
                break;
        }
        
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
} 
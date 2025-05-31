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
(declare-const x String)
(declare-const y String)
(assert (= (str.num_splits x ";") 3))
(assert (= (str.split_at x ";" 0) "hello"))
(assert (= (str.split_at x ";" 1) "world"))
(assert (= (str.split_at x ";" 2) "test"))
(assert (= (str.num_splits y ";") 2))
(assert (= (str.split_at y ";" 0) "foo"))
(assert (= (str.split_at y ";" 1) "bar"))
(check-sat)
(get-model)
)";

        std::cout << "=== Testing Variable Split Functions ===" << std::endl;
        std::cout << "Original input:" << std::endl;
        std::cout << testInput << std::endl;
        
        if (!context.parseString(testInput)) {
            std::cerr << "Failed to parse test input" << std::endl;
            return 1;
        }
        
        std::cout << "\n=== Before Replacement ===" << std::endl;
        auto splitAtVarNodes = context.getSplitAtVarNodes();
        auto numSplitsVarNodes = context.getNumSplitsVarNodes();
        
        std::cout << "SplitAt var nodes found: " << splitAtVarNodes.size() << std::endl;
        for (size_t i = 0; i < splitAtVarNodes.size(); ++i) {
            std::cout << "  SplitAtVar[" << i << "]: " << context.getSource(splitAtVarNodes[i]) << std::endl;
        }
        
        std::cout << "NumSplits var nodes found: " << numSplitsVarNodes.size() << std::endl;
        for (size_t i = 0; i < numSplitsVarNodes.size(); ++i) {
            std::cout << "  NumSplitsVar[" << i << "]: " << context.getSource(numSplitsVarNodes[i]) << std::endl;
        }
        
        std::cout << "\nOriginal SMTLIB2:" << std::endl;
        std::cout << context.getSMTLIB2(true) << std::endl;
        
        std::cout << "\n=== Applying Variable Split Processing ===" << std::endl;
        strp::splitSolver solver(strp::SolverType::Z3);
        
        std::cout << "\n--- Step 1: Analyzing split constraints ---" << std::endl;
        solver.getSplitNums(context, splitAtVarNodes, numSplitsVarNodes);
        
        std::cout << "\n--- Step 2: Setting initial split numbers ---" << std::endl;
        context.setInitSplitNums();
        
        std::cout << "\n--- Step 3: Adding concat nodes ---" << std::endl;
        context.addConcatNodes();
        
        std::cout << "\n--- Step 4: Replacing variable nodes ---" << std::endl;
        solver.replaceNumSplitsVarNodes(context, numSplitsVarNodes);
        solver.replaceSplitAtVarNodes(context, splitAtVarNodes);
        
        std::cout << "\n=== After Variable Split Processing ===" << std::endl;
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
        
        std::cout << "\n=== Split Info Summary ===" << std::endl;
        auto& splitInfos = context.getAllSplitInfos();
        std::cout << "Found " << splitInfos.size() << " split info entries:" << std::endl;
        for (size_t i = 0; i < splitInfos.size(); ++i) {
            const auto& info = splitInfos[i];
            std::cout << "  [" << i << "] Variable: " << info.variable 
                     << ", Delimiter: '" << info.delimiter << "'"
                     << ", Min: " << info.minSplits 
                     << ", Max: " << info.maxSplits
                     << ", HasExact: " << (info.hasExactCount ? "true" : "false");
            if (info.hasExactCount) {
                std::cout << ", Exact: " << info.exactCount;
            }
            std::cout << ", Required indices: [";
            for (size_t j = 0; j < info.requiredIndices.size(); ++j) {
                if (j > 0) std::cout << ",";
                std::cout << info.requiredIndices[j];
            }
            std::cout << "]" << std::endl;
        }
        
        std::cout << "\n=== Testing the solver ===" << std::endl;
        strp::SatResult result = solver.solve();
        std::cout << "Result: " << (result == strp::SatResult::SAT ? "SAT" : 
                                    result == strp::SatResult::UNSAT ? "UNSAT" : 
                                    result == strp::SatResult::UNKNOWN ? "UNKNOWN" : "ERROR") << std::endl;
        if (result == strp::SatResult::SAT) {
            std::string rawModel = solver.getModel();
            std::string filteredModel = solver.filterModel(rawModel);
            std::cout << "Filtered Model (original variables only): " << std::endl << filteredModel << std::endl;
        }
        
        std::cout << "\n=== Testing Incremental Solving ===" << std::endl;
        std::string incrementalInput = R"(
(set-logic QF_S)
(declare-const z String)
(assert (>= (str.num_splits z ",") 2))
(assert (<= (str.num_splits z ",") 5))
(assert (= (str.split_at z "," 0) "a"))
(assert (= (str.split_at z "," 1) "b"))
(assert (= (str.split_at z "," 2) "c"))
(assert (= (str.split_at z "," 3) "d"))
(check-sat)
)";
        
        strp::Context& incrementalCtx = strp::Context::getInstance();
        if (incrementalCtx.parseString(incrementalInput)) {
            std::cout << "Incremental test input parsed successfully" << std::endl;
            
            strp::splitSolver incrementalSolver(strp::SolverType::Z3);
            incrementalSolver.setMaxIterations(20);
            
            std::cout << "Starting incremental solving..." << std::endl;
            strp::SatResult incrementalResult = incrementalSolver.solve();
            std::cout << "Incremental result: " << (incrementalResult == strp::SatResult::SAT ? "SAT" : 
                                                    incrementalResult == strp::SatResult::UNSAT ? "UNSAT" : 
                                                    incrementalResult == strp::SatResult::UNKNOWN ? "UNKNOWN" : "ERROR") << std::endl;
        }
        
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
} 
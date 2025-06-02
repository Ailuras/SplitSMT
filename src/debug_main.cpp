#include <iostream>
#include <string>
#include <chrono>
#include <vector>
#include "Logger.h"
#include "parser.h"
#include "Context.h"
#include "Solver.h"

int main(int argc, char* argv[]) {
    // 设置日志级别
    LOGGER.setLevel(strp::utils::LogLevel::DEBUG);
    
    try {
        auto& context = strp::Context::getInstance();
        
        std::cout << "=== Testing Optimized getSplitNums Function ===" << std::endl;
        
        std::vector<std::string> testCases = {
            R"(
(set-logic QF_S)
(declare-const email String)
(assert (= (str.num_splits email "@") 2))
(assert (>= (str.num_splits email ".") 2))
(assert (<= (str.num_splits email ".") 4))
(assert (= (str.split_at email "@" 0) "username"))
(assert (= (str.split_at email "@" 1) "domain.com"))
(assert (= (str.split_at email "." 1) "domain"))
(assert (= (str.split_at email "." 2) "com"))
(check-sat)
(get-model)
)",
            R"(
(set-logic QF_S)
(declare-const csv_line String)
(declare-const path String)
(assert (>= (str.num_splits csv_line ",") 3))
(assert (<= (str.num_splits csv_line ",") 10))
(assert (= (str.num_splits path "/") 4))
(assert (= (str.split_at csv_line "," 0) "name"))
(assert (= (str.split_at csv_line "," 1) "age"))
(assert (= (str.split_at csv_line "," 2) "city"))
(assert (= (str.split_at path "/" 0) "home"))
(assert (= (str.split_at path "/" 1) "user"))
(assert (= (str.split_at path "/" 2) "documents"))
(assert (= (str.split_at path "/" 3) "file.txt"))
(check-sat)
)",
            R"(
(set-logic QF_S)
(declare-const data String)
(assert (= (str.num_splits data ";") 5))
(assert (= (str.split_at data ";" 0) "field1"))
(assert (= (str.split_at data ";" 1) "field2"))
(assert (= (str.split_at data ";" 2) "field3"))
(assert (= (str.split_at data ";" 3) "field4"))
(assert (= (str.split_at data ";" 4) "field5"))
(assert (>= (str.num_splits data ":") 1))
(assert (= (str.split_at data ":" 0) "prefix"))
(check-sat)
)"
        };
        
        for (size_t i = 0; i < testCases.size(); ++i) {
            std::cout << "\n=== Test Case " << (i + 1) << " ===" << std::endl;
            
            context.clear();
            
            auto start = std::chrono::high_resolution_clock::now();
            
            if (!context.parseString(testCases[i])) {
                std::cerr << "Failed to parse test case " << (i + 1) << std::endl;
                continue;
            }
            
            auto parseEnd = std::chrono::high_resolution_clock::now();
            
            auto splitAtVarNodes = context.getSplitAtVarNodes();
            auto numSplitsVarNodes = context.getNumSplitsVarNodes();
            
            std::cout << "Found " << splitAtVarNodes.size() << " split_at nodes and " 
                     << numSplitsVarNodes.size() << " num_splits nodes" << std::endl;
            
            strp::splitSolver solver(strp::SolverType::Z3);
            
            auto analysisStart = std::chrono::high_resolution_clock::now();
            solver.getSplitNums(context, splitAtVarNodes, numSplitsVarNodes);
            auto analysisEnd = std::chrono::high_resolution_clock::now();
            
            auto parseTime = std::chrono::duration_cast<std::chrono::microseconds>(parseEnd - start);
            auto analysisTime = std::chrono::duration_cast<std::chrono::microseconds>(analysisEnd - analysisStart);
            
            std::cout << "Performance metrics:" << std::endl;
            std::cout << "  Parse time: " << parseTime.count() << " μs" << std::endl;
            std::cout << "  Analysis time: " << analysisTime.count() << " μs" << std::endl;
            
            std::cout << "\nExtracted split information:" << std::endl;
            auto& splitInfos = context.getAllSplitInfos();
            for (size_t j = 0; j < splitInfos.size(); ++j) {
                const auto& info = splitInfos[j];
                std::cout << "  [" << j << "] Variable: " << info.variable 
                         << ", Delimiter: '" << info.delimiter << "'"
                         << ", Min: " << info.minSplits 
                         << ", Max: " << (info.maxSplits > 0 ? std::to_string(info.maxSplits) : "unlimited")
                         << ", HasExact: " << (info.hasExactCount ? "true" : "false");
                if (info.hasExactCount) {
                    std::cout << ", Exact: " << info.exactCount;
                }
                std::cout << ", Required indices: [";
                for (size_t k = 0; k < info.requiredIndices.size(); ++k) {
                    if (k > 0) std::cout << ",";
                    std::cout << info.requiredIndices[k];
                }
                std::cout << "]" << std::endl;
            }
            
            std::cout << "\nTesting full solve process:" << std::endl;
            auto solveStart = std::chrono::high_resolution_clock::now();
            strp::SatResult result = solver.solve();
            auto solveEnd = std::chrono::high_resolution_clock::now();
            auto solveTime = std::chrono::duration_cast<std::chrono::milliseconds>(solveEnd - solveStart);
            
            std::cout << "Solve result: " << (result == strp::SatResult::SAT ? "SAT" : 
                                              result == strp::SatResult::UNSAT ? "UNSAT" : 
                                              result == strp::SatResult::UNKNOWN ? "UNKNOWN" : "ERROR") << std::endl;
            std::cout << "Solve time: " << solveTime.count() << " ms" << std::endl;
            
            if (result == strp::SatResult::SAT && context.hasTask(strp::TaskType::GET_MODEL)) {
                std::string rawModel = solver.getModel();
                std::string filteredModel = solver.filterModel(rawModel);
                if (!filteredModel.empty()) {
                    std::cout << "Model (original variables only):" << std::endl;
                    std::cout << filteredModel << std::endl;
                }
            }
        }
        
        std::cout << "\n=== Testing Conflict Detection ===\n" << std::endl;
        
        std::string conflictTestCase = R"(
(set-logic QF_S)
(declare-const data String)
(assert (= (str.num_splits data ";") 3))
(assert (<= (str.num_splits data ";") 2))
(assert (= (str.split_at data ";" 0) "field1"))
(assert (= (str.split_at data ";" 1) "field2"))
(assert (= (str.split_at data ";" 2) "field3"))
(check-sat)
)";
        
        std::cout << "Testing conflict detection with inconsistent constraints..." << std::endl;
        std::cout << "Case: exact=3, max<=2, accessing indices [0,1,2]" << std::endl;
        
        if (context.parseString(conflictTestCase)) {
            auto splitAtNodes = context.getSplitAtVarNodes();
            auto numSplitsNodes = context.getNumSplitsVarNodes();
            
            std::cout << "Found " << splitAtNodes.size() << " split_at nodes and " 
                      << numSplitsNodes.size() << " num_splits nodes" << std::endl;
            
            strp::splitSolver solver(strp::SolverType::Z3);
            
            auto start = std::chrono::high_resolution_clock::now();
            solver.getSplitNums(context, splitAtNodes, numSplitsNodes);
            auto end = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
            
            std::cout << "Conflict detection time: " << duration.count() << " μs" << std::endl;
            
            if (context.hasConflictingSplitConstraints()) {
                std::cout << "✓ Successfully detected constraint conflict!" << std::endl;
            } else {
                std::cout << "✗ Failed to detect constraint conflict!" << std::endl;
            }
            
            auto result = solver.solve();
            std::cout << "Final solve result: " << 
                (result == strp::SatResult::SAT ? "SAT" : 
                 result == strp::SatResult::UNSAT ? "UNSAT" : "UNKNOWN") << std::endl;
        }
        
        std::cout << "\n=== Performance Comparison Test ===" << std::endl;
        std::cout << "Testing with a larger example to demonstrate efficiency..." << std::endl;
        
        std::string largeTest = R"(
(set-logic QF_S)
(declare-const url String)
(declare-const query String)
(declare-const headers String)
(assert (= (str.num_splits url "/") 6))
(assert (= (str.split_at url "/" 0) "https:"))
(assert (= (str.split_at url "/" 1) ""))
(assert (= (str.split_at url "/" 2) "example.com"))
(assert (= (str.split_at url "/" 3) "api"))
(assert (= (str.split_at url "/" 4) "v1"))
(assert (= (str.split_at url "/" 5) "users"))
(assert (>= (str.num_splits query "&") 2))
(assert (<= (str.num_splits query "&") 8))
(assert (= (str.split_at query "&" 0) "name=john"))
(assert (= (str.split_at query "&" 1) "age=25"))
(assert (= (str.num_splits headers "|") 3))
(assert (= (str.split_at headers "|" 0) "Content-Type: application/json"))
(assert (= (str.split_at headers "|" 1) "Authorization: Bearer token"))
(assert (= (str.split_at headers "|" 2) "Accept: application/json"))
(check-sat)
(get-model)
)";
        
        context.clear();
        
        auto totalStart = std::chrono::high_resolution_clock::now();
        
        if (context.parseString(largeTest)) {
            auto splitAtNodes = context.getSplitAtVarNodes();
            auto numSplitsNodes = context.getNumSplitsVarNodes();
            
            std::cout << "Large test case:" << std::endl;
            std::cout << "  Split_at nodes: " << splitAtNodes.size() << std::endl;
            std::cout << "  Num_splits nodes: " << numSplitsNodes.size() << std::endl;
            std::cout << "  Total assertions: " << context.getAssertions().size() << std::endl;
            
            strp::splitSolver largeSolver(strp::SolverType::Z3);
            
            auto analysisStart = std::chrono::high_resolution_clock::now();
            largeSolver.getSplitNums(context, splitAtNodes, numSplitsNodes);
            auto analysisEnd = std::chrono::high_resolution_clock::now();
            
            auto analysisTime = std::chrono::duration_cast<std::chrono::microseconds>(analysisEnd - analysisStart);
            std::cout << "  Optimized analysis time: " << analysisTime.count() << " μs" << std::endl;
            
            auto& splitInfos = context.getAllSplitInfos();
            std::cout << "  Extracted " << splitInfos.size() << " split info entries" << std::endl;
        }
        
        auto totalEnd = std::chrono::high_resolution_clock::now();
        auto totalTime = std::chrono::duration_cast<std::chrono::milliseconds>(totalEnd - totalStart);
        std::cout << "Total test time: " << totalTime.count() << " ms" << std::endl;
        
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
} 
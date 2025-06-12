#include "Split.h"
#include "Logger.h"
#include "Context.h"
#include <iostream>

using namespace strp;

int main() {
    strp::utils::Logger::getInstance().setLevel(strp::utils::LogLevel::DEBUG);
    
    std::cout << "Testing External Solvers" << std::endl;
    
    Context& ctx = Context::getInstance();
    
    ctx.parseString(R"(
        (set-logic QF_S)
        (declare-fun x () String)
        (declare-fun y () String)
        (assert (= x "hello"))
        (assert (= y "world"))
        (assert (= (str.++ x " " y) "hello world"))
        (check-sat)
    )");
    
    // Test each external solver
    std::vector<std::pair<SolverType, std::string>> solvers = {
        {SolverType::EXTERNAL_Z3, "External Z3"},
        {SolverType::EXTERNAL_CVC5, "External CVC5"},
        {SolverType::EXTERNAL_OSTRICH, "External Ostrich"},
        {SolverType::EXTERNAL_Z3_NOODLER, "External Z3-Noodler"}
    };
    
    for (const auto& [solverType, solverName] : solvers) {
        std::cout << "\n=== Testing " << solverName << " ===" << std::endl;
        
        try {
            splitSolver solver(solverType);
            SatResult result = solver.solve();
            
            std::cout << solverName << " result: ";
            switch (result) {
                case SatResult::SAT:
                    std::cout << "SAT" << std::endl;
                    break;
                case SatResult::UNSAT:
                    std::cout << "UNSAT" << std::endl;
                    break;
                case SatResult::UNKNOWN:
                    std::cout << "UNKNOWN" << std::endl;
                    break;
                case SatResult::ERROR:
                    std::cout << "ERROR" << std::endl;
                    break;
            }
        } catch (const std::exception& e) {
            std::cout << solverName << " failed: " << e.what() << std::endl;
        }
    }
    
    return 0;
} 
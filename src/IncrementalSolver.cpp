#include "IncrementalSolver.h"
#include "Logger.h"
#include <sstream>
#include <fstream>

namespace strp {

IncrementalSolver::IncrementalSolver(SolverType solverType)
    : context(Context::getInstance()), maxIterations(10), iterationCount(0) {
    solver = std::make_unique<Check>(solverType);
    
    INFO("IncrementalSolver initialized with solver type: ", 
         solverType == SolverType::Z3 ? "Z3" : "CVC5");
}

void IncrementalSolver::setMaxIterations(int max) {
    maxIterations = max;
    DEBUG("Max iterations set to: ", max);
}

void IncrementalSolver::setClauseGenerator(ClauseGenerator generator) {
    clauseGenerator = generator;
}

void IncrementalSolver::setAnalysisFunction(AnalysisFunction analyzer) {
    analysisFunction = analyzer;
}

std::string IncrementalSolver::generateInitialFormula() {
    std::stringstream ss;
    auto& parser = context.getParser();
    auto variables = parser.getVariables();
    
    for (const auto& var : variables) {
        auto sort = var->getSort();
        ss << "(declare-fun " << var->getName() << " () ";
        if (sort->isInt()) {
            ss << "Int";
        } else if (sort->isReal()) {
            ss << "Real";
        } else if (sort->isBool()) {
            ss << "Bool";
        } else if (sort->isStr()) {
            ss << "String";
        } else {
            ss << sort->toString();
        }
        ss << ")\n";
    }
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        ss << "(assert ";
        dumpSMTLIB2(assertion, ss);
        ss << ")\n";
    }
    ss << "(check-sat)\n";
    return ss.str();
}

void dumpSMTLIB2(const SMTLIBParser::NodePtr& node, std::stringstream& ss) {
    if (node->isLeaf()) {
        ss << node->getName();
    } else {
        ss << "(" << node->getName();
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            ss << " ";
            dumpSMTLIB2(node->getChild(i), ss);
        }
        ss << ")";
    }
}

bool IncrementalSolver::shouldContinue(SatResult result) {
    if (iterationCount >= maxIterations) {
        WARN("Reached maximum iterations: ", maxIterations);
        return false;
    }
    if (result == SatResult::ERROR) {
        ERROR("Solver error occurred");
        return false;
    }
    return true;
}

SatResult IncrementalSolver::solve() {
    INFO("Starting incremental solving process");
    iterationCount = 0;
    addedClauses.clear();
    
    solver->resetSolver();
    
    auto& parser = context.getParser();
    auto variables = parser.getVariables();
    
    for (const auto& var : variables) {
        auto sort = var->getSort();
        std::stringstream decl;
        decl << "(declare-fun " << var->getName() << " () ";
        if (sort->isInt()) {
            decl << "Int";
        } else if (sort->isReal()) {
            decl << "Real";
        } else if (sort->isBool()) {
            decl << "Bool";
        } else if (sort->isStr()) {
            decl << "String";
        } else {
            decl << sort->toString();
        }
        decl << ")";
        solver->addAssertion(decl.str());
    }
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        std::stringstream ss;
        ss << "(assert ";
        dumpSMTLIB2(assertion, ss);
        ss << ")";
        solver->addAssertion(ss.str());
    }
    
    SatResult result = solver->checkSat();
    INFO("Initial result: ", static_cast<int>(result));
    
    while (shouldContinue(result)) {
        iterationCount++;
        INFO("Iteration ", iterationCount, " - Previous result: ", 
             result == SatResult::SAT ? "SAT" : 
             result == SatResult::UNSAT ? "UNSAT" : "UNKNOWN");
             
        if (analysisFunction && !analysisFunction(context, result, solver->getModel())) {
            INFO("Analysis function indicates termination");
            break;
        }
        
        if (clauseGenerator) {
            std::string newClause = clauseGenerator(context, result);
            if (!newClause.empty()) {
                INFO("Adding new clause: ", newClause);
                addedClauses.push_back(newClause);
                solver->pushContext();
                
                std::string assertion;
                if (newClause.find("(assert") == 0) {
                    assertion = newClause;
                } else {
                    assertion = "(assert " + newClause + ")";
                }
                solver->addAssertion(assertion);
                result = solver->checkSat();
            } else {
                DEBUG("No new clause generated");
                break;
            }
        } else {
            WARN("No clause generator set");
            break;
        }
    }
    
    if (iterationCount >= maxIterations && result == SatResult::UNSAT) {
        INFO("Reached max iterations with UNSAT, returning UNKNOWN");
        return SatResult::UNKNOWN;
    }
    
    INFO("Incremental solving completed after ", iterationCount, " iterations");
    INFO("Final result: ", 
         result == SatResult::SAT ? "SAT" : 
         result == SatResult::UNSAT ? "UNSAT" : 
         result == SatResult::UNKNOWN ? "UNKNOWN" : "ERROR");
    return result;
}

} 
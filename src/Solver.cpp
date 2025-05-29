#include "Solver.h"
#include "Logger.h"
#include "Context.h"
#include "parser.h"
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <filesystem>
#include <chrono>
#include <unordered_map>

#ifdef ENABLE_Z3
#include <z3++.h>
#endif

#ifdef ENABLE_CVC5
#include <cvc5/cvc5.h>
#include <cvc5/cvc5_parser.h>
#endif

namespace strp {

#ifdef ENABLE_Z3
class Z3Solver::Impl {
public:
    z3::context ctx;
    z3::solver solver;
    std::unordered_map<std::string, z3::expr> variables;
    
    Impl() : solver(ctx) {
        z3::params p(ctx);
        p.set("timeout", 30000u);
        solver.set(p);
    }
};

Z3Solver::Z3Solver() : pImpl(std::make_unique<Impl>()) {
    DEBUG("Z3Solver initialized");
}

Z3Solver::~Z3Solver() = default;

SatResult Z3Solver::checkSat(const std::string& formula) {
    try {
        pImpl->solver.reset();
        z3::expr_vector exprs = pImpl->ctx.parse_string(formula.c_str());
        for (unsigned i = 0; i < exprs.size(); ++i) {
            pImpl->solver.add(exprs[i]);
        }
        
        z3::check_result result = pImpl->solver.check();
        switch (result) {
            case z3::sat: return SatResult::SAT;
            case z3::unsat: return SatResult::UNSAT;
            case z3::unknown: return SatResult::UNKNOWN;
            default: return SatResult::ERROR;
        }
    } catch (const z3::exception& e) {
        ERROR("Z3 error: ", e.msg());
        return SatResult::ERROR;
    }
}

SatResult Z3Solver::checkSatIncremental(const std::string& assertion) {
    try {
        z3::expr_vector exprs = pImpl->ctx.parse_string(assertion.c_str());
        for (unsigned i = 0; i < exprs.size(); ++i) {
            pImpl->solver.add(exprs[i]);
        }
        
        z3::check_result result = pImpl->solver.check();
        switch (result) {
            case z3::sat: return SatResult::SAT;
            case z3::unsat: return SatResult::UNSAT;
            case z3::unknown: return SatResult::UNKNOWN;
            default: return SatResult::ERROR;
        }
    } catch (const z3::exception& e) {
        ERROR("Z3 error: ", e.msg());
        return SatResult::ERROR;
    }
}

void Z3Solver::push() {
    pImpl->solver.push();
}

void Z3Solver::pop() {
    pImpl->solver.pop();
}

void Z3Solver::reset() {
    pImpl->solver.reset();
    pImpl->variables.clear();
}

std::string Z3Solver::getModel() {
    try {
        z3::model model = pImpl->solver.get_model();
        return model.to_string();
    } catch (const z3::exception& e) {
        ERROR("Z3 model error: ", e.msg());
        return "";
    }
}

std::string Z3Solver::getUnsatCore() {
    try {
        z3::expr_vector core = pImpl->solver.unsat_core();
        return core.to_string();
    } catch (const z3::exception& e) {
        ERROR("Z3 unsat core error: ", e.msg());
        return "";
    }
}

void Z3Solver::addAssertion(const std::string& assertion) {
    try {
        if (assertion.find("(declare-fun") == 0) {
            size_t nameStart = assertion.find(' ') + 1;
            size_t nameEnd = assertion.find(' ', nameStart);
            std::string varName = assertion.substr(nameStart, nameEnd - nameStart);
            
            size_t typeStart = assertion.rfind(' ') + 1;
            size_t typeEnd = assertion.rfind(')');
            std::string varType = assertion.substr(typeStart, typeEnd - typeStart);
            
            if (varType == "Int") {
                pImpl->variables.insert({varName, pImpl->ctx.int_const(varName.c_str())});
            } else if (varType == "Real") {
                pImpl->variables.insert({varName, pImpl->ctx.real_const(varName.c_str())});
            } else if (varType == "Bool") {
                pImpl->variables.insert({varName, pImpl->ctx.bool_const(varName.c_str())});
            } else if (varType == "String") {
                z3::sort string_sort = pImpl->ctx.string_sort();
                pImpl->variables.insert({varName, pImpl->ctx.constant(varName.c_str(), string_sort)});
            }
            DEBUG("Declared variable: ", varName, " of type ", varType);
        } else {
            std::string fullFormula;
            for (const auto& [name, expr] : pImpl->variables) {
                fullFormula += "(declare-fun " + name + " () ";
                if (expr.is_int()) fullFormula += "Int";
                else if (expr.is_real()) fullFormula += "Real";
                else if (expr.is_bool()) fullFormula += "Bool";
                else if (expr.get_sort().sort_kind() == Z3_SEQ_SORT) fullFormula += "String";
                fullFormula += ") ";
            }
            fullFormula += assertion;
            
            z3::expr_vector exprs = pImpl->ctx.parse_string(fullFormula.c_str());
            if (exprs.size() > 0) {
                pImpl->solver.add(exprs[exprs.size() - 1]);
            }
        }
    } catch (const z3::exception& e) {
        ERROR("Z3 error adding assertion: ", e.msg());
    }
}

SatResult Z3Solver::checkSat() {
    try {
        z3::check_result result = pImpl->solver.check();
        switch (result) {
            case z3::sat: return SatResult::SAT;
            case z3::unsat: return SatResult::UNSAT;
            case z3::unknown: return SatResult::UNKNOWN;
            default: return SatResult::ERROR;
        }
    } catch (const z3::exception& e) {
        ERROR("Z3 error checking sat: ", e.msg());
        return SatResult::ERROR;
    }
}

#else

class Z3Solver::Impl {};

Z3Solver::Z3Solver() : pImpl(nullptr) {
    ERROR("Z3 support not compiled in");
    throw std::runtime_error("Z3 support not available");
}

Z3Solver::~Z3Solver() = default;

SatResult Z3Solver::checkSat(const std::string&) { return SatResult::ERROR; }
SatResult Z3Solver::checkSatIncremental(const std::string&) { return SatResult::ERROR; }
void Z3Solver::push() {}
void Z3Solver::pop() {}
void Z3Solver::reset() {}
std::string Z3Solver::getModel() { return ""; }
std::string Z3Solver::getUnsatCore() { return ""; }
void Z3Solver::addAssertion(const std::string&) {}
SatResult Z3Solver::checkSat() { return SatResult::ERROR; }

#endif

#ifdef ENABLE_CVC5
class CVC5Solver::Impl {
public:
    cvc5::TermManager tm;
    cvc5::Solver solver;
    
    Impl() : solver(tm) {
        solver.setOption("produce-models", "true");
        solver.setOption("produce-unsat-cores", "true");
    }
};

CVC5Solver::CVC5Solver() : pImpl(std::make_unique<Impl>()) {
    DEBUG("CVC5Solver initialized");
}

CVC5Solver::~CVC5Solver() = default;

SatResult CVC5Solver::checkSat(const std::string& formula) {
    try {
        pImpl->solver.resetAssertions();
        
        cvc5::parser::InputParser parser(&pImpl->solver);
        std::stringstream ss(formula);
        parser.setStreamInput(cvc5::modes::InputLanguage::SMT_LIB_2_6, ss, "formula");
        
        cvc5::parser::SymbolManager* sm = parser.getSymbolManager();
        
        cvc5::parser::Command cmd;
        while (true) {
            cmd = parser.nextCommand();
            if (cmd.isNull()) {
                break;
            }
            std::ostringstream oss;
            cmd.invoke(&pImpl->solver, sm, oss);
        }
        
        cvc5::Result result = pImpl->solver.checkSat();
        if (result.isSat()) return SatResult::SAT;
        if (result.isUnsat()) return SatResult::UNSAT;
        if (result.isUnknown()) return SatResult::UNKNOWN;
        return SatResult::ERROR;
    } catch (const cvc5::CVC5ApiException& e) {
        ERROR("CVC5 error: ", e.what());
        return SatResult::ERROR;
    }
}

SatResult CVC5Solver::checkSatIncremental(const std::string& assertion) {
    try {
        cvc5::parser::InputParser parser(&pImpl->solver);
        std::stringstream ss(assertion);
        parser.setStreamInput(cvc5::modes::InputLanguage::SMT_LIB_2_6, ss, "assertion");
        
        cvc5::parser::SymbolManager* sm = parser.getSymbolManager();
        
        cvc5::parser::Command cmd;
        while (true) {
            cmd = parser.nextCommand();
            if (cmd.isNull()) {
                break;
            }
            std::ostringstream oss;
            cmd.invoke(&pImpl->solver, sm, oss);
        }
        
        cvc5::Result result = pImpl->solver.checkSat();
        if (result.isSat()) return SatResult::SAT;
        if (result.isUnsat()) return SatResult::UNSAT;
        if (result.isUnknown()) return SatResult::UNKNOWN;
        return SatResult::ERROR;
    } catch (const cvc5::CVC5ApiException& e) {
        ERROR("CVC5 error: ", e.what());
        return SatResult::ERROR;
    }
}

void CVC5Solver::push() {
    pImpl->solver.push();
}

void CVC5Solver::pop() {
    pImpl->solver.pop();
}

void CVC5Solver::reset() {
    pImpl->solver.resetAssertions();
}

std::string CVC5Solver::getModel() {
    try {
        std::stringstream ss;
        std::vector<cvc5::Term> vars;
        
        for (const auto& var : vars) {
            cvc5::Term value = pImpl->solver.getValue(var);
            ss << var << " = " << value << "\n";
        }
        return ss.str();
    } catch (const cvc5::CVC5ApiException& e) {
        ERROR("CVC5 model error: ", e.what());
        return "";
    }
}

std::string CVC5Solver::getUnsatCore() {
    try {
        std::vector<cvc5::Term> core = pImpl->solver.getUnsatCore();
        std::stringstream ss;
        for (const auto& term : core) {
            ss << term << "\n";
        }
        return ss.str();
    } catch (const cvc5::CVC5ApiException& e) {
        ERROR("CVC5 unsat core error: ", e.what());
        return "";
    }
}

void CVC5Solver::addAssertion(const std::string& assertion) {
    try {
        cvc5::parser::InputParser parser(&pImpl->solver);
        std::stringstream ss(assertion);
        parser.setStreamInput(cvc5::modes::InputLanguage::SMT_LIB_2_6, ss, "assertion");
        
        cvc5::parser::SymbolManager* sm = parser.getSymbolManager();
        
        cvc5::parser::Command cmd;
        while (true) {
            cmd = parser.nextCommand();
            if (cmd.isNull()) {
                break;
            }
            std::ostringstream oss;
            cmd.invoke(&pImpl->solver, sm, oss);
        }
    } catch (const cvc5::CVC5ApiException& e) {
        ERROR("CVC5 error adding assertion: ", e.what());
    }
}

SatResult CVC5Solver::checkSat() {
    try {
        cvc5::Result result = pImpl->solver.checkSat();
        if (result.isSat()) return SatResult::SAT;
        if (result.isUnsat()) return SatResult::UNSAT;
        if (result.isUnknown()) return SatResult::UNKNOWN;
        return SatResult::ERROR;
    } catch (const cvc5::CVC5ApiException& e) {
        ERROR("CVC5 error checking sat: ", e.what());
        return SatResult::ERROR;
    }
}

#else

class CVC5Solver::Impl {};

CVC5Solver::CVC5Solver() : pImpl(nullptr) {
    ERROR("CVC5 support not compiled in");
    throw std::runtime_error("CVC5 support not available");
}

CVC5Solver::~CVC5Solver() = default;

SatResult CVC5Solver::checkSat(const std::string&) { return SatResult::ERROR; }
SatResult CVC5Solver::checkSatIncremental(const std::string&) { return SatResult::ERROR; }
void CVC5Solver::push() {}
void CVC5Solver::pop() {}
void CVC5Solver::reset() {}
std::string CVC5Solver::getModel() { return ""; }
std::string CVC5Solver::getUnsatCore() { return ""; }
void CVC5Solver::addAssertion(const std::string&) {}
SatResult CVC5Solver::checkSat() { return SatResult::ERROR; }

#endif

Check::Check(SolverType type) 
    : currentSolverType(type), initialized(false) {
    initializeSolver();
}

void Check::setSolver(SolverType type) {
    currentSolverType = type;
    initializeSolver();
}

SatResult Check::checkFormula(const std::string& formula) {
    if (!initialized) {
        initializeSolver();
    }
    if (!solver) {
        ERROR("Solver not initialized");
        return SatResult::ERROR;
    }
    
    DEBUG("Checking formula: ", formula.substr(0, 100), "...");
    auto start = std::chrono::high_resolution_clock::now();
    
    SatResult result = solver->checkSat(formula);
    
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
    
    switch (result) {
        case SatResult::SAT:
            INFO("Formula is SAT (", duration.count(), "ms)");
            break;
        case SatResult::UNSAT:
            INFO("Formula is UNSAT (", duration.count(), "ms)");
            break;
        case SatResult::UNKNOWN:
            WARN("Formula result is UNKNOWN (", duration.count(), "ms)");
            break;
        case SatResult::ERROR:
            ERROR("Error checking formula (", duration.count(), "ms)");
            break;
    }
    
    return result;
}

SatResult Check::checkFormulaIncremental(const std::string& assertion) {
    if (!initialized) {
        initializeSolver();
    }
    if (!solver) {
        ERROR("Solver not initialized");
        return SatResult::ERROR;
    }
    
    DEBUG("Checking incremental assertion: ", assertion.substr(0, 100), "...");
    SatResult result = solver->checkSatIncremental(assertion);
    
    switch (result) {
        case SatResult::SAT:
            DEBUG("Incremental check: SAT");
            break;
        case SatResult::UNSAT:
            DEBUG("Incremental check: UNSAT");
            break;
        case SatResult::UNKNOWN:
            DEBUG("Incremental check: UNKNOWN");
            break;
        case SatResult::ERROR:
            ERROR("Incremental check: ERROR");
            break;
    }
    
    return result;
}

void Check::pushContext() {
    if (solver) {
        solver->push();
        DEBUG("Pushed solver context");
    }
}

void Check::popContext() {
    if (solver) {
        solver->pop();
        DEBUG("Popped solver context");
    }
}

void Check::resetSolver() {
    if (solver) {
        solver->reset();
        DEBUG("Reset solver");
    }
}

std::string Check::getModel() {
    if (solver) {
        return solver->getModel();
    }
    return "";
}

std::string Check::getUnsatCore() {
    if (solver) {
        return solver->getUnsatCore();
    }
    return "";
}

Check& Check::getInstance() {
    static Check instance;
    return instance;
}

void Check::initializeSolver() {
    try {
        switch (currentSolverType) {
            case SolverType::Z3:
                solver = std::make_unique<Z3Solver>();
                INFO("Initialized Z3 solver");
                break;
            case SolverType::CVC5:
                solver = std::make_unique<CVC5Solver>();
                INFO("Initialized CVC5 solver");
                break;
            default:
                ERROR("Unknown solver type");
                throw std::runtime_error("Unknown solver type");
        }
        initialized = true;
    } catch (const std::exception& e) {
        ERROR("Failed to initialize solver: ", e.what());
        throw;
    }
}

void Check::addAssertion(const std::string& assertion) {
    if (!initialized) {
        initializeSolver();
    }
    if (!solver) {
        ERROR("Solver not initialized");
        return;
    }
    
    DEBUG("Adding assertion: ", assertion);
    solver->addAssertion(assertion);
}

SatResult Check::checkSat() {
    if (!initialized) {
        initializeSolver();
    }
    if (!solver) {
        ERROR("Solver not initialized");
        return SatResult::ERROR;
    }
    
    DEBUG("Checking satisfiability...");
    auto start = std::chrono::high_resolution_clock::now();
    
    SatResult result = solver->checkSat();
    
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
    
    switch (result) {
        case SatResult::SAT:
            INFO("Result: SAT (", duration.count(), "ms)");
            break;
        case SatResult::UNSAT:
            INFO("Result: UNSAT (", duration.count(), "ms)");
            break;
        case SatResult::UNKNOWN:
            WARN("Result: UNKNOWN (", duration.count(), "ms)");
            break;
        case SatResult::ERROR:
            ERROR("Result: ERROR (", duration.count(), "ms)");
            break;
    }
    
    return result;
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
    auto variables = context.getVariables();
    
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
    
    auto assertions = context.getAssertions();
    for (const auto& assertion : assertions) {
        ss << "(assert ";
        dumpSMTLIB2(assertion, ss);
        ss << ")\n";
    }
    ss << "(check-sat)\n";
    return ss.str();
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
    
    auto variables = context.getVariables();
    
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
    
    auto assertions = context.getAssertions();
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

void IncrementalSolver::initializeFromParsedData() {
}

} 
#include "Solver.h"
#include "Logger.h"
#include "Context.h"
#include "parser.h"
#include "kind.h"
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <filesystem>
#include <chrono>
#include <unordered_map>
#include <boost/unordered_map.hpp>

#ifdef ENABLE_Z3
#include <z3++.h>
#endif

#ifdef ENABLE_CVC5
#include <cvc5/cvc5.h>
#include <cvc5/cvc5_parser.h>
#endif

std::vector<std::string> splitString(const std::string& str, const std::string& delimiter) {
    std::vector<std::string> result;
    if (delimiter.empty()) {
        for (char c : str) {
            result.push_back(std::string(1, c));
        }
        return result;
    }
    
    size_t start = 0;
    size_t end = str.find(delimiter);
    
    while (end != std::string::npos) {
        result.push_back(str.substr(start, end - start));
        start = end + delimiter.length();
        end = str.find(delimiter, start);
    }
    result.push_back(str.substr(start));
    
    return result;
}

std::string cleanQuotes(const std::string& str) {
    if (str.length() >= 2 && str.front() == '"' && str.back() == '"') {
        return str.substr(1, str.length() - 2);
    }
    return str;
}

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
        p.set("model", true);
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
        pImpl->variables.clear();
        
        std::istringstream ss(formula);
        std::string line;
        std::string currentFormula;
        
        while (std::getline(ss, line)) {
            if (line.find("(declare-fun") != std::string::npos) {
                size_t nameStart = line.find(' ', line.find('(')) + 1;
                size_t nameEnd = line.find(' ', nameStart);
                std::string varName = line.substr(nameStart, nameEnd - nameStart);
                
                if (line.find("String") != std::string::npos) {
                    z3::sort string_sort = pImpl->ctx.string_sort();
                    pImpl->variables.insert({varName, pImpl->ctx.constant(varName.c_str(), string_sort)});
                } else if (line.find("Int") != std::string::npos) {
                    pImpl->variables.insert({varName, pImpl->ctx.int_const(varName.c_str())});
                } else if (line.find("Real") != std::string::npos) {
                    pImpl->variables.insert({varName, pImpl->ctx.real_const(varName.c_str())});
                } else if (line.find("Bool") != std::string::npos) {
                    pImpl->variables.insert({varName, pImpl->ctx.bool_const(varName.c_str())});
                    DEBUG("Declared bool variable: ", varName);
                }
            }
            currentFormula += line + "\n";
        }
        
        z3::expr_vector exprs = pImpl->ctx.parse_string(currentFormula.c_str());
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
        if (!pImpl || !pImpl->solver) {
            return "";
        }
        
        z3::model model = pImpl->solver.get_model();
        
        std::stringstream ss;
        
        ss << "(\n";
        
        for (unsigned i = 0; i < model.size(); ++i) {
            z3::func_decl decl = model[i];
            z3::expr body = model.get_const_interp(decl);
            ss << "  (define-fun " << decl.name() << " () " << decl.range() << "\n";
            ss << "    " << body << ")\n";
        }
        
        if (model.size() == 0) {
            for (const auto& [name, expr] : pImpl->variables) {
                ss << "  (define-fun " << name << " () ";
                if (expr.is_int()) {
                    ss << "Int\n    0)\n";
                } else if (expr.is_real()) {
                    ss << "Real\n    0.0)\n";
                } else if (expr.is_bool()) {
                    ss << "Bool\n    false)\n";
                } else if (expr.get_sort().sort_kind() == Z3_SEQ_SORT) {
                    ss << "String\n    \"\")\n";
                } else {
                    ss << expr.get_sort() << "\n    " << expr << ")\n";
                }
            }
        }
        
        ss << ")";
        
        return ss.str();
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

void dumpSMTLIB2(const SMTParser::NodePtr& node, std::stringstream& ss) {
    if (node->isLeaf()) {
        ss << node->getName();
    } else {
        ss << "(" << SMTParser::kindToString(node->getKind());
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            ss << " ";
            dumpSMTLIB2(node->getChild(i), ss);
        }
        ss << ")";
    }
}

splitSolver::splitSolver(SolverType solverType)
    : currentSolverType(solverType), context(Context::getInstance()), 
      maxIterations(10), iterationCount(0) {
    initializeSolver();
}

void splitSolver::setSolver(SolverType type) {
    currentSolverType = type;
    initializeSolver();
}

void splitSolver::initializeSolver() {
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
    } catch (const std::exception& e) {
        ERROR("Failed to initialize solver: ", e.what());
        throw;
    }
}

SatResult splitSolver::checkFormula(const std::string& formula) {
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

SatResult splitSolver::checkFormulaIncremental(const std::string& assertion) {
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

void splitSolver::addAssertion(const std::string& assertion) {
    if (!solver) {
        ERROR("Solver not initialized");
        return;
    }
    
    DEBUG("Adding assertion: ", assertion);
    solver->addAssertion(assertion);
}

SatResult splitSolver::checkSat() {
    if (!solver) {
        ERROR("Solver not initialized");
        return SatResult::ERROR;
    }
    
    DEBUG("Checking satisfiability...");
    auto start = std::chrono::high_resolution_clock::now();
    
    std::string formula = context.getSMTLIB2(true);
    DEBUG("Sending formula to solver: ", formula.substr(0, 200), "...");
    
    SatResult result = solver->checkSat(formula);
    
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

void splitSolver::pushContext() {
    if (solver) {
        solver->push();
        DEBUG("Pushed solver context");
    }
}

void splitSolver::popContext() {
    if (solver) {
        solver->pop();
        DEBUG("Popped solver context");
    }
}

void splitSolver::resetSolver() {
    if (solver) {
        solver->reset();
        DEBUG("Reset solver");
    }
}

std::string splitSolver::getModel() {
    if (solver) {
        return solver->getModel();
    }
    return "";
}

std::string splitSolver::getUnsatCore() {
    if (solver) {
        return solver->getUnsatCore();
    }
    return "";
}

void splitSolver::setMaxIterations(int max) {
    maxIterations = max;
    DEBUG("Max iterations set to: ", max);
}

void splitSolver::setClauseGenerator(ClauseGenerator generator) {
    clauseGenerator = generator;
}

void splitSolver::setAnalysisFunction(AnalysisFunction analyzer) {
    analysisFunction = analyzer;
}

void splitSolver::rewriteFormula(Context& ctx) {
    resetSolver();
    auto splitAtConstNodes = ctx.getSplitAtConstNodes();
    auto numSplitsConstNodes = ctx.getNumSplitsConstNodes();
    replaceSplitAtConstNodes(ctx, splitAtConstNodes);
    replaceNumSplitsConstNodes(ctx, numSplitsConstNodes);
    auto splitAtVarNodes = ctx.getSplitAtVarNodes();
    auto numSplitsVarNodes = ctx.getNumSplitsVarNodes();
    getSplitNums(ctx, splitAtVarNodes, numSplitsVarNodes);
    ctx.setInitSplitNums();
    ctx.addConcatNodes();
    replaceNumSplitsVarNodes(ctx, numSplitsVarNodes);
    replaceSplitAtVarNodes(ctx, splitAtVarNodes);
}

void splitSolver::replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes) {
    if (splitAtConstNodes.empty()) {
        DEBUG("No SplitAt const nodes to replace");
        return;
    }
    
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : splitAtConstNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                std::string str = cleanQuotes(arg1->toString());
                std::string delimiter = cleanQuotes(arg2->toString());
                int index = std::stoi(arg3->toString());
                
                DEBUG("Processing str.split_at: str='", str, "', delimiter='", delimiter, "', index=", index);
                
                std::vector<std::string> parts;
                if (ctx.hasCachedSplit(str, delimiter)) {
                    parts = ctx.getCachedSplit(str, delimiter);
                    DEBUG("Using cached split result for: '", str, "' with delimiter '", delimiter, "'");
                } else {
                    parts = splitString(str, delimiter);
                    ctx.cacheSplit(str, delimiter, parts);
                    DEBUG("Cached split result for: '", str, "' with delimiter '", delimiter, "'");
                }
                
                if (index >= 0 && index < static_cast<int>(parts.size())) {
                    SMTParser::NodePtr replacement = Context::createStringConst(parts[index]);
                    replacementMap[node] = replacement;
                    
                    DEBUG("Original node content: ", node->toString());
                    DEBUG("Replacement node content: ", replacement->toString());
                    DEBUG("Replaced (str.split_at \"", str, "\" \"", delimiter, "\" ", index, ") with \"", parts[index], "\"");
                } else {
                    DEBUG("Index out of bounds for str.split_at");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        DEBUG("About to call updateAssertions with ", replacementMap.size(), " replacements");
        updateAssertionsWithReplacement(ctx, replacementMap);
        DEBUG("updateAssertions completed");
    }
}

void splitSolver::replaceNumSplitsConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitsConstNodes) {
    if (numSplitsConstNodes.empty()) {
        DEBUG("No NumSplits const nodes to replace");
        return;
    }
    
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : numSplitsConstNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string str = cleanQuotes(arg1->toString());
                std::string delimiter = cleanQuotes(arg2->toString());
                
                DEBUG("Processing str.num_splits: str='", str, "', delimiter='", delimiter, "'");
                
                std::vector<std::string> parts;
                if (ctx.hasCachedSplit(str, delimiter)) {
                    parts = ctx.getCachedSplit(str, delimiter);
                    DEBUG("Using cached split result for: '", str, "' with delimiter '", delimiter, "'");
                } else {
                    parts = splitString(str, delimiter);
                    ctx.cacheSplit(str, delimiter, parts);
                    DEBUG("Cached split result for: '", str, "' with delimiter '", delimiter, "'");
                }
                
                int count = static_cast<int>(parts.size());
                SMTParser::NodePtr replacement = Context::createIntConst(count);
                replacementMap[node] = replacement;
                
                DEBUG("Replaced (str.num_splits \"", str, "\" \"", delimiter, "\") with ", count);
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing num_splits node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        updateAssertionsWithReplacement(ctx, replacementMap);
    }
}

void splitSolver::updateAssertionsWithReplacement(Context& ctx, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap) {
    ctx.updateAssertionsWithNodes(replacementMap);
}

bool splitSolver::shouldContinue(SatResult result) {
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

void splitSolver::generateClause(Context& ctx, SatResult lastResult) {
    static int clauseIndex = 0;
    auto clauses = ctx.getClauses();
    if (lastResult == SatResult::SAT && clauseIndex < static_cast<int>(clauses.size())) {
        std::string clauseStr = clauses[clauseIndex].toSMT();
        clauseIndex++;
        INFO("Adding clause ", clauseIndex, ": ", clauseStr.substr(0, 100), "...");
        
        pushContext();
        std::string assertion = "(assert " + clauseStr + ")";
        addAssertion(assertion);
    }
}

bool splitSolver::analyzeResult(Context& ctx, SatResult result, const std::string& model) {
    (void)model;
    static int clauseIndex = 0;
    auto clauses = ctx.getClauses();
    if (result == SatResult::SAT) {
        if (clauseIndex < static_cast<int>(clauses.size())) {
            INFO("Current result is SAT, continuing to add more clauses (", clauseIndex, "/", clauses.size(), ")");
            return true;
        } else {
            INFO("All clauses added and result is still SAT");
            return false;
        }
    } else if (result == SatResult::UNSAT) {
        INFO("Result became UNSAT after adding clause ", clauseIndex, ", stopping iteration");
        return false;
    }
    return true;
}

std::string splitSolver::filterModel(const std::string& rawModel) {
    if (rawModel.empty()) {
        return "";
    }
    
    std::stringstream filteredModel;
    std::stringstream ss(rawModel);
    std::string line;
    bool inFilteredFunction = false;
    int parenCount = 0;
    bool modelStarted = false;
    
    while (std::getline(ss, line)) {
        if (line == "(" && !modelStarted) {
            filteredModel << line << "\n";
            modelStarted = true;
        } else if (line == ")" && modelStarted) {
            filteredModel << line;
        } else if (line.find("(define-fun") != std::string::npos) {
            if (line.find("_split_") == std::string::npos) {
                inFilteredFunction = true;
                filteredModel << line << "\n";
                parenCount = 1;
                for (char c : line.substr(line.find("(define-fun"))) {
                    if (c == '(') parenCount++;
                    else if (c == ')') parenCount--;
                }
                if (parenCount == 0) {
                    inFilteredFunction = false;
                }
            } else {
                inFilteredFunction = false;
                parenCount = 1;
                for (char c : line.substr(line.find("(define-fun"))) {
                    if (c == '(') parenCount++;
                    else if (c == ')') parenCount--;
                }
                if (parenCount > 0) {
                    inFilteredFunction = false;
                }
            }
        } else if (inFilteredFunction) {
            filteredModel << line << "\n";
            for (char c : line) {
                if (c == '(') parenCount++;
                else if (c == ')') parenCount--;
            }
            if (parenCount == 0) {
                inFilteredFunction = false;
            }
        } else if (!inFilteredFunction && parenCount > 0) {
            for (char c : line) {
                if (c == '(') parenCount++;
                else if (c == ')') parenCount--;
            }
            if (parenCount == 0) {
                inFilteredFunction = false;
            }
        }
    }
    
    return filteredModel.str();
}

bool splitSolver::shouldOutputModel() {
    DEBUG("Checking if model output is needed");
    return context.hasTask(strp::TaskType::GET_MODEL);
}

SatResult splitSolver::solve() {
    INFO("Starting solving process");
    iterationCount = 0;
    
    INFO("Rewriting formula");
    rewriteFormula(context);
    context.printCurrentSplitState();
    
    INFO("Checking satisfiability");
    SatResult result = checkSat();
    INFO("Initial result: ", static_cast<int>(result));
    
    while (shouldContinue(result)) {
        iterationCount++;
        INFO("=== Iteration ", iterationCount, " ===");
        
        if (result == SatResult::UNSAT) {
            if (context.hasMoreSplitCombinations()) {
                INFO("UNSAT detected, incrementing split numbers");
                
                if (context.incrementSplitNums()) {
                    DEBUG("New split state:");
                    context.printCurrentSplitState();
                    
                    resetSolver();
                    rewriteFormula(context);
                    result = checkSat();
                    continue;
                } else {
                    INFO("No more split number combinations available");
                    break;
                }
            } else {
                INFO("No more split combinations to try, formula is genuinely UNSAT");
                break;
            }
        } else if (result == SatResult::SAT) {
            break;
        } else if (result == SatResult::UNKNOWN) {
            WARN("Unknown result, trying to increment split numbers if possible");
            if (context.hasMoreSplitCombinations() && context.incrementSplitNums()) {
                DEBUG("Incremented split numbers due to UNKNOWN");
                context.printCurrentSplitState();
                
                resetSolver();
                rewriteFormula(context);
                result = checkSat();
                continue;
            } else {
                INFO("No more combinations to try with UNKNOWN result");
                break;
            }
        } else {
            ERROR("Solver error occurred, terminating");
            break;
        }
        
        if (analysisFunction && !analysisFunction(context, result, getModel())) {
            INFO("Analysis function indicates termination");
            break;
        }
        
        if (clauseGenerator) {
            std::string newClause = clauseGenerator(context, result);
            if (!newClause.empty()) {
                INFO("Adding new clause: ", newClause);
                pushContext();
                
                std::string assertion;
                if (newClause.find("(assert") == 0) {
                    assertion = newClause;
                } else {
                    assertion = "(assert " + newClause + ")";
                }
                addAssertion(assertion);
                result = checkSat();
            } else {
                DEBUG("No new clause generated");
                break;
            }
        }
    }
    
    if (iterationCount >= maxIterations) {
        if (result == SatResult::UNSAT) {
            result = SatResult::UNKNOWN;  // Set result but don't return early
        }
    }
    
    INFO("=== Split Solving Completed ===");
    INFO("Total iterations: ", iterationCount);
    INFO("Final result: ", 
         result == SatResult::SAT ? "SAT" : 
         result == SatResult::UNSAT ? "UNSAT" : 
         result == SatResult::UNKNOWN ? "UNKNOWN" : "ERROR");
    
    DEBUG("Final context contains: ", context.getVarCount(), " vars, ", context.getClauseCount(), " clauses");
    DEBUG("Final split state:");
    context.printCurrentSplitState();
    
    if (context.hasTask(strp::TaskType::CHECK_SAT)) {
        if (result == SatResult::SAT) {
            std::cout << "sat" << std::endl;
        } else if (result == SatResult::UNSAT) {
            std::cout << "unsat" << std::endl;
        } else {
            std::cout << "unknown" << std::endl;
        }
    }
    
    if (result == SatResult::SAT && context.hasTask(strp::TaskType::GET_MODEL)) {
        std::string rawModel = getModel();
        if (!rawModel.empty()) {
            std::string filteredModel = filterModel(rawModel);
            if (!filteredModel.empty()) {
                std::cout << filteredModel << std::endl;
            } else {
                DEBUG("No original variables found in model");
            }
        } else {
            DEBUG("No model available from solver");
        }
    }
    
    return result;
}

void splitSolver::getSplitNums(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes, const std::vector<SMTParser::NodePtr>& numSplitsVarNodes) {
    DEBUG("Analyzing split constraints from ", splitAtVarNodes.size(), " split_at nodes and ", numSplitsVarNodes.size(), " num_splits nodes");
    
    std::function<void(const SMTParser::NodePtr&, const std::set<SMTParser::NodePtr>&)> analyzeConstraint = 
        [&](const SMTParser::NodePtr& node, const std::set<SMTParser::NodePtr>& targetNodes) {
        if (!node) return;
        
        if (node->getKind() == SMTParser::NODE_KIND::NT_EQ && node->getChildrenSize() == 2) {
            auto left = node->getChild(0);
            auto right = node->getChild(1);
            
            if (targetNodes.count(left) && right->isConst()) {
                if (left->isStrNumSplits()) {
                    auto var = left->getChild(0);
                    auto delim = left->getChild(1);
                    if (var->isVar() && delim->isConst()) {
                        std::string variable = var->toString();
                        std::string delimiter = cleanQuotes(delim->toString());
                        int exactCount = std::stoi(right->toString());
                        ctx.updateSplitInfo(variable, delimiter, -1, -1, exactCount);
                    }
                }
            } else if (targetNodes.count(right) && left->isConst()) {
                if (right->isStrNumSplits()) {
                    auto var = right->getChild(0);
                    auto delim = right->getChild(1);
                    if (var->isVar() && delim->isConst()) {
                        std::string variable = var->toString();
                        std::string delimiter = cleanQuotes(delim->toString());
                        int exactCount = std::stoi(left->toString());
                        ctx.updateSplitInfo(variable, delimiter, -1, -1, exactCount);
                    }
                }
            }
        } else if (node->getKind() == SMTParser::NODE_KIND::NT_GE && node->getChildrenSize() == 2) {
            auto left = node->getChild(0);
            auto right = node->getChild(1);
            
            if (targetNodes.count(left) && right->isConst()) {
                auto var = left->getChild(0);
                auto delim = left->getChild(1);
                if (var->isVar() && delim->isConst()) {
                    std::string variable = var->toString();
                    std::string delimiter = cleanQuotes(delim->toString());
                    int minSplits = std::stoi(right->toString());
                    ctx.updateSplitInfo(variable, delimiter, std::max(1, minSplits), -1, -1);
                }
            } else if (targetNodes.count(right) && left->isConst()) {
                auto var = right->getChild(0);
                auto delim = right->getChild(1);
                if (var->isVar() && delim->isConst()) {
                    std::string variable = var->toString();
                    std::string delimiter = cleanQuotes(delim->toString());
                    int maxSplits = std::stoi(left->toString());
                    ctx.updateSplitInfo(variable, delimiter, -1, maxSplits, -1);
                }
            }
        } else if (node->getKind() == SMTParser::NODE_KIND::NT_LE && node->getChildrenSize() == 2) {
            auto left = node->getChild(0);
            auto right = node->getChild(1);
            
            if (targetNodes.count(left) && right->isConst()) {
                auto var = left->getChild(0);
                auto delim = left->getChild(1);
                if (var->isVar() && delim->isConst()) {
                    std::string variable = var->toString();
                    std::string delimiter = cleanQuotes(delim->toString());
                    int maxSplits = std::stoi(right->toString());
                    ctx.updateSplitInfo(variable, delimiter, -1, maxSplits, -1);
                }
            } else if (targetNodes.count(right) && left->isConst()) {
                auto var = right->getChild(0);
                auto delim = right->getChild(1);
                if (var->isVar() && delim->isConst()) {
                    std::string variable = var->toString();
                    std::string delimiter = cleanQuotes(delim->toString());
                    int minSplits = std::stoi(left->toString());
                    ctx.updateSplitInfo(variable, delimiter, minSplits, -1, -1);
                }
            }
        }
        
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            analyzeConstraint(node->getChild(i), targetNodes);
        }
    };
    
    std::set<SMTParser::NodePtr> allTargetNodes;
    
    for (auto& node : numSplitsVarNodes) {
        if (node->getChildrenSize() >= 2) {
            auto arg1 = node->getChild(0);
            auto arg2 = node->getChild(1);
            
            if (arg1->isVar() && arg2->isConst()) {
                std::string variable = arg1->toString();
                std::string delimiter = cleanQuotes(arg2->toString());
                ctx.addSplitInfo(variable, delimiter);
                allTargetNodes.insert(node);
            }
        }
    }
    
    for (auto& node : splitAtVarNodes) {
        if (node->getChildrenSize() >= 3) {
            auto arg1 = node->getChild(0);
            auto arg2 = node->getChild(1);
            auto arg3 = node->getChild(2);
            
            if (arg1->isVar() && arg2->isConst() && arg3->isConst()) {
                std::string variable = arg1->toString();
                std::string delimiter = cleanQuotes(arg2->toString());
                int index = std::stoi(arg3->toString());
                
                ctx.addSplitInfo(variable, delimiter);
                ctx.addRequiredIndex(variable, delimiter, index);
            }
        }
    }
    
    auto assertions = ctx.getAssertions();
    for (auto& assertion : assertions) {
        analyzeConstraint(assertion, allTargetNodes);
    }
    
    if (ctx.hasConflictingSplitConstraints()) {
        ERROR("Detected conflicting split constraints, adding false constraint");
        ctx.addFalseConstraint();
    }
    
}

void splitSolver::replaceNumSplitsVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitsVarNodes) {
    if (numSplitsVarNodes.empty()) {
        DEBUG("No NumSplits var nodes to replace");
        return;
    }
    
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : numSplitsVarNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                if (arg1->isVar() && arg2->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = cleanQuotes(arg2->toString());
                    
                    SplitInfo* info = ctx.getSplitInfo(variable, delimiter);
                    if (info) {
                        int count = info->hasExactCount ? info->exactCount : info->minSplits;
                        SMTParser::NodePtr replacement = Context::createIntConst(count);
                        replacementMap[node] = replacement;
                        
                        DEBUG("Replaced (str.num_splits ", variable, " \"", delimiter, "\") with ", count);
                    } else {
                        DEBUG("No split info found for variable ", variable, " with delimiter ", delimiter);
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing num_splits var node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        updateAssertionsWithReplacement(ctx, replacementMap);
        DEBUG("Replaced ", replacementMap.size(), " num_splits var nodes");
    }
}

void splitSolver::replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes) {
    if (splitAtVarNodes.empty()) {
        DEBUG("No SplitAt var nodes to replace");
        return;
    }
    
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : splitAtVarNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                if (arg1->isVar() && arg2->isConst() && arg3->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = cleanQuotes(arg2->toString());
                    int index = std::stoi(arg3->toString());
                    
                    SplitInfo* info = ctx.getSplitInfo(variable, delimiter);
                    if (info) {
                        int currentSplits = info->hasExactCount ? info->exactCount : info->minSplits;
                        
                        if (index >= currentSplits) {
                            DEBUG("Index ", index, " is out of bounds for current split count ", currentSplits, 
                                  " for variable ", variable, " with delimiter ", delimiter);
                            
                            SMTParser::NodePtr emptyStringReplacement = Context::createStringConst("");
                            replacementMap[node] = emptyStringReplacement;
                            ctx.addFalseConstraint();
                            DEBUG("Replaced out-of-bounds (str.split_at ", variable, " \"", delimiter, "\" ", index, ") with empty string and added false constraint");
                            continue;
                        }
                        
                        std::string auxVarName = variable + "_split_" + std::to_string(index);
                        SMTParser::NodePtr replacement = Context::createStringVar(auxVarName);
                        if (replacement) {
                            replacementMap[node] = replacement;
                            DEBUG("Replaced (str.split_at ", variable, " \"", delimiter, "\" ", index, ") with auxiliary variable ", auxVarName);
                        } else {
                            DEBUG("Failed to create auxiliary variable ", auxVarName, " - replacing with empty string and adding false constraint");
                            SMTParser::NodePtr emptyStringReplacement = Context::createStringConst("");
                            replacementMap[node] = emptyStringReplacement;
                            ctx.addFalseConstraint();
                        }
                    } else {
                        DEBUG("No split info found for variable ", variable, " with delimiter ", delimiter, " - replacing with empty string");
                        SMTParser::NodePtr emptyStringReplacement = Context::createStringConst("");
                        replacementMap[node] = emptyStringReplacement;
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split_at var node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        updateAssertionsWithReplacement(ctx, replacementMap);
        DEBUG("Replaced ", replacementMap.size(), " split_at var nodes");
    }
}

}
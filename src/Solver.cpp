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
#include <iomanip>

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

}
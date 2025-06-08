#include "Split.h"
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
#include <algorithm>

std::string cleanQuotes(const std::string& str) {
    if (str.length() >= 2 && str.front() == '"' && str.back() == '"') {
        return str.substr(1, str.length() - 2);
    }
    return str;
}

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

namespace strp {

splitSolver::splitSolver(SolverType solverType)
    : currentSolverType(solverType), context(Context::getInstance()) {
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

// checked
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
                DEBUG("Node: ", ctx.getSource(node));
                std::string str = cleanQuotes(arg1->toString());
                std::string delimiter = cleanQuotes(arg2->toString());
                int index = std::stoi(arg3->toString());
                
                Division* division = ctx.getDivision(str, delimiter);
                if (division && index >= 0 && index < division->getConstSplitNums()) {
                    std::string splitValue = division->getConstSplit(index);
                    std::string quotedValue = "\"" + splitValue + "\"";
                    SMTParser::NodePtr replacement = Context::createStringConst(quotedValue);
                    replacementMap[node] = replacement;
                    DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                } else {
                    SMTParser::NodePtr replacement = Context::createBoolConst(false);
                    boost::unordered_set<SMTParser::NodePtr> atoms = ctx.getAtomsForSplitNode(node);
                    for (auto& atom : atoms) {
                        DEBUG("Atom: ", ctx.getSource(atom));
                        replacementMap[atom] = replacement;
                    }
                    DEBUG("Index out of bounds for str.split_at or division not found");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split node: ", e.what());
        }
    }
    Context::replaceNodes(replacementMap);
}

void splitSolver::replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes) {
    if (splitAtVarNodes.empty()) {
        DEBUG("No SplitAt var nodes to replace");
        return;
    }
    
    DEBUG("Replacing ", splitAtVarNodes.size(), " split_at var nodes with auxiliary variables");
    
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : splitAtVarNodes) {
        try {
            if (node && node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                DEBUG("Node: ", ctx.getSource(node));
                
                if (arg1->isVar() && arg2->isConst() && arg3->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = cleanQuotes(arg2->toString());
                    int index = std::stoi(arg3->toString());
                    
                    Division* division = ctx.getDivision(variable, delimiter);
                    if (division && division->getDividedType() == "var") {
                        auto splitNums = division->getVarSplitNumsAppeared();
                        if (std::find(splitNums.begin(), splitNums.end(), index) != splitNums.end()) {
                            std::string xi = variable + "_split_" + std::to_string(index);
                            SMTParser::NodePtr replacement = Context::createStringVar(xi);
                            
                            if (replacement) {
                                replacementMap[node] = replacement;
                                DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                            } else {
                                WARN("Failed to create replacement variable: ", xi);
                            }
                        } else {
                            DEBUG("Index ", index, " not found in division for variable ", variable);
                        }
                    } else {
                        WARN("Division not found for variable ", variable, " with delimiter '", delimiter, "'");
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        DEBUG("About to call replaceNodes with ", replacementMap.size(), " replacements");
        Context::replaceNodes(replacementMap);
        DEBUG("replaceNodes completed");
    } else {
        DEBUG("No replacements to make");
    }
}

void splitSolver::addAuxiliaryVariables(Context& ctx, const Division& division) {
    std::string variable = division.getDivided();
    std::string delimiter = division.getDelimiter();
    int maxIndex = division.getVarMaxSplitNumAppeared();
    
    std::string x_split = variable + "_split";
    std::string x_last = variable + "_last";
    
    ctx.declareStringVar(x_split);
    ctx.declareStringVar(x_last);
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string xi = variable + "_split_" + std::to_string(i);
        ctx.declareStringVar(xi);
    }
    
    for (int idx : division.getVarSplitNumsAppeared()) {
        std::string si = "b_" + variable + "_split_num_" + std::to_string(idx);
        ctx.declareBoolVar(si);
    }
    
    DEBUG("Declared auxiliary variables for ", variable, " with delimiter '", delimiter, "'");
}

void splitSolver::addBasicConstraints(Context& ctx, const Division& division) {
    std::string variable = division.getDivided();
    std::string delimiter = division.getDelimiter();
    int maxIndex = division.getVarMaxSplitNumAppeared();
    
    std::string x_split = variable + "_split";
    std::string x_last = variable + "_last";
    
    std::string constraint1 = "(= " + variable + " (str.++ " + x_split + " " + x_last + "))";
    ctx.addAssertion(constraint1);
    DEBUG("Added constraint: ", constraint1);
    
    std::string constraint2 = "(or (= " + x_last + " \"\") (str.prefixof \"" + delimiter + "\" " + x_last + "))";
    ctx.addAssertion(constraint2);
    DEBUG("Added constraint: ", constraint2);
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string xi = variable + "_split_" + std::to_string(i);
        std::string notContains = "(not (str.contains " + xi + " \"" + delimiter + "\"))";
        ctx.addAssertion(notContains);
        DEBUG("Added constraint: ", notContains);
    }
}

void splitSolver::addEquivalenceConstraints(Context& ctx, const Division& division) {
    std::string variable = division.getDivided();
    std::string delimiter = division.getDelimiter();
    std::string x_split = variable + "_split";
    
    for (int idx : division.getVarSplitNumsAppeared()) {
        std::string si = "b_" + variable + "_split_num_" + std::to_string(idx);
        std::string equiv;
        
        if (idx == 0) {
            equiv = "(= " + si + " (= " + x_split + " " + variable + "_split_0))";
        } else {
            equiv = "(= " + si + " (= " + x_split + " (str.++";
            for (int j = 0; j < idx; ++j) {
                equiv += " " + variable + "_split_" + std::to_string(j) + " \"" + delimiter + "\"";
            }
            equiv += " " + variable + "_split_" + std::to_string(idx) + ")))";
        }
        
        ctx.addAssertion(equiv);
        DEBUG("Added constraint: ", equiv);
    }
}

void splitSolver::addAuxiliaryNodes(Context& ctx) {
    DEBUG("Adding auxiliary nodes for variable splits");
    
    splitAtAtoms = ctx.getSplitAtVarNodes();
    
    auto divisions = ctx.getAllDivisions();
    
    for (const auto& [key, division] : divisions) {
        if (division.getDividedType() == "var") {
            DEBUG("Processing var division: ", division.getDivided(), " with delimiter '", division.getDelimiter(), "'");
            
            addAuxiliaryVariables(ctx, division);
            addBasicConstraints(ctx, division);
            addEquivalenceConstraints(ctx, division);
        }
    }
    
    DEBUG("Completed adding auxiliary nodes for ", divisions.size(), " divisions");
}



void splitSolver::addAuxiliaryLemmas(Context& ctx) {
    DEBUG("Adding auxiliary lemmas for variable splits");
    
    auto assertions = ctx.getAssertions();
    auto divisions = ctx.getAllDivisions();
    
    for (const auto& [key, division] : divisions) {
        if (division.getDividedType() == "var") {
            std::string variable = division.getDivided();
            std::string delimiter = division.getDelimiter();
            auto allIndices = division.getVarSplitNumsAppeared();
            
            for (auto& assertion : assertions) {
                for (auto& splitAtom : splitAtAtoms) {
                    if (containsSplitAtom(assertion, splitAtom) && 
                        splitAtom->getChildrenSize() >= 3) {
                        
                        auto arg1 = splitAtom->getChild(0);
                        auto arg2 = splitAtom->getChild(1);
                        auto arg3 = splitAtom->getChild(2);
                        
                        if (arg1->isVar() && arg2->isConst() &&
                            arg1->toString() == variable && 
                            cleanQuotes(arg2->toString()) == delimiter) {
                            
                            int index = std::stoi(arg3->toString());
                            
                            std::string disjuncts = "";
                            bool first = true;
                            for (int idx : allIndices) {
                                if (idx >= index) {
                                    if (!first) disjuncts += " ";
                                    disjuncts += "b_" + variable + "_split_num_" + std::to_string(idx);
                                    first = false;
                                }
                            }
                            
                            std::string lemma;
                            if (disjuncts.find(" ") != std::string::npos) {
                                lemma = "(=> " + nodeToString(assertion) + " (or " + disjuncts + "))";
                            } else {
                                lemma = "(=> " + nodeToString(assertion) + " " + disjuncts + ")";
                            }
                            
                            ctx.addAssertion(lemma);
                            DEBUG("Added lemma: ", lemma);
                        }
                    }
                }
            }
        }
    }
}

bool splitSolver::containsSplitAtom(const SMTParser::NodePtr& node, const SMTParser::NodePtr& splitAtom) {
    if (!node || !splitAtom) return false;
    
    if (node == splitAtom) return true;
    
    for (size_t i = 0; i < node->getChildrenSize(); ++i) {
        if (containsSplitAtom(node->getChild(i), splitAtom)) {
            return true;
        }
    }
    
    return false;
}

std::string splitSolver::nodeToString(const SMTParser::NodePtr& node) {
    if (!node) return "";
    
    std::stringstream ss;
    dumpSMTLIB2(node, ss);
    return ss.str();
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
            bool isAuxiliaryVar = false;
            
            if (line.find("_split_") != std::string::npos ||
                line.find("_split ") != std::string::npos ||
                line.find("_last ") != std::string::npos ||
                line.find("b_") != std::string::npos) {
                isAuxiliaryVar = true;
            }
            
            if (!isAuxiliaryVar) {
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

void splitSolver::rewriteFormula(Context& ctx) {
    resetSolver();
    ctx.updateDivisions();
    addAuxiliaryNodes(ctx);
    addAuxiliaryLemmas(ctx);
    
    auto splitAtConstNodes = ctx.getSplitAtConstNodes();
    replaceSplitAtConstNodes(ctx, splitAtConstNodes);
    auto splitAtVarNodes = ctx.getSplitAtVarNodes();
    replaceSplitAtVarNodes(ctx, splitAtVarNodes);
    
    DEBUG("=== Final SMT-LIB after rewriting ===");
    LOG5(ctx.getSMTLIB2(true));
    DEBUG("=== End of SMT-LIB ===");
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

SatResult splitSolver::solve() {
    INFO("Starting solving process");
    
    INFO("Rewriting formula");
    rewriteFormula(context);
    
    INFO("Checking satisfiability");
    SatResult result = checkSat();
    
    INFO("Final result: ", 
         result == SatResult::SAT ? "SAT" : 
         result == SatResult::UNSAT ? "UNSAT" : 
         result == SatResult::UNKNOWN ? "UNKNOWN" : "ERROR");
    
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

} 
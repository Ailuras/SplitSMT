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
                if (division && index >= 0 && index < division->getSplitNums()) {
                    std::string splitValue = division->getSplit(index);
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
                
                if (arg1->isVar() && arg2->isConst() && arg3->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = cleanQuotes(arg2->toString());
                    int index = std::stoi(arg3->toString());
                    
                    std::string xi = variable + std::to_string(index);
                    SMTParser::NodePtr replacement = Context::createStringVar(xi);
                    
                    if (replacement) {
                        replacementMap[node] = replacement;
                        
                        DEBUG("Original node content: ", node->toString());
                        DEBUG("Replacement node content: ", replacement->toString());
                        DEBUG("Replaced (str.split_at ", variable, " \"", delimiter, "\" ", index, ") with ", xi);
                    } else {
                        WARN("Failed to create replacement variable: ", xi);
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
    }
}

void splitSolver::addAuxiliaryNodes(Context& ctx) {
    DEBUG("Adding auxiliary nodes for ", splitMaxIndices.size(), " splits");
    
    std::vector<std::string> allDeclarations;
    std::vector<std::string> allConstraints;
    
    for (const auto& [key, maxIndex] : splitMaxIndices) {
        size_t pos = key.find("##");
        if (pos == std::string::npos) continue;
        
        std::string variable = key.substr(0, pos);
        std::string delimiter = key.substr(pos + 2);
        
        DEBUG("Processing split: variable=", variable, ", delimiter='", delimiter, "', maxIndex=", maxIndex);
        
        std::string x_split = variable + "_split";
        std::string x_last = variable + "_last";
        
        allDeclarations.push_back("(declare-fun " + x_split + " () String)");
        allDeclarations.push_back("(declare-fun " + x_last + " () String)");
        
        for (int i = 0; i <= maxIndex; ++i) {
            std::string xi = variable + std::to_string(i);
            allDeclarations.push_back("(declare-fun " + xi + " () String)");
        }
        
        for (int i = 0; i <= maxIndex; ++i) {
            std::string si = "s" + std::to_string(i) + "_" + variable + "_" + delimiter;
            allDeclarations.push_back("(declare-fun " + si + " () Bool)");
        }
        
        std::string assertion1 = "(assert (= " + variable + " (str.++ " + x_split + " " + x_last + ")))";
        allConstraints.push_back(assertion1);
        DEBUG("Added constraint: ", assertion1);
        
        std::string assertion2 = "(assert (or (= " + x_last + " \"\") (str.prefixof \"" + delimiter + "\" " + x_last + ")))";
        allConstraints.push_back(assertion2);
        DEBUG("Added constraint: ", assertion2);
        
        for (int i = 0; i <= maxIndex; ++i) {
            std::string xi = variable + std::to_string(i);
            std::string notContains = "(assert (not (str.contains " + xi + " \"" + delimiter + "\")))";
            allConstraints.push_back(notContains);
            DEBUG("Added constraint: ", notContains);
        }
        
        for (int i = 0; i <= maxIndex; ++i) {
            std::string si = "s" + std::to_string(i) + "_" + variable + "_" + delimiter;
            std::string equiv;
            
            if (i == 0) {
                equiv = "(assert (iff " + si + " (= " + x_split + " " + variable + "0)))";
            } else {
                equiv = "(assert (iff " + si + " (= " + x_split + " (str.++";
                for (int j = 0; j < i; ++j) {
                    equiv += " " + variable + std::to_string(j) + " \"" + delimiter + "\"";
                }
                equiv += " " + variable + std::to_string(i) + "))))";
            }
            
            allConstraints.push_back(equiv);
            DEBUG("Added constraint: ", equiv);
        }
    }
    
    if (!allDeclarations.empty() || !allConstraints.empty()) {
        addConstraintsBatch(ctx, allDeclarations, allConstraints);
    }
}

std::string splitSolver::generateSplitKey(const std::string& variable, const std::string& delimiter) {
    return variable + "##" + delimiter;
}

void splitSolver::findSplitAtAtoms(const SMTParser::NodePtr& node, std::vector<SMTParser::NodePtr>& atoms) {
    if (!node) return;
    
    if (node->isStrSplitAt() && node->getChildrenSize() >= 3) {
        auto arg1 = node->getChild(0);
        auto arg2 = node->getChild(1);
        if (arg1->isVar() && arg2->isConst()) {
            atoms.push_back(node);
            DEBUG("Found split_at atom: ", node->toString());
        }
    }
    
    for (size_t i = 0; i < node->getChildrenSize(); ++i) {
        findSplitAtAtoms(node->getChild(i), atoms);
    }
}

void splitSolver::addAuxiliaryLemmas(Context& ctx) {
    DEBUG("Adding auxiliary lemmas for ", splitAtAtoms.size(), " split_at atoms");
    
    std::vector<std::string> allLemmas;
    auto assertions = ctx.getAssertions();
    
    for (auto& assertion : assertions) {
        addLemmasForAssertion(ctx, assertion, allLemmas);
    }
    
    if (!allLemmas.empty()) {
        addConstraintsBatch(ctx, {}, allLemmas);
    }
}

void splitSolver::addLemmasForAssertion(Context& ctx, const SMTParser::NodePtr& node, std::vector<std::string>& allLemmas) {
    if (!node) return;
    
    for (auto& splitAtom : splitAtAtoms) {
        if (containsSplitAtom(node, splitAtom)) {
            std::string variable = splitAtom->getChild(0)->toString();
            std::string delimiter = cleanQuotes(splitAtom->getChild(1)->toString());
            int index = std::stoi(splitAtom->getChild(2)->toString());
            
            std::string si = "s" + std::to_string(index) + "_" + variable + "_" + delimiter;
            std::string lemma = "(assert (=> " + nodeToString(node) + " " + si + "))";
            
            allLemmas.push_back(lemma);
            DEBUG("Added lemma: ", lemma);
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

void splitSolver::addConstraintsBatch(Context& ctx, const std::vector<std::string>& declarations, const std::vector<std::string>& constraints) {
    if (declarations.empty() && constraints.empty()) {
        return;
    }
    
    DEBUG("Adding batch: ", declarations.size(), " declarations and ", constraints.size(), " constraints");
    
    std::stringstream ss;
    ss << "(set-logic QF_S)\n";
    
    auto originalSMT = ctx.getSMTLIB2(true);
    
    std::istringstream originalStream(originalSMT);
    std::string line;
    
    while (std::getline(originalStream, line)) {
        if (line.find("(set-logic") == 0) {
            continue;
        }
        if (line.find("(check-sat") == 0 || line.find("(exit") == 0) {
            break;
        }
        ss << line << "\n";
    }
    
    for (const auto& decl : declarations) {
        ss << decl << "\n";
    }
    
    for (const auto& constraint : constraints) {
        ss << constraint << "\n";
    }
    
    ss << "(check-sat)\n(exit)\n";
    
    std::string combinedSMT = ss.str();
    
    std::string tempFilename = "/tmp/smtlib_parser_batch_temp.smt2";
    std::ofstream tempFile(tempFilename);
    if (tempFile.is_open()) {
        tempFile << combinedSMT;
        tempFile.close();
        
        ctx.clear();
        
        std::ifstream tempFileRead(tempFilename);
        std::string content((std::istreambuf_iterator<char>(tempFileRead)), std::istreambuf_iterator<char>());
        tempFileRead.close();
        
        if (ctx.parseString(content)) {
            DEBUG("Batch processing completed successfully");
        }
        
        std::filesystem::remove(tempFilename);
    }
}

void splitSolver::getSplitNums(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes) {
    DEBUG("Analyzing split constraints from ", splitAtVarNodes.size(), " split_at nodes");
    
    splitMaxIndices.clear();
    
    for (auto& node : splitAtVarNodes) {
        if (node && node->getChildrenSize() >= 3) {
            auto arg1 = node->getChild(0);
            auto arg2 = node->getChild(1);
            auto arg3 = node->getChild(2);
            
            if (arg1->isVar() && arg2->isConst() && arg3->isConst()) {
                std::string variable = arg1->toString();
                std::string delimiter = cleanQuotes(arg2->toString());
                int index = std::stoi(arg3->toString());
                
                std::string key = generateSplitKey(variable, delimiter);
                
                if (splitMaxIndices.find(key) == splitMaxIndices.end()) {
                    splitMaxIndices[key] = index;
                    DEBUG("Found split: variable=", variable, ", delimiter='", delimiter, "', index=", index);
                } else {
                    splitMaxIndices[key] = std::max(splitMaxIndices[key], index);
                    DEBUG("Updated max index for split: variable=", variable, ", delimiter='", delimiter, "', max_index=", splitMaxIndices[key]);
                }
            }
        }
    }
    
    auto assertions = ctx.getAssertions();
    for (auto& assertion : assertions) {
        findSplitAtAtoms(assertion, splitAtAtoms);
    }
    
    DEBUG("Found ", splitMaxIndices.size(), " different splits with ", splitAtAtoms.size(), " split_at atoms");
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

void splitSolver::rewriteFormula(Context& ctx) {
    resetSolver();
    ctx.updateDivisions();
    auto splitAtConstNodes = ctx.getSplitAtConstNodes();
    replaceSplitAtConstNodes(ctx, splitAtConstNodes);
    // auto splitAtVarNodes = ctx.getSplitAtVarNodes();
    // addAuxiliaryNodes(ctx);
    // addAuxiliaryLemmas(ctx);
    // replaceSplitAtVarNodes(ctx, splitAtVarNodes);
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
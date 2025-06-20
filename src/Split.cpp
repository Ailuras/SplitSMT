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

#include <iomanip>
#include <algorithm>
#include <functional>

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
            case SolverType::EXTERNAL_Z3:
                solver = std::make_unique<ExternalSolver>(SolverType::EXTERNAL_Z3);
                INFO("Initialized external Z3 solver");
                break;
            case SolverType::EXTERNAL_CVC5:
                solver = std::make_unique<ExternalSolver>(SolverType::EXTERNAL_CVC5);
                INFO("Initialized external CVC5 solver");
                break;
            case SolverType::EXTERNAL_OSTRICH:
                solver = std::make_unique<ExternalSolver>(SolverType::EXTERNAL_OSTRICH);
                INFO("Initialized external Ostrich solver");
                break;
            case SolverType::EXTERNAL_Z3_NOODLER:
                solver = std::make_unique<ExternalSolver>(SolverType::EXTERNAL_Z3_NOODLER);
                INFO("Initialized external Z3-Noodler solver");
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

void splitSolver::replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes) {
    if (splitAtConstNodes.empty()) {
        DEBUG("No SplitAt const nodes to replace");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
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
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    if (index >= 0 && index < constDiv->getSplitNums()) {
                        std::string splitValue = constDiv->getSplit(index);
                        std::string quotedValue = "\"" + splitValue + "\"";
                        SMTParser::NodePtr replacement = Context::createStringConst(quotedValue);
                        replacementMap[node] = replacement;
                        DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                    }
                } else {
                    SMTParser::NodePtr replacement = Context::createBoolConst(false);
                    std::unordered_set<SMTParser::NodePtr> atoms = ctx.getAtomsForSplitNode(node);
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

void splitSolver::replaceSplitEndConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndConstNodes) {
    if (splitEndConstNodes.empty()) {
        DEBUG("No SplitEnd const nodes to replace");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    for (auto& node : splitEndConstNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                DEBUG("SplitEnd Node: ", ctx.getSource(node));
                std::string str = cleanQuotes(arg1->toString());
                std::string delimiter = cleanQuotes(arg2->toString());
                int index = std::stoi(arg3->toString());
                
                Division* division = ctx.getDivision(str, delimiter);
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    if (index >= 0 && index < constDiv->getSplitNums()) {
                        std::string splitEndValue = "";
                        const auto& splits = constDiv->getSplits();
                        
                        for (int i = index; i < static_cast<int>(splits.size()); ++i) {
                            if (i > index) {
                                splitEndValue += delimiter;
                            }
                            splitEndValue += splits[i];
                        }
                        
                        std::string quotedValue = "\"" + splitEndValue + "\"";
                        SMTParser::NodePtr replacement = Context::createStringConst(quotedValue);
                        replacementMap[node] = replacement;
                        DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                    } else {
                        SMTParser::NodePtr replacement = Context::createStringConst("\"\"");
                        replacementMap[node] = replacement;
                        DEBUG("Index out of bounds for str.split_rest, replaced with empty string");
                    }
                } else {
                    SMTParser::NodePtr replacement = Context::createBoolConst(false);
                    std::unordered_set<SMTParser::NodePtr> atoms = ctx.getAtomsForSplitNode(node);
                    for (auto& atom : atoms) {
                        DEBUG("Atom: ", ctx.getSource(atom));
                        replacementMap[atom] = replacement;
                    }
                    DEBUG("Division not found for str.split_rest");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split_rest node: ", e.what());
        }
    }
    Context::replaceNodes(replacementMap);
}

void splitSolver::replaceNumSplitConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitConstNodes) {
    if (numSplitConstNodes.empty()) {
        DEBUG("No NumSplit const nodes to replace");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    for (auto& node : numSplitConstNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                DEBUG("NumSplit Node: ", ctx.getSource(node));
                std::string str = cleanQuotes(arg1->toString());
                std::string delimiter = cleanQuotes(arg2->toString());
                
                Division* division = ctx.getDivision(str, delimiter);
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    int numSplits = constDiv->getSplitNums();
                    SMTParser::NodePtr replacement = Context::createIntConst(numSplits);
                    replacementMap[node] = replacement;
                    DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                } else {
                    SMTParser::NodePtr replacement = Context::createIntConst(0);
                    std::unordered_set<SMTParser::NodePtr> atoms = ctx.getAtomsForSplitNode(node);
                    for (auto& atom : atoms) {
                        DEBUG("Atom: ", ctx.getSource(atom));
                        replacementMap[atom] = replacement;
                    }
                    DEBUG("Division not found for str.num_splits, replacing with 0");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing num_splits node: ", e.what());
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
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
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
                    if (division && division->isVarType()) {
                        VarDivision* varDiv = static_cast<VarDivision*>(division);
                        auto splitNums = varDiv->getSplitNumsAppeared();
                        if (std::find(splitNums.begin(), splitNums.end(), index) != splitNums.end()) {
                            std::string hashStr = division->getHashString();
                            std::string xi = hashStr + "_split_" + std::to_string(index);
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

void splitSolver::replaceSplitEndVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndVarNodes) {
    if (splitEndVarNodes.empty()) {
        DEBUG("No SplitEnd var nodes to replace");
        return;
    }
    
    DEBUG("Replacing ", splitEndVarNodes.size(), " split_rest var nodes with auxiliary variables");
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : splitEndVarNodes) {
        try {
            if (node && node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                DEBUG("SplitEnd Node: ", ctx.getSource(node));
                
                if (arg1->isVar() && arg2->isConst() && arg3->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = cleanQuotes(arg2->toString());
                    int index = std::stoi(arg3->toString());
                    
                    Division* division = ctx.getDivision(variable, delimiter);
                    if (division && division->isVarType()) {
                        VarDivision* varDiv = static_cast<VarDivision*>(division);
                        auto splitEndNums = varDiv->getSplitEndNumsAppeared();
                        if (std::find(splitEndNums.begin(), splitEndNums.end(), index) != splitEndNums.end()) {
                            std::string hashStr = division->getHashString();
                            std::string xi = hashStr + "_split_end_" + std::to_string(index);
                            SMTParser::NodePtr replacement = Context::createStringVar(xi);
                            
                            if (replacement) {
                                replacementMap[node] = replacement;
                                DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                            } else {
                                WARN("Failed to create replacement variable: ", xi);
                            }
                        } else {
                            DEBUG("Index ", index, " not found in split_rest division for variable ", variable);
                        }
                    } else {
                        WARN("Division not found for variable ", variable, " with delimiter '", delimiter, "'");
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split_rest node: ", e.what());
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

void splitSolver::replaceNumSplitVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitVarNodes) {
    if (numSplitVarNodes.empty()) {
        DEBUG("No NumSplit var nodes to replace");
        return;
    }
    
    DEBUG("Replacing ", numSplitVarNodes.size(), " num_splits var nodes with length expressions");
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : numSplitVarNodes) {
        try {
            if (node && node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                DEBUG("NumSplit Node: ", ctx.getSource(node));
                
                if (arg1->isVar() && arg2->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = cleanQuotes(arg2->toString());
                    
                    Division* division = ctx.getDivision(variable, delimiter);
                    if (division && division->isVarType() && division->isNumSplitsUsed()) {
                        std::string hashStr = division->getHashString();
                        std::string numSplitsVar = hashStr + "_num_splits";
                        SMTParser::NodePtr replacement = Context::createIntVar(numSplitsVar);
                        
                        if (replacement) {
                            replacementMap[node] = replacement;
                            DEBUG("Replaced ", ctx.getSource(node), " with ", ctx.getSource(replacement));
                        } else {
                            WARN("Failed to create replacement variable: ", numSplitsVar);
                        }
                    } else {
                        WARN("Division not found or num_splits not used for variable ", variable, " with delimiter '", delimiter, "'");
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing num_splits node: ", e.what());
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

void splitSolver::convertZeroParamDefineFuns(Context& ctx) {
    DEBUG("Converting zero-parameter define-fun to variables + assertions using topological sort");
    
    // Step 1: Collect all zero-parameter functions
    std::vector<FunctionDependency> functions;
    auto allFunctions = ctx.getFunctions();
    
    for (const auto& func : allFunctions) {
        if (func && func->getFuncBody() && func->getFuncParamsSize() == 0) {
            std::string funcName = func->getName();
            std::string funcBody = ctx.nodeToString(func->getFuncBody());
            std::string sortName = func->getSort()->toString();
            
            functions.emplace_back(func, funcName, sortName, funcBody);
            DEBUG("Found zero-parameter function: ", funcName, " : ", sortName);
        }
    }
    
    if (functions.empty()) {
        DEBUG("No zero-parameter functions to convert");
        return;
    }
    
    // Step 2: Build dependency graph
    updateFunctionDependencies(ctx, functions);
    
    // Step 3: Get topological order
    std::vector<std::string> processingOrder = topologicalSort(functions);
    
    if (processingOrder.empty()) {
        WARN("Failed to create topological order - possible circular dependencies");
        return;
    }
    
    // Step 4: Process functions in topological order
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    std::unordered_map<std::string, std::string> functionToVariable; // func_name -> var_name
    std::vector<std::string> assertionsToAdd;
    std::vector<std::string> functionsToRemove;
    
    DEBUG("Processing ", processingOrder.size(), " functions in topological order");
    
    for (const std::string& funcName : processingOrder) {
        // Find the function
        auto it = std::find_if(functions.begin(), functions.end(),
                              [&funcName](const FunctionDependency& f) { return f.name == funcName; });
        
        if (it == functions.end()) continue;
        
        const FunctionDependency& funcDep = *it;
        
        // Create replacement variable
        SMTParser::NodePtr replacementVar = nullptr;
        if (funcDep.returnType == "Int") {
            ctx.declareIntVar(funcName);
            replacementVar = Context::createIntVar(funcName);
        } else if (funcDep.returnType == "Bool") {
            ctx.declareBoolVar(funcName);
            replacementVar = Context::createBoolVar(funcName);
        } else if (funcDep.returnType == "String") {
            ctx.declareStringVar(funcName);
            replacementVar = Context::createStringVar(funcName);
        }
        
        if (replacementVar) {
            replacementMap[funcDep.function] = replacementVar;
            functionToVariable[funcName] = funcName; // Same name for variable
            
            std::string assertion = "(= " + funcName + " " + funcDep.body + ")";
            assertionsToAdd.push_back(assertion);
            functionsToRemove.push_back(funcName);
            
            DEBUG("Will convert function ", funcName, " to variable with assertion: ", assertion);
        }
    }
    
    // Step 5: Apply all replacements at once
    if (!replacementMap.empty()) {
        DEBUG("Applying ", replacementMap.size(), " function-to-variable replacements");
        Context::replaceNodes(replacementMap);
    }
    
    // Step 6: Remove function definitions
    if (!functionsToRemove.empty()) {
        ctx.removeFunDef(functionsToRemove);
        DEBUG("Removed ", functionsToRemove.size(), " function definitions");
    }
    
    // Step 7: Add assertions
    for (const auto& assertion : assertionsToAdd) {
        ctx.addAssertion(assertion);
        DEBUG("Added assertion: ", assertion);
    }
    
    // Step 8: Handle remaining func_def nodes with proper mapping
    DEBUG("Searching for remaining func_def nodes to replace");
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> funcDefReplacements;
    
    auto assertions = ctx.getAssertions();
    for (auto& assertion : assertions) {
        findAndReplaceFuncDefNodes(assertion, funcDefReplacements, ctx, functionToVariable);
    }
    
    if (!funcDefReplacements.empty()) {
        DEBUG("Found ", funcDefReplacements.size(), " func_def nodes to replace");
        Context::replaceNodes(funcDefReplacements);
        DEBUG("Replaced remaining func_def nodes");
    }
    
    DEBUG("Completed zero-parameter function conversion using topological sort");
}

void splitSolver::updateFunctionDependencies(Context& ctx, std::vector<FunctionDependency>& functions) {
    DEBUG("Building function dependency graph");
    
    // Create a map for quick lookup
    std::unordered_map<std::string, FunctionDependency*> funcMap;
    for (auto& func : functions) {
        funcMap[func.name] = &func;
    }
    
    // Find dependencies for each function
    for (auto& func : functions) {
        for (const auto& [otherName, otherFunc] : funcMap) {
            if (otherName != func.name && func.body.find(otherName) != std::string::npos) {
                func.dependencies.insert(otherName);
                DEBUG("Function ", func.name, " depends on ", otherName);
            }
        }
    }
    
    DEBUG("Built dependency graph for ", functions.size(), " functions");
}

std::vector<std::string> splitSolver::topologicalSort(const std::vector<FunctionDependency>& functions) {
    DEBUG("Performing topological sort");
    
    std::vector<std::string> result;
    std::unordered_set<std::string> visited;
    std::unordered_set<std::string> visiting;
    
    // Create function map for quick lookup
    std::unordered_map<std::string, const FunctionDependency*> funcMap;
    for (const auto& func : functions) {
        funcMap[func.name] = &func;
    }
    
    std::function<bool(const std::string&)> dfs = [&](const std::string& funcName) -> bool {
        if (visiting.count(funcName)) {
            WARN("Circular dependency detected involving function: ", funcName);
            return false; // Circular dependency
        }
        
        if (visited.count(funcName)) {
            return true; // Already processed
        }
        
        visiting.insert(funcName);
        
        auto it = funcMap.find(funcName);
        if (it != funcMap.end()) {
            for (const std::string& dep : it->second->dependencies) {
                if (!dfs(dep)) {
                    return false;
                }
            }
        }
        
        visiting.erase(funcName);
        visited.insert(funcName);
        result.push_back(funcName);
        return true;
    };
    
    // Process all functions
    for (const auto& func : functions) {
        if (!visited.count(func.name)) {
            if (!dfs(func.name)) {
                ERROR("Failed to create topological sort due to circular dependencies");
                return {};
            }
        }
    }
    
    DEBUG("Topological sort completed. Processing order: ", 
          [&]() {
              std::string order;
              for (const auto& name : result) {
                  if (!order.empty()) order += " -> ";
                  order += name;
              }
              return order;
          }());
    
    return result;
}

void splitSolver::findAndReplaceFuncDefNodes(SMTParser::NodePtr node, 
                                           std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacements,
                                           Context& ctx,
                                           const std::unordered_map<std::string, std::string>& functionToVariable) {
    if (!node) return;
    
    // Check if this node is a func_def node
    if (node->getName() == "func_def" || node->getName().find("func_def") != std::string::npos) {
        DEBUG("Found func_def node: ", ctx.getSource(node));
        
        // Try to determine which function this func_def represents
        // This is a heuristic approach - in practice, we need more sophisticated analysis
        
        // For now, try to match with the context or use a heuristic
        // If we can't determine the exact function, we need to analyze the surrounding context
        
        // First, try to find if this func_def appears in a context where we can infer the function
        std::string contextStr = ctx.getSource(node);
        
        // Look for function names in the context
        SMTParser::NodePtr replacement = nullptr;
        for (const auto& [funcName, varName] : functionToVariable) {
            // This is a simplified heuristic - in a more robust implementation,
            // we would need to track the exact mapping during parsing
            if (contextStr.find(funcName) != std::string::npos) {
                replacement = Context::createIntVar(varName);
                DEBUG("Mapping func_def to variable: ", varName, " (inferred from function: ", funcName, ")");
                break;
            }
        }
        
        // If we can't determine the exact mapping, create a placeholder but log a warning
        if (!replacement) {
            WARN("Could not determine exact function mapping for func_def node. Creating placeholder.");
            std::string placeholderName = "func_def_replacement_" + std::to_string(replacements.size());
            ctx.declareIntVar(placeholderName);
            replacement = Context::createIntVar(placeholderName);
            DEBUG("Created placeholder: ", placeholderName);
        }
        
        if (replacement) {
            replacements[node] = replacement;
        }
    }
    
    // Recursively process children
    for (size_t i = 0; i < node->getChildrenSize(); ++i) {
        findAndReplaceFuncDefNodes(node->getChild(i), replacements, ctx, functionToVariable);
    }
}

void splitSolver::addAuxiliaryVariables(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    int maxIndex = varDiv->getMaxSplitNumAppeared();
    
    if (maxIndex == -1 && !division->isNumSplitsUsed()) {
        DEBUG("Skipping auxiliary variables for ", variable, " - no split_at, split_rest or num_splits usage");
        return;
    }
    
    if (division->isNumSplitsUsed()) {
        std::string numSplitsVar = hashStr + "_num_splits";
        ctx.declareIntVar(numSplitsVar);
        DEBUG("Declared num_splits variable: ", numSplitsVar);
    }
    
    if (maxIndex == -1) {
        DEBUG("Only num_splits used for ", variable, " - skipping split variables");
        return;
    }
    
    std::string x_split = hashStr + "_split";
    std::string x_last = hashStr + "_last";
    
    ctx.declareStringVar(x_split);
    ctx.declareStringVar(x_last);
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string xi = hashStr + "_split_" + std::to_string(i);
        ctx.declareStringVar(xi);
    }
    
    for (int idx : varDiv->getSplitNumsAppeared()) {
        std::string si = "b_" + hashStr + "_split_num_" + std::to_string(idx);
        ctx.declareBoolVar(si);
    }
    
    for (int idx : varDiv->getSplitEndNumsAppeared()) {
        std::string xi = hashStr + "_split_end_" + std::to_string(idx);
        ctx.declareStringVar(xi);
    }
    
    if (delimiter.length() != 1) {
        for (int i = 0; i <= maxIndex; ++i) {
            std::string bi = "b_" + hashStr + "_split_index_" + std::to_string(i);
            std::string xi = hashStr + "_split_index_" + std::to_string(i);
            ctx.declareBoolVar(bi);
            ctx.declareIntVar(xi);
        }
    }
    
    DEBUG("Declared auxiliary variables for ", variable, " with delimiter '", delimiter, "' using hash ", hashStr);
}

void splitSolver::addBasicConstraints(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    int maxIndex = varDiv->getMaxSplitNumAppeared();
    
    if (maxIndex == -1) {
        DEBUG("Skipping basic constraints for ", variable, " - no split_at usage");
        return;
    }
    
    std::string x_split = hashStr + "_split";
    std::string x_last = hashStr + "_last";
    
    std::string constraint1 = "(= " + variable + " (str.++ " + x_split + " " + x_last + "))";
    ctx.addAssertion(constraint1);
    DEBUG("Added constraint: ", constraint1);
    
    std::string constraint2 = "(or (= " + x_last + " \"\") (str.prefixof \"" + delimiter + "\" " + x_last + "))";
    ctx.addAssertion(constraint2);
    DEBUG("Added constraint: ", constraint2);
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string xi = hashStr + "_split_" + std::to_string(i);
        std::string notContains = "(not (str.contains " + xi + " \"" + delimiter + "\"))";
        ctx.addAssertion(notContains);
        DEBUG("Added constraint: ", notContains);
    }
}

void splitSolver::addEquivalenceConstraints(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    std::string x_split = hashStr + "_split";
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    
    for (int idx : varDiv->getSplitNumsAppeared()) {
        std::string si = "b_" + hashStr + "_split_num_" + std::to_string(idx);
        std::string equiv;
        
        if (idx == 0) {
            equiv = "(= " + si + " (= " + x_split + " " + hashStr + "_split_0))";
        } else {
            equiv = "(= " + si + " (= " + x_split + " (str.++";
            for (int j = 0; j < idx; ++j) {
                equiv += " " + hashStr + "_split_" + std::to_string(j) + " \"" + delimiter + "\"";
            }
            equiv += " " + hashStr + "_split_" + std::to_string(idx) + ")))";
        }
        
        ctx.addAssertion(equiv);
        DEBUG("Added constraint: ", equiv);
    }
}

void splitSolver::addIndexConstraints(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    int maxIndex = varDiv->getMaxSplitNumAppeared();
    
    if (maxIndex == -1) {
        DEBUG("Skipping index constraints for ", variable, " - no split_at usage");
        return;
    }
    
    if (delimiter.length() == 1) {
        return;
    }
    std::string x_split = hashStr + "_split";
    int delimiterLen = static_cast<int>(delimiter.length());

    for (int i = 0; i <= maxIndex; ++i) {
        std::string xi = hashStr + "_split_index_" + std::to_string(i);
        std::string constraint;
        if (i == 0) {
            constraint = "(= " + xi + " (str.indexof " + x_split + " \"" + delimiter + "\" 0))";
        } else {
            std::string prevXi = hashStr + "_split_index_" + std::to_string(i - 1);
            constraint = "(= " + xi + " (str.indexof " + x_split + " \"" + delimiter + "\" (+ " + prevXi + " " + std::to_string(delimiterLen) + ")))";
        }
        ctx.addAssertion(constraint);
        DEBUG("Added index constraint: ", constraint);
    }
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string bi = "b_" + hashStr + "_split_index_" + std::to_string(i);
        std::string xi = hashStr + "_split_index_" + std::to_string(i);
        std::string splitVar = hashStr + "_split_" + std::to_string(i);
        std::string constraint;
        if (i == 0) {
            constraint = "(=> " + bi + " (or (= " + xi + " (str.len " + splitVar + ")) (= " + xi + " -1)))";
        } else {
            std::string prevXi = hashStr + "_split_index_" + std::to_string(i - 1);
            constraint = "(=> " + bi + " (or (= (- " + xi + " " + prevXi + " " + std::to_string(delimiterLen) + ") (str.len " + splitVar + ")) (= " + xi + " -1)))";
        }
        ctx.addAssertion(constraint);
        DEBUG("Added conditional constraint: ", constraint);
    }
}

void splitSolver::addIndexLemmas(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    
    if (delimiter.length() == 1) {
        return;
    }
    
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    auto splitNums = varDiv->getSplitNumsAppeared();
    
    for (int idx : splitNums) {
        std::string si = "b_" + hashStr + "_split_num_" + std::to_string(idx);
        
        if (idx == 0) {
            std::string bi = "b_" + hashStr + "_split_index_0";
            std::string constraint = "(=> " + si + " " + bi + ")";
            ctx.addAssertion(constraint);
            DEBUG("Added index lemma: ", constraint);
        } else {
            std::string constraint = "(=> " + si + " (and";
            for (int i = 0; i <= idx; ++i) {
                constraint += " b_" + hashStr + "_split_index_" + std::to_string(i);
            }
            constraint += "))";
            ctx.addAssertion(constraint);
            DEBUG("Added index lemma: ", constraint);
        }
    }
}

void splitSolver::addNumSplitsConstraints(Context& ctx, const Division* division) {
    if (!division->isNumSplitsUsed()) {
        return;
    }
    
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    std::string numSplitsVar = hashStr + "_num_splits";
    
    std::string lengthBefore = hashStr + "_length_before";
    std::string lengthAfter = hashStr + "_length_after";
    
    ctx.declareIntVar(lengthBefore);
    ctx.declareIntVar(lengthAfter);
    
    std::string constraint1 = "(= (str.len " + variable + ") " + lengthBefore + ")";
    ctx.addAssertion(constraint1);
    DEBUG("Added length before constraint: ", constraint1);
    
    std::string constraint2 = "(= (str.len (str.replace_all " + variable + " \"" + delimiter + "\" \"\")) " + lengthAfter + ")";
    ctx.addAssertion(constraint2);
    DEBUG("Added length after constraint: ", constraint2);
    
    std::string constraint3;
    int delimiterLen = static_cast<int>(delimiter.length());
    constraint3 = "(= " + numSplitsVar + " (div (- " + lengthBefore + " " + lengthAfter + ") " + std::to_string(delimiterLen) + "))";
    ctx.addAssertion(constraint3);
    DEBUG("Added num_splits calculation constraint: ", constraint3);
    
    std::string nonNegConstraint = "(>= " + numSplitsVar + " 1)";
    ctx.addAssertion(nonNegConstraint);
    DEBUG("Added non-negative constraint: ", nonNegConstraint);
}

void splitSolver::addAuxiliaryNodes(Context& ctx) {
    DEBUG("Adding auxiliary nodes for variable splits");
    
    splitAtTerms = ctx.getSplitAtVarNodes();
    
    const auto& divisions = ctx.getAllDivisions();
    
    for (const auto& [key, divisionPtr] : divisions) {
        if (divisionPtr->isVarType()) {
            DEBUG("Processing var division: ", divisionPtr->getDivided(), " with delimiter '", divisionPtr->getDelimiter(), "'");
            
            addAuxiliaryVariables(ctx, divisionPtr.get());
            addBasicConstraints(ctx, divisionPtr.get());
            addEquivalenceConstraints(ctx, divisionPtr.get());
            addIndexConstraints(ctx, divisionPtr.get());
            addIndexLemmas(ctx, divisionPtr.get());
            addNumSplitsConstraints(ctx, divisionPtr.get());
        }
    }
    
    DEBUG("Completed adding auxiliary nodes for ", divisions.size(), " divisions");
}

void splitSolver::addAuxiliaryLemmas(Context& ctx) {
    DEBUG("Adding auxiliary lemmas for variable splits");
    
    auto splitEndVarNodes = ctx.getSplitEndVarNodes();
    
    const auto& divisions = ctx.getAllDivisions();
    
    for (const auto& [key, divisionPtr] : divisions) {
        if (divisionPtr->isVarType()) {
            std::string variable = divisionPtr->getDivided();
            std::string delimiter = divisionPtr->getDelimiter();
            std::string hashStr = divisionPtr->getHashString();
            const VarDivision* varDiv = static_cast<const VarDivision*>(divisionPtr.get());
            auto allIndices = varDiv->getSplitNumsAppeared();
            
            for (auto& splitAtTerm : splitAtTerms) {
                if (splitAtTerm->getChildrenSize() >= 3) {
                    auto arg1 = splitAtTerm->getChild(0);
                    auto arg2 = splitAtTerm->getChild(1);
                    auto arg3 = splitAtTerm->getChild(2);
                    
                    if (arg1->toString() == variable && cleanQuotes(arg2->toString()) == delimiter) {
                        int index = std::stoi(arg3->toString());
                        
                        auto atoms = ctx.getAtomsForSplitNode(splitAtTerm);
                        
                        for (auto& atom : atoms) {
                            std::string disjuncts = "";
                            bool first = true;
                            for (int idx : allIndices) {
                                if (idx >= index) {
                                    if (!first) disjuncts += " ";
                                    disjuncts += "b_" + hashStr + "_split_num_" + std::to_string(idx);
                                    first = false;
                                }
                            }
                            
                            std::string lemma;
                            if (disjuncts.find(" ") != std::string::npos) {
                                lemma = "(=> " + nodeToString(atom) + " (or " + disjuncts + "))";
                            } else {
                                lemma = "(=> " + nodeToString(atom) + " " + disjuncts + ")";
                            }
                            
                            ctx.addAssertion(lemma);
                            DEBUG("Added lemma: ", lemma);
                        }
                    }
                }
            }
            
            for (auto& splitEndTerm : splitEndVarNodes) {
                if (splitEndTerm->getChildrenSize() >= 3) {
                    auto arg1 = splitEndTerm->getChild(0);
                    auto arg2 = splitEndTerm->getChild(1);
                    auto arg3 = splitEndTerm->getChild(2);
                    
                    if (arg1->toString() == variable && cleanQuotes(arg2->toString()) == delimiter) {
                        int index = std::stoi(arg3->toString());
                        
                        auto atoms = ctx.getAtomsForSplitNode(splitEndTerm);
                        
                        for (auto& atom : atoms) {
                            std::string disjuncts = "";
                            bool first = true;
                            for (int idx : allIndices) {
                                if (idx >= index) {
                                    if (!first) disjuncts += " ";
                                    disjuncts += "b_" + hashStr + "_split_num_" + std::to_string(idx);
                                    first = false;
                                }
                            }
                            
                            std::string lemma;
                            if (disjuncts.find(" ") != std::string::npos) {
                                lemma = "(=> " + nodeToString(atom) + " (or " + disjuncts + "))";
                            } else {
                                lemma = "(=> " + nodeToString(atom) + " " + disjuncts + ")";
                            }
                            
                            ctx.addAssertion(lemma);
                            DEBUG("Added split_rest lemma: ", lemma);
                        }
                    }
                }
            }
            
            for (int idx : allIndices) {
                std::string bSplitNum = "b_" + hashStr + "_split_num_" + std::to_string(idx);
                
                for (int endIdx : varDiv->getSplitEndNumsAppeared()) {
                    if (endIdx <= idx) {
                        std::string splitEndVar = hashStr + "_split_end_" + std::to_string(endIdx);
                        std::string splitVar = hashStr + "_split_" + std::to_string(idx);
                        std::string lastVar = hashStr + "_last";
                        
                        std::string lemma = "(=> " + bSplitNum + " (= (str.++ " + splitVar + " " + lastVar + ") " + splitEndVar + "))";
                        ctx.addAssertion(lemma);
                        DEBUG("Added split_rest auxiliary lemma: ", lemma);
                    }
                }
            }
        }
    }
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
            
            std::size_t definePos = line.find("(define-fun ");
            if (definePos != std::string::npos) {
                std::size_t nameStart = definePos + 12;
                std::size_t spacePos = line.find(" ", nameStart);
                if (spacePos != std::string::npos) {
                    std::string varName = line.substr(nameStart, spacePos - nameStart);
                    
                    if (varName.find("div") == 0 || varName.find("b_div") == 0) {
                        isAuxiliaryVar = true;
                    }
                }
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

    INFO("Converting zero-parameter functions to variables");
    convertZeroParamDefineFuns(ctx);
    DEBUG("=== Final SMT-LIB after converting zero-parameter functions to variables ===");
    LOG5("\n", ctx.getSMTLIB2(true));
    DEBUG("=== End of SMT-LIB after converting zero-parameter functions to variables ===");

    addAuxiliaryNodes(ctx);
    addAuxiliaryLemmas(ctx);
    
    auto splitAtConstNodes = ctx.getSplitAtConstNodes();
    replaceSplitAtConstNodes(ctx, splitAtConstNodes);
    auto splitEndConstNodes = ctx.getSplitEndConstNodes();
    replaceSplitEndConstNodes(ctx, splitEndConstNodes);
    auto numSplitConstNodes = ctx.getNumSplitConstNodes();
    replaceNumSplitConstNodes(ctx, numSplitConstNodes);
    
    auto splitAtVarNodes = ctx.getSplitAtVarNodes();
    replaceSplitAtVarNodes(ctx, splitAtVarNodes);
    auto splitEndVarNodes = ctx.getSplitEndVarNodes();
    replaceSplitEndVarNodes(ctx, splitEndVarNodes);
    auto numSplitVarNodes = ctx.getNumSplitVarNodes();
    replaceNumSplitVarNodes(ctx, numSplitVarNodes);
    
    std::vector<std::string> splitFuncNames = ctx.getSplitRelatedFunctionNames();
    ctx.removeFunDef(splitFuncNames);
    
    DEBUG("=== Final SMT-LIB after rewriting ===");
    LOG5("\n", ctx.getSMTLIB2(true));
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
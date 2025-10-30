#include "Split.h"
#include "utils/Logger.h"
#include "Context.h"
#include "utils/Config.h"
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <filesystem>
#include <chrono>
#include <unordered_map>
#include <iterator>
#include <iomanip>
#include <algorithm>
#include <functional>
#include <exception>
#include <cctype>
#include <string_view>
#include <utility>

// Internal delimiter used for splitting operations
#define INTERNAL_DELIMITER "\"#\""
// #define INTERNAL_DELIMITER "\"\\u{2FFFF}\""

std::string cleanQuotes(const std::string& str) {
    if (str.length() >= 2 && str.front() == '"' && str.back() == '"') {
        return str.substr(1, str.length() - 2);
    }
    return str;
}

int parseInteger(const std::string& str) {
    if (str.empty()) {
        return 0;
    }
    
    if (str[0] == '(' && str.back() == ')') {
        if (str.substr(1, 2) == "- " && str.length() > 4) {
            std::string numPart = str.substr(3, str.length() - 4);
            try {
                return -std::stoi(numPart);
            } catch (const std::exception&) {
                return 0;
            }
        }
    }
    
    try {
        return std::stoi(str);
    } catch (const std::exception&) {
        return 0;
    }
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

namespace {
bool hasUnsupportedScopeNode(const SMTParser::NodePtr& node) {
    if (!node) {
        return false;
    }

    using SMTParser::NODE_KIND;
    auto kind = node->getKind();
    if (kind == NODE_KIND::NT_FORALL ||
        kind == NODE_KIND::NT_EXISTS ||
        kind == NODE_KIND::NT_LET ||
        kind == NODE_KIND::NT_LET_CHAIN ||
        kind == NODE_KIND::NT_LET_BIND_VAR_LIST) {
        return true;
    }

    for (size_t i = 0; i < node->getChildrenSize(); ++i) {
        if (hasUnsupportedScopeNode(node->getChild(i))) {
            return true;
        }
    }
    return false;
}

std::string normalizeDelimiterLiteral(const std::string& literal) {
    if (!literal.empty() && literal.front() == '"') {
        return strp::Parser::normalizeStringLiteral(literal);
    }
    return literal;
}
} // namespace

namespace strp {

SplitSolver::SplitSolver(SolverType solverType, Context& ctx)
    : currentSolverType(solverType), context(ctx) {
    initializeSolver();
}

void SplitSolver::setSolver(SolverType type) {
    currentSolverType = type;
    initializeSolver();
}

void SplitSolver::initializeSolver() {
    try {
        switch (currentSolverType) {
            case SolverType::Z3:
                solver = std::make_unique<ExternalSolver>(SolverType::Z3);
                INFO("Initialized external Z3 solver");
                break;
            case SolverType::CVC5:
                solver = std::make_unique<ExternalSolver>(SolverType::CVC5);
                INFO("Initialized external CVC5 solver");
                break;
            case SolverType::OSTRICH:
                solver = std::make_unique<ExternalSolver>(SolverType::OSTRICH);
                INFO("Initialized external Ostrich solver");
                break;
            case SolverType::Z3_NOODLER:
                solver = std::make_unique<ExternalSolver>(SolverType::Z3_NOODLER);
                INFO("Initialized external Z3-Noodler solver");
                break;
            default:
                ERROR("Unknown external solver type");
                throw std::runtime_error("Unknown external solver type");
        }
    } catch (const std::exception& e) {
        ERROR("Failed to initialize solver: ", e.what());
        throw;
    }
}

void SplitSolver::resetSolver() {
    if (solver) {
        solver->reset();
        DEBUG("Reset solver");
    }
}

std::string SplitSolver::getModel() {
    if (solver) {
        return solver->getModel();
    }
    return "";
}

std::string SplitSolver::getUnsatCore() {
    if (solver) {
        return solver->getUnsatCore();
    }
    return "";
}

bool SplitSolver::containsUnsupportedScopes(Context& ctx) {
    auto assertions = ctx.getParser().getAssertions();
    for (const auto& assertion : assertions) {
        if (hasUnsupportedScopeNode(assertion)) {
            return true;
        }
    }
    return false;
}

const std::string& SplitSolver::getFallbackDefinitions() const {
    static std::string cachedDefinitions;
    static bool loaded = false;

    if (!loaded) {
        loaded = true;
        try {
            auto path = config::projectRoot() / "src" / "utils" / "RA.txt";
            std::ifstream file(path);
            if (!file.is_open()) {
                ERROR("Failed to open fallback definition file: ", path.string());
            } else {
                std::stringstream buffer;
                buffer << file.rdbuf();
                cachedDefinitions = buffer.str();
                DEBUG("Loaded fallback split definitions from ", path.string());
            }
        } catch (const std::exception& e) {
            ERROR("Error loading fallback definition file: ", e.what());
        }
    }

    return cachedDefinitions;
}

std::string SplitSolver::injectFallbackDefinitions(const std::string& formula) const {
    const std::string& definitions = getFallbackDefinitions();
    if (definitions.empty()) {
        WARN("Fallback definitions are empty; returning original formula");
        return formula;
    }

    if (formula.find("(define-fun split_at ") != std::string::npos ||
        formula.find("(define-fun split_rest ") != std::string::npos ||
        formula.find("(define-fun split_at_re ") != std::string::npos ||
        formula.find("(define-fun split_rest_re ") != std::string::npos) {
        return formula;
    }

    auto isInsertionLine = [](std::string_view line) {
        while (!line.empty() && std::isspace(static_cast<unsigned char>(line.front()))) {
            line.remove_prefix(1);
        }
        if (line.empty()) {
            return false;
        }
        return line.rfind("(declare", 0) == 0 ||
               line.rfind("(define", 0) == 0 ||
               line.rfind("(assert", 0) == 0;
    };

    size_t insertPos = formula.size();
    size_t pos = 0;
    while (pos < formula.size()) {
        size_t lineEnd = formula.find('\n', pos);
        size_t nextPos = (lineEnd == std::string::npos) ? formula.size() : lineEnd + 1;
        std::string_view line(formula.c_str() + pos,
                              (lineEnd == std::string::npos ? formula.size() : lineEnd) - pos);
        if (isInsertionLine(line)) {
            insertPos = pos;
            break;
        }
        pos = nextPos;
    }

    std::string result;
    std::string definitionsWithNewline = definitions;
    if (!definitionsWithNewline.empty() && definitionsWithNewline.back() != '\n') {
        definitionsWithNewline.push_back('\n');
    }

    result.reserve(formula.size() + definitionsWithNewline.size() + 2);
    result.append(formula.substr(0, insertPos));
    if (!result.empty() && result.back() != '\n') {
        result.push_back('\n');
    }
    result.append(definitionsWithNewline);
    if (insertPos < formula.size() && result.back() != '\n') {
        result.push_back('\n');
    }
    result.append(formula.substr(insertPos));
    return result;
}

std::string SplitSolver::buildFormulaForSolver() const {
    std::string formula = context.getFormula();
    if (fallbackActive) {
        formula = ensureFallbackLogic(formula);
        formula = rewriteFallbackFunctionCalls(formula);
        formula = injectFallbackDefinitions(formula);
    }
    return formula;
}

std::string SplitSolver::ensureFallbackLogic(const std::string& formula) const {
    std::istringstream input(formula);
    std::ostringstream body;
    std::string line;
    bool firstLine = true;

    while (std::getline(input, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        if (trimmed.rfind("(set-logic", 0) == 0) {
            continue;
        }
        if (!firstLine) {
            body << '\n';
        }
        body << line;
        firstLine = false;
    }

    std::ostringstream result;
    result << "(set-logic ALL)";
    if (!body.str().empty()) {
        result << '\n' << body.str();
    }
    return result.str();
}

std::string SplitSolver::rewriteFallbackFunctionCalls(const std::string& formula) const {
    std::string result = formula;
    const std::pair<std::string_view, std::string_view> replacements[] = {
        {"(str.split_at", "(split_at"},
        {"(str.split_rest", "(split_rest"},
        {"(str.num_splits", "(num_splits"},
        {"(str.split_at_re", "(split_at_re"},
        {"(str.split_rest_re", "(split_rest_re"},
        {"(str.num_splits_re", "(num_splits_re"}
    };

    for (const auto& [from, to] : replacements) {
        size_t pos = 0;
        while ((pos = result.find(from, pos)) != std::string::npos) {
            result.replace(pos, from.size(), to);
            pos += to.size();
        }
    }
    return result;
}

bool SplitSolver::prepareFallback() {
    if (fallbackAttempted) {
        return fallbackReady;
    }

    fallbackAttempted = true;
    INFO("Activating fallback split handling pipeline");
    resetSolver();
    fallbackReady = context.reloadCurrentFile();
    fallbackActive = fallbackReady;
    if (!fallbackReady) {
        ERROR("Failed to reload original SMT-LIB input for fallback mode");
    } else {
        DEBUG("Fallback SMT-LIB reloaded; alternative definitions will be injected");
        if (currentSolverType == SolverType::Z3_NOODLER && !solverSwitchedForFallback) {
            auto z3Script = config::z3ScriptPath();
            auto z3Binary = z3Script.parent_path() / "bin" / "z3";
            if (std::filesystem::exists(z3Binary)) {
                INFO("Switching solver to plain Z3 for fallback handling");
                setSolver(SolverType::Z3);
                solverSwitchedForFallback = true;
            } else {
                WARN("Fallback detected but plain Z3 binary not found at ", z3Binary.string(),
                     "; proceeding with current solver, recursive definitions may yield warnings");
            }
        }
    }
    return fallbackReady;
}

void SplitSolver::replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes) {
    if (splitAtConstNodes.empty()) {
        DEBUG("No SplitAt const nodes to replace");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    std::for_each(splitAtConstNodes.begin(), splitAtConstNodes.end(), [&](const SMTParser::NodePtr& node) {
                DEBUG("Node: ", ctx.getParser().getString(node));
                if (node->getChildrenSize() >= 3) {
                    auto arg1 = node->getChild(0);
                    auto arg2 = node->getChild(1);
                    auto arg3 = node->getChild(2);
                    
                    std::string str = arg1->toString();
                    if (str.size() >= 2 && str.front() == '"' && str.back() == '"') {
                        str = str.substr(1, str.size() - 2);
                    }
                    
                    std::string delimiter = normalizeDelimiterLiteral(ctx.getParser().getString(node->getChild(1)));
                    
                    Division* division = ctx.getDivision(str, delimiter);
                    if (division && division->isConstType()) {
                        ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                        int index = parseInteger(arg3->toString());
                        if (index >= 0 && index < constDiv->getSplitNums()) {
                            std::string splitValue = constDiv->getSplit(index);
                            std::string quotedValue = "\"" + splitValue + "\"";
                            SMTParser::NodePtr replacement = ctx.getParser().createStringConst(quotedValue);
                            if (replacement) {
                                DEBUG("Replaced ", ctx.getParser().getString(node), " with ", ctx.getParser().getString(replacement));
                            }
                            replacementMap[node] = replacement;
                        }
                    } else {
                        SMTParser::NodePtr replacement = ctx.getParser().createBoolConst(false);
                        replacementMap[node] = replacement;
                        auto atoms = ctx.getAtomsForSplitNode(node);
                        std::for_each(atoms.begin(), atoms.end(), [&](const SMTParser::NodePtr& atom) {
                            DEBUG("Atom: ", ctx.getParser().getString(atom));
                            auto atomReplacement = ctx.getParser().createBoolConst(false);
                            replacementMap[atom] = atomReplacement;
                        });
                    }
                }
            });
    ctx.getParser().replaceNodes(replacementMap);
}

void SplitSolver::replaceSplitEndConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndConstNodes) {
    if (splitEndConstNodes.empty()) {
        DEBUG("No SplitEnd const nodes to replace");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    std::for_each(splitEndConstNodes.begin(), splitEndConstNodes.end(), [&](const SMTParser::NodePtr& node) {
                DEBUG("SplitEnd Node: ", ctx.getParser().getString(node));
                if (node->getChildrenSize() >= 3) {
                    auto arg1 = node->getChild(0);
                    auto arg2 = node->getChild(1);
                    auto arg3 = node->getChild(2);
                    
                    std::string str = arg1->toString();
                    if (str.size() >= 2 && str.front() == '"' && str.back() == '"') {
                        str = str.substr(1, str.size() - 2);
                    }
                    
                    std::string delimiter = normalizeDelimiterLiteral(ctx.getParser().getString(node->getChild(1)));
                    
                    int index = parseInteger(arg3->toString());
                    Division* division = ctx.getDivision(str, delimiter);
                    if (division && division->isConstType()) {
                        ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                        if (index >= 0 && index < constDiv->getSplitNums()) {
                            const auto& splits = constDiv->getSplits();
                            const auto& splitDelimiters = constDiv->getSplitDelimiters();
                            std::string splitEndValue = "";
                            for (int i = index; i < static_cast<int>(splits.size()); ++i) {
                                if (i > index) {
                                    splitEndValue += splitDelimiters[i-1];
                                }
                                splitEndValue += splits[i];
                            }
                            std::string quotedValue = "\"" + splitEndValue + "\"";
                            SMTParser::NodePtr replacement = ctx.getParser().createStringConst(quotedValue);
                            if (replacement) {
                                DEBUG("Replaced ", ctx.getParser().getString(node), " with ", ctx.getParser().getString(replacement));
                            }
                            replacementMap[node] = replacement;
                        } else {
                            SMTParser::NodePtr replacement = ctx.getParser().createStringConst("\"\"");
                            replacementMap[node] = replacement;
                        }
                    } else {
                        SMTParser::NodePtr replacement = ctx.getParser().createBoolConst(false);
                        replacementMap[node] = replacement;
                        auto atoms = ctx.getAtomsForSplitNode(node);
                        std::for_each(atoms.begin(), atoms.end(), [&](const SMTParser::NodePtr& atom) {
                            DEBUG("Atom: ", ctx.getParser().getString(atom));
                            auto atomReplacement = ctx.getParser().createBoolConst(false);
                            replacementMap[atom] = atomReplacement;
                        });
                    }
                }
            });
    ctx.getParser().replaceNodes(replacementMap);
}

void SplitSolver::replaceNumSplitConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitConstNodes) {
    if (numSplitConstNodes.empty()) {
        DEBUG("No NumSplit const nodes to replace");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    std::for_each(numSplitConstNodes.begin(), numSplitConstNodes.end(), [&](const SMTParser::NodePtr& node) {
                DEBUG("NumSplit Node: ", ctx.getParser().getString(node));
                if (node->getChildrenSize() >= 2) {
                    auto arg1 = node->getChild(0);
                    auto arg2 = node->getChild(1);
                    std::string str = arg1->toString();
                    if (str.size() >= 2 && str.front() == '"' && str.back() == '"') {
                        str = str.substr(1, str.size() - 2);
                    }
                    std::string delimiter = normalizeDelimiterLiteral(ctx.getParser().getString(node->getChild(1)));
                    
                    Division* division = ctx.getDivision(str, delimiter);
                    int numSplits = 0;
                    if (division && division->isConstType()) {
                        ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                        numSplits = constDiv->getSplitNums();
                    }
                    SMTParser::NodePtr replacement = ctx.getParser().createIntConst(numSplits);
                    if (replacement) {
                        DEBUG("Replaced ", ctx.getParser().getString(node), " with ", ctx.getParser().getString(replacement));
                    }
                    replacementMap[node] = replacement;
                } else {
                    SMTParser::NodePtr replacement = ctx.getParser().createIntConst(0);
                    replacementMap[node] = replacement;
                    auto atoms = ctx.getAtomsForSplitNode(node);
                    std::for_each(atoms.begin(), atoms.end(), [&](const SMTParser::NodePtr& atom) {
                        DEBUG("Atom: ", ctx.getParser().getString(atom));
                        auto atomReplacement = ctx.getParser().createBoolConst(false);
                        replacementMap[atom] = atomReplacement;
                    });
                }
            });
    ctx.getParser().replaceNodes(replacementMap);
}

void SplitSolver::replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes) {
    if (splitAtVarNodes.empty()) {
        DEBUG("No SplitAt var nodes to replace");
        return;
    }
    
    DEBUG("Replacing ", splitAtVarNodes.size(), " split_at var nodes with auxiliary variables");
    if (splitAtVarNodes.empty()) {
        DEBUG("[replaceSplitAtVarNodes] No split_at var nodes found");
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& node : splitAtVarNodes) {
        DEBUG("[replaceSplitAtVarNodes] Processing node: ", ctx.getParser().getString(node));
        try {
            if (node && node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                DEBUG("Node: ", ctx.getParser().getString(node));
                
                if (arg1->isVar() && arg3->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = normalizeDelimiterLiteral(ctx.getParser().getString(node->getChild(1)));
                    DEBUG("[replaceSplitAtVarNodes] Variable: '", variable, "'");
                    DEBUG("[replaceSplitAtVarNodes] Delimiter regex: ", delimiter);
                    int index = parseInteger(arg3->toString());
                    DEBUG("[replaceSplitAtVarNodes] Index: ", index);
                    
                    Division* division = ctx.getDivision(variable, delimiter);
                    if (division && division->isVarType()) {
                        VarDivision* varDiv = static_cast<VarDivision*>(division);
                        auto splitNums = varDiv->getSplitAtNumsAppeared();
                        if (std::find(splitNums.begin(), splitNums.end(), index) != splitNums.end()) {
                            std::string hashStr = division->getHashString();
                            std::string xi = hashStr + "_x_" + std::to_string(index);
                            SMTParser::NodePtr replacement = ctx.getParser().createStringVar(xi);
                            
                            if (replacement) {
                                replacementMap[node] = replacement;
                                DEBUG("Replaced ", ctx.getParser().getString(node), " with ", ctx.getParser().getString(replacement));
                            } else {
                                WARN("Failed to create replacement variable: ", xi);
                            }
                        } else {
                            DEBUG("Index ", index, " not found in division for variable ", variable);
                        }
                    } else {
                        WARN("Division not found for variable ", variable, " with delimiter regex: ", delimiter);
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        DEBUG("About to call replaceNodes with ", replacementMap.size(), " replacements");
        ctx.getParser().replaceNodes(replacementMap);
        DEBUG("replaceNodes completed");
    } else {
        DEBUG("No replacements to make");
    }
}

void SplitSolver::replaceSplitEndVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndVarNodes) {
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
                DEBUG("SplitEnd Node: ", ctx.getParser().getString(node));
                
                if (arg1->isVar() && arg3->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = normalizeDelimiterLiteral(ctx.getParser().getString(node->getChild(1)));
                    int index = parseInteger(arg3->toString());
                    
                    Division* division = ctx.getDivision(variable, delimiter);
                    if (division && division->isVarType()) {
                        VarDivision* varDiv = static_cast<VarDivision*>(division);
                        auto splitEndNums = varDiv->getSplitRestNumsAppeared();
                        if (std::find(splitEndNums.begin(), splitEndNums.end(), index) != splitEndNums.end()) {
                            std::string hashStr = division->getHashString();
                            std::string ri = hashStr + "_r_" + std::to_string(index);
                            SMTParser::NodePtr replacement = ctx.getParser().createStringVar(ri);
                            
                            if (replacement) {
                                replacementMap[node] = replacement;
                                DEBUG("Replaced ", ctx.getParser().getString(node), " with ", ctx.getParser().getString(replacement));
                            } else {
                                WARN("Failed to create replacement variable: ", ri);
                            }
                        } else {
                            DEBUG("Index ", index, " not found in split_rest division for variable ", variable);
                        }
                    } else {
                        WARN("Division not found for variable ", variable, " with delimiter regex: ", delimiter);
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing split_rest node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        DEBUG("About to call replaceNodes with ", replacementMap.size(), " replacements");
        ctx.getParser().replaceNodes(replacementMap);
        DEBUG("replaceNodes completed");
    } else {
        DEBUG("No replacements to make");
    }
}

void SplitSolver::replaceNumSplitVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitVarNodes) {
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
                DEBUG("NumSplit Node: ", ctx.getParser().getString(node));
                
                if (arg1->isVar() && arg2->isConst()) {
                    std::string variable = arg1->toString();
                    std::string delimiter = normalizeDelimiterLiteral(ctx.getParser().getString(node->getChild(1)));
                    
                    Division* division = ctx.getDivision(variable, delimiter);
                    if (division && division->isVarType() && division->isNumSplitsUsed()) {
                        std::string hashStr = division->getHashString();
                        std::string num_splits = hashStr + "_num";
                        SMTParser::NodePtr replacement = ctx.getParser().createIntVar(num_splits);
                        
                        if (replacement) {
                            replacementMap[node] = replacement;
                            DEBUG("Replaced ", ctx.getParser().getString(node), " with ", ctx.getParser().getString(replacement));
                        } else {
                            WARN("Failed to create replacement variable: ", num_splits);
                        }
                    } else {
                        WARN("Division not found or num_splits not used for variable ", variable, " with delimiters");
                    }
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing num_splits node: ", e.what());
        }
    }
    
    if (!replacementMap.empty()) {
        DEBUG("About to call replaceNodes with ", replacementMap.size(), " replacements");
        ctx.getParser().replaceNodes(replacementMap);
        DEBUG("replaceNodes completed");
    } else {
        DEBUG("No replacements to make");
    }
}

void SplitSolver::detectInvalidIndex(Context& ctx, Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::vector<SMTParser::NodePtr> divisionNodes = ctx.getDivisionNodes(variable, delimiter);
    
    if (divisionNodes.empty()) {
        DEBUG("No division nodes found for ", variable);
        return;
    }
    
    VarDivision* varDiv = static_cast<VarDivision*>(division);
    int maxIndex = varDiv->getMaxSplitNumAppeared();
    
    if (maxIndex == -1) {
        DEBUG("No split indices to validate for ", variable);
        return;
    }
    
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacementMap;
    
    for (auto& divisionNode : divisionNodes) {
        if (ctx.isSplitAtVarNode(divisionNode)) {
            if (divisionNode->getChildrenSize() >= 3) {
                auto arg3 = divisionNode->getChild(2);
                int index = parseInteger(arg3->toString());
                if (index < 0 || index > maxIndex) {
                    DEBUG("Invalid split_at index ", index, " for ", variable, " with delimiters");
                    SMTParser::NodePtr replacement = ctx.getParser().createStringConst("\"\"");
                    replacementMap[divisionNode] = replacement;
                    varDiv->deleteSplitAtNumAppeared(index);
                }
            }
        }
        
        if (ctx.isSplitRestVarNode(divisionNode)) {
            if (divisionNode->getChildrenSize() >= 3) {
                auto arg3 = divisionNode->getChild(2);
                int index = parseInteger(arg3->toString());
                if (index < 0 || index > maxIndex) {
                    DEBUG("Invalid split_rest index ", index, " for ", variable, " with delimiters");
                    SMTParser::NodePtr replacement = ctx.getParser().createStringConst("\"\"");
                    replacementMap[divisionNode] = replacement;
                    varDiv->deleteSplitRestNumAppeared(index);
                }
            }
        }
    }
    
    if (!replacementMap.empty()) {
        DEBUG("Replacing ", replacementMap.size(), " invalid split nodes with empty string");
        ctx.getParser().replaceNodes(replacementMap);
    }
}

void SplitSolver::addAuxiliaryVariables(Context& ctx, const Division* division) {
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
        std::string num_splits = hashStr + "_num";
        ctx.getParser().declareIntVar(num_splits);
        DEBUG("Declared num_splits variable: ", num_splits);
    }
    
    if (maxIndex == -1) {
        DEBUG("Only num_splits used for ", variable, " - skipping split variables");
        return;
    }
    
    std::string variable_split = variable + "_" + hashStr;
    std::string split = hashStr + "_split";
    std::string last = hashStr + "_last";
    
    ctx.getParser().declareStringVar(variable_split);
    ctx.getParser().declareStringVar(split);
    ctx.getParser().declareStringVar(last);
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string xi = hashStr + "_x_" + std::to_string(i);
        ctx.getParser().declareStringVar(xi);
    }
    
    for (int idx : varDiv->getSplitNumsAppeared()) {
        std::string bi = hashStr + "_b_" + std::to_string(idx);
        ctx.getParser().declareBoolVar(bi);
    }
    
    for (int idx : varDiv->getSplitRestNumsAppeared()) {
        std::string ri = hashStr + "_r_" + std::to_string(idx);
        ctx.getParser().declareStringVar(ri);
    }
    
    for (int i = 0; i <= maxIndex; ++i) {
        std::string gi = hashStr + "_g_" + std::to_string(i);
        ctx.getParser().declareBoolVar(gi);
    }
    for (int i = 0; i <= maxIndex+1; ++i) {
        std::string pi = hashStr + "_p_" + std::to_string(i);
        ctx.getParser().declareIntVar(pi);
    }
    
    DEBUG("Declared auxiliary variables for ", variable, " with delimiter regex ", delimiter, " using hash ", hashStr);
}

void SplitSolver::addBasicConstraints(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string delimiter = division->getDelimiter();
    std::string hashStr = division->getHashString();
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    int maxIndex = varDiv->getMaxSplitNumAppeared();
    
    if (maxIndex == -1) {
        DEBUG("Skipping basic constraints for ", variable, " - no split_at usage");
        return;
    }
    
    std::string variable_split = variable + "_" + hashStr;
    std::string split = hashStr + "_split";
    std::string last = hashStr + "_last";
    
    bool isStringType = ctx.isDelimiterStringType(delimiter);
    std::string constraint1;
    if (isStringType) {
        constraint1 = "(= " + variable_split + " (str.replace_all " + variable + " " + delimiter + " " INTERNAL_DELIMITER "))";
    } else {
        constraint1 = "(= " + variable_split + " (str.replace_re_all " + variable + " " + delimiter + " " INTERNAL_DELIMITER "))";
    }
    DEBUG("[addBasicConstraints] Adding constraint: ", constraint1);
    ctx.getParser().addAssertion(constraint1);

    std::string constraint2 = "(= " + variable_split + " (str.++ " + split + " " + last + "))";
    DEBUG("[addBasicConstraints] Adding constraint: ", constraint2);
    ctx.getParser().addAssertion(constraint2);
    std::string constraint3 = "(or (= " + last + " \"\") (str.prefixof " INTERNAL_DELIMITER " " + last + "))";
    DEBUG("[addBasicConstraints] Adding constraint: ", constraint3);
    ctx.getParser().addAssertion(constraint3);
}

void SplitSolver::addEquivalenceConstraints(Context& ctx, const Division* division) {
    std::string hashStr = division->getHashString();
    std::string split = hashStr + "_split";
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    
    for (int idx : varDiv->getSplitNumsAppeared()) {
        std::string bi = hashStr + "_b_" + std::to_string(idx);
        std::string equiv;
        
        if (idx == 0) {
            equiv = "(= " + bi + " (= " + split + " " + hashStr + "_x_0))";
        } else {
            equiv = "(= " + bi + " (= " + split + " (str.++";
            for (int j = 0; j < idx; ++j) {
                equiv += " " + hashStr + "_x_" + std::to_string(j) + " " INTERNAL_DELIMITER;
            }
            equiv += " " + hashStr + "_x_" + std::to_string(idx) + ")))";
        }
        DEBUG("[addEquivalenceConstraints] Adding constraint: ", equiv);
        ctx.getParser().addAssertion(equiv);
    }
}

void SplitSolver::addIndexConstraints(Context& ctx, const Division* division) {
    std::string variable = division->getDivided();
    std::string hashStr = division->getHashString();
    const VarDivision* varDiv = static_cast<const VarDivision*>(division);
    int maxIndex = varDiv->getMaxSplitNumAppeared();
    
    if (maxIndex == -1) {
        DEBUG("Skipping index constraints for ", variable, " - no split_at usage");
        return;
    }
    
    std::string split = hashStr + "_split";
    
    std::string constraint = "(= " + hashStr + "_p_0 -1)";
    ctx.getParser().addAssertion(constraint);

    for (int i = 0; i <= maxIndex; ++i) {
        std::string prevPi = hashStr + "_p_" + std::to_string(i);
        std::string pi = hashStr + "_p_" + std::to_string(i+1);
        std::string gi = hashStr + "_g_" + std::to_string(i);
        std::string xi = hashStr + "_x_" + std::to_string(i);
        std::string bi = hashStr + "_b_" + std::to_string(i);
        std::string constraint;

        constraint = "(= " + pi + " (str.indexof " + split + " " INTERNAL_DELIMITER " (+ " + prevPi + " 1)))";
        DEBUG("[addIndexConstraints] Adding constraint: ", constraint);
        ctx.getParser().addAssertion(constraint);
        std::string gConstraint = "(= " + gi + " (or (= " + pi + " (- 0 1)) (= (- (- " + pi + " " + prevPi + ") 1) (str.len " + xi + "))))";
        DEBUG("[addIndexConstraints] Adding constraint: ", gConstraint);
        ctx.getParser().addAssertion(gConstraint);
    }
    
    for (int idx : varDiv->getSplitNumsAppeared()) {
        std::string bi = hashStr + "_b_" + std::to_string(idx);
        std::string equiv = "(=> " + bi + " (and";
        for (int i = 0; i <= idx; ++i) {
            std::string gi = hashStr + "_g_" + std::to_string(i);
            equiv += " " + gi;
        }
        equiv += "))";
        DEBUG("[addIndexConstraints] Adding constraint: ", equiv);
        ctx.getParser().addAssertion(equiv);
    }
}

void SplitSolver::addNumSplitsConstraints(Context& ctx, const Division* division) {
    if (!division->isNumSplitsUsed()) {
        return;
    }
    
    std::string variable = division->getDivided();
    std::string hashStr = division->getHashString();
    std::string variable_split = variable + "_" + hashStr;
    std::string num_splits = hashStr + "_num";
    
    std::string constraint = "(= " + num_splits + " (- (str.len " + variable_split + ") (str.len (str.replace_all " + variable_split + " " INTERNAL_DELIMITER " \"\"))))";
    DEBUG("[addNumSplitsConstraints] Adding constraint: ", constraint);
    ctx.getParser().addAssertion(constraint);
}

void SplitSolver::addAuxiliaryNodes(Context& ctx) {
    DEBUG("Adding auxiliary nodes for variable splits");
    
    splitAtTerms = ctx.getSplitAtVarNodes();
    const auto& divisions = ctx.getAllDivisions();
    for (const auto& [key, divisionPtr] : divisions) {
        if (divisionPtr->isVarType()) {
            const Division* div = divisionPtr.get();
            DEBUG("Processing var division: ", div->getDivided(), " with delimiter regex ", div->getDelimiter());
            detectInvalidIndex(ctx, divisionPtr.get());
            addAuxiliaryVariables(ctx, divisionPtr.get());
            addBasicConstraints(ctx, divisionPtr.get());
            addEquivalenceConstraints(ctx, divisionPtr.get());
            addIndexConstraints(ctx, divisionPtr.get());
            addNumSplitsConstraints(ctx, divisionPtr.get());
        }
    }
    
    DEBUG("Completed adding auxiliary nodes for ", divisions.size(), " divisions");
}

void SplitSolver::addAuxiliaryLemmas(Context& ctx) {
    DEBUG("Adding auxiliary lemmas for variable splits");
    
    auto splitAtVarNodes = ctx.getSplitAtVarNodes();
    auto splitRestVarNodes = ctx.getSplitRestVarNodes();
    const auto& divisions = ctx.getAllDivisions();
    
    for (const auto& [key, divisionPtr] : divisions) {
        if (divisionPtr->isVarType()) {
            std::string variable = divisionPtr->getDivided();
            std::string delimiter = divisionPtr->getDelimiter();
            std::string hashStr = divisionPtr->getHashString();
            const VarDivision* varDiv = static_cast<const VarDivision*>(divisionPtr.get());
            auto splitAtIndices = varDiv->getSplitAtNumsAppeared();
            auto splitRestIndices = varDiv->getSplitRestNumsAppeared();
            auto allIndices = varDiv->getSplitNumsAppeared();
            
            for (auto& node : splitAtVarNodes) {
                if (node->getChildrenSize() >= 3) {
                    auto arg3 = node->getChild(2);
                    
                    if (ctx.matchesDivision(node, variable, delimiter)) {
                        int index = parseInteger(arg3->toString());
                        auto atoms = ctx.getAtomsForSplitNode(node);
                        
                        for (auto& atom : atoms) {
                            std::string disjuncts = "";
                            bool first = true;
                            for (int i : allIndices) {
                                if (i >= index) {
                                    if (!first) disjuncts += " ";
                                    std::string bi = hashStr + "_b_" + std::to_string(i);
                                    disjuncts += bi;
                                    first = false;
                                }
                            }
                            
                            if (!disjuncts.empty()) {
                                std::string lemma;
                                if (disjuncts.find(" ") != std::string::npos) {
                                    lemma = "(=> " + ctx.getParser().getString(atom) + " (or " + disjuncts + "))";
                                } else {
                                    lemma = "(=> " + ctx.getParser().getString(atom) + " " + disjuncts + ")";
                                }
                                
                                DEBUG("[addAuxiliaryLemmas] Adding split_at lemma: ", lemma);
                                ctx.getParser().addAssertion(lemma);
                            }
                        }
                    }
                }
            }
            
            for (auto& node : splitRestVarNodes) {
                if (node->getChildrenSize() >= 3) {
                    auto arg3 = node->getChild(2);
                    
                    if (ctx.matchesDivision(node, variable, delimiter)) {
                        int index = parseInteger(arg3->toString());
                        auto atoms = ctx.getAtomsForSplitNode(node);
                        
                        for (auto& atom : atoms) {
                            std::string disjuncts = "";
                            bool first = true;
                            for (int i : allIndices) {
                                if (i >= index) {
                                    if (!first) disjuncts += " ";
                                    std::string bi = hashStr + "_b_" + std::to_string(i);
                                    disjuncts += bi;
                                    first = false;
                                }
                            }
                            
                            if (!disjuncts.empty()) {
                                std::string lemma;
                                if (disjuncts.find(" ") != std::string::npos) {
                                    lemma = "(=> " + ctx.getParser().getString(atom) + " (or " + disjuncts + "))";
                                } else {
                                    lemma = "(=> " + ctx.getParser().getString(atom) + " " + disjuncts + ")";
                                }
                                
                                DEBUG("[addAuxiliaryLemmas] Adding split_rest lemma: ", lemma);
                                ctx.getParser().addAssertion(lemma);
                            }
                        }
                    }
                }
            }
            
            bool isStringType = ctx.isDelimiterStringType(delimiter);
            
            for (int i : allIndices) {
                std::string bi = hashStr + "_b_" + std::to_string(i);
                std::string xi = hashStr + "_x_" + std::to_string(i);
                std::string last = hashStr + "_last";
                
                for (int j : splitRestIndices) {
                    if (j <= i) {
                        std::string rj = hashStr + "_r_" + std::to_string(j);
                        
                        std::string lemma;
                        if (isStringType) {
                            lemma = "(=> " + bi + " (= (str.++ " + xi + " " + last + ") (str.replace_all " + rj + " " + delimiter + " " INTERNAL_DELIMITER ")))";
                        } else {
                            lemma = "(=> " + bi + " (= (str.++ " + xi + " " + last + ") (str.replace_re_all " + rj + " " + delimiter + " " INTERNAL_DELIMITER ")))";
                        }
                        DEBUG("[addAuxiliaryLemmas] Adding split_rest lemma for i=", i, " j=", j, ": ", lemma);
                        ctx.getParser().addAssertion(lemma);
                    }
                }
            }
        }
    }
}

std::string nodeToString(const SMTParser::NodePtr& node) {
    if (!node) return "";
    
    std::stringstream ss;
    dumpSMTLIB2(node, ss);
    return ss.str();
}

std::string SplitSolver::filterModel(const std::string& rawModel) {
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
                    
                    if (varName.find("div") != std::string::npos) {
                        std::size_t divPos = varName.find("div");
                        if (divPos != std::string::npos) {
                            std::size_t afterDiv = divPos + 3;
                            if (afterDiv < varName.length()) {
                                char nextChar = varName[afterDiv];
                                if (std::isdigit(nextChar)) {
                                    std::size_t numEnd = afterDiv;
                                    while (numEnd < varName.length() && std::isdigit(varName[numEnd])) {
                                        numEnd++;
                                    }
                                    if (numEnd == varName.length() || 
                                        varName[numEnd] == '_') {
                                        isAuxiliaryVar = true;
                                    }
                                }
                            }
                        }
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

bool SplitSolver::rewriteFormula(Context& ctx) {
    if (fallbackActive) {
        DEBUG("Fallback mode already active; skipping rewrite pipeline");
        return false;
    }

    if (containsUnsupportedScopes(ctx)) {
        INFO("Detected unsupported quantifiers or LET constructs; switching to fallback mode");
        prepareFallback();
        return false;
    }

    try {
        LOG5("\n", ctx.getParser().getSMTLIB2(true));
        resetSolver();
        
        ctx.updateDivisions();
        addAuxiliaryNodes(ctx);
        addAuxiliaryLemmas(ctx);
        
        auto splitAtConstNodes = ctx.getSplitAtConstNodes();
        replaceSplitAtConstNodes(ctx, splitAtConstNodes);
        auto splitRestConstNodes = ctx.getSplitRestConstNodes();
        replaceSplitEndConstNodes(ctx, splitRestConstNodes);
        auto numSplitConstNodes = ctx.getNumSplitConstNodes();
        replaceNumSplitConstNodes(ctx, numSplitConstNodes);
        
        auto splitAtVarNodes = ctx.getSplitAtVarNodes();
        replaceSplitAtVarNodes(ctx, splitAtVarNodes);
        auto splitRestVarNodes = ctx.getSplitRestVarNodes();
        replaceSplitEndVarNodes(ctx, splitRestVarNodes);
        auto numSplitVarNodes = ctx.getNumSplitVarNodes();
        replaceNumSplitVarNodes(ctx, numSplitVarNodes);
        
        DEBUG("=== Final SMT-LIB after rewriting ===");
        LOG5("\n", ctx.getParser().getSMTLIB2(true));
        DEBUG("=== End of SMT-LIB ===");
        return true;
    } catch (const std::exception& e) {
        ERROR("Rewrite pipeline failed: ", e.what());
    } catch (...) {
        ERROR("Rewrite pipeline failed due to an unknown error");
    }

    prepareFallback();
    return false;
}

SatResult SplitSolver::checkSat() {
    if (!solver) {
        ERROR("Solver not initialized");
        return SatResult::ERROR;
    }
    DEBUG("Checking satisfiability...");
    auto start = std::chrono::high_resolution_clock::now();
    
    std::string smtFormula = buildFormulaForSolver();
    SatResult result = solver->checkSat(smtFormula);
    
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
            INFO("Result: UNKNOWN (", duration.count(), "ms)");
            break;
        case SatResult::ERROR:
            INFO("Result: ERROR (", duration.count(), "ms)");
            break;
    }
    return result;
}

SatResult SplitSolver::solve() {
    INFO("Starting split solver");

    fallbackAttempted = false;
    fallbackReady = false;
    fallbackActive = false;

    bool rewriteSuccessful = rewriteFormula(context);
    if (!rewriteSuccessful && !fallbackActive && !fallbackReady) {
        ERROR("Failed to rewrite formula and fallback preparation was unsuccessful");
        return SatResult::ERROR;
    }

    SatResult result = checkSat();
    
    if (result == SatResult::ERROR && !fallbackActive) {
        WARN("Initial solver invocation returned ERROR; attempting fallback pipeline");
        if (prepareFallback()) {
            result = checkSat();
        }
    }

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

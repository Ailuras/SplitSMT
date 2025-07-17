// At the top of Context.cpp, ensure these includes are present:
#include "Context.h"
#include "Structures.h"
#include "Split.h"
#include <sstream>
#include <fstream>
#include <filesystem>
#include <regex>       // Already included in your file
#include <chrono>
#include <algorithm>   // Add this for std::find_if
#include <iterator>    // Add this for iterator utilities

namespace strp {

Context& Context::getInstance() {
    static Context instance;
    return instance;
}

Context::Context() : logger(utils::Logger::getInstance()), SMTParser() {
}

bool Context::parseFile(const std::string& filename) {
    DEBUG("Parsing file: ", filename);
    clear();
    
    if (!std::filesystem::exists(filename)) {
        ERROR("File does not exist: ", filename);
        return false;
    }

    auto separationResult = separateSplitConstraints(filename);
    DEBUG("Split functions found: ", separationResult.splitRelatedFunctions.size());
    DEBUG("Split constraints: ", separationResult.splitConstraints.length(), " chars");
    DEBUG("Other constraints: ", separationResult.otherConstraints.length(), " chars");

    bool hasSplitConstraints = !separationResult.splitConstraints.empty() && 
                              separationResult.splitConstraints != "(set-logic ALL)\n\n(check-sat)\n";
    
    if (hasSplitConstraints) {
        INFO("Detected split constraints - using constraint separation and rewriting");
        return parseWithConstraintSeparation(separationResult, filename);
    } else {
        DEBUG("No split constraints detected - using standard parsing");
        return parseStandard(filename);
    }
}

bool Context::parseString(const std::string& input) {
    DEBUG("Parsing string input");
    clear();
    
    std::string tempFilename = "/tmp/smtlib_parser_temp.smt2";
    std::ofstream tempFile(tempFilename);
    if (!tempFile.is_open()) {
        ERROR("Failed to create temporary file for string parsing");
        return false;
    }
    tempFile << input;
    tempFile.close();
    if (!SMTParser.parse(tempFilename)) {
        ERROR("Failed to parse string input");
        std::filesystem::remove(tempFilename);
        return false;
    }
    std::filesystem::remove(tempFilename);
    DEBUG("Parser info updated with ", SMTParser.assertions.size(), " assertions");
    updateInfo();
    updateTasks(tempFilename);
    std::string smtlib2 = getSMTLIB2(true);
    LOG5("SMTLIB2: ", smtlib2);
    DEBUG("Found ", tasks.size(), " tasks");
    return true;
}

void Context::updateInfo() {
    std::vector<SMTParser::NodePtr> variables = getVariables();
    std::vector<SMTParser::NodePtr> assertions = getAssertions();
    for (auto& node : variables) {
        Var var = Var(node, *this);
        addVar(var);
        DEBUG("Added var: ", var.getName(), " of type ", var.getType(), " with comment: ", var.getComment());
    }
    for (auto& node : assertions) {
        Clause clause = Clause(node, *this, true);
        auto atom_set = clause.getAtoms();
        std::vector<Atom> atoms(atom_set.begin(), atom_set.end());
        for (auto& atom : atoms) {
            addAtom(atom);
            DEBUG("Added atom: ", atom.getName(), " of type ", atom.getType(), " with comment: ", atom.getComment());
        }
        addClause(clause);
        DEBUG("Added clause: ", clause.getName(), " of type ", clause.getType(), " with comment: ", clause.getComment());
    }
}

std::string Context::getSMTLIB2(bool from_parser) const {
    if (from_parser) {
        return const_cast<Context*>(this)->SMTParser.dumpSMT2();
    }
    std::stringstream ss;
    ss << "(set-logic ALL)\n\n";
    for (const auto& var : vars) {
        ss << var.toSMT() << "\n";
    }
    if (!vars.empty()) {
        ss << "\n";
    }
    for (const auto& clause : clauses) {
        ss << clause.toSMT() << "\n";
    }

    ss << "\n(check-sat)\n";
    
    return ss.str();
}

void Context::removeFunDef(const std::vector<std::string>& funcNames) {
    if (!funcNames.empty()) {
        size_t removed = SMTParser.removeFuns(funcNames);
        DEBUG("Removed ", removed, " functions from parser");
        for (const auto& funcName : funcNames) {
            DEBUG("Requested removal of function: ", funcName);
        }
    }
    DEBUG("Marked split-related functions for removal during SMT-LIB output");
}

std::vector<std::string> Context::getSplitRelatedFunctionNames() const {
    std::vector<std::string> splitFuncNames;
    std::set<std::string> splitRelatedNames;
    std::vector<SMTParser::NodePtr> functions = const_cast<Context*>(this)->SMTParser.getFunctions();
    
    // First pass: find functions with parameters that directly contain split operations
    for (const auto& func : functions) {
        if (func && func->getFuncBody() && func->getFuncParamsSize() > 0) {
            std::string funcBodyStr = const_cast<Context*>(this)->SMTParser.toString(func->getFuncBody());
            if (funcBodyStr.find("str.split_at") != std::string::npos ||
                funcBodyStr.find("str.split_rest") != std::string::npos ||
                funcBodyStr.find("str.num_splits") != std::string::npos) {
                splitRelatedNames.insert(func->getName());
            }
        }
    }
    
    // Second pass: find functions with parameters that reference split-related functions
    bool foundNew = true;
    while (foundNew) {
        foundNew = false;
        for (const auto& func : functions) {
            if (func && func->getFuncBody() && func->getFuncParamsSize() > 0 && splitRelatedNames.find(func->getName()) == splitRelatedNames.end()) {
                std::string funcBodyStr = const_cast<Context*>(this)->SMTParser.toString(func->getFuncBody());
                for (const auto& splitName : splitRelatedNames) {
                    if (funcBodyStr.find(splitName) != std::string::npos) {
                        splitRelatedNames.insert(func->getName());
                        foundNew = true;
                        break;
                    }
                }
            }
        }
    }
    
    splitFuncNames.assign(splitRelatedNames.begin(), splitRelatedNames.end());
    return splitFuncNames;
}

std::vector<SMTParser::NodePtr> Context::getFunctions() const {
    return const_cast<Context*>(this)->SMTParser.getFunctions();
}

std::string Context::nodeToString(const SMTParser::NodePtr& node) const {
    return const_cast<Context*>(this)->SMTParser.toString(node);
}

TaskType Context::parseTaskCommand(const std::string& line) const {
    std::string trimmed = line;
    trimmed.erase(0, trimmed.find_first_not_of(" \t\n\r"));
    trimmed.erase(trimmed.find_last_not_of(" \t\n\r") + 1);
    
    if (trimmed.find("(check-sat") == 0) {
        return TaskType::CHECK_SAT;
    } else if (trimmed.find("(get-model") == 0) {
        return TaskType::GET_MODEL;
    } else if (trimmed.find("(get-unsat-core") == 0) {
        return TaskType::GET_UNSAT_CORE;
    } else if (trimmed.find("(get-proof") == 0) {
        return TaskType::GET_PROOF;
    } else if (trimmed.find("(get-value") == 0) {
        return TaskType::GET_VALUE;
    } else if (trimmed.find("(get-assignment") == 0) {
        return TaskType::GET_ASSIGNMENT;
    } else if (trimmed.find("(get-info") == 0) {
        return TaskType::GET_INFO;
    } else if (trimmed.find("(get-option") == 0) {
        return TaskType::GET_OPTION;
    } else if (trimmed.find("(push") == 0) {
        return TaskType::PUSH;
    } else if (trimmed.find("(pop") == 0) {
        return TaskType::POP;
    } else if (trimmed.find("(reset") == 0) {
        return TaskType::RESET;
    } else if (trimmed.find("(exit") == 0) {
        return TaskType::EXIT;
    }
    
    throw std::invalid_argument("Unknown task command: " + trimmed);
}

std::set<TaskType> Context::getTask(const std::string& filename) const {
    std::set<TaskType> foundTasks;
    
    if (!std::filesystem::exists(filename)) {
        ERROR("File does not exist: ", filename);
        return foundTasks;
    }
    
    std::ifstream file(filename);
    if (!file.is_open()) {
        ERROR("Failed to open file: ", filename);
        return foundTasks;
    }
    
    std::string line;
    std::regex taskRegex(R"(\s*\(\s*(check-sat|get-model|get-unsat-core|get-proof|get-value|get-assignment|get-info|get-option|push|pop|reset|exit)\s*[\)\s])");
    
    while (std::getline(file, line)) {
        std::smatch match;
        if (std::regex_search(line, match, taskRegex)) {
            try {
                TaskType task = parseTaskCommand("(" + match[1].str() + ")");
                foundTasks.insert(task);
                DEBUG("Found task: ", match[1].str());
            } catch (const std::invalid_argument&) {
                continue;
            }
        }
    }
    
    file.close();
    
    return foundTasks;
}

bool Context::hasTask(TaskType taskType) const {
    return tasks.find(taskType) != tasks.end();
}

void Context::updateTasks(const std::string& filename) {
    tasks = getTask(filename);
}

std::set<TaskType> Context::getAllTasks() const {
    return tasks;
}

void Context::clearTasks() {
    tasks.clear();
}

int Context::getType(const SMTParser::NodePtr& node) {
    if (!node) return -1;
    if (node->isVar()) {
        return 1;
    } else if (node->isNot() || node->isAnd() || node->isOr() || node->isImplies() || node->isXor()) {
        return 2;
    } else if (node->isAtom()) {
        return 3;
    }
    return 0;
}

VarType Context::getVarType(const SMTParser::NodePtr& node) {
    if (!node) return VarType::UNKNOWN;
    
    std::string sortStr = node->getSort()->toString();
    if (sortStr == "Int") {
        return VarType::INTEGER;
    } else if (sortStr == "Real") {
        return VarType::REAL;
    } else if (sortStr == "Bool") {
        return VarType::BOOLEAN;
    } else if (sortStr == "String") {
        return VarType::STRING;
    } else if (node->isApplyUF()) {
        return VarType::FUNCTION;
    }
    
    return VarType::UNKNOWN;
}

AtomType Context::getAtomType(const SMTParser::NodePtr& node) {
    if (!node) return AtomType::Unknown;
    
    if (node->isArithComp()) {
        return AtomType::Arithmetic;
    } else if (node->isStrComp()) {
        return AtomType::String;
    } else if (node->isStrProp()) {
        return AtomType::Regular;
    } else if (node->isApplyUF() && node->getSort()->isBool()) {
        return AtomType::UninterpretedFunction;
    }
    
    return AtomType::Unknown;
}

ClauseType Context::getClauseType(const SMTParser::NodePtr& node) {
    if (!node) return ClauseType::Unknown;
    
    std::string kindStr = getInstance().SMTParser.toString(node->getKind());
    if (kindStr == "implies") {
        return ClauseType::Implies;
    } else if (kindStr == "and") {
        return ClauseType::And;
    } else if (kindStr == "or") {
        return ClauseType::Or;
    } else if (kindStr == "not") {
        return ClauseType::Not;
    } else if (kindStr == "iff") {
        return ClauseType::Iff;
    } else if (kindStr == "xor") {
        return ClauseType::Xor;
    } else if (kindStr == "ite") {
        return ClauseType::Ite;
    } else if (kindStr == "forall") {
        return ClauseType::Forall;
    } else if (kindStr == "exists") {
        return ClauseType::Exists;
    } else {
        return ClauseType::Leaf;
    }
}

std::vector<SMTParser::NodePtr> Context::getVariables() {
    std::unordered_set<SMTParser::NodePtr> varSet;
    SMTParser.collectVars(SMTParser.assertions, varSet);
    std::vector<SMTParser::NodePtr> vars(varSet.begin(), varSet.end());
    return vars;
}

void Context::declareStringVar(const std::string& name) {
    SMTParser.mkVarStr(name);
    DEBUG("Declared string variable: ", name);
}

void Context::declareBoolVar(const std::string& name) {
    SMTParser.mkVarBool(name);
    DEBUG("Declared boolean variable: ", name);
}

void Context::declareIntVar(const std::string& name) {
    SMTParser.mkVarInt(name);
    DEBUG("Declared integer variable: ", name);
}

void Context::addAssertion(const std::string& constraint) {
    SMTParser.assert(constraint);
    DEBUG("Added assertion: ", constraint);
}

std::vector<SMTParser::NodePtr> Context::getAssertions() {
    return SMTParser.assertions;
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes() {
    std::unordered_set<SMTParser::NodePtr> splitNodes;
    
    // Collect split nodes from all assertions
    auto assertions = getAssertions();
    for (const auto& assertion : assertions) {
        auto splitNodesInAssertion = getSplitAtNodes(assertion);
        for (const auto& node : splitNodesInAssertion) {
            splitNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitNodes.begin(), splitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> splitNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrSplitAt()) {
            splitNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectSplitNodes(node->getChild(i));
        }
    };
    
    collectSplitNodes(node);
    
    return std::vector<SMTParser::NodePtr>(splitNodes.begin(), splitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitAtNodes = getSplitAtNodes();
    for (const auto& node : splitAtNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtVarNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitAtNodes = getSplitAtNodes();
    for (const auto& node : splitAtNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (!arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitEndNodes() {
    std::unordered_set<SMTParser::NodePtr> splitEndNodes;
    
    auto assertions = getAssertions();
    for (const auto& assertion : assertions) {
        auto splitEndNodesInAssertion = getSplitEndNodes(assertion);
        for (const auto& node : splitEndNodesInAssertion) {
            splitEndNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(), splitEndNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitEndNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> splitEndNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitEndNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrSplitRest()) {
            splitEndNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectSplitEndNodes(node->getChild(i));
        }
    };
    
    collectSplitEndNodes(node);
    
    return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(), splitEndNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitEndConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitEndNodes = getSplitEndNodes();
    for (const auto& node : splitEndNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitEndVarNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitEndNodes = getSplitEndNodes();
    for (const auto& node : splitEndNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (!arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitNodes() {
    std::unordered_set<SMTParser::NodePtr> numSplitNodes;
    
    auto assertions = getAssertions();
    for (const auto& assertion : assertions) {
        auto numSplitNodesInAssertion = getNumSplitNodes(assertion);
        for (const auto& node : numSplitNodesInAssertion) {
            numSplitNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(numSplitNodes.begin(), numSplitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> numSplitNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectNumSplitNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrNumSplits()) {
            numSplitNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectNumSplitNodes(node->getChild(i));
        }
    };
    
    collectNumSplitNodes(node);
    
    return std::vector<SMTParser::NodePtr>(numSplitNodes.begin(), numSplitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto numSplitNodes = getNumSplitNodes();
    for (const auto& node : numSplitNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitVarNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto numSplitNodes = getNumSplitNodes();
    for (const auto& node : numSplitNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (!arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getAtoms(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> nodes;
    getInstance().SMTParser.collectAtoms(node, nodes);
    std::vector<SMTParser::NodePtr> atoms(nodes.begin(), nodes.end());
    return atoms;
}

bool Context::containsNode(const SMTParser::NodePtr& parent, const SMTParser::NodePtr& target) {
    if (!parent || !target) return false;
    if (parent == target) return true;
    for (size_t i = 0; i < parent->getChildrenSize(); ++i) {
        if (containsNode(parent->getChild(i), target)) {
            return true;
        }
    }
    return false;
}

std::string Context::getSource(const SMTParser::NodePtr& node) {
    return getInstance().SMTParser.toString(node);
}

std::string Context::getComment(const SMTParser::NodePtr& node) {
    if (!node) return "";
    if (node->getChildrenSize() == 0) {
        std::string value = node->toString();
        if (value.size() >= 2 && value.front() == '"' && value.back() == '"') {
            return value;
        }
        return value;
    }
    auto kind = node->getKind();
    std::string kindStr = SMTParser::kindToString(kind);
    
    if (kind == SMTParser::NODE_KIND::NT_APPLY_UF) {
        std::string result = node->getName() + "(";
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            if (i > 0) result += ", ";
            result += getComment(node->getChildren()[i]);
        }
        result += ")";
        return result;
    }
    
    if (kindStr == "declare-const" && node->getChildrenSize() >= 2) {
        return getComment(node->getChildren()[0]);
    }
    if (kindStr == "assert" && node->getChildrenSize() == 1) {
        return getComment(node->getChildren()[0]);
    }
    if (kindStr == "and" && node->getChildrenSize() >= 2) {
        std::string result = getComment(node->getChildren()[0]);
        for (size_t i = 1; i < node->getChildrenSize(); ++i) {
            result += " and " + getComment(node->getChildren()[i]);
        }
        return result;
    }
    if (kindStr == "or" && node->getChildrenSize() >= 2) {
        std::string result = getComment(node->getChildren()[0]);
        for (size_t i = 1; i < node->getChildrenSize(); ++i) {
            result += " or " + getComment(node->getChildren()[i]);
        }
        return result;
    }
    if (kindStr == "not" && node->getChildrenSize() == 1) {
        auto child = node->getChildren()[0];
        std::string childKind = SMTParser::kindToString(child->getKind());
        if (childKind == "str.in_re" && child->getChildrenSize() == 2) {
            std::string var = getComment(child->getChildren()[0]);
            std::string regex = getComment(child->getChildren()[1]);
            return var + " not in " + regex;
        }
        return "not " + getComment(node->getChildren()[0]);
    }
    if (kindStr == "implies" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " -> " + getComment(node->getChildren()[1]);
    }
    if (kindStr == "iff" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " <-> " + getComment(node->getChildren()[1]);
    }
    if (kindStr == "str.++" && node->getChildrenSize() >= 1) {
        std::string result;
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            if (i > 0) result += " + ";
            result += getComment(node->getChildren()[i]);
        }
        return "[" + result + "]";
    }
    if (kindStr == "str.in_re" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " in " + getComment(node->getChildren()[1]);
    }
    if (kindStr == "re.++" && node->getChildrenSize() >= 1) {
        std::string result;
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            if (i > 0) result += " + ";
            result += getComment(node->getChildren()[i]);
        }
        return "[" + result + "]";
    }
    if (kindStr == "re.union" && node->getChildrenSize() >= 1) {
        if (node->getChildrenSize() == 0) return "[\"\"]";
        std::string result;
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            if (i > 0) result += " | ";
            result += getComment(node->getChildren()[i]);
        }
        return "[" + result + "]";
    }
    if (kindStr == "re.*" && node->getChildrenSize() == 1) {
        std::string inner = getComment(node->getChildren()[0]);
        if (inner.front() == '[' && inner.back() == ']') {
            return inner + "*";
        }
        return "[" + inner + "]*";
    }
    if (kindStr == "re.+" && node->getChildrenSize() == 1) {
        std::string inner = getComment(node->getChildren()[0]);
        if (inner.front() == '[' && inner.back() == ']') {
            return inner + "+";
        }
        return "[" + inner + "]+";
    }
    if (kindStr == "re.range" && node->getChildrenSize() == 2) {
        std::string start = getComment(node->getChildren()[0]);
        std::string end = getComment(node->getChildren()[1]);
        if (start.size() >= 2 && start.front() == '"' && start.back() == '"') {
            start = start.substr(1, start.size() - 2);
        }
        if (end.size() >= 2 && end.front() == '"' && end.back() == '"') {
            end = end.substr(1, end.size() - 2);
        }
        return "[" + start + "-" + end + "]";
    }
    if (kindStr == "str.to_re" && node->getChildrenSize() >= 1) {
        return getComment(node->getChildren()[0]);
    }
    if (kindStr == "str.len" && node->getChildrenSize() >= 1) {
        return "len(" + getComment(node->getChildren()[0]) + ")";
    }
    if (kindStr == "=" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " = " + getComment(node->getChildren()[1]);
    }
    if (kindStr == ">=" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " >= " + getComment(node->getChildren()[1]);
    }
    if (kindStr == "<=" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " <= " + getComment(node->getChildren()[1]);
    }
    if (kindStr == ">" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " > " + getComment(node->getChildren()[1]);
    }
    if (kindStr == "<" && node->getChildrenSize() == 2) {
        return getComment(node->getChildren()[0]) + " < " + getComment(node->getChildren()[1]);
    }
    if (kindStr == "+" && node->getChildrenSize() >= 2) {
        std::string result = getComment(node->getChildren()[0]);
        for (size_t i = 1; i < node->getChildrenSize(); ++i) {
            result += " + " + getComment(node->getChildren()[i]);
        }
        return result;
    }
    if (kindStr == "-" && node->getChildrenSize() >= 2) {
        std::string result = getComment(node->getChildren()[0]);
        for (size_t i = 1; i < node->getChildrenSize(); ++i) {
            result += " - " + getComment(node->getChildren()[i]);
        }
        return result;
    }
    if (kindStr == "*" && node->getChildrenSize() >= 2) {
        std::string result = getComment(node->getChildren()[0]);
        for (size_t i = 1; i < node->getChildrenSize(); ++i) {
            result += " * " + getComment(node->getChildren()[i]);
        }
        return result;
    }
    if (kindStr == "/" && node->getChildrenSize() >= 2) {
        std::string result = getComment(node->getChildren()[0]);
        for (size_t i = 1; i < node->getChildrenSize(); ++i) {
            result += " / " + getComment(node->getChildren()[i]);
        }
        return result;
    }
    if (kindStr == "mod" && node->getChildrenSize() >= 2) {
        std::string left = getComment(node->getChildren()[0]);
        std::string right = getComment(node->getChildren()[1]);
        if (node->getChildren()[0]->getChildrenSize() > 0) {
            return "(" + left + ") mod " + right;
        }
        return left + " mod " + right;
    }
    std::string result = "(" + kindStr;
    for (size_t i = 0; i < node->getChildrenSize(); ++i) {
        result += " " + getComment(node->getChildren()[i]);
    }
    result += ")";
    return result;
}

void Context::addVar(const Var& var) {
    vars.insert(var);
}

void Context::addAtom(const Atom& atom) {
    atoms.insert(atom);
}

void Context::addClause(const Clause& clause) {
    clauses.push_back(clause);
}

std::unordered_set<Var, Var::Hash> Context::getVars() const {
    return vars;
}

std::unordered_set<Atom, Atom::Hash> Context::getAtoms() const {
    return atoms;
}

std::vector<Clause> Context::getClauses() const {
    return clauses;
}

void Context::clear() {
    clearVars();
    clearAtoms();
    clearClauses();

    clearDivisions();
    clearSplitNodeToAtoms();

    clearTasks();
}

void Context::clearVars() {
    vars.clear();
}

void Context::clearAtoms() {
    atoms.clear();
}

void Context::clearClauses() {
    clauses.clear();
}

void Context::clearDivisions() {
    divisions.clear();
}

void Context::clearSplitNodeToAtoms() {
    splitNodeToAtoms.clear();
}

size_t Context::getVarCount() const {
    return vars.size();
}

size_t Context::getAtomCount() const {
    return atoms.size();
}

size_t Context::getClauseCount() const {
    return clauses.size();
}

SMTParser::NodePtr Context::replaceNodes(const SMTParser::NodePtr& expr, const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = nodeMap;
    return getInstance().SMTParser.replaceNodes(expr, convertedMap);
}

void Context::replaceNodes(const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    auto& parser = getInstance().SMTParser;
    
    // Replace nodes in assertions
    for (size_t i = 0; i < parser.assertions.size(); ++i) {
        std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = nodeMap;
        parser.assertions[i] = parser.replaceNodes(parser.assertions[i], convertedMap);
    }
    
    // Replace nodes in function definitions
    auto functions = parser.getFunctions();
    for (auto& func : functions) {
        if (func && func->isFuncDef() && func->getChildrenSize() > 0) {
            // Replace nodes in function body (first child)
            std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = nodeMap;
            auto newBody = parser.replaceNodes(func->getChild(0), convertedMap);
            if (newBody != func->getChild(0)) {
                // Collect function parameters (children 1 onwards)
                std::vector<SMTParser::NodePtr> params;
                for (size_t i = 1; i < func->getChildrenSize(); ++i) {
                    params.push_back(func->getChild(i));
                }
                // Update the function with new body
                func->updateFuncDef(func->getSort(), newBody, params);
            }
        }
    }
}

SMTParser::NodePtr Context::createNode(const std::string& node_str) {
    try {
        return getInstance().SMTParser.mkExpr(node_str);
    } catch (const std::exception& e) {
        ERROR("Failed to create node from string '", node_str, "': ", e.what());
        return nullptr;
    }
}

SMTParser::NodePtr Context::createStringConst(const std::string& value) {
    return getInstance().SMTParser.mkConstStr(value);
}

SMTParser::NodePtr Context::createIntConst(int value) {
    return getInstance().SMTParser.mkConstInt(value);
}

SMTParser::NodePtr Context::createBoolConst(bool value) {
    if (value) {
        return getInstance().SMTParser.mkTrue();
    } else {
        return getInstance().SMTParser.mkFalse();
    }
}

SMTParser::NodePtr Context::createStringVar(const std::string& name) {
    auto var = getInstance().SMTParser.getVariable(name);
    if (var) {
        return var;
    }
    
    std::string declareStmt = "(declare-fun " + name + " () String)";
    if (getInstance().SMTParser.parseStr(declareStmt)) {
        var = getInstance().SMTParser.getVariable(name);
        if (var) {
            DEBUG("Created new string variable: ", name);
            return var;
        }
    }
    
    WARN("Failed to create string variable: ", name);
    return nullptr;
}

SMTParser::NodePtr Context::createIntVar(const std::string& name) {
    auto var = getInstance().SMTParser.getVariable(name);
    if (var) {
        return var;
    }

    std::string declareStmt = "(declare-fun " + name + " () Int)";
    if (getInstance().SMTParser.parseStr(declareStmt)) {
        var = getInstance().SMTParser.getVariable(name);
        if (var) {
            DEBUG("Created new int variable: ", name);
            return var;
        }
    }
    
    WARN("Failed to create int variable: ", name);
    return nullptr;
}

SMTParser::NodePtr Context::createBoolVar(const std::string& name) {
    auto var = getInstance().SMTParser.getVariable(name);
    if (var) {
        return var;
    }

    std::string declareStmt = "(declare-fun " + name + " () Bool)";
    if (getInstance().SMTParser.parseStr(declareStmt)) {
        var = getInstance().SMTParser.getVariable(name);
        if (var) {
            DEBUG("Created new bool variable: ", name);
            return var;
        }
    }

    WARN("Failed to create bool variable: ", name);
    return nullptr;
}

void Context::addDivision(std::unique_ptr<Division> division) {
    std::string key = Division::generateKey(division->getDivided(), division->getDelimiter());
    divisions[key] = std::move(division);
}

Division* Context::getDivision(const std::string& divided, const std::string& delimiter) {
    std::string key = Division::generateKey(divided, delimiter);
    auto it = divisions.find(key);
    if (it != divisions.end()) {
        return it->second.get();
    }
    return nullptr;
}

bool Context::hasDivision(const std::string& divided, const std::string& delimiter) const {
    std::string key = Division::generateKey(divided, delimiter);
    return divisions.find(key) != divisions.end();
}

const std::unordered_map<std::string, std::unique_ptr<Division>>& Context::getAllDivisions() const {
    return divisions;
}

void Context::updateSplitNodeToAtoms() {
    clearSplitNodeToAtoms();
    
    auto assertions = getAssertions();
    std::unordered_set<SMTParser::NodePtr> allAtoms;
    auto allSplitNodes = getSplitAtNodes();
    auto allSplitEndNodes = getSplitEndNodes();
    auto allNumSplitNodes = getNumSplitNodes();
    
    for (auto& assertion : assertions) {
        auto atomsInAssertion = getAtoms(assertion);
        allAtoms.insert(atomsInAssertion.begin(), atomsInAssertion.end());
    }
    
    for (auto& splitNode : allSplitNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (containsNode(atom, splitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitNode] = relatedAtoms;
        }
    }
    
    for (auto& splitEndNode : allSplitEndNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (containsNode(atom, splitEndNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitEndNode] = relatedAtoms;
        }
    }
    
    for (auto& numSplitNode : allNumSplitNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (containsNode(atom, numSplitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[numSplitNode] = relatedAtoms;
        }
    }
    
    DEBUG("Updated split node to atoms mapping with ", splitNodeToAtoms.size(), " entries");
}

Context::SMTSeparationResult Context::separateSplitConstraints(const std::string& filename) {
    SMTSeparationResult result;
    
    if (!std::filesystem::exists(filename)) {
        ERROR("File does not exist: ", filename);
        return result;
    }
    
    std::ifstream file(filename);
    if (!file.is_open()) {
        ERROR("Failed to open file: ", filename);
        return result;
    }
    
    std::stringstream splitConstraints;
    std::stringstream otherConstraints;
    std::string line;
    bool inSplitFunction = false;
    int parenthesesCount = 0;
    
    splitConstraints << "(set-logic ALL)\n";
    otherConstraints << "(set-logic ALL)\n";
    
    while (std::getline(file, line)) {
        std::string trimmedLine = line;
        trimmedLine.erase(0, trimmedLine.find_first_not_of(" \t"));
        trimmedLine.erase(trimmedLine.find_last_not_of(" \t") + 1);
        
        // 跳过空行和纯注释行
        if (trimmedLine.empty() || trimmedLine[0] == ';') {
            continue;
        }
        
        // 跳过set-logic和set-option
        if (trimmedLine.find("(set-logic") == 0 || 
            trimmedLine.find("(set-option") == 0) {
            continue;
        }
        
        // 处理多行define-fun
        if (trimmedLine.find("(define-fun") == 0) {
            if (trimmedLine.find("get_split_") != std::string::npos) {
                inSplitFunction = true;
                parenthesesCount = 1;
                splitConstraints << line << "\n";
                
                // 记录函数名
                size_t nameStart = trimmedLine.find(' ', 11);
                if (nameStart != std::string::npos) {
                    nameStart = trimmedLine.find_first_not_of(' ', nameStart);
                    size_t nameEnd = trimmedLine.find(' ', nameStart);
                    if (nameEnd != std::string::npos) {
                        std::string funcName = trimmedLine.substr(nameStart, nameEnd - nameStart);
                        result.splitRelatedFunctions.push_back(funcName);
                    }
                }
                continue;
            }
        }
        
        // 如果在split函数定义中，继续收集直到匹配的括号
        if (inSplitFunction) {
            splitConstraints << line << "\n";
            
            for (char c : trimmedLine) {
                if (c == '(') parenthesesCount++;
                else if (c == ')') parenthesesCount--;
            }
            
            if (parenthesesCount <= 0) {
                inSplitFunction = false;
                parenthesesCount = 0;
            }
            continue;
        }
        
        // 检查是否为split相关行
        if (isSplitRelatedLine(line)) {
            splitConstraints << line << "\n";
        } else {
            otherConstraints << line << "\n";
        }
    }
    
    splitConstraints << "\n(check-sat)\n";
    otherConstraints << "\n(check-sat)\n";
    
    result.splitConstraints = splitConstraints.str();
    result.otherConstraints = otherConstraints.str();
    
    result.variableDeclarations = extractVariablesFromSplitConstraints(result.splitConstraints);
    result.tempVariableDeclarations = extractTempVariables(result.splitConstraints);

    if (!result.variableDeclarations.empty()) {
        std::string varDeclarations = generateVariableDeclarations(result.variableDeclarations);
        size_t logicPos = result.splitConstraints.find("(set-logic ALL)\n");
        if (logicPos != std::string::npos) {
            size_t insertPos = logicPos + 16;
            result.splitConstraints.insert(insertPos, "\n" + varDeclarations);
        }
        DEBUG("Added ", result.variableDeclarations.size(), " variable declarations to split constraints");
    }
    
    file.close();
    
    DEBUG("Separated split constraints (", result.splitConstraints.length(), " chars) from other constraints (", result.otherConstraints.length(), " chars)");
    
    return result;
}

bool Context::isSplitRelatedLine(const std::string& line) {
    std::string trimmedLine = line;
    trimmedLine.erase(0, trimmedLine.find_first_not_of(" \t"));
    
    // 检查split相关的函数调用
    if (trimmedLine.find("get_split_length") != std::string::npos ||
        trimmedLine.find("get_split_element") != std::string::npos ||
        trimmedLine.find("str.split_at") != std::string::npos ||
        trimmedLine.find("str.split_rest") != std::string::npos ||
        trimmedLine.find("str.num_splits") != std::string::npos) {
        return true;
    }
    
    // 检查split相关的函数定义
    if (trimmedLine.find("(define-fun get_split_length") == 0 ||
        trimmedLine.find("(define-fun get_split_element") == 0) {
        return true;
    }
    
    // 检查split相关的注释
    if (trimmedLine.find(";split operation:") != std::string::npos ||
        trimmedLine.find("split operation:") != std::string::npos ||
        trimmedLine.find("; split operation:") != std::string::npos) {
        return true;
    }
    
    // 检查包含split模式的变量声明和定义
    if (trimmedLine.find("(define-const") == 0 && 
        (trimmedLine.find("get_split_length") != std::string::npos ||
         trimmedLine.find("get_split_element") != std::string::npos)) {
        return true;
    }
    
    return false;
}

// Add this method to Context.cpp for intelligent variable ordering:
std::vector<std::string> Context::orderDeclarationsByDependency(
    const std::vector<std::string>& declarations,
    const std::unordered_set<std::string>& availableVars) {
    
    std::vector<std::string> ordered;
    std::vector<std::string> remaining = declarations;
    std::unordered_set<std::string> declared = availableVars;
    
    // Extract variable dependencies from each declaration
    auto extractUsedVars = [](const std::string& decl) -> std::unordered_set<std::string> {
        std::unordered_set<std::string> used;
        
        // Simple regex to find variable references
        // This is a simplified approach - in practice you might need more sophisticated parsing
        std::regex varRegex(R"(\b(var\d+|div\d+\w*)\b)");
        std::sregex_iterator it(decl.begin(), decl.end(), varRegex);
        std::sregex_iterator end;
        
        for (; it != end; ++it) {
            used.insert(it->str());
        }
        
        return used;
    };
    
    // Extract declared variable from declaration
    auto extractDeclaredVar = [](const std::string& decl) -> std::string {
        std::string trimmed = decl;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(declare-") == 0 || trimmed.find("(define-const") == 0) {
            size_t nameStart = trimmed.find(' ');
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    return trimmed.substr(nameStart, nameEnd - nameStart);
                }
            }
        }
        return "";
    };
    
    // Iteratively add declarations whose dependencies are satisfied
    bool progress = true;
    while (progress && !remaining.empty()) {
        progress = false;
        
        for (auto it = remaining.begin(); it != remaining.end(); ) {
            std::string declaredVar = extractDeclaredVar(*it);
            std::unordered_set<std::string> usedVars = extractUsedVars(*it);
            
            // Remove self-reference
            usedVars.erase(declaredVar);
            
            // Check if all dependencies are satisfied
            bool canAdd = true;
            for (const auto& usedVar : usedVars) {
                if (declared.find(usedVar) == declared.end()) {
                    canAdd = false;
                    break;
                }
            }
            
            if (canAdd) {
                ordered.push_back(*it);
                if (!declaredVar.empty()) {
                    declared.insert(declaredVar);
                }
                it = remaining.erase(it);
                progress = true;
            } else {
                ++it;
            }
        }
    }
    
    // Add any remaining declarations (might have circular dependencies)
    for (const auto& decl : remaining) {
        ordered.push_back(decl);
        DEBUG("Warning: Declaration might have unresolved dependencies: ", decl);
    }
    
    return ordered;
}

// Update mergeSMTConstraints to also clean the content:
std::string Context::mergeSMTConstraints(const std::string& rewrittenSplitPart, const std::string& otherPart) {
    // Clean both parts from non-ASCII characters
    std::string cleanedRewritten = cleanNonAsciiCharacters(rewrittenSplitPart);
    std::string cleanedOther = cleanNonAsciiCharacters(otherPart);
    
    std::stringstream result;
    std::istringstream splitStream(cleanedRewritten);
    std::istringstream otherStream(cleanedOther);
    std::string line;
    
    result << "(set-logic ALL)\n\n";
    
    // First pass: collect all function definitions from other part
    std::vector<std::string> functionDefs;
    std::vector<std::string> otherLines;
    
    while (std::getline(otherStream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(set-logic") == 0 || 
            trimmed.find("(check-sat") == 0 ||
            trimmed.find("(exit") == 0 ||
            trimmed.empty()) {
            continue;
        }
        
        if (trimmed.find("(define-fun") == 0) {
            functionDefs.push_back(line);
            
            // Handle multi-line function definitions
            if (std::count(trimmed.begin(), trimmed.end(), '(') > 
                std::count(trimmed.begin(), trimmed.end(), ')')) {
                int parenCount = std::count(trimmed.begin(), trimmed.end(), '(') - 
                                std::count(trimmed.begin(), trimmed.end(), ')');
                while (parenCount > 0 && std::getline(otherStream, line)) {
                    functionDefs.push_back(line);
                    parenCount += std::count(line.begin(), line.end(), '(');
                    parenCount -= std::count(line.begin(), line.end(), ')');
                }
            }
        } else {
            otherLines.push_back(line);
        }
    }
    
    // Output function definitions first
    for (const auto& funcDef : functionDefs) {
        result << funcDef << "\n";
    }
    if (!functionDefs.empty()) {
        result << "\n";
    }
    
    // Now collect declarations and assertions
    std::vector<std::string> allDeclarations;
    std::vector<std::string> allAssertions;
    std::unordered_set<std::string> declaredVars;
    
    // Process other lines
    for (const auto& line : otherLines) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(declare-") == 0) {
            // Check if this is a split-related variable that we'll declare later
            if (!isSplitRelatedLine(line)) {
                size_t nameStart = trimmed.find(' ');
                if (nameStart != std::string::npos) {
                    nameStart = trimmed.find_first_not_of(' ', nameStart);
                    size_t nameEnd = trimmed.find(' ', nameStart);
                    if (nameEnd != std::string::npos) {
                        std::string varName = trimmed.substr(nameStart, nameEnd - nameStart);
                        if (declaredVars.find(varName) == declaredVars.end()) {
                            allDeclarations.push_back(line);
                            declaredVars.insert(varName);
                        }
                    }
                }
            }
        } else if (trimmed.find("(assert") == 0) {
            allAssertions.push_back(line);
        } else if (trimmed.find("(define-const") == 0) {
            // Handle define-const before assertions
            allDeclarations.push_back(line);
        }
    }
    
    // Process split declarations
    splitStream.clear();
    splitStream.seekg(0);
    while (std::getline(splitStream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(declare-") == 0) {
            size_t nameStart = trimmed.find(' ');
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmed.substr(nameStart, nameEnd - nameStart);
                    if (declaredVars.find(varName) == declaredVars.end()) {
                        allDeclarations.push_back(line);
                        declaredVars.insert(varName);
                    }
                }
            }
        } else if (trimmed.find("(assert") == 0) {
            allAssertions.push_back(line);
        }
    }
    
    // Output all declarations
    for (const auto& decl : allDeclarations) {
        result << decl << "\n";
    }
    if (!allDeclarations.empty()) {
        result << "\n";
    }
    
    // Output all assertions
    for (const auto& assertion : allAssertions) {
        result << assertion << "\n";
    }
    
    result << "\n(check-sat)\n";
    
    return result.str();
}

std::vector<std::string> Context::extractSplitFunctionNames(const std::string& smtContent) {
    std::vector<std::string> functionNames;
    std::istringstream stream(smtContent);
    std::string line;
    
    while (std::getline(stream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(define-fun") == 0) {
            size_t nameStart = trimmed.find(' ', 11);
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string funcName = trimmed.substr(nameStart, nameEnd - nameStart);
                    if (funcName.find("split") != std::string::npos ||
                        funcName.find("get_split") != std::string::npos) {
                        functionNames.push_back(funcName);
                    }
                }
            }
        }
    }
    
    return functionNames;
}

void Context::updateDivisions() {
    auto splitAtConstNodes = getSplitAtConstNodes();
    auto splitAtVarNodes = getSplitAtVarNodes();
    auto splitEndConstNodes = getSplitEndConstNodes();
    auto splitEndVarNodes = getSplitEndVarNodes();
    auto numSplitConstNodes = getNumSplitConstNodes();
    auto numSplitVarNodes = getNumSplitVarNodes();
    
    for (auto& node : splitAtConstNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string str = arg1->toString();
                if (str.size() >= 2 && str.front() == '"' && str.back() == '"') {
                    str = str.substr(1, str.size() - 2);
                }
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                if (!hasDivision(str, delimiter)) {
                    addDivision(std::make_unique<ConstDivision>(str, delimiter));
                    DEBUG("Created new const division for: '", str, "' with delimiter '", delimiter, "'");
                } else {
                    DEBUG("Using existing const division for: '", str, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const split node: ", e.what());
        }
    }
    
    for (auto& node : splitAtVarNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                std::string variable = arg1->toString();
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                int index = std::stoi(arg3->toString());
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    DEBUG("Created new var division for: '", variable, "' with delimiter '", delimiter, "'");
                }
                
                if (division && division->isVarType()) {
                    static_cast<VarDivision*>(division)->addSplitNumAppeared(index);
                    DEBUG("Added split index ", index, " for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split node: ", e.what());
        }
    }
    
    for (auto& node : splitEndConstNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string str = arg1->toString();
                if (str.size() >= 2 && str.front() == '"' && str.back() == '"') {
                    str = str.substr(1, str.size() - 2);
                }
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                if (!hasDivision(str, delimiter)) {
                    addDivision(std::make_unique<ConstDivision>(str, delimiter));
                    DEBUG("Created new const division for split_rest: '", str, "' with delimiter '", delimiter, "'");
                } else {
                    DEBUG("Using existing const division for split_rest: '", str, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const split_rest node: ", e.what());
        }
    }
    
    for (auto& node : splitEndVarNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                std::string variable = arg1->toString();
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                int index = std::stoi(arg3->toString());
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    DEBUG("Created new var division for split_rest: '", variable, "' with delimiter '", delimiter, "'");
                }
                
                if (division && division->isVarType()) {
                    static_cast<VarDivision*>(division)->addSplitEndNumAppeared(index);
                    DEBUG("Added split_rest index ", index, " for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split_rest node: ", e.what());
        }
    }
    
    for (auto& node : numSplitConstNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string str = arg1->toString();
                if (str.size() >= 2 && str.front() == '"' && str.back() == '"') {
                    str = str.substr(1, str.size() - 2);
                }
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                if (!hasDivision(str, delimiter)) {
                    addDivision(std::make_unique<ConstDivision>(str, delimiter));
                    DEBUG("Created new const division for num_splits: '", str, "' with delimiter '", delimiter, "'");
                } else {
                    DEBUG("Using existing const division for num_splits: '", str, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const num_splits node: ", e.what());
        }
    }
    
    for (auto& node : numSplitVarNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string variable = arg1->toString();
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    DEBUG("Created new var division for num_splits: '", variable, "' with delimiter '", delimiter, "'");
                }
                
                if (division) {
                    division->setNumSplitsUsed(true);
                    DEBUG("Marked num_splits usage for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var num_splits node: ", e.what());
        }
    }
    
    updateSplitNodeToAtoms();
}

std::unordered_set<SMTParser::NodePtr> Context::getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const {
    auto it = splitNodeToAtoms.find(splitNode);
    if (it != splitNodeToAtoms.end()) {
        return it->second;
    }
    return std::unordered_set<SMTParser::NodePtr>();
}

bool Context::parseStandard(const std::string& filename) {
    DEBUG("Using standard parsing for: ", filename);
    
    if (!SMTParser.parse(filename)) {
        ERROR("Failed to parse file: ", filename);
        return false;
    }
    
    DEBUG("Parser info updated with ", SMTParser.assertions.size(), " assertions");
    updateInfo();
    updateTasks(filename);
    std::string smtlib2 = getSMTLIB2(true);
    LOG5("SMTLIB2: \n", smtlib2);
    DEBUG("Found ", tasks.size(), " tasks");
    return true;
}

// In Context.cpp, modify parseWithConstraintSeparation:
bool Context::parseWithConstraintSeparation(const SMTSeparationResult& separationResult, const std::string& filename) {
    DEBUG("Using constraint separation for: ", filename);
    
    // Store the separation result for later use
    lastSeparationResult = separationResult;
    usedConstraintSeparation = true;
    
    if (!separationResult.splitConstraints.empty()) {
        std::string tempFilename = "/tmp/strprocessor_split_temp.smt2";
        std::ofstream tempFile(tempFilename);
        if (!tempFile.is_open()) {
            ERROR("Failed to create temporary file for split constraints");
            return false;
        }
        LOG5("Split constraints: \n", separationResult.splitConstraints);
        tempFile << separationResult.splitConstraints;
        tempFile.close();
        if (!SMTParser.parse(tempFilename)) {
            ERROR("Failed to parse split constraints");
            std::filesystem::remove(tempFilename);
            return false;
        }
        std::filesystem::remove(tempFilename);
        DEBUG("Successfully parsed split constraints with ", separationResult.variableDeclarations.size(), " auto-declared variables");
    } else {
        DEBUG("No split constraints found, parsing original file");
        if (!SMTParser.parse(filename)) {
            ERROR("Failed to parse file: ", filename);
            return false;
        }
    }
    
    DEBUG("Parser info updated with ", SMTParser.assertions.size(), " assertions");
    updateInfo();
    updateTasks(filename);
    DEBUG("Found ", tasks.size(), " tasks");
    return true;
}

// Add this new method to Context class:
std::string Context::mergeRewrittenConstraints() {
    if (!usedConstraintSeparation) {
        // If no separation was used, just return the current SMT
        return getSMTLIB2(true);
    }
    
    // Get the rewritten split constraints
    std::string rewrittenSplit = getSMTLIB2(true);
    
    // Debug: show what variables are considered temporary
    DEBUG("Temporary variables to remove:");
    for (const auto& var : lastSeparationResult.variableDeclarations) {
        DEBUG("  - ", var.first, " (", var.second, ")");
    }
    
    // Remove temporary variable declarations
    std::string cleanedRewritten = removeTemporaryVariables(rewrittenSplit, lastSeparationResult.tempVariableDeclarations);
    for (const auto& var : lastSeparationResult.tempVariableDeclarations) {
        LOG4("Variable: ", var.first, " with type: ", var.second);
    }
    LOG4("Cleaned rewritten split constraints: \n", cleanedRewritten);
    // Merge with original other constraints
    return mergeSMTConstraints(cleanedRewritten, lastSeparationResult.otherConstraints);
}

std::string Context::removeTemporaryVariables(const std::string& smtContent, const std::unordered_map<std::string, std::string>& tempVars) {
    std::stringstream result;
    std::istringstream stream(smtContent);
    std::string line;

    while (std::getline(stream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t\n\r"));

        bool isTemporaryVar = false;
        std::string varName;
        const std::string declareFunPrefix = "(declare-fun ";
        const std::string defineConstPrefix = "(define-const ";

        if (trimmed.rfind(declareFunPrefix, 0) == 0) {
            size_t nameStartPos = declareFunPrefix.length();
            size_t nameEndPos = trimmed.find(" ()", nameStartPos);
            if (nameEndPos != std::string::npos) {
                varName = trimmed.substr(nameStartPos, nameEndPos - nameStartPos);
            }
        }
        else if (trimmed.rfind(defineConstPrefix, 0) == 0) {
            size_t nameStartPos = defineConstPrefix.length();
            size_t nameEndPos = trimmed.find(' ', nameStartPos);
            if (nameEndPos != std::string::npos) {
                varName = trimmed.substr(nameStartPos, nameEndPos - nameStartPos);
            }
        }

        if (!varName.empty() && tempVars.count(varName)) {
            isTemporaryVar = true;
        }

        if (!isTemporaryVar) {
            std::string fixedLine = line;
            size_t pos = 0;
            while ((pos = fixedLine.find("，", pos)) != std::string::npos) {
                fixedLine.replace(pos, 3, ",");
                pos += 1;
            }
            result << fixedLine << "\n";
        }
    }
    return result.str();
}

// Add getters for the new members:
bool Context::wasConstraintSeparationUsed() const {
    return usedConstraintSeparation;
}

const Context::SMTSeparationResult& Context::getLastSeparationResult() const {
    return lastSeparationResult;
}

void Context::processSplitConstraints(const SMTSeparationResult& separationResult) {
    if (separationResult.splitConstraints.empty()) {
        DEBUG("No split constraints to process");
        return;
    }
    
    DEBUG("Processing split constraints with ", separationResult.splitRelatedFunctions.size(), " functions");
    
    for (const auto& funcName : separationResult.splitRelatedFunctions) {
        DEBUG("Found split-related function: ", funcName);
    }
}

std::string Context::rewriteAndMergeConstraints(const SMTSeparationResult& separationResult) {
    if (separationResult.splitConstraints.empty()) {
        return separationResult.otherConstraints;
    }
    
    Context splitContext;
    bool parseSuccess = splitContext.parseString(separationResult.splitConstraints);
    if (!parseSuccess) {
        ERROR("Failed to parse split constraints for rewriting");
        return separationResult.otherConstraints;
    }
    
    DEBUG("Successfully parsed split constraints for rewriting");
    DEBUG("Found ", splitContext.getVarCount(), " variables, ", 
          splitContext.getAtomCount(), " atoms, ", 
          splitContext.getClauseCount(), " clauses in split constraints");
    
    splitSolver solver(SolverType::Z3);
    solver.rewriteFormula(splitContext);
    
    std::string rewrittenSplit = splitContext.getSMTLIB2(true);
    DEBUG("Rewritten split constraints length: ", rewrittenSplit.length(), " chars");
    
    std::string finalSMT = mergeSMTConstraints(rewrittenSplit, separationResult.otherConstraints);
    DEBUG("Final merged SMT length: ", finalSMT.length(), " chars");
    
    return finalSMT;
}

std::unordered_map<std::string, std::string> Context::extractVariablesFromSplitConstraints(const std::string& splitConstraints) {
    std::unordered_map<std::string, std::string> variableDeclarations;
    std::istringstream stream(splitConstraints);
    std::string line;
    
    while (std::getline(stream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.empty() || trimmed[0] == ';' || 
            trimmed.find("(set-logic") == 0 || 
            trimmed.find("(check-sat") == 0 ||
            trimmed.find("(define-fun") == 0) {
            continue;
        }
        
        std::vector<std::string> variables = extractVariableNames(line);
        for (const std::string& var : variables) {
            if (variableDeclarations.find(var) == variableDeclarations.end()) {
                std::string type = inferVariableType(var, line);
                variableDeclarations[var] = type;
                DEBUG("Detected variable: ", var, " with type: ", type);
            }
        }
    }
    
    return variableDeclarations;
}

std::string Context::inferVariableType(const std::string& variableName, const std::string& context) {
    // 更精确的类型推断逻辑
    
    // 检查变量是否作为函数的字符串参数使用
    std::string varPattern = "\\b" + variableName + "\\b";
    std::regex varRegex(varPattern);
    
    // 如果在get_split_length/get_split_element函数调用中作为第一个参数(字符串参数)
    std::regex stringArgPattern("get_split_(?:length|element)\\s*\\(\\s*" + variableName + "\\s*,");
    if (std::regex_search(context, stringArgPattern)) {
        return "String";
    }
    
    // 如果在str.*函数中作为字符串参数
    std::regex strFuncPattern("str\\.\\w+\\s*\\(\\s*" + variableName + "\\s*[,)]");
    if (std::regex_search(context, strFuncPattern)) {
        return "String";
    }
    
    // 检查变量是否在define-const中被声明为某种类型的返回值
    if (context.find("(define-const " + variableName + " Int") != std::string::npos) {
        return "Int";
    }
    if (context.find("(define-const " + variableName + " String") != std::string::npos) {
        return "String";  
    }
    if (context.find("(define-const " + variableName + " Bool") != std::string::npos) {
        return "Bool";
    }
    
    // 如果上下文包含返回Int的函数调用且变量是结果
    if ((context.find("get_split_length") != std::string::npos ||
         context.find("str.len") != std::string::npos ||
         context.find("str.num_splits") != std::string::npos) &&
        context.find("(define-const " + variableName) != std::string::npos) {
        return "Int";
    }
    
    // 如果上下文包含返回String的函数调用且变量是结果
    if ((context.find("get_split_element") != std::string::npos ||
         context.find("str.split_at") != std::string::npos ||
         context.find("str.split_rest") != std::string::npos) &&
        context.find("(define-const " + variableName) != std::string::npos) {
        return "String";
    }
    
    // 默认情况：如果无法确定，默认为String
    return "String";
}

std::unordered_map<std::string, std::string> Context::extractTempVariables(const std::string& splitConstraints) {
    std::unordered_map<std::string, std::string> tempVariableDeclarations;
    std::istringstream stream(splitConstraints);
    std::string line;
    
    while (std::getline(stream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.empty() || trimmed[0] == ';' || 
            trimmed.find("(set-logic") == 0 || 
            trimmed.find("(check-sat") == 0 ||
            trimmed.find("(define-fun") == 0) {
            continue;
        }
        
        std::vector<std::string> variables = extractVariableNames(line);
        for (const std::string& var : variables) {
            if (tempVariableDeclarations.find(var) == tempVariableDeclarations.end()) {
                if (isTempVariable(var, line)) {
                    tempVariableDeclarations[var] = inferVariableType(var, line);
                    DEBUG("Detected variable: ", var, " with type: ", tempVariableDeclarations[var]);
                }
            }
        }
    }
    return tempVariableDeclarations;
}

bool Context::isTempVariable(const std::string& variableName, const std::string& context) {
    // 检查变量是否在define-const中被声明为某种类型的返回值
    if (context.find("(define-const " + variableName + " Int") != std::string::npos) {
        return false;
    }
    if (context.find("(define-const " + variableName + " String") != std::string::npos) {
        return false;  
    }
    if (context.find("(define-const " + variableName + " Bool") != std::string::npos) {
        return false;
    }
    return true;
}

std::vector<std::string> Context::extractVariableNames(const std::string& line) {
    std::vector<std::string> variables;
    std::regex varPattern(R"(\b(var\d+)\b)");
    std::sregex_iterator iter(line.begin(), line.end(), varPattern);
    std::sregex_iterator end;
    
    for (; iter != end; ++iter) {
        std::string var = iter->str();
        variables.push_back(var);
    }
    
    return variables;
}

std::string Context::generateVariableDeclarations(const std::unordered_map<std::string, std::string>& varDeclarations) {
    std::stringstream declarations;
    
    for (const auto& pair : varDeclarations) {
        declarations << "(declare-fun " << pair.first << " () " << pair.second << ")\n";
    }
    
    return declarations.str();
}

// In Context.cpp, replace the mergeAtOriginalPosition method:
std::string Context::mergeAtOriginalPosition(const std::string& rewrittenSplitPart, const std::string& otherPart) {
    std::stringstream result;
    std::istringstream otherStream(otherPart);
    std::string line;
    
    // Data structures for organizing content
    std::vector<std::string> splitDeclarations;
    std::vector<std::string> splitAssertions;
    std::unordered_set<std::string> splitDeclaredVars;
    
    // Extract declarations and assertions from rewritten split part
    std::istringstream splitStream(rewrittenSplitPart);
    while (std::getline(splitStream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(set-logic") == 0 || 
            trimmed.find("(check-sat") == 0 ||
            trimmed.find("(exit") == 0 ||
            trimmed.empty()) {
            continue;
        }
        
        if (trimmed.find("(declare-") == 0) {
            // Extract variable name
            size_t nameStart = trimmed.find(' ');
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmed.substr(nameStart, nameEnd - nameStart);
                    splitDeclaredVars.insert(varName);
                }
            }
            splitDeclarations.push_back(line);
        } else if (trimmed.find("(assert") == 0) {
            splitAssertions.push_back(line);
        }
    }
    
    // Process the other part
    bool foundSplitSection = false;
    std::vector<std::string> pendingLines;
    std::unordered_set<std::string> declaredVars;
    
    while (std::getline(otherStream, line)) {
        // Clean the line from any non-ASCII characters
        std::string cleanedLine;
        for (char c : line) {
            if (static_cast<unsigned char>(c) < 128) {
                cleanedLine += c;
            }
        }
        line = cleanedLine;
        
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        // Skip exit statements
        if (trimmed.find("(exit") == 0) {
            continue;
        }
        
        // Check if this is a split-related line
        if (isSplitRelatedLine(line)) {
            if (!foundSplitSection) {
                foundSplitSection = true;
                
                // Insert split variable declarations that aren't already declared
                for (const auto& decl : splitDeclarations) {
                    std::string declTrimmed = decl;
                    declTrimmed.erase(0, declTrimmed.find_first_not_of(" \t"));
                    
                    bool shouldAdd = true;
                    if (declTrimmed.find("(declare-") == 0) {
                        size_t nameStart = declTrimmed.find(' ');
                        if (nameStart != std::string::npos) {
                            nameStart = declTrimmed.find_first_not_of(' ', nameStart);
                            size_t nameEnd = declTrimmed.find(' ', nameStart);
                            if (nameEnd != std::string::npos) {
                                std::string varName = declTrimmed.substr(nameStart, nameEnd - nameStart);
                                if (declaredVars.count(varName) > 0) {
                                    shouldAdd = false;
                                } else {
                                    declaredVars.insert(varName);
                                }
                            }
                        }
                    }
                    
                    if (shouldAdd) {
                        result << decl << "\n";
                    }
                }
                
                // Add a blank line for readability
                if (!splitDeclarations.empty()) {
                    result << "\n";
                }
            }
            // Skip the original split-related line
            continue;
        }
        
        // Handle regular lines
        if (trimmed.find("(declare-") == 0) {
            // Check if this variable is already declared by split constraints
            size_t nameStart = trimmed.find(' ');
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmed.substr(nameStart, nameEnd - nameStart);
                    if (splitDeclaredVars.count(varName) > 0) {
                        // Skip this declaration
                        continue;
                    }
                    declaredVars.insert(varName);
                }
            }
        }
        
        // Check if this is an assertion section
        if (trimmed.find("(assert") == 0) {
            // If we haven't inserted split assertions yet, do it before the first assertion
            if (foundSplitSection && !splitAssertions.empty()) {
                for (const auto& assertion : splitAssertions) {
                    result << assertion << "\n";
                }
                splitAssertions.clear(); // Clear to avoid duplicate insertion
            }
        }
        
        result << line << "\n";
    }
    
    // If split assertions weren't inserted yet, add them before check-sat
    if (!splitAssertions.empty()) {
        for (const auto& assertion : splitAssertions) {
            result << assertion << "\n";
        }
    }
    
    // Ensure we end with check-sat
    std::string resultStr = result.str();
    if (resultStr.find("(check-sat)") == std::string::npos) {
        result << "\n(check-sat)\n";
    }
    
    return result.str();
}

// Also add a helper method to clean non-ASCII characters:
std::string Context::cleanNonAsciiCharacters(const std::string& input) {
    std::string result;
    for (char c : input) {
        if (static_cast<unsigned char>(c) < 128) {
            result += c;
        }
    }
    return result;
}

} // namespace strp
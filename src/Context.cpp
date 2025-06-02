#include "Context.h"
#include "Structures.h"
#include <sstream>
#include <fstream>
#include <filesystem>
#include <regex>

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

std::vector<SMTParser::NodePtr> Context::getVariables() {
    boost::unordered_set<SMTParser::NodePtr> varSet;
    SMTParser.collectVars(SMTParser.assertions, varSet);
    return std::vector<SMTParser::NodePtr>(varSet.begin(), varSet.end());
}

std::vector<SMTParser::NodePtr> Context::getAssertions() {
    return SMTParser.assertions;
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes() {
    std::vector<SMTParser::NodePtr> result;
    boost::unordered_set<SMTParser::NodePtr> allNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectAllNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        allNodes.insert(node);
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectAllNodes(node->getChild(i));
        }
    };
    
    for (auto& assertion : SMTParser.assertions) {
        collectAllNodes(assertion);
    }
    
    for (auto& node : allNodes) {
        if (node && node->isStrSplitAt()) {
            result.push_back(node);
        }
    }
    
    return result;
}

std::vector<SMTParser::NodePtr> Context::getNumSplitsNodes() {
    std::vector<SMTParser::NodePtr> result;
    boost::unordered_set<SMTParser::NodePtr> allNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectAllNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        allNodes.insert(node);
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectAllNodes(node->getChild(i));
        }
    };
    
    for (auto& assertion : SMTParser.assertions) {
        collectAllNodes(assertion);
    }
    
    for (auto& node : allNodes) {
        if (node && node->isStrNumSplits()) {
            result.push_back(node);
        }
    }
    
    return result;
}

std::vector<SMTParser::NodePtr> Context::getSplitAtConstNodes() {
    std::vector<SMTParser::NodePtr> result;
    auto splitAtNodes = getSplitAtNodes();
    
    for (auto& node : splitAtNodes) {
        if (node && node->getChildrenSize() > 0) {
            auto firstChild = node->getChild(0);
            if (firstChild && firstChild->isConst()) {
                result.push_back(node);
            }
        }
    }
    
    return result;
}

std::vector<SMTParser::NodePtr> Context::getNumSplitsConstNodes() {
    std::vector<SMTParser::NodePtr> result;
    auto numSplitsNodes = getNumSplitsNodes();
    
    for (auto& node : numSplitsNodes) {
        if (node && node->getChildrenSize() > 0) {
            auto firstChild = node->getChild(0);
            if (firstChild && firstChild->isConst()) {
                result.push_back(node);
            }
        }
    }
    
    return result;
}

std::vector<SMTParser::NodePtr> Context::getSplitAtVarNodes() {
    std::vector<SMTParser::NodePtr> result;
    auto splitAtNodes = getSplitAtNodes();
    
    for (auto& node : splitAtNodes) {
        if (node && node->getChildrenSize() > 0) {
            auto firstChild = node->getChild(0);
            if (firstChild && firstChild->isVar()) {
                result.push_back(node);
            }
        }
    }
    
    return result;
}

std::vector<SMTParser::NodePtr> Context::getNumSplitsVarNodes() {
    std::vector<SMTParser::NodePtr> result;
    auto numSplitsNodes = getNumSplitsNodes();
    
    for (auto& node : numSplitsNodes) {
        if (node && node->getChildrenSize() > 0) {
            auto firstChild = node->getChild(0);
            if (firstChild && firstChild->isVar()) {
                result.push_back(node);
            }
        }
    }
    
    return result;
}

std::vector<SMTParser::NodePtr> Context::getSplitNodes() {
    std::vector<SMTParser::NodePtr> result;
    boost::unordered_set<SMTParser::NodePtr> allNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectAllNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        allNodes.insert(node);
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectAllNodes(node->getChild(i));
        }
    };
    
    for (auto& assertion : SMTParser.assertions) {
        collectAllNodes(assertion);
    }
    
    for (auto& node : allNodes) {
        if (node && (node->isStrSplitAt() || node->isStrNumSplits())) {
            result.push_back(node);
        }
    }
    
    return result;
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
    for (const auto& lemma : lemmas) {
        ss << lemma.toSMT() << "\n";
    }
    ss << "\n(check-sat)\n";
    
    return ss.str();
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

boost::unordered_set<SMTParser::NodePtr> Context::getAtoms(const SMTParser::NodePtr& node) {
    boost::unordered_set<SMTParser::NodePtr> nodes;
    getInstance().SMTParser.collectAtoms(node, nodes);
    return nodes;
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

void Context::addLemma(const Lemma& lemma) {
    lemmas.push_back(lemma);
}

boost::unordered_set<Var> Context::getVars() const {
    return vars;
}

boost::unordered_set<Atom> Context::getAtoms() const {
    return atoms;
}

std::vector<Clause> Context::getClauses() const {
    return clauses;
}

std::vector<Lemma> Context::getLemmas() const {
    return lemmas;
}

void Context::clear() {
    clearVars();
    clearAtoms();
    clearClauses();
    clearLemmas();
    clearSplitCache();
    clearSplitInfos();
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

void Context::clearLemmas() {
    lemmas.clear();
}

void Context::clearSplitCache() {
    splitCache.clear();
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

size_t Context::getLemmaCount() const {
    return lemmas.size();
}

SMTParser::NodePtr Context::replaceAtoms(const SMTParser::NodePtr& expr, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& atomMap) {
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = atomMap;
    return getInstance().SMTParser.replaceAtoms(expr, convertedMap);
}

SMTParser::NodePtr Context::replaceNodes(const SMTParser::NodePtr& expr, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = nodeMap;
    return getInstance().SMTParser.replaceNodes(expr, convertedMap);
}

SMTParser::NodePtr Context::createIntConst(int value) {
    return getInstance().SMTParser.mkConstInt(value);
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

SMTParser::NodePtr Context::createStringConst(const std::string& value) {
    return getInstance().SMTParser.mkConstStr(value);
}

void Context::updateAssertions(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap) {
    for (size_t i = 0; i < SMTParser.assertions.size(); ++i) {
        boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = replacementMap;
        SMTParser.assertions[i] = SMTParser.replaceAtoms(SMTParser.assertions[i], convertedMap);
    }
}

void Context::updateAssertionsWithNodes(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap) {
    for (size_t i = 0; i < SMTParser.assertions.size(); ++i) {
        boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = replacementMap;
        SMTParser.assertions[i] = SMTParser.replaceNodes(SMTParser.assertions[i], convertedMap);
    }
}

std::string Context::generateCacheKey(const std::string& str, const std::string& delimiter) const {
    return str + "|" + delimiter;
}

std::vector<std::string> Context::getCachedSplit(const std::string& str, const std::string& delimiter) {
    std::string key = generateCacheKey(str, delimiter);
    auto it = splitCache.find(key);
    if (it != splitCache.end()) {
        return it->second;
    }
    return std::vector<std::string>();
}

void Context::cacheSplit(const std::string& str, const std::string& delimiter, const std::vector<std::string>& result) {
    std::string key = generateCacheKey(str, delimiter);
    splitCache[key] = result;
}

bool Context::hasCachedSplit(const std::string& str, const std::string& delimiter) const {
    std::string key = generateCacheKey(str, delimiter);
    return splitCache.find(key) != splitCache.end();
}

std::string Context::generateSplitKey(const std::string& variable, const std::string& delimiter) const {
    return variable + "##" + delimiter;
}

void Context::addSplitInfo(const std::string& variable, const std::string& delimiter) {
    std::string key = generateSplitKey(variable, delimiter);
    if (splitInfoMap.find(key) == splitInfoMap.end()) {
        SplitInfo info;
        info.variable = variable;
        info.delimiter = delimiter;
        splitInfoMap[key] = info;
        DEBUG("Added split info for variable: ", variable, " with delimiter: \"", delimiter, "\"");
    }
}

void Context::updateSplitInfo(const std::string& variable, const std::string& delimiter, int minSplits, int maxSplits, int exactCount) {
    std::string key = generateSplitKey(variable, delimiter);
    auto it = splitInfoMap.find(key);
    if (it == splitInfoMap.end()) {
        addSplitInfo(variable, delimiter);
        it = splitInfoMap.find(key);
    }
    
    SplitInfo& info = it->second;
    if (exactCount >= 0) {
        info.hasExactCount = true;
        info.exactCount = exactCount;
        info.minSplits = exactCount;
        info.maxSplits = exactCount;
        DEBUG("Set exact count for ", variable, " with delimiter \"", delimiter, "\": ", exactCount);
    } else {
        if (minSplits >= 0) {
            info.minSplits = std::max(info.minSplits, minSplits);
            DEBUG("Updated min splits for ", variable, " with delimiter \"", delimiter, "\": ", info.minSplits);
        }
        if (maxSplits >= 0) {
            if (info.maxSplits < 0) {
                info.maxSplits = maxSplits;
            } else {
                info.maxSplits = std::min(info.maxSplits, maxSplits);
            }
            DEBUG("Updated max splits for ", variable, " with delimiter \"", delimiter, "\": ", info.maxSplits);
        }
    }
}

void Context::addRequiredIndex(const std::string& variable, const std::string& delimiter, int index) {
    std::string key = generateSplitKey(variable, delimiter);
    auto it = splitInfoMap.find(key);
    if (it == splitInfoMap.end()) {
        addSplitInfo(variable, delimiter);
        it = splitInfoMap.find(key);
    }
    
    SplitInfo& info = it->second;
    if (std::find(info.requiredIndices.begin(), info.requiredIndices.end(), index) == info.requiredIndices.end()) {
        info.requiredIndices.push_back(index);
        std::sort(info.requiredIndices.begin(), info.requiredIndices.end());
        
        int requiredMinSplits = index + 1;
        if (!info.hasExactCount && requiredMinSplits > info.minSplits) {
            info.minSplits = requiredMinSplits;
            DEBUG("Added required index ", index, " for ", variable, " with delimiter \"", delimiter, "\", updated min splits to: ", info.minSplits);
        } else {
            DEBUG("Added required index ", index, " for ", variable, " with delimiter \"", delimiter, "\", current min splits: ", info.minSplits);
        }
    }
}

SplitInfo* Context::getSplitInfo(const std::string& variable, const std::string& delimiter) {
    std::string key = generateSplitKey(variable, delimiter);
    auto it = splitInfoMap.find(key);
    if (it != splitInfoMap.end()) {
        return &(it->second);
    }
    return nullptr;
}

std::vector<SplitInfo>& Context::getAllSplitInfos() {
    static std::vector<SplitInfo> result;
    result.clear();
    for (auto& pair : splitInfoMap) {
        result.push_back(pair.second);
    }
    return result;
}

void Context::clearSplitInfos() {
    splitInfoMap.clear();
    tempAssertions.clear();
    tempVariables.clear();
}

void Context::setInitSplitNums() {
    DEBUG("Setting initial split numbers for all split infos");
    for (auto& pair : splitInfoMap) {
        SplitInfo& info = pair.second;
        if (!info.hasExactCount) {
            if (info.maxSplits > 0 && info.minSplits > info.maxSplits) {
                WARN("Inconsistent split constraints for ", info.variable, " with delimiter \"", info.delimiter, 
                     "\": min=", info.minSplits, " > max=", info.maxSplits);
                info.minSplits = info.maxSplits;
            }
        }
        DEBUG("Split info for ", info.variable, " with delimiter \"", info.delimiter, 
              ": min=", info.minSplits, 
              ", max=", (info.maxSplits > 0 ? std::to_string(info.maxSplits) : "unlimited"),
              ", exact=", (info.hasExactCount ? std::to_string(info.exactCount) : "none"),
              ", required indices: [", 
              [&]() {
                  std::string indices;
                  for (size_t i = 0; i < info.requiredIndices.size(); ++i) {
                      if (i > 0) indices += ",";
                      indices += std::to_string(info.requiredIndices[i]);
                  }
                  return indices;
              }(), "]");
    }
}

void Context::addConcatNodes() {
    DEBUG("Adding concat nodes and auxiliary variables");
    
    for (auto& pair : splitInfoMap) {
        const SplitInfo& info = pair.second;
        int numParts = info.hasExactCount ? info.exactCount : info.minSplits;
        
        DEBUG("Creating ", numParts, " auxiliary variables for ", info.variable, " with delimiter \"", info.delimiter, "\"");
        
        SMTParser::NodePtr originalVar = SMTParser.getVariable(info.variable);
        if (!originalVar) {
            WARN("Could not find original variable: ", info.variable);
            continue;
        }
        
        std::stringstream concatConstraints;
        
        for (int i = 0; i < numParts; ++i) {
            std::string auxVarName = info.variable + "_split_" + std::to_string(i);
            concatConstraints << "(declare-fun " << auxVarName << " () String)\n";
        }
        
        concatConstraints << "(assert (= " << info.variable << " (str.++";
        for (int i = 0; i < numParts; ++i) {
            std::string auxVarName = info.variable + "_split_" + std::to_string(i);
            concatConstraints << " " << auxVarName;
            if (i < numParts - 1) {
                concatConstraints << " \"" << info.delimiter << "\"";
            }
        }
        concatConstraints << ")))\n";
        
        for (int i = 0; i < numParts; ++i) {
            std::string auxVarName = info.variable + "_split_" + std::to_string(i);
            concatConstraints << "(assert (not (str.contains " << auxVarName << " \"" << info.delimiter << "\")))\n";
        }
        
        std::string constraintStr = concatConstraints.str();
        DEBUG("Generated concat constraint with delimiter exclusions: \n", constraintStr);
        
        if (SMTParser.parseStr(constraintStr)) {
            DEBUG("Successfully added concat constraint and delimiter exclusions for ", info.variable);
        } else {
            WARN("Failed to parse concat constraint for ", info.variable);
        }
    }
    
    DEBUG("Completed adding concat constraints with delimiter exclusions");
}

bool Context::incrementSplitNums() {
    DEBUG("Attempting to increment split numbers");
    
    for (auto& pair : splitInfoMap) {
        SplitInfo& info = pair.second;
        
        if (info.hasExactCount) {
            continue;
        }
        
        int currentSplits = info.minSplits;
        int maxAllowed = (info.maxSplits > 0) ? info.maxSplits : currentSplits + 5;
        
        if (currentSplits < maxAllowed) {
            info.minSplits = currentSplits + 1;
            DEBUG("Incremented split count for ", info.variable, " with delimiter \"", info.delimiter, 
                  " from ", currentSplits, " to ", info.minSplits);
            return true;
        }
    }
    
    DEBUG("No more split numbers can be incremented");
    return false;
}

void Context::resetSplitNums() {
    DEBUG("Resetting split numbers to initial values");
    
    for (auto& pair : splitInfoMap) {
        SplitInfo& info = pair.second;
        
        if (!info.hasExactCount) {
            int minRequired = 1;
            for (int idx : info.requiredIndices) {
                minRequired = std::max(minRequired, idx + 1);
            }
            info.minSplits = std::max(1, minRequired - 2);
            DEBUG("Reset split count for ", info.variable, " with delimiter \"", info.delimiter, "\" to ", info.minSplits, " (conservative start)");
        }
    }
}

bool Context::hasMoreSplitCombinations() const {
    for (const auto& pair : splitInfoMap) {
        const SplitInfo& info = pair.second;
        
        if (info.hasExactCount) {
            continue;
        }
        
        int currentSplits = info.minSplits;
        int maxAllowed = (info.maxSplits > 0) ? info.maxSplits : currentSplits + 5;
        
        if (currentSplits < maxAllowed) {
            return true;
        }
    }
    
    return false;
}

void Context::printCurrentSplitState() const {
    DEBUG("Current split state:");
    for (const auto& pair : splitInfoMap) {
        const SplitInfo& info = pair.second;
        DEBUG("  ", info.variable, " with delimiter \"", info.delimiter, "\": current=", info.minSplits, 
              ", max=", (info.maxSplits > 0 ? std::to_string(info.maxSplits) : "unlimited"),
              ", exact=", (info.hasExactCount ? std::to_string(info.exactCount) : "none"));
    }
    std::string smtlib2 = getSMTLIB2(true);
    LOG5("SMTLIB2: \n", smtlib2);
}

void Context::addFalseConstraint() {
    std::string assertion = "(assert false)";
    SMTParser.parseStr(assertion);
    DEBUG("Added false constraint to make formula UNSAT");
}

void Context::updateTasks(const std::string& filename) {
    tasks = getTask(filename);
}

bool Context::hasConflictingSplitConstraints() const {
    for (const auto& pair : splitInfoMap) {
        const SplitInfo& info = pair.second;
        
        if (info.hasExactCount) {
            if (info.maxSplits > 0 && info.exactCount > info.maxSplits) {
                ERROR("Conflicting split constraints for ", info.variable, " with delimiter \"", info.delimiter, 
                      "\": exact count=", info.exactCount, " > max=", info.maxSplits);
                return true;
            }
            
            if (info.exactCount < info.minSplits) {
                ERROR("Conflicting split constraints for ", info.variable, " with delimiter \"", info.delimiter, 
                      "\": exact count=", info.exactCount, " < min=", info.minSplits);
                return true;
            }
            continue;
        }
        
        if (info.maxSplits > 0 && info.minSplits > info.maxSplits) {
            ERROR("Conflicting split constraints for ", info.variable, " with delimiter \"", info.delimiter, 
                  "\": min=", info.minSplits, " > max=", info.maxSplits);
            return true;
        }
        
        if (!info.requiredIndices.empty()) {
            int maxRequiredIndex = *std::max_element(info.requiredIndices.begin(), info.requiredIndices.end());
            int requiredMinSplits = maxRequiredIndex + 1;
            
            if (info.maxSplits > 0 && requiredMinSplits > info.maxSplits) {
                ERROR("Split constraint conflict for ", info.variable, " with delimiter \"", info.delimiter, 
                      "\": required index ", maxRequiredIndex, " needs at least ", requiredMinSplits, 
                      " splits, but max allowed is ", info.maxSplits);
                return true;
            }
        }
    }
    
    return false;
}

} // namespace strp
#include "Context.h"
#include "Structures.h"
#include <sstream>
#include <fstream>
#include <filesystem>
#include <regex>
#include <chrono>

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
    boost::unordered_set<SMTParser::NodePtr> varSet;
    SMTParser.collectVars(SMTParser.assertions, varSet);
    return std::vector<SMTParser::NodePtr>(varSet.begin(), varSet.end());
}

void Context::declareStringVar(const std::string& name) {
    SMTParser.mkVarStr(name);
    DEBUG("Declared string variable: ", name);
}

void Context::declareBoolVar(const std::string& name) {
    SMTParser.mkVarBool(name);
    DEBUG("Declared boolean variable: ", name);
}

void Context::addAssertion(const std::string& constraint) {
    SMTParser.assert(constraint);
    DEBUG("Added assertion: ", constraint);
}

std::vector<SMTParser::NodePtr> Context::getAssertions() {
    return SMTParser.assertions;
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes() {
    boost::unordered_set<SMTParser::NodePtr> splitNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrSplitAt()) {
            splitNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectSplitNodes(node->getChild(i));
        }
    };
    
    for (auto& assertion : SMTParser.assertions) {
        collectSplitNodes(assertion);
    }
    
    return std::vector<SMTParser::NodePtr>(splitNodes.begin(), splitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes(const SMTParser::NodePtr& node) {
    boost::unordered_set<SMTParser::NodePtr> splitNodes;
    
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
    boost::unordered_set<SMTParser::NodePtr> result;
    auto splitAtNodes = getSplitAtNodes();
    
    for (auto& node : splitAtNodes) {
        if (node && node->getChildrenSize() > 0) {
            auto firstChild = node->getChild(0);
            if (firstChild && firstChild->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtVarNodes() {
    boost::unordered_set<SMTParser::NodePtr> result;
    auto splitAtNodes = getSplitAtNodes();
    
    for (auto& node : splitAtNodes) {
        if (node && node->getChildrenSize() > 0) {
            auto firstChild = node->getChild(0);
            if (firstChild && firstChild->isVar()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getAtoms(const SMTParser::NodePtr& node) {
    boost::unordered_set<SMTParser::NodePtr> nodes;
    getInstance().SMTParser.collectAtoms(node, nodes);
    return std::vector<SMTParser::NodePtr>(nodes.begin(), nodes.end());
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

std::unordered_map<std::string, Division> Context::getDivisions() const {
    return divisions;
}

void Context::clear() {
    clearVars();
    clearAtoms();
    clearClauses();
    clearLemmas();
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

void Context::clearLemmas() {
    lemmas.clear();
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

size_t Context::getLemmaCount() const {
    return lemmas.size();
}

SMTParser::NodePtr Context::replaceNodes(const SMTParser::NodePtr& expr, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = nodeMap;
    return getInstance().SMTParser.replaceNodes(expr, convertedMap);
}

void Context::replaceNodes(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    auto& parser = getInstance().SMTParser;
    for (size_t i = 0; i < parser.assertions.size(); ++i) {
        boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> convertedMap = nodeMap;
        parser.assertions[i] = parser.replaceNodes(parser.assertions[i], convertedMap);
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

void Context::addDivision(const Division& division) {
    std::string key = Division::generateKey(division.getDivided(), division.getDelimiter());
    divisions[key] = division;
}

Division* Context::getDivision(const std::string& divided, const std::string& delimiter) {
    std::string key = Division::generateKey(divided, delimiter);
    auto it = divisions.find(key);
    if (it != divisions.end()) {
        return &it->second;
    }
    return nullptr;
}

bool Context::hasDivision(const std::string& divided, const std::string& delimiter) const {
    std::string key = Division::generateKey(divided, delimiter);
    return divisions.find(key) != divisions.end();
}

const std::unordered_map<std::string, Division>& Context::getAllDivisions() const {
    return divisions;
}

void Context::updateSplitNodeToAtoms() {
    clearSplitNodeToAtoms();
    
    auto assertions = getAssertions();
    boost::unordered_set<SMTParser::NodePtr> allAtoms;
    auto allSplitNodes = getSplitAtNodes();
    
    for (auto& assertion : assertions) {
        auto atomsInAssertion = getAtoms(assertion);
        allAtoms.insert(atomsInAssertion.begin(), atomsInAssertion.end());
    }
    
    for (auto& splitNode : allSplitNodes) {
        boost::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (containsNode(atom, splitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitNode] = relatedAtoms;
        }
    }
    
    DEBUG("Updated splitNodeToAtoms with ", splitNodeToAtoms.size(), " splitAt nodes");
}

void Context::updateDivisions() {
    auto splitAtConstNodes = getSplitAtConstNodes();
    auto splitAtVarNodes = getSplitAtVarNodes();
    
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
                    Division newDivision(str, delimiter, "const");
                    addDivision(newDivision);
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
                    Division newDivision(variable, delimiter, "var");
                    addDivision(newDivision);
                    division = getDivision(variable, delimiter);
                    DEBUG("Created new var division for: '", variable, "' with delimiter '", delimiter, "'");
                }
                
                if (division) {
                    division->addVarSplitNumAppeared(index);
                    DEBUG("Added split index ", index, " for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split node: ", e.what());
        }
    }
    
    updateSplitNodeToAtoms();
}

boost::unordered_set<SMTParser::NodePtr> Context::getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const {
    auto it = splitNodeToAtoms.find(splitNode);
    if (it != splitNodeToAtoms.end()) {
        return it->second;
    }
    return {};
}

} // namespace strp
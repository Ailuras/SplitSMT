#include "Context.h"
#include "Structures.h"
#include <sstream>
#include <fstream>
#include <filesystem>

namespace strp {

Context& Context::getInstance() {
    static Context instance;
    return instance;
}

Context::Context() {}

bool Context::parseFile(const std::string& filename) {
    DEBUG("Parsing file: ", filename);
    clear();
    
    if (!std::filesystem::exists(filename)) {
        ERROR("File does not exist: ", filename);
        return false;
    }
    if (!smtlibParser.parse(filename)) {
        ERROR("Failed to parse file: ", filename);
        return false;
    }
    DEBUG("Parser info updated with ", smtlibParser.assertions.size(), " assertions");
    updateInfo();
    std::string smtlib2 = getSMTLIB2(true);
    DEBUG("SMTLIB2: ", smtlib2);
    std::string smtlib2_from_context = getSMTLIB2(false);
    DEBUG("SMTLIB2 from context: ", smtlib2_from_context);
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
    if (!smtlibParser.parse(tempFilename)) {
        ERROR("Failed to parse string input");
        std::filesystem::remove(tempFilename);
        return false;
    }
    std::filesystem::remove(tempFilename);
    DEBUG("Parser info updated with ", smtlibParser.assertions.size(), " assertions");
    updateInfo();
    return true;
}

void Context::updateInfo() {
    std::vector<SMTLIBParser::NodePtr> variables = getVariables();
    std::vector<SMTLIBParser::NodePtr> assertions = getAssertions();
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

std::vector<SMTLIBParser::NodePtr> Context::getVariables() {
    boost::unordered_set<SMTLIBParser::NodePtr> varSet;
    smtlibParser.collectVars(smtlibParser.assertions, varSet);
    return std::vector<SMTLIBParser::NodePtr>(varSet.begin(), varSet.end());
}

std::vector<SMTLIBParser::NodePtr> Context::getAssertions() {
    return smtlibParser.assertions;
}

std::string Context::getSMTLIB2(bool from_parser) const {
    if (from_parser) {
        return const_cast<Context*>(this)->smtlibParser.dumpSMT2();
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

int Context::getType(const SMTLIBParser::NodePtr& node) {
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

VarType Context::getVarType(const SMTLIBParser::NodePtr& node) {
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

AtomType Context::getAtomType(const SMTLIBParser::NodePtr& node) {
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

ClauseType Context::getClauseType(const SMTLIBParser::NodePtr& node) {
    if (!node) return ClauseType::Unknown;
    
    std::string kindStr = getInstance().smtlibParser.toString(node->getKind());
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

boost::unordered_set<SMTLIBParser::NodePtr> Context::getAtoms(const SMTLIBParser::NodePtr& node) {
    boost::unordered_set<SMTLIBParser::NodePtr> nodes;
    getInstance().smtlibParser.collectAtoms(node, nodes);
    return nodes;
}

std::string Context::getSource(const SMTLIBParser::NodePtr& node) {
    return getInstance().smtlibParser.toString(node);
}

std::string Context::getComment(const SMTLIBParser::NodePtr& node) {
    if (!node) return "";
    if (node->getChildrenSize() == 0) {
        std::string value = node->toString();
        if (value.size() >= 2 && value.front() == '"' && value.back() == '"') {
            return value;
        }
        return value;
    }
    auto kind = node->getKind();
    std::string kindStr = SMTLIBParser::kindToString(kind);
    
    if (kind == SMTLIBParser::NODE_KIND::NT_APPLY_UF) {
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
        std::string childKind = SMTLIBParser::kindToString(child->getKind());
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

} // namespace strp

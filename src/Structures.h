#pragma once
#include <string>
#include <vector>
#include <memory>
#include <unordered_map>
#include <iostream>
#include <boost/unordered/unordered_set.hpp>
#include <boost/functional/hash.hpp>
#include "dag.h"

namespace strp {

class Context;

enum class VarType {
    INTEGER,
    REAL,
    BOOLEAN,
    STRING,
    FUNCTION,
    UNKNOWN
};

inline std::ostream& operator<<(std::ostream& os, const VarType& type) {
    switch (type) {
        case VarType::INTEGER: return os << "INTEGER";
        case VarType::REAL: return os << "REAL";
        case VarType::BOOLEAN: return os << "BOOLEAN";
        case VarType::STRING: return os << "STRING";
        case VarType::FUNCTION: return os << "FUNCTION";
        case VarType::UNKNOWN: return os << "UNKNOWN";
        default: return os << "Invalid";
    }
}

class Var {
public:
    Var() = default;
    Var(const SMTLIBParser::NodePtr& node, Context& context);
    Var(const Var& other) = default;
    Var& operator=(const Var& other) = default;
    ~Var() = default;
    
    std::string getName() const { return node->getName(); }
    VarType getType() const { return type; }
    std::string getSource() const { return source; }
    std::string getComment() const { return comment; }
    
    std::string toSMT() const {
        std::string typeStr;
        switch (type) {
            case VarType::INTEGER: typeStr = "Int"; break;
            case VarType::REAL: typeStr = "Real"; break;
            case VarType::BOOLEAN: typeStr = "Bool"; break;
            case VarType::STRING: typeStr = "String"; break;
            case VarType::FUNCTION: typeStr = source; break;
            default: typeStr = source; break;
        }
        if (type == VarType::FUNCTION) {
            return source;
        }
        return "(declare-fun " + getName() + " () " + typeStr + ")";
    }
    
    bool operator==(const Var& other) const {
        return node == other.node;
    }
    
    bool operator!=(const Var& other) const {
        return !(*this == other);
    }
    
    friend std::size_t hash_value(const Var& var) {
        return boost::hash<SMTLIBParser::NodePtr>()(var.node);
    }

private:
    SMTLIBParser::NodePtr node;
    VarType type;
    std::string source;
    std::string comment;
};

enum class AtomType {
    Arithmetic,
    String,
    Regular,
    UninterpretedFunction,
    Unknown
};

inline std::ostream& operator<<(std::ostream& os, const AtomType& type) {
    switch (type) {
        case AtomType::Arithmetic: return os << "Arithmetic";
        case AtomType::String: return os << "String";
        case AtomType::Regular: return os << "Regular";
        case AtomType::UninterpretedFunction: return os << "UninterpretedFunction";
        case AtomType::Unknown: return os << "Unknown";
        default: return os << "Invalid";
    }
}

class Atom {
public:
    Atom() = default;
    Atom(const SMTLIBParser::NodePtr& node, Context& context);
    Atom(const Atom& other) = default;
    Atom& operator=(const Atom& other) = default;
    ~Atom() = default;
    
    std::string getName() const { return node->getName(); }
    AtomType getType() const { return type; }
    std::string getSource() const { return source; }
    std::string getComment() const { return comment; }
    
    std::string toSMT() const {
        return source;
    }
    
    bool operator==(const Atom& other) const {
        return node == other.node;
    }
    
    bool operator!=(const Atom& other) const {
        return !(*this == other);
    }
    
    friend std::size_t hash_value(const Atom& atom) {
        return boost::hash<SMTLIBParser::NodePtr>()(atom.node);
    }

private:
    SMTLIBParser::NodePtr node;
    AtomType type;
    std::string source;
    std::string comment;
};

enum class ClauseType {
    Leaf,
    Implies,
    And,
    Or,
    Not,
    Iff,
    Xor,
    Ite,
    Forall,
    Exists,
    Unknown
};

inline std::ostream& operator<<(std::ostream& os, const ClauseType& type) {
    switch (type) {
        case ClauseType::Leaf: return os << "Leaf";
        case ClauseType::Implies: return os << "Implies";
        case ClauseType::And: return os << "And";
        case ClauseType::Or: return os << "Or";
        case ClauseType::Not: return os << "Not";
        case ClauseType::Iff: return os << "Iff";
        case ClauseType::Xor: return os << "Xor";
        case ClauseType::Ite: return os << "Ite";
        case ClauseType::Forall: return os << "Forall";
        case ClauseType::Exists: return os << "Exists";
        case ClauseType::Unknown: return os << "Unknown";
        default: return os << "Invalid";
    }
}

class Clause {
public:
    Clause() = default;
    Clause(const SMTLIBParser::NodePtr& node, Context& context, bool is_original = false);
    Clause(const Clause& other) = default;
    Clause& operator=(const Clause& other) = default;
    ~Clause() = default;
    
    std::string getName() const { return node->getName(); }
    ClauseType getType() const { return type; }
    std::string getSource() const { return source; }
    std::string getComment() const { return comment; }
    boost::unordered_set<Atom> getAtoms() const { return atoms; }

    bool isAtom() const { return node->isAtom(); }
    bool isOriginal() const { return is_original; }
    
    std::string toSMT() const {
        return "(assert " + source + ")";
    }

private:
    SMTLIBParser::NodePtr node;
    ClauseType type;
    std::string source;
    std::string comment;
    boost::unordered_set<Atom> atoms;
    bool is_original;
};

class Lemma {
public:
    Lemma() = default;
    Lemma(const std::vector<Clause>& premises, const Clause& conclusion, Context& context);
    Lemma(const Lemma& other) = default;
    Lemma& operator=(const Lemma& other) = default;
    ~Lemma() = default;

    std::string getSource() const { return source; }
    std::string getComment() const { return comment; }
    
    std::string toSMT() const {
        std::string result;
        for (const auto& premise : premises) {
            result += premise.toSMT() + "\n";
        }
        result += conclusion.toSMT();
        return result;
    }

private:
    std::vector<Clause> premises;
    Clause conclusion;
    std::string source;
    std::string comment;
};

} // namespace strp
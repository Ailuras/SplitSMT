#pragma once
#include <string>
#include <vector>
#include <memory>
#include <unordered_map>
#include <unordered_set>
#include <iostream>
#include <cassert>
#include <functional>
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
    Var(const SMTParser::NodePtr& node, Context& context);
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
    
    // Simple hash function for unordered containers
    struct Hash {
        std::size_t operator()(const Var& var) const noexcept {
            return reinterpret_cast<std::size_t>(&var);
        }
    };

private:
    SMTParser::NodePtr node;
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
    Atom(const SMTParser::NodePtr& node, Context& context);
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
    
    // Simple hash function for unordered containers
    struct Hash {
        std::size_t operator()(const Atom& atom) const noexcept {
            return reinterpret_cast<std::size_t>(&atom);
        }
    };

private:
    SMTParser::NodePtr node;
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
    Clause(const SMTParser::NodePtr& node, Context& context, bool is_original = false);
    Clause(const Clause& other) = default;
    Clause& operator=(const Clause& other) = default;
    ~Clause() = default;
    
    std::string getName() const { return node->getName(); }
    ClauseType getType() const { return type; }
    std::string getSource() const { return source; }
    std::string getComment() const { return comment; }
    std::unordered_set<Atom, Atom::Hash> getAtoms() const { return atoms; }

    bool isAtom() const { return node->isAtom(); }
    bool isOriginal() const { return is_original; }
    
    std::string toSMT() const {
        return "(assert " + source + ")";
    }

private:
    SMTParser::NodePtr node;
    ClauseType type;
    std::string source;
    std::string comment;
    std::unordered_set<Atom, Atom::Hash> atoms;
    bool is_original;
};

class Division {
public:
    Division() = default;
    Division(const std::string& divided, const std::string& delimiter);
    virtual ~Division() = default;

    std::string getDivided() const { return divided; }
    std::string getDelimiter() const { return delimiter; }
    std::string getHashString() const { return hash_string; }
    virtual bool isConstType() const = 0;
    virtual bool isVarType() const = 0;
    
    bool isNumSplitsUsed() const { return num_splits_used; }
    void setNumSplitsUsed(bool used) { this->num_splits_used = used; }
    
    static std::string generateKey(const std::string& divided, const std::string& delimiter);

protected:
    std::string divided;
    std::string delimiter;
    std::string hash_string;
    bool num_splits_used = false;
    
private:
    std::string generateHashString() const;
};

class ConstDivision : public Division {
public:
    ConstDivision(const std::string& divided, const std::string& delimiter);
    
    bool isConstType() const override { return true; }
    bool isVarType() const override { return false; }
    
    int getSplitNums() const { return splitNums; }
    const std::vector<std::string>& getSplits() const { return splits; }
    std::string getSplit(int index) const { 
        if (index < 0 || index >= static_cast<int>(splits.size())) {
            throw std::out_of_range("Split index out of range");
        }
        return splits[index]; 
    }
    
    bool hasSplitNum() const { return has_split_num; }
    void setHasSplitNum(bool has_split_num) { this->has_split_num = has_split_num; }

private:
    std::vector<std::string> splits;
    int splitNums;
    bool has_split_num = false;
};

class VarDivision : public Division {
public:
    VarDivision(const std::string& divided, const std::string& delimiter);
    
    bool isConstType() const override { return false; }
    bool isVarType() const override { return true; }
    
    void addSplitNumAppeared(int num) { splitNumsAppeared.push_back(num); }
    int getMaxSplitNumAppeared() const { 
        if (splitNumsAppeared.empty()) {
            return num_splits_used ? 0 : -1;
        }
        return *std::max_element(splitNumsAppeared.begin(), splitNumsAppeared.end()); 
    }
    const std::vector<int>& getSplitNumsAppeared() const { return splitNumsAppeared; }
    int getSplitNumAppeared(int index) const { 
        if (index < 0 || index >= static_cast<int>(splitNumsAppeared.size())) {
            throw std::out_of_range("Split number index out of range");
        }
        return splitNumsAppeared[index]; 
    }
    bool hasSplitNums() const { return !splitNumsAppeared.empty(); }

private:
    std::vector<int> splitNumsAppeared;
};

} // namespace strp

// Hash functions are now defined as nested classes within Var and Atom
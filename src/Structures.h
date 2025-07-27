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

struct Decomposition {
    std::vector<std::string> splitConstraints;
    std::vector<std::string> otherConstraints;
    std::vector<std::string> splitRelatedFunctionNames;
    std::vector<std::pair<std::string, std::string>> variables;
    std::vector<std::pair<std::string, std::string>> variablesNeedDeclare;
    std::vector<std::pair<std::string, std::string>> variablesHasDefined;
    std::string splitSMTLIB2;
};

enum class TaskType {
    CHECK_SAT,
    GET_MODEL,
    GET_UNSAT_CORE,
    GET_PROOF,
    GET_VALUE,
    GET_ASSIGNMENT,
    GET_INFO,
    GET_OPTION,
    PUSH,
    POP,
    RESET,
    EXIT
};

class Context;

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
    void deleteSplitNumAppeared(int num) { 
        splitNumsAppeared.erase(std::remove(splitNumsAppeared.begin(), splitNumsAppeared.end(), num), splitNumsAppeared.end()); 
        splitEndNumsAppeared.erase(std::remove(splitEndNumsAppeared.begin(), splitEndNumsAppeared.end(), num), splitEndNumsAppeared.end()); 
    }
    void addSplitEndNumAppeared(int num) { 
        splitNumsAppeared.push_back(num);
        splitEndNumsAppeared.push_back(num);
    }
    int getMaxSplitNumAppeared() const { 
        if (splitNumsAppeared.empty()) {
            return num_splits_used ? 0 : -1;
        }
        return *std::max_element(splitNumsAppeared.begin(), splitNumsAppeared.end()); 
    }
    const std::vector<int>& getSplitNumsAppeared() const { return splitNumsAppeared; }
    const std::vector<int>& getSplitEndNumsAppeared() const { return splitEndNumsAppeared; }
    int getSplitNumAppeared(int index) const { 
        if (index < 0 || index >= static_cast<int>(splitNumsAppeared.size())) {
            throw std::out_of_range("Split number index out of range");
        }
        return splitNumsAppeared[index]; 
    }
    bool hasSplitNums() const { return !splitNumsAppeared.empty(); }
    bool hasSplitEndNums() const { return !splitEndNumsAppeared.empty(); }

private:
    std::vector<int> splitNumsAppeared;
    std::vector<int> splitEndNumsAppeared;
};

class RegDivision : public Division {
public:
    RegDivision(const std::string& divided, const std::string& delimiter);
    
    bool isConstType() const override { return false; }
    bool isVarType() const override { return true; }

    void addSplitNumAppeared(int num) { splitNumsAppeared.push_back(num); }
    void deleteSplitNumAppeared(int num) { 
        splitNumsAppeared.erase(std::remove(splitNumsAppeared.begin(), splitNumsAppeared.end(), num), splitNumsAppeared.end()); 
        splitEndNumsAppeared.erase(std::remove(splitEndNumsAppeared.begin(), splitEndNumsAppeared.end(), num), splitEndNumsAppeared.end()); 
    }
    void addSplitEndNumAppeared(int num) { 
        splitNumsAppeared.push_back(num);
        splitEndNumsAppeared.push_back(num);
    }
    int getMaxSplitNumAppeared() const { 
        if (splitNumsAppeared.empty()) {
            return num_splits_used ? 0 : -1;
        }
        return *std::max_element(splitNumsAppeared.begin(), splitNumsAppeared.end()); 
    }
    const std::vector<int>& getSplitNumsAppeared() const { return splitNumsAppeared; }
    const std::vector<int>& getSplitEndNumsAppeared() const { return splitEndNumsAppeared; }
    int getSplitNumAppeared(int index) const { 
        if (index < 0 || index >= static_cast<int>(splitNumsAppeared.size())) {
            throw std::out_of_range("Split number index out of range");
        }
        return splitNumsAppeared[index]; 
    }
    bool hasSplitNums() const { return !splitNumsAppeared.empty(); }
    bool hasSplitEndNums() const { return !splitEndNumsAppeared.empty(); }

private:
    std::vector<int> splitNumsAppeared;
    std::vector<int> splitEndNumsAppeared;
};

} // namespace strp
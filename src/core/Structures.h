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
    
    const std::vector<std::string>& getSplitDelimiters() const { return splitDelimiters; }
    std::string getSplitDelimiter(int index) const { 
        if (index < 0 || index >= static_cast<int>(splitDelimiters.size())) {
            throw std::out_of_range("Split delimiter index out of range");
        }
        return splitDelimiters[index]; 
    }
    
    bool hasSplitNum() const { return has_split_num; }
    void setHasSplitNum(bool has_split_num) { this->has_split_num = has_split_num; }

private:
    std::vector<std::string> splits;
    std::vector<std::string> splitDelimiters;
    int splitNums;
    bool has_split_num = false;
};

class VarDivision : public Division {
public:
    VarDivision(const std::string& divided, const std::string& delimiter);
    
    bool isConstType() const override { return false; }
    bool isVarType() const override { return true; }
    
    void addSplitAtNumAppeared(int num) { 
        splitAtNumsAppeared.push_back(num); 
        std::sort(splitAtNumsAppeared.begin(), splitAtNumsAppeared.end());
        splitAtNumsAppeared.erase(std::unique(splitAtNumsAppeared.begin(), splitAtNumsAppeared.end()), splitAtNumsAppeared.end());
    }
    void deleteSplitAtNumAppeared(int num) { splitAtNumsAppeared.erase(std::remove(splitAtNumsAppeared.begin(), splitAtNumsAppeared.end(), num), splitAtNumsAppeared.end()); }
    void addSplitRestNumAppeared(int num) { 
        splitRestNumsAppeared.push_back(num); 
        std::sort(splitRestNumsAppeared.begin(), splitRestNumsAppeared.end());
        splitRestNumsAppeared.erase(std::unique(splitRestNumsAppeared.begin(), splitRestNumsAppeared.end()), splitRestNumsAppeared.end());
    }
    void deleteSplitRestNumAppeared(int num) { splitRestNumsAppeared.erase(std::remove(splitRestNumsAppeared.begin(), splitRestNumsAppeared.end(), num), splitRestNumsAppeared.end()); }
    int getMaxSplitNumAppeared() const { 
        if (splitAtNumsAppeared.empty() && splitRestNumsAppeared.empty()) {
            return 0;
        }
        if (splitAtNumsAppeared.empty()) {
            return *std::max_element(splitRestNumsAppeared.begin(), splitRestNumsAppeared.end());
        }
        if (splitRestNumsAppeared.empty()) {
            return *std::max_element(splitAtNumsAppeared.begin(), splitAtNumsAppeared.end());
        }
        return *std::max_element(splitAtNumsAppeared.begin(), splitAtNumsAppeared.end()) + *std::max_element(splitRestNumsAppeared.begin(), splitRestNumsAppeared.end()); 
    }
    const std::vector<int>& getSplitAtNumsAppeared() const { return splitAtNumsAppeared; }
    const std::vector<int>& getSplitRestNumsAppeared() const { return splitRestNumsAppeared; }
    std::vector<int> getSplitNumsAppeared() const { 
        std::vector<int> result = splitAtNumsAppeared;
        result.insert(result.end(), splitRestNumsAppeared.begin(), splitRestNumsAppeared.end());
        std::sort(result.begin(), result.end());
        result.erase(std::unique(result.begin(), result.end()), result.end());
        return result;
    }
    int getSplitAtNumAppeared(int index) const { 
        if (index < 0 || index >= static_cast<int>(splitAtNumsAppeared.size())) {
            throw std::out_of_range("Split number index out of range");
        }
        return splitAtNumsAppeared[index]; 
    }
    int getSplitRestNumAppeared(int index) const { 
        if (index < 0 || index >= static_cast<int>(splitRestNumsAppeared.size())) {
            throw std::out_of_range("Split number index out of range");
        }
        return splitRestNumsAppeared[index]; 
    }
    bool hasSplitAtNums() const { return !splitAtNumsAppeared.empty(); }
    bool hasSplitRestNums() const { return !splitRestNumsAppeared.empty(); }

private:
    std::vector<int> splitAtNumsAppeared;
    std::vector<int> splitRestNumsAppeared;
};

} // namespace strp
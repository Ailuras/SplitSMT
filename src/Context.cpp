// At the top of Context.cpp, ensure these includes are present:
#include "Context.h"
#include "Structures.h"
#include "Split.h"
#include <sstream>
#include <fstream>
#include <filesystem>
#include <regex>
#include <chrono>
#include <algorithm>
#include <iterator>

namespace strp {

Context& Context::getInstance() {
    static Context instance;
    return instance;
}

Context::Context() : logger(utils::Logger::getInstance()) {}

bool Context::parseFile(const std::string& filename) {
    clear();
    
    if (!parser.parseFile(filename, decomposition)) {
        ERROR("Failed to parse file: ", filename);
        return false;
    }
    updateTasks(filename);
    updateDivisions();
    return true;
}

void Context::updateTasks(const std::string& filename) {
    tasks = parser.getTask(filename);
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes() {
    std::unordered_set<SMTParser::NodePtr> splitNodes;
    
    auto assertions = parser.getAssertions();
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

std::vector<SMTParser::NodePtr> Context::getSplitRestNodes() {
    std::unordered_set<SMTParser::NodePtr> splitEndNodes;
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        auto splitEndNodesInAssertion = getSplitRestNodes(assertion);
        for (const auto& node : splitEndNodesInAssertion) {
            splitEndNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(), splitEndNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestNodes(const SMTParser::NodePtr& node) {
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

std::vector<SMTParser::NodePtr> Context::getSplitRestConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitRestNodes = getSplitRestNodes();
    for (const auto& node : splitRestNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestVarNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitRestNodes = getSplitRestNodes();
    for (const auto& node : splitRestNodes) {
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
    
    auto assertions = parser.getAssertions();
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

std::vector<SMTParser::NodePtr> Context::getSplitAtRegNodes() {
    std::unordered_set<SMTParser::NodePtr> splitAtRegNodes;
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        auto splitAtRegNodesInAssertion = getSplitAtRegNodes(assertion);
        for (const auto& node : splitAtRegNodesInAssertion) {
            splitAtRegNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitAtRegNodes.begin(), splitAtRegNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtRegNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> splitAtRegNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitAtRegNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrSplitAtRe()) {
            splitAtRegNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectSplitAtRegNodes(node->getChild(i));
        }
    };
    
    collectSplitAtRegNodes(node);
    
    return std::vector<SMTParser::NodePtr>(splitAtRegNodes.begin(), splitAtRegNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestRegNodes() {
    std::unordered_set<SMTParser::NodePtr> splitRestRegNodes;
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        auto splitRestRegNodesInAssertion = getSplitRestRegNodes(assertion);
        for (const auto& node : splitRestRegNodesInAssertion) {
            splitRestRegNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitRestRegNodes.begin(), splitRestRegNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestRegNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> splitRestRegNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitRestRegNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrSplitRestRe()) {
            splitRestRegNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectSplitRestRegNodes(node->getChild(i));
        }
    };
    
    collectSplitRestRegNodes(node);
    
    return std::vector<SMTParser::NodePtr>(splitRestRegNodes.begin(), splitRestRegNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitRegNodes() {
    std::unordered_set<SMTParser::NodePtr> numSplitRegNodes;
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        auto numSplitRegNodesInAssertion = getNumSplitRegNodes(assertion);
        for (const auto& node : numSplitRegNodesInAssertion) {
            numSplitRegNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(numSplitRegNodes.begin(), numSplitRegNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitRegNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> numSplitRegNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectNumSplitRegNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrNumSplitsRe()) {
            numSplitRegNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectNumSplitRegNodes(node->getChild(i));
        }
    };
    
    collectNumSplitRegNodes(node);
    
    return std::vector<SMTParser::NodePtr>(numSplitRegNodes.begin(), numSplitRegNodes.end());
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

void Context::clearDivisions() {
    divisions.clear();
}

void Context::clearSplitNodeToAtoms() {
    splitNodeToAtoms.clear();
}

void Context::clear() {
    clearTasks();
    clearDivisions();
    clearSplitNodeToAtoms();
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

void Context::updateDivisions() {
    DEBUG("Updating divisions from split nodes");
    
    auto splitAtConstNodes = getSplitAtConstNodes();
    auto splitRestConstNodes = getSplitRestConstNodes();
    auto numSplitConstNodes = getNumSplitConstNodes();
    auto splitAtVarNodes = getSplitAtVarNodes();
    auto splitRestVarNodes = getSplitRestVarNodes();
    auto numSplitVarNodes = getNumSplitVarNodes();
    auto splitAtRegNodes = getSplitAtRegNodes();
    auto splitEndRegNodes = getSplitRestRegNodes();
    auto numSplitRegNodes = getNumSplitRegNodes();
    
    for (auto& node : splitAtConstNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string divided = arg1->toString();
                if (divided.size() >= 2 && divided.front() == '"' && divided.back() == '"') {
                    divided = divided.substr(1, divided.size() - 2);
                }
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                if (!hasDivision(divided, delimiter)) {
                    addDivision(std::make_unique<ConstDivision>(divided, delimiter));
                    DEBUG("Created new const division for: '", divided, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const split node: ", e.what());
        }
    }
    
    for (auto& node : splitRestConstNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                std::string divided = arg1->toString();
                if (divided.size() >= 2 && divided.front() == '"' && divided.back() == '"') {
                    divided = divided.substr(1, divided.size() - 2);
                }
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                int index = parseInteger(arg3->toString());
                
                if (!hasDivision(divided, delimiter)) {
                    addDivision(std::make_unique<ConstDivision>(divided, delimiter));
                    DEBUG("Created new const division for split_rest: '", divided, "' with delimiter '", delimiter, "'");
                }
                
                Division* division = getDivision(divided, delimiter);
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    constDiv->setHasSplitNum(true);
                    DEBUG("Marked split_rest usage for const division '", divided, "' with delimiter '", delimiter, "' at index ", index);
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const split_rest node: ", e.what());
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
                
                int index = parseInteger(arg3->toString());
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    DEBUG("Created new var division for: '", variable, "' with delimiter '", delimiter, "'");
                }
                
                if (division && division->isVarType()) {
                    VarDivision* varDiv = static_cast<VarDivision*>(division);
                    varDiv->addSplitNumAppeared(index);
                    DEBUG("Added split index ", index, " for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split node: ", e.what());
        }
    }
    
    for (auto& node : splitRestVarNodes) {
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
                
                int index = parseInteger(arg3->toString());
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    DEBUG("Created new var division for split_rest: '", variable, "' with delimiter '", delimiter, "'");
                }
                
                if (division && division->isVarType()) {
                    VarDivision* varDiv = static_cast<VarDivision*>(division);
                    varDiv->addSplitEndNumAppeared(index);
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
                
                std::string divided = arg1->toString();
                if (divided.size() >= 2 && divided.front() == '"' && divided.back() == '"') {
                    divided = divided.substr(1, divided.size() - 2);
                }
                
                std::string delimiter = arg2->toString();
                if (delimiter.size() >= 2 && delimiter.front() == '"' && delimiter.back() == '"') {
                    delimiter = delimiter.substr(1, delimiter.size() - 2);
                }
                
                if (!hasDivision(divided, delimiter)) {
                    addDivision(std::make_unique<ConstDivision>(divided, delimiter));
                    DEBUG("Created new const division for num_splits: '", divided, "' with delimiter '", delimiter, "'");
                }
                
                Division* division = getDivision(divided, delimiter);
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    constDiv->setHasSplitNum(true);
                    DEBUG("Marked num_splits usage for const division '", divided, "' with delimiter '", delimiter, "'");
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
    
    for (auto& node : splitAtRegNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                std::string variable = arg1->toString();
                std::string regexDelimiter = arg2->toString();
                int index = parseInteger(arg3->toString());
                
                Division* division = getDivision(variable, regexDelimiter);
                if (!division) {
                    addDivision(std::make_unique<RegDivision>(variable, regexDelimiter));
                    division = getDivision(variable, regexDelimiter);
                    DEBUG("Created new reg division for: '", variable, "' with regex delimiter '", regexDelimiter, "'");
                }
                
                if (division && division->isVarType()) {
                    RegDivision* regDiv = static_cast<RegDivision*>(division);
                    regDiv->addSplitNumAppeared(index);
                    DEBUG("Added split index ", index, " for variable '", variable, "' with regex delimiter '", regexDelimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing reg split_at node: ", e.what());
        }
    }
    
    for (auto& node : splitEndRegNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                auto arg3 = node->getChild(2);
                
                std::string variable = arg1->toString();
                std::string regexDelimiter = arg2->toString();
                int index = parseInteger(arg3->toString());
                
                Division* division = getDivision(variable, regexDelimiter);
                if (!division) {
                    addDivision(std::make_unique<RegDivision>(variable, regexDelimiter));
                    division = getDivision(variable, regexDelimiter);
                    DEBUG("Created new reg division for split_rest: '", variable, "' with regex delimiter '", regexDelimiter, "'");
                }
                
                if (division && division->isVarType()) {
                    RegDivision* regDiv = static_cast<RegDivision*>(division);
                    regDiv->addSplitEndNumAppeared(index);
                    DEBUG("Added split_rest index ", index, " for variable '", variable, "' with regex delimiter '", regexDelimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing reg split_rest node: ", e.what());
        }
    }
    
    for (auto& node : numSplitRegNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                auto arg2 = node->getChild(1);
                
                std::string variable = arg1->toString();
                std::string regexDelimiter = arg2->toString();
                
                Division* division = getDivision(variable, regexDelimiter);
                if (!division) {
                    addDivision(std::make_unique<RegDivision>(variable, regexDelimiter));
                    division = getDivision(variable, regexDelimiter);
                    DEBUG("Created new reg division for num_splits: '", variable, "' with regex delimiter '", regexDelimiter, "'");
                }
                
                if (division) {
                    division->setNumSplitsUsed(true);
                    DEBUG("Marked num_splits usage for variable '", variable, "' with regex delimiter '", regexDelimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing reg num_splits node: ", e.what());
        }
    }
    
    updateSplitNodeToAtoms();
}

void Context::updateSplitNodeToAtoms() {
    clearSplitNodeToAtoms();
    
    auto assertions = parser.getAssertions();
    std::unordered_set<SMTParser::NodePtr> allAtoms;
    auto allSplitNodes = getSplitAtNodes();
    auto allSplitRestNodes = getSplitRestNodes();
    auto allNumSplitNodes = getNumSplitNodes();
    auto allSplitRegNodes = getSplitAtRegNodes();
    auto allSplitEndRegNodes = getSplitRestRegNodes();
    auto allNumSplitRegNodes = getNumSplitRegNodes();
    
    for (auto& assertion : assertions) {
        auto atomsInAssertion = parser.getAtoms(assertion);
        allAtoms.insert(atomsInAssertion.begin(), atomsInAssertion.end());
    }
    
    for (auto& splitNode : allSplitNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitNode] = relatedAtoms;
        }
    }
    
    for (auto& splitRestNode : allSplitRestNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitRestNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitRestNode] = relatedAtoms;
        }
    }
    
    for (auto& numSplitNode : allNumSplitNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, numSplitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[numSplitNode] = relatedAtoms;
        }
    }
    
    for (auto& splitRegNode : allSplitRegNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitRegNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitRegNode] = relatedAtoms;
        }
    }
    
    for (auto& splitEndRegNode : allSplitEndRegNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitEndRegNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitEndRegNode] = relatedAtoms;
        }
    }
    
    for (auto& numSplitRegNode : allNumSplitRegNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, numSplitRegNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[numSplitRegNode] = relatedAtoms;
        }
    }
    
    DEBUG("Updated split node to atoms mapping with ", splitNodeToAtoms.size(), " entries");
}

std::unordered_set<SMTParser::NodePtr> Context::getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const {
    auto it = splitNodeToAtoms.find(splitNode);
    if (it != splitNodeToAtoms.end()) {
        return it->second;
    }
    return std::unordered_set<SMTParser::NodePtr>();
}

std::string Context::getFormula() {
    DEBUG("Getting formula");
    return parser.getMergedSMTLIB2(decomposition);
}

} // namespace strp
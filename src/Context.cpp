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

std::vector<SMTParser::NodePtr> Context::getSplitEndConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitEndNodes = getSplitRestNodes();
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
    
    auto splitEndNodes = getSplitRestNodes();
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
    auto splitAtVarNodes = getSplitAtVarNodes();
    auto splitEndConstNodes = getSplitEndConstNodes();
    auto splitEndVarNodes = getSplitEndVarNodes();
    auto numSplitConstNodes = getNumSplitConstNodes();
    auto numSplitVarNodes = getNumSplitVarNodes();
    
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
                    VarDivision* varDiv = static_cast<VarDivision*>(division);
                    varDiv->addSplitNumAppeared(index);
                    DEBUG("Added split index ", index, " for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split node: ", e.what());
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
                    VarDivision* varDiv = static_cast<VarDivision*>(division);
                    varDiv->addSplitEndNumAppeared(index);
                    DEBUG("Added split_rest index ", index, " for variable '", variable, "' with delimiter '", delimiter, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split_rest node: ", e.what());
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

void Context::updateSplitNodeToAtoms() {
    clearSplitNodeToAtoms();
    
    auto assertions = parser.getAssertions();
    std::unordered_set<SMTParser::NodePtr> allAtoms;
    auto allSplitNodes = getSplitAtNodes();
    auto allSplitEndNodes = getSplitRestNodes();
    auto allNumSplitNodes = getNumSplitNodes();
    
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
    
    for (auto& splitEndNode : allSplitEndNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitEndNode)) {
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
            if (Parser::containsNode(atom, numSplitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[numSplitNode] = relatedAtoms;
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
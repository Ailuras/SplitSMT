#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <memory>
#include <set>
#include "Structures.h"
#include "dag.h"
#include "utils/Logger.h"
#include "parser/Parser.h"

namespace strp {

class Context {
public:
    static Context& getInstance();
    bool parseFile(const std::string& filename);
    std::string getFormula();

    void addDivision(std::unique_ptr<Division> division);
    Division* getDivision(const std::string& divided, const std::string& delimiter);
    bool hasDivision(const std::string& divided, const std::string& delimiter) const;
    bool matchesDivision(const SMTParser::NodePtr& node, const std::string& variable, const std::string& delimiter);
    std::vector<SMTParser::NodePtr> getDivisionNodes(const std::string& divided, const std::string& delimiter) const;
    bool isDelimiterStringType(const std::string& delimiter);
    const std::unordered_map<std::string, std::unique_ptr<Division>>& getAllDivisions() const;
    std::unordered_set<SMTParser::NodePtr> getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const;
    bool hasTask(TaskType taskType) const;
    std::set<TaskType> getAllTasks() const;
    std::string getVarName(const SMTParser::NodePtr& node);
    
    std::vector<SMTParser::NodePtr> getSplitAtNodes();
    std::vector<SMTParser::NodePtr> getSplitAtNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getSplitAtConstNodes();
    std::vector<SMTParser::NodePtr> getSplitAtVarNodes();
    std::vector<SMTParser::NodePtr> getSplitRestNodes();
    std::vector<SMTParser::NodePtr> getSplitRestNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getSplitRestConstNodes();
    std::vector<SMTParser::NodePtr> getSplitRestVarNodes();
    std::vector<SMTParser::NodePtr> getNumSplitNodes();
    std::vector<SMTParser::NodePtr> getNumSplitNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getNumSplitConstNodes();
    std::vector<SMTParser::NodePtr> getNumSplitVarNodes();
    std::unordered_map<SMTParser::NodePtr, std::string> getNodeToVar() { return nodeToVar; };

    bool isSplitAtConstNode(const SMTParser::NodePtr& node);
    bool isSplitAtVarNode(const SMTParser::NodePtr& node);
    bool isSplitRestConstNode(const SMTParser::NodePtr& node);
    bool isSplitRestVarNode(const SMTParser::NodePtr& node);
    bool isNumSplitConstNode(const SMTParser::NodePtr& node);
    bool isNumSplitVarNode(const SMTParser::NodePtr& node);

    void updateDivisions();
    void updateSplitNodeToAtoms();
    void updateTasks(const std::string& filename);
    void clearTasks();
    void clear();
    void clearDivisions();
    void clearSplitNodeToAtoms();
    void updateSplitNodeWithVar();
    
    Parser& getParser() { return parser; }
    const Parser& getParser() const { return parser; }

private:
    Context();
    ~Context() = default;
    Context(const Context&) = delete;
    Context& operator=(const Context&) = delete;
    Context(Context&&) = delete;
    Context& operator=(Context&&) = delete;

    Decomposition decomposition;
    std::set<TaskType> tasks;
    std::unordered_map<std::string, std::unique_ptr<Division>> divisions;
    std::unordered_map<std::string, std::vector<SMTParser::NodePtr>> divisionNodes;
    std::unordered_map<SMTParser::NodePtr, std::unordered_set<SMTParser::NodePtr>> splitNodeToAtoms;
    std::unordered_map<SMTParser::NodePtr, std::string> nodeToVar;
    std::vector<std::string> varList;
    std::vector<SMTParser::NodePtr> tempAssertions;
    std::vector<SMTParser::NodePtr> tempVariables;
    
    utils::Logger& logger = utils::Logger::getInstance();
    Parser& parser = Parser::getInstance();
};

} // namespace strp

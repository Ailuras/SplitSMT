#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <memory>
#include <set>
#include "Structures.h"
#include "dag.h"
#include "Logger.h"
#include "Parser.h"

namespace strp {

class Context {
public:
    static Context& getInstance();
    bool parseFile(const std::string& filename);
    std::string getFormula();

    void addDivision(std::unique_ptr<Division> division);
    Division* getDivision(const std::string& divided, const std::string& delimiter);
    bool hasDivision(const std::string& divided, const std::string& delimiter) const;
    const std::unordered_map<std::string, std::unique_ptr<Division>>& getAllDivisions() const;
    std::unordered_set<SMTParser::NodePtr> getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const;
    bool hasTask(TaskType taskType) const;
    std::set<TaskType> getAllTasks() const;
    
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

    std::vector<SMTParser::NodePtr> getSplitAtRegNodes();
    std::vector<SMTParser::NodePtr> getSplitAtRegNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getSplitRestRegNodes();
    std::vector<SMTParser::NodePtr> getSplitRestRegNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getNumSplitRegNodes();
    std::vector<SMTParser::NodePtr> getNumSplitRegNodes(const SMTParser::NodePtr& node);

    void updateDivisions();
    void updateSplitNodeToAtoms();
    void updateTasks(const std::string& filename);
    void clearTasks();
    void clear();
    void clearDivisions();
    void clearSplitNodeToAtoms();
    
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
    std::unordered_map<SMTParser::NodePtr, std::unordered_set<SMTParser::NodePtr>> splitNodeToAtoms;
    std::vector<SMTParser::NodePtr> tempAssertions;
    std::vector<SMTParser::NodePtr> tempVariables;
    
    utils::Logger& logger = utils::Logger::getInstance();
    Parser& parser = Parser::getInstance();
};

} // namespace strp

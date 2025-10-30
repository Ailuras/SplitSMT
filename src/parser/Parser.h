#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <memory>
#include <set>
#include "SMTParserAPI.h"
#include "utils/Logger.h"
#include "core/Structures.h"

namespace strp {

class Parser {
public:
    static Parser& getInstance();
    bool parseFile(const std::string& filename, Decomposition& decomposition);
    
    void declareStringVar(const std::string& name);
    void declareBoolVar(const std::string& name);
    void declareIntVar(const std::string& name);
    SMTParser::NodePtr createNode(const std::string& node_str);
    SMTParser::NodePtr createStringConst(const std::string& value);
    SMTParser::NodePtr createIntConst(int value);
    SMTParser::NodePtr createBoolConst(bool value);
    SMTParser::NodePtr createStringVar(const std::string& name);
    SMTParser::NodePtr createIntVar(const std::string& name);
    SMTParser::NodePtr createBoolVar(const std::string& name);
    static bool containsNode(const SMTParser::NodePtr& parent, const SMTParser::NodePtr& target);
    SMTParser::NodePtr replaceNodes(const SMTParser::NodePtr& expr, const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    void replaceNodes(const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    void addAssertion(const std::string& constraint);

    std::vector<SMTParser::NodePtr> getVariables();
    std::vector<SMTParser::NodePtr> getAssertions();
    std::vector<SMTParser::NodePtr> getAtoms(const SMTParser::NodePtr& node);
    std::string getSMTLIB2(bool from_parser = true);
    static TaskType parseTaskCommand(const std::string& command);
    std::set<TaskType> getTask(const std::string& filename) const;
    std::string getString(const SMTParser::NodePtr& node);
    void resetParser();
    static std::string decodeStringLiteral(const std::string& literal);
    static std::string encodeStringLiteral(const std::string& value);
    static std::string normalizeStringLiteral(const std::string& literal);
    static std::string postProcessSMTLIB(const std::string& content);

    // for decomposition
    bool need_decomposition(const std::string& filename);
    Decomposition getDecomposition(const std::string& filename);
    std::string getSplitSMTLIB2(const Decomposition& decomposition);
    std::vector<std::pair<std::string, std::string>> getAllVariables(Decomposition& decomposition);

    // for merging
    std::string getMergedSMTLIB2(const Decomposition& decomposition);
    bool needDelete(const std::string& constraint, const Decomposition& decomposition);
    
    SMTParser::Parser SMTParser;
private:

    std::pair<std::vector<std::string>, std::vector<std::string>> extractConstraints(const std::string& content, std::vector<std::string>& splitFunctionNames);
    std::vector<std::pair<std::string, std::string>> extractVariablesFromConstraints(const std::vector<std::string>& constraints);
    std::string extractFunctionName(const std::string& functionDef);
    std::vector<std::string> extractVariablesAppeared(const std::vector<std::string>& constraints, const std::set<std::string>& allVars);
    std::vector<std::string> extractAllConstraints(const std::string& content);
    bool isSplitRelated(const std::string& constraint, const std::vector<std::string>& splitFunctionNames = {});
    std::string convertDefineToAssert(const std::string& content);
    bool needConvert(const std::string& constraint, const std::vector<std::pair<std::string, std::string>>& variablesHasDefined);
    
    Parser();
    ~Parser() = default;
    Parser(const Parser&) = delete;
    Parser& operator=(const Parser&) = delete;
    Parser(Parser&&) = delete;
    Parser& operator=(Parser&&) = delete;
    bool needDecomposition = false;
};

} // namespace strp 

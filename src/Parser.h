#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <memory>
#include <set>
#include "parser.h"
#include "Logger.h"
#include "Structures.h"

namespace strp {

class Parser {
public:
    static Parser& getInstance();
    bool parseFile(const std::string& filename);
    bool parseString(const std::string& input);
    
    void declareStringVar(const std::string& name);
    void declareBoolVar(const std::string& name);
    void declareIntVar(const std::string& name);
    static SMTParser::NodePtr createNode(const std::string& node_str);
    static SMTParser::NodePtr createStringConst(const std::string& value);
    static SMTParser::NodePtr createIntConst(int value);
    static SMTParser::NodePtr createBoolConst(bool value);
    static SMTParser::NodePtr createStringVar(const std::string& name);
    static SMTParser::NodePtr createIntVar(const std::string& name);
    static SMTParser::NodePtr createBoolVar(const std::string& name);
    static bool containsNode(const SMTParser::NodePtr& parent, const SMTParser::NodePtr& target);
    static SMTParser::NodePtr replaceNodes(const SMTParser::NodePtr& expr, const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    void replaceNodes(const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    void addAssertion(const std::string& constraint);

    std::vector<SMTParser::NodePtr> getVariables();
    std::vector<SMTParser::NodePtr> getAssertions();
    static std::vector<SMTParser::NodePtr> getAtoms(const SMTParser::NodePtr& node);
    std::string getSMTLIB2(bool from_parser = true) const;
    static TaskType parseTaskCommand(const std::string& command);
    std::set<TaskType> getTask(const std::string& filename) const;
    static std::string getSource(const SMTParser::NodePtr& node);
    static std::string getComment(const SMTParser::NodePtr& node);
    std::string nodeToString(const SMTParser::NodePtr& node) const;

    void removeFunDef(const std::vector<std::string>& funcNames);
    std::vector<std::string> getSplitRelatedFunctionNames() const;
    std::vector<SMTParser::NodePtr> getFunctions() const;
    
    std::string mergeSMTConstraints(const std::string& rewrittenSplitPart, const std::string& otherPart);
    SMTSeparationResult separateSplitConstraints(const std::string& filename);
    bool isSplitRelatedLine(const std::string& line);
    std::vector<std::string> extractSplitFunctionNames(const std::string& smtContent);
    
    std::unordered_map<std::string, std::string> extractVariablesFromSplitConstraints(const std::string& splitConstraints);
    std::string inferVariableType(const std::string& variableName, const std::string& context);
    bool isTempVariable(const std::string& variableName);
    std::vector<std::string> extractVariableNames(const std::string& line);
    std::string generateVariableDeclarations(const std::unordered_map<std::string, std::string>& varDeclarations);
    
    SMTParser::NodePtr getVariable(const std::string& name) const;
    bool isVariableDeclared(const std::string& varName) const;
    std::set<std::string> getUsedVariables() const;
    
    SMTParser::Parser SMTParser;
    std::vector<std::string> funcDefNames;

private:
    Parser();
    ~Parser() = default;
    Parser(const Parser&) = delete;
    Parser& operator=(const Parser&) = delete;
    Parser(Parser&&) = delete;
    Parser& operator=(Parser&&) = delete;
};

} // namespace strp 
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
#include "parser.h"
#include "kind.h"

namespace strp {

enum class VarType;
enum class AtomType;
enum class ClauseType;

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



class Context {
public:
    static Context& getInstance();
    
    bool parseFile(const std::string& filename);
    bool parseString(const std::string& input);
    
    void addVar(const Var& var);
    void addAtom(const Atom& atom);
    void addClause(const Clause& clause);

    void addDivision(std::unique_ptr<Division> division);
    
    void declareStringVar(const std::string& name);
    void declareBoolVar(const std::string& name);
    void declareIntVar(const std::string& name);
    void addAssertion(const std::string& constraint);
    
    std::vector<SMTParser::NodePtr> getSplitAtNodes();
    std::vector<SMTParser::NodePtr> getSplitAtNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getSplitAtConstNodes();
    std::vector<SMTParser::NodePtr> getSplitAtVarNodes();
    std::vector<SMTParser::NodePtr> getSplitEndNodes();
    std::vector<SMTParser::NodePtr> getSplitEndNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getSplitEndConstNodes();
    std::vector<SMTParser::NodePtr> getSplitEndVarNodes();
    std::vector<SMTParser::NodePtr> getNumSplitNodes();
    std::vector<SMTParser::NodePtr> getNumSplitNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getNumSplitConstNodes();
    std::vector<SMTParser::NodePtr> getNumSplitVarNodes();
    
    std::vector<SMTParser::NodePtr> getVariables();
    std::vector<SMTParser::NodePtr> getAssertions();
    std::unordered_set<Var, Var::Hash> getVars() const;
    std::unordered_set<Atom, Atom::Hash> getAtoms() const;
    std::vector<Clause> getClauses() const;

    Division* getDivision(const std::string& divided, const std::string& delimiter);
    bool hasDivision(const std::string& divided, const std::string& delimiter) const;
    const std::unordered_map<std::string, std::unique_ptr<Division>>& getAllDivisions() const;
    std::string getSMTLIB2(bool from_parser = true) const;
    std::set<TaskType> getTask(const std::string& filename) const;
    
    bool hasTask(TaskType taskType) const;
    std::set<TaskType> getAllTasks() const;
    void clearTasks();
    void clear();
    void clearVars();
    void clearAtoms();
    void clearClauses();
    void clearDivisions();
    void clearSplitNodeToAtoms();
    
    void updateDivisions();
    void updateSplitNodeToAtoms();
    std::unordered_set<SMTParser::NodePtr> getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const;
    
    size_t getVarCount() const;
    size_t getAtomCount() const;
    size_t getClauseCount() const;

    
    static int getType(const SMTParser::NodePtr& node);
    static VarType getVarType(const SMTParser::NodePtr& node);
    static AtomType getAtomType(const SMTParser::NodePtr& node);
    static ClauseType getClauseType(const SMTParser::NodePtr& node);
    static std::string getSource(const SMTParser::NodePtr& node);
    static std::string getComment(const SMTParser::NodePtr& node);

    static std::vector<SMTParser::NodePtr> getAtoms(const SMTParser::NodePtr& node);
    static bool containsNode(const SMTParser::NodePtr& parent, const SMTParser::NodePtr& target);

    static SMTParser::NodePtr replaceNodes(const SMTParser::NodePtr& expr, const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    static void replaceNodes(const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    static SMTParser::NodePtr createNode(const std::string& node_str);
    static SMTParser::NodePtr createStringConst(const std::string& value);
    static SMTParser::NodePtr createIntConst(int value);
    static SMTParser::NodePtr createBoolConst(bool value);
    static SMTParser::NodePtr createStringVar(const std::string& name);
    static SMTParser::NodePtr createIntVar(const std::string& name);
    static SMTParser::NodePtr createBoolVar(const std::string& name);

private:
    Context();
    ~Context() = default;
    Context(const Context&) = delete;
    Context& operator=(const Context&) = delete;
    Context(Context&&) = delete;
    Context& operator=(Context&&) = delete;
    void updateInfo();
    void updateTasks(const std::string& filename);
    TaskType parseTaskCommand(const std::string& line) const;

    std::unordered_set<Var, Var::Hash> vars;
    std::unordered_set<Atom, Atom::Hash> atoms;
    std::vector<Clause> clauses;
    std::set<TaskType> tasks;
    
    std::unordered_map<std::string, std::unique_ptr<Division>> divisions;
    std::unordered_map<SMTParser::NodePtr, std::unordered_set<SMTParser::NodePtr>> splitNodeToAtoms;
    std::vector<SMTParser::NodePtr> tempAssertions;
    std::vector<SMTParser::NodePtr> tempVariables;
    
    utils::Logger& logger = utils::Logger::getInstance();
    SMTParser::Parser SMTParser;
};

} // namespace strp

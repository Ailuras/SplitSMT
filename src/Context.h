#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>
#include <set>
#include <boost/unordered/unordered_set.hpp>
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
    void addLemma(const Lemma& lemma);
    void addDivision(const Division& division);
    
    void declareStringVar(const std::string& name);
    void declareBoolVar(const std::string& name);
    void addAssertion(const std::string& constraint);
    
    std::vector<SMTParser::NodePtr> getSplitAtNodes();
    std::vector<SMTParser::NodePtr> getSplitAtNodes(const SMTParser::NodePtr& node);
    std::vector<SMTParser::NodePtr> getSplitAtConstNodes();
    std::vector<SMTParser::NodePtr> getSplitAtVarNodes();
    
    std::vector<SMTParser::NodePtr> getVariables();
    std::vector<SMTParser::NodePtr> getAssertions();
    boost::unordered_set<Var> getVars() const;
    boost::unordered_set<Atom> getAtoms() const;
    std::vector<Clause> getClauses() const;
    std::vector<Lemma> getLemmas() const;
    std::unordered_map<std::string, Division> getDivisions() const;
    Division* getDivision(const std::string& divided, const std::string& delimiter);
    bool hasDivision(const std::string& divided, const std::string& delimiter) const;
    const std::unordered_map<std::string, Division>& getAllDivisions() const;
    std::string getSMTLIB2(bool from_parser = true) const;
    std::set<TaskType> getTask(const std::string& filename) const;
    
    bool hasTask(TaskType taskType) const;
    std::set<TaskType> getAllTasks() const;
    void clearTasks();

    void clear();
    void clearVars();
    void clearAtoms();
    void clearClauses();
    void clearLemmas();
    void clearDivisions();
    void clearSplitNodeToAtoms();
    
    void updateSplitNodeToAtoms();
    void updateDivisions();
    boost::unordered_set<SMTParser::NodePtr> getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const;
    
    size_t getVarCount() const;
    size_t getAtomCount() const;
    size_t getClauseCount() const;
    size_t getLemmaCount() const;
    
    static int getType(const SMTParser::NodePtr& node);
    static VarType getVarType(const SMTParser::NodePtr& node);
    static AtomType getAtomType(const SMTParser::NodePtr& node);
    static ClauseType getClauseType(const SMTParser::NodePtr& node);
    static std::string getSource(const SMTParser::NodePtr& node);
    static std::string getComment(const SMTParser::NodePtr& node);

    static std::vector<SMTParser::NodePtr> getAtoms(const SMTParser::NodePtr& node);
    static bool containsNode(const SMTParser::NodePtr& parent, const SMTParser::NodePtr& target);

    static SMTParser::NodePtr replaceNodes(const SMTParser::NodePtr& expr, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    static void replaceNodes(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
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
    void updateInfo();
    void updateTasks(const std::string& filename);
    TaskType parseTaskCommand(const std::string& line) const;

    boost::unordered_set<Var> vars;
    boost::unordered_set<Atom> atoms;
    std::vector<Clause> clauses;
    std::vector<Lemma> lemmas;
    std::set<TaskType> tasks;
    
    std::unordered_map<std::string, Division> divisions;
    std::vector<SMTParser::NodePtr> tempAssertions;
    std::vector<SMTParser::NodePtr> tempVariables;
    
    std::unordered_map<SMTParser::NodePtr, boost::unordered_set<SMTParser::NodePtr>> splitNodeToAtoms;
    
    utils::Logger& logger = utils::Logger::getInstance();
    SMTParser::Parser SMTParser;
};

} // namespace strp

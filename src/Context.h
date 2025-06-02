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

struct SplitInfo {
    std::string variable;
    std::string delimiter;
    int minSplits;
    int maxSplits;
    bool hasExactCount;
    int exactCount;
    std::vector<int> requiredIndices;
    
    SplitInfo() : minSplits(1), maxSplits(-1), hasExactCount(false), exactCount(0) {}
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
    
    std::vector<SMTParser::NodePtr> getSplitAtNodes();
    std::vector<SMTParser::NodePtr> getNumSplitsNodes();
    std::vector<SMTParser::NodePtr> getSplitAtConstNodes();
    std::vector<SMTParser::NodePtr> getNumSplitsConstNodes();
    std::vector<SMTParser::NodePtr> getSplitAtVarNodes();
    std::vector<SMTParser::NodePtr> getNumSplitsVarNodes();
    std::vector<SMTParser::NodePtr> getSplitNodes();
    
    std::vector<SMTParser::NodePtr> getVariables();
    std::vector<SMTParser::NodePtr> getAssertions();
    boost::unordered_set<Var> getVars() const;
    boost::unordered_set<Atom> getAtoms() const;
    std::vector<Clause> getClauses() const;
    std::vector<Lemma> getLemmas() const;
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
    void clearSplitCache();
    
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
    static boost::unordered_set<SMTParser::NodePtr> getAtoms(const SMTParser::NodePtr& node);
    static SMTParser::NodePtr replaceAtoms(const SMTParser::NodePtr& expr, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& atomMap);
    static SMTParser::NodePtr replaceNodes(const SMTParser::NodePtr& expr, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap);
    static SMTParser::NodePtr createStringConst(const std::string& value);
    static SMTParser::NodePtr createIntConst(int value);
    static SMTParser::NodePtr createStringVar(const std::string& name);
    void updateAssertions(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap);
    void updateAssertionsWithNodes(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap);

    std::vector<std::string> getCachedSplit(const std::string& str, const std::string& delimiter);
    void cacheSplit(const std::string& str, const std::string& delimiter, const std::vector<std::string>& result);
    bool hasCachedSplit(const std::string& str, const std::string& delimiter) const;

    void setInitSplitNums();
    void addConcatNodes();
    
    void addSplitInfo(const std::string& variable, const std::string& delimiter);
    void updateSplitInfo(const std::string& variable, const std::string& delimiter, int minSplits = -1, int maxSplits = -1, int exactCount = -1);
    void addRequiredIndex(const std::string& variable, const std::string& delimiter, int index);
    SplitInfo* getSplitInfo(const std::string& variable, const std::string& delimiter);
    std::vector<SplitInfo>& getAllSplitInfos();
    void clearSplitInfos();

    bool incrementSplitNums();
    void resetSplitNums();
    bool hasMoreSplitCombinations() const;
    void printCurrentSplitState() const;
    
    void addFalseConstraint();

    void updateTasks(const std::string& filename);
    bool hasConflictingSplitConstraints() const;

private:
    Context();
    ~Context() = default;
    Context(const Context&) = delete;
    Context& operator=(const Context&) = delete;
    void updateInfo();
    std::string generateCacheKey(const std::string& str, const std::string& delimiter) const;
    std::string generateSplitKey(const std::string& variable, const std::string& delimiter) const;
    TaskType parseTaskCommand(const std::string& line) const;

    boost::unordered_set<Var> vars;
    boost::unordered_set<Atom> atoms;
    std::vector<Clause> clauses;
    std::vector<Lemma> lemmas;
    std::set<TaskType> tasks;
    
    std::unordered_map<std::string, std::vector<std::string>> splitCache;
    std::unordered_map<std::string, SplitInfo> splitInfoMap;
    std::vector<SMTParser::NodePtr> tempAssertions;
    std::vector<SMTParser::NodePtr> tempVariables;
    
    utils::Logger& logger = utils::Logger::getInstance();
    SMTParser::Parser SMTParser;
};

} // namespace strp

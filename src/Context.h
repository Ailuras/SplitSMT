#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>
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

    void clear();
    void clearVars();
    void clearAtoms();
    void clearClauses();
    void clearLemmas();
    
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
    void updateAssertions(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap);
    void updateAssertionsWithNodes(const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap);
    void refreshInfo();

private:
    Context();
    ~Context() = default;
    Context(const Context&) = delete;
    Context& operator=(const Context&) = delete;
    void updateInfo();

    boost::unordered_set<Var> vars;
    boost::unordered_set<Atom> atoms;
    std::vector<Clause> clauses;
    std::vector<Lemma> lemmas;
    
    utils::Logger& logger = utils::Logger::getInstance();
    SMTParser::Parser SMTParser;
};

} // namespace strp

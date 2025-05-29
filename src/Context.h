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
    
    std::vector<SMTLIBParser::NodePtr> getVariables();
    std::vector<SMTLIBParser::NodePtr> getAssertions();
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
    
    static int getType(const SMTLIBParser::NodePtr& node);
    static VarType getVarType(const SMTLIBParser::NodePtr& node);
    static AtomType getAtomType(const SMTLIBParser::NodePtr& node);
    static ClauseType getClauseType(const SMTLIBParser::NodePtr& node);
    static std::string getSource(const SMTLIBParser::NodePtr& node);
    static std::string getComment(const SMTLIBParser::NodePtr& node);
    static boost::unordered_set<SMTLIBParser::NodePtr> getAtoms(const SMTLIBParser::NodePtr& node);
    
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
    SMTLIBParser::Parser smtlibParser;
};

} // namespace strp

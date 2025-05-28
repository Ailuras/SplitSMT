#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>
#include <boost/unordered/unordered_set.hpp>
#include "Structures.h"
#include "dag.h"
#include "Logger.h"
#include "Parser.h"

namespace strp {

class Context {
public:
    static Context& getInstance();
    void addInfo();
    void addVar(const Var& var);
    void addAtom(const Atom& atom);
    void addClause(const Clause& clause);
    void addLemma(const Lemma& lemma);
    
    boost::unordered_set<Var> getVars() const;
    boost::unordered_set<Atom> getAtoms() const;
    std::vector<Clause> getClauses() const;
    std::vector<Lemma> getLemmas() const;
    
    void clear();
    void clearVars();
    void clearAtoms();
    void clearClauses();
    void clearLemmas();
    
    size_t getVarCount() const;
    size_t getAtomCount() const;
    size_t getClauseCount() const;
    size_t getLemmaCount() const;
    
    Parser& getParser() { return parser; }
    const Parser& getParser() const { return parser; }
    
private:
    Context();
    ~Context() = default;
    Context(const Context&) = delete;
    Context& operator=(const Context&) = delete;
    
    boost::unordered_set<Var> vars;
    boost::unordered_set<Atom> atoms;
    std::vector<Clause> clauses;
    std::vector<Lemma> lemmas;
    
    utils::Logger& logger = utils::Logger::getInstance();
    Parser& parser = Parser::getInstance();
};

} // namespace strp

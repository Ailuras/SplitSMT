#include "Context.h"
#include "Parser.h"

namespace strp {

Context& Context::getInstance() {
    static Context instance;
    return instance;
}

Context::Context() {}

void Context::addInfo() {
    std::vector<SMTLIBParser::NodePtr> variables = parser.getVariables();
    std::vector<SMTLIBParser::NodePtr> assertions = parser.getAssertions();

    for (auto& node : variables) {
        Var var = Var(node, parser);
        addVar(var);
        DEBUG("Added var: ", var.getName(), " of type ", var.getType(), " with comment: ", var.getComment());
    }

    for (auto& node : assertions) {
        Clause clause = Clause(node, parser, true);
        auto atom_set = clause.getAtoms();
        std::vector<Atom> atoms(atom_set.begin(), atom_set.end());
        for (auto& atom : atoms) {
            addAtom(atom);
            DEBUG("Added atom: ", atom.getName(), " of type ", atom.getType(), " with comment: ", atom.getComment());
        }
        addClause(clause);
        DEBUG("Added clause: ", clause.getName(), " of type ", clause.getType(), " with comment: ", clause.getComment());
    }
}

void Context::addVar(const Var& var) {
    vars.insert(var);
}

void Context::addAtom(const Atom& atom) {
    atoms.insert(atom);
}

void Context::addClause(const Clause& clause) {
    clauses.push_back(clause);
}

void Context::addLemma(const Lemma& lemma) {
    lemmas.push_back(lemma);
}

boost::unordered_set<Var> Context::getVars() const {
    return vars;
}

boost::unordered_set<Atom> Context::getAtoms() const {
    return atoms;
}

std::vector<Clause> Context::getClauses() const {
    return clauses;
}

std::vector<Lemma> Context::getLemmas() const {
    return lemmas;
}

void Context::clear() {
    clearVars();
    clearAtoms();
    clearClauses();
    clearLemmas();
}

void Context::clearVars() {
    vars.clear();
}

void Context::clearAtoms() {
    atoms.clear();
}

void Context::clearClauses() {
    clauses.clear();
}

void Context::clearLemmas() {
    lemmas.clear();
}

size_t Context::getVarCount() const {
    return vars.size();
}

size_t Context::getAtomCount() const {
    return atoms.size();
}

size_t Context::getClauseCount() const {
    return clauses.size();
}

size_t Context::getLemmaCount() const {
    return lemmas.size();
}

} // namespace strp

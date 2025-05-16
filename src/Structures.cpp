#include "Structures.h"
#include "Parser.h"

namespace strp {

Var::Var(const SMTLIBParser::NodePtr& node, Parser& parser) :
    node(node),
    type(parser.getVarType(node)),
    source(parser.getSource(node)),
    comment(parser.getComment(node)) {}

Atom::Atom(const SMTLIBParser::NodePtr& node, Parser& parser) :
    node(node),
    type(parser.getAtomType(node)),
    source(parser.getSource(node)),
    comment(parser.getComment(node)) {}

Clause::Clause(const SMTLIBParser::NodePtr& node, Parser& parser, bool is_original) :
    node(node),
    type(parser.getClauseType(node)),
    source(parser.getSource(node)),
    comment(parser.getComment(node)),
    is_original(is_original) {
    for (auto& atom_node : parser.getAtoms(node)) {
        atoms.insert(Atom(atom_node, parser));
    }
}

Lemma::Lemma(const std::vector<Clause>& premises, const Clause& conclusion, Parser& parser) :
    premises(premises),
    conclusion(conclusion) {}

} // namespace strp

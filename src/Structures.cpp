#include "Structures.h"
#include "Context.h"

namespace strp {

Var::Var(const SMTParser::NodePtr& node, Context& context) :
    node(node),
    type(context.getVarType(node)),
    source(context.getSource(node)),
    comment(context.getComment(node)) {}

Atom::Atom(const SMTParser::NodePtr& node, Context& context) :
    node(node),
    type(context.getAtomType(node)),
    source(context.getSource(node)),
    comment(context.getComment(node)) {}

Clause::Clause(const SMTParser::NodePtr& node, Context& context, bool is_original) :
    node(node),
    type(context.getClauseType(node)),
    source(context.getSource(node)),
    comment(context.getComment(node)),
    is_original(is_original) {
    for (auto& atom_node : context.getAtoms(node)) {
        atoms.insert(Atom(atom_node, context));
    }
}

Lemma::Lemma(const std::vector<Clause>& premises, const Clause& conclusion, Context& context) :
    premises(premises),
    conclusion(conclusion) {}

} // namespace strp

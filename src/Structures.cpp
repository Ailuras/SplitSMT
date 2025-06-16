#include "Structures.h"
#include "Context.h"
#include <algorithm>
#include <sstream>

std::vector<std::string> splitString(const std::string& str, const std::string& delimiter) {
    std::vector<std::string> result;
    if (delimiter.empty()) {
        for (char c : str) {
            result.push_back(std::string(1, c));
        }
        return result;
    }
    
    size_t start = 0;
    size_t end = str.find(delimiter);
    
    while (end != std::string::npos) {
        result.push_back(str.substr(start, end - start));
        start = end + delimiter.length();
        end = str.find(delimiter, start);
    }
    result.push_back(str.substr(start));
    
    return result;
}

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



Division::Division(const std::string& divided, const std::string& delimiter, const std::string& dividedType) :
    divided(divided),
    dividedType(dividedType),
    delimiter(delimiter),
    splitNums(0) {
    
    if (dividedType == "const") {
        splits = splitString(divided, delimiter);
        splitNums = static_cast<int>(splits.size());
        
        for (int i = 0; i < splitNums; ++i) {
            splitNumsAppeared.push_back(i);
        }
    }
}

std::string Division::generateKey(const std::string& divided, const std::string& delimiter) {
    return divided + "##" + delimiter;
}

} // namespace strp

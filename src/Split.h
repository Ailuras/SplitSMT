#pragma once

#include "Solver.h"
#include "Context.h"
#include <vector>
#include <string>
#include <unordered_map>

namespace strp {

class splitSolver {
public:
    splitSolver(SolverType solverType = SolverType::Z3);
    ~splitSolver() = default;

    void setSolver(SolverType type);
    SatResult solve();
    SatResult checkSat();
    void resetSolver();
    std::string getModel();
    std::string getUnsatCore();
    std::string filterModel(const std::string& rawModel);

    void rewriteFormula(Context& ctx);
    void replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes);
    void replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes);

    void addAuxiliaryNodes(Context& ctx);
    void addAuxiliaryVariables(Context& ctx, const Division& division);
    void addBasicConstraints(Context& ctx, const Division& division);
    void addEquivalenceConstraints(Context& ctx, const Division& division);
    void addAuxiliaryLemmas(Context& ctx);

private:
    std::unique_ptr<SolverInterface> solver;
    SolverType currentSolverType;
    Context& context;
    
    std::vector<SMTParser::NodePtr> splitAtAtoms;

    void initializeSolver();
    bool containsSplitAtom(const SMTParser::NodePtr& node, const SMTParser::NodePtr& splitAtom);
    std::string nodeToString(const SMTParser::NodePtr& node);
};

} 
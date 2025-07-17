#pragma once

#include "Solver.h"
#include "Context.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

namespace strp {

class splitSolver {
public:
    splitSolver(SolverType solverType = SolverType::EXTERNAL_Z3_NOODLER);
    ~splitSolver() = default;

    void setSolver(SolverType type);
    void initializeSolver();
    void resetSolver();
    SatResult solve();
    SatResult checkSat();
    std::string getModel();
    std::string getUnsatCore();
    std::string filterModel(const std::string& rawModel);

    void rewriteFormula(Context& ctx);
    void replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes);
    void replaceSplitEndConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndConstNodes);
    void replaceNumSplitConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitConstNodes);
    void replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes);
    void replaceSplitEndVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndVarNodes);
    void replaceNumSplitVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitVarNodes);

    void addAuxiliaryNodes(Context& ctx);
    void addAuxiliaryVariables(Context& ctx, const Division* division);
    void addBasicConstraints(Context& ctx, const Division* division);
    void addEquivalenceConstraints(Context& ctx, const Division* division);
    void addIndexConstraints(Context& ctx, const Division* division);
    void addIndexLemmas(Context& ctx, const Division* division);
    void addNumSplitsConstraints(Context& ctx, const Division* division);
    void addAuxiliaryLemmas(Context& ctx);

private:
    std::unique_ptr<SolverInterface> solver;
    SolverType currentSolverType;
    Context& context = Context::getInstance();
    std::vector<SMTParser::NodePtr> splitAtTerms;
};
} 
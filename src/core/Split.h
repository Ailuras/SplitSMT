#pragma once

#include "Solver.h"
#include "Context.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

int parseInteger(const std::string& str);

namespace strp {

class SplitSolver {
public:
    SplitSolver(SolverType solverType = SolverType::Z3_NOODLER,
        Context& ctx = Context::getInstance());
    ~SplitSolver() = default;

    void setSolver(SolverType type);
    void initializeSolver();
    void resetSolver();
    SatResult solve();
    SatResult checkSat();
    std::string getModel();
    std::string getUnsatCore();
    std::string filterModel(const std::string& rawModel);

    bool rewriteFormula(Context& ctx);
    void replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes);
    void replaceSplitEndConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndConstNodes);
    void replaceNumSplitConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitConstNodes);
    void replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes);
    void replaceSplitEndVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitEndVarNodes);
    void replaceNumSplitVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitVarNodes);

    void addAuxiliaryNodes(Context& ctx);
    void detectInvalidIndex(Context& ctx, Division* division);
    void addAuxiliaryVariables(Context& ctx, const Division* division);
    void addBasicConstraints(Context& ctx, const Division* division);
    void addEquivalenceConstraints(Context& ctx, const Division* division);
    void addIndexConstraints(Context& ctx, const Division* division);
    void addNumSplitsConstraints(Context& ctx, const Division* division);
    void addAuxiliaryLemmas(Context& ctx);

private:
    std::unique_ptr<SolverInterface> solver;
    SolverType currentSolverType;
    Context& context;
    std::vector<SMTParser::NodePtr> splitAtTerms;
    bool fallbackAttempted = false;
    bool fallbackReady = false;
    bool fallbackActive = false;
    bool solverSwitchedForFallback = false;

    bool containsUnsupportedScopes(Context& ctx);
    bool prepareFallback();
    std::string buildFormulaForSolver() const;
    std::string injectFallbackDefinitions(const std::string& formula) const;
    const std::string& getFallbackDefinitions() const;
    std::string ensureFallbackLogic(const std::string& formula) const;
    std::string rewriteFallbackFunctionCalls(const std::string& formula) const;
};
} 

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
    void getSplitNums(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes);
    void addAuxiliaryNodes(Context& ctx);
    void addAuxiliaryLemmas(Context& ctx);

private:
    std::unique_ptr<SolverInterface> solver;
    SolverType currentSolverType;
    Context& context;
    
    std::unordered_map<std::string, int> splitMaxIndices;
    std::vector<SMTParser::NodePtr> splitAtAtoms;

    void initializeSolver();
    void findSplitAtAtoms(const SMTParser::NodePtr& node, std::vector<SMTParser::NodePtr>& atoms);
    std::string generateSplitKey(const std::string& variable, const std::string& delimiter);
    void addLemmasForAssertion(Context& ctx, const SMTParser::NodePtr& node, std::vector<std::string>& allLemmas);
    bool containsSplitAtom(const SMTParser::NodePtr& node, const SMTParser::NodePtr& splitAtom);
    std::string nodeToString(const SMTParser::NodePtr& node);
    void addConstraintsBatch(Context& ctx, const std::vector<std::string>& declarations, const std::vector<std::string>& constraints);
};

} 
#pragma once

#include "Solver.h"
#include "Context.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

namespace strp {

struct FunctionDependency {
    SMTParser::NodePtr function;
    std::string name;
    std::string returnType;
    std::string body;
    std::unordered_set<std::string> dependencies;
    
    FunctionDependency(SMTParser::NodePtr func, const std::string& funcName, 
                      const std::string& type, const std::string& funcBody)
        : function(func), name(funcName), returnType(type), body(funcBody) {}
};

class splitSolver {
public:
    splitSolver(SolverType solverType = SolverType::Z3);
    ~splitSolver() = default;

    void setSolver(SolverType type);
    SatResult solve(const std::string& originalFilePath = "");
    SatResult checkSat();
    SatResult tryDirectSolve(const std::string& originalFilePath = "");
    void resetSolver();
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
    void convertZeroParamDefineFuns(Context& ctx);
    void replaceSplitRelatedConstants(Context& ctx);

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
    Context& context;
    
    std::vector<SMTParser::NodePtr> splitAtTerms;

    void initializeSolver();
    void updateFunctionDependencies(Context& ctx, std::vector<FunctionDependency>& functions);
    std::vector<std::string> topologicalSort(const std::vector<FunctionDependency>& functions);
    void findAndReplaceFuncDefNodes(SMTParser::NodePtr node, 
                                   std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacements,
                                   Context& ctx,
                                   const std::unordered_map<std::string, std::string>& functionToVariable);

    std::string nodeToString(const SMTParser::NodePtr& node);
};

} 
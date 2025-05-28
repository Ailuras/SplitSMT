#pragma once
#include <string>
#include <vector>
#include <functional>
#include <memory>
#include "Solver.h"
#include "Context.h"
#include "Parser.h"
namespace strp {
void dumpSMTLIB2(const SMTLIBParser::NodePtr& node, std::stringstream& ss);
class IncrementalSolver {
public:
    using ClauseGenerator = std::function<std::string(Context&, SatResult)>;
    using AnalysisFunction = std::function<bool(Context&, SatResult, const std::string&)>;
    IncrementalSolver(SolverType solverType = SolverType::Z3);
    ~IncrementalSolver() = default;
    void setMaxIterations(int max);
    void setClauseGenerator(ClauseGenerator generator);
    void setAnalysisFunction(AnalysisFunction analyzer);
    SatResult solve();
    int getIterationCount() const { return iterationCount; }
    std::vector<std::string> getAddedClauses() const { return addedClauses; }
    Context& getContext() { return context; }
    const Context& getContext() const { return context; }
private:
    std::unique_ptr<Check> solver;
    Context& context;
    int maxIterations;
    int iterationCount;
    std::vector<std::string> addedClauses;
    ClauseGenerator clauseGenerator;
    AnalysisFunction analysisFunction;
    std::string generateInitialFormula();
    bool shouldContinue(SatResult result);
    void initializeFromParsedData();
};
} 
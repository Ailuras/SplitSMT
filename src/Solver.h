#pragma once

#include <string>
#include <memory>
#include <vector>
#include <unordered_map>
#include <functional>
#include <sstream>
#include "parser.h"

namespace strp {

class Context;

enum class SolverType {
    Z3,
    CVC5
};

enum class SatResult {
    SAT,
    UNSAT,
    UNKNOWN,
    ERROR
};

class SolverInterface {
public:
    virtual ~SolverInterface() = default;
    virtual SatResult checkSat(const std::string& formula) = 0;
    virtual SatResult checkSatIncremental(const std::string& assertion) = 0;
    virtual void addAssertion(const std::string& assertion) = 0;
    virtual SatResult checkSat() = 0;
    virtual void push() = 0;
    virtual void pop() = 0;
    virtual void reset() = 0;
    virtual std::string getModel() = 0;
    virtual std::string getUnsatCore() = 0;
};

class Z3Solver : public SolverInterface {
private:
    class Impl;
    std::unique_ptr<Impl> pImpl;

public:
    Z3Solver();
    ~Z3Solver();
    SatResult checkSat(const std::string& formula) override;
    SatResult checkSatIncremental(const std::string& assertion) override;
    void addAssertion(const std::string& assertion) override;
    SatResult checkSat() override;
    void push() override;
    void pop() override;
    void reset() override;
    std::string getModel() override;
    std::string getUnsatCore() override;
};

class CVC5Solver : public SolverInterface {
private:
    class Impl;
    std::unique_ptr<Impl> pImpl;

public:
    CVC5Solver();
    ~CVC5Solver();
    SatResult checkSat(const std::string& formula) override;
    SatResult checkSatIncremental(const std::string& assertion) override;
    void addAssertion(const std::string& assertion) override;
    SatResult checkSat() override;
    void push() override;
    void pop() override;
    void reset() override;
    std::string getModel() override;
    std::string getUnsatCore() override;
};

void dumpSMTLIB2(const SMTParser::NodePtr& node, std::stringstream& ss);

class splitSolver {
public:
    using ClauseGenerator = std::function<std::string(Context&, SatResult)>;
    using AnalysisFunction = std::function<bool(Context&, SatResult, const std::string&)>;

    splitSolver(SolverType solverType = SolverType::Z3);
    ~splitSolver() = default;
    
    void setSolver(SolverType type);
    void setMaxIterations(int max);
    void setClauseGenerator(ClauseGenerator generator);
    void setAnalysisFunction(AnalysisFunction analyzer);
    int getIterationCount() const { return iterationCount; }

    SatResult checkSat();
    std::string getModel();
    std::string getUnsatCore();
    SatResult solve();
    void rewriteFormula(Context& ctx);
    
    void getSplitNums(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes, const std::vector<SMTParser::NodePtr>& numSplitsVarNodes);
    void replaceSplitAtVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtVarNodes);
    void replaceNumSplitsVarNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitsVarNodes);

    std::string filterModel(const std::string& rawModel);

private:
    std::unique_ptr<SolverInterface> solver;
    SolverType currentSolverType;
    Context& context;
    int maxIterations;
    int iterationCount;
    AnalysisFunction analysisFunction;
    ClauseGenerator clauseGenerator;

    void initializeSolver();
    SatResult checkFormula(const std::string& formula);
    SatResult checkFormulaIncremental(const std::string& assertion);
    void addAssertion(const std::string& assertion);
    void resetSolver();
    void pushContext();
    void popContext();
    
    void replaceSplitAtConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& splitAtConstNodes);
    void replaceNumSplitsConstNodes(Context& ctx, const std::vector<SMTParser::NodePtr>& numSplitsConstNodes);
    void updateAssertionsWithReplacement(Context& ctx, const boost::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& replacementMap);
    bool shouldContinue(SatResult result);
    void generateClause(Context& ctx, SatResult lastResult);
    bool analyzeResult(Context& ctx, SatResult result, const std::string& model);
    
    bool shouldOutputModel();
};

} 
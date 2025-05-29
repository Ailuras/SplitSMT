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

class Check {
private:
    std::unique_ptr<SolverInterface> solver;
    SolverType currentSolverType;
    bool initialized;

    Check() : currentSolverType(SolverType::Z3), initialized(false) {}

public:
    Check(SolverType type);
    ~Check() = default;

    void setSolver(SolverType type);
    SatResult checkFormula(const std::string& formula);
    SatResult checkFormulaIncremental(const std::string& assertion);
    void addAssertion(const std::string& assertion);
    SatResult checkSat();
    
    void pushContext();
    void popContext();
    void resetSolver();
    
    std::string getModel();
    std::string getUnsatCore();
    
    static Check& getInstance();

private:
    void initializeSolver();
};

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
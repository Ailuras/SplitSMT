#pragma once

#include <string>
#include <memory>
#include <vector>
#include <sstream>
#include "parser/SMTParserAPI.h"

namespace strp {

enum class SolverType {
    Z3,
    CVC5,
    OSTRICH,
    Z3_NOODLER
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

class ExternalSolver : public SolverInterface {
private:
    SolverType solverType;
    std::string solverPath;
    std::vector<std::string> currentAssertions;
    std::string currentFormula;
    int timeout;

public:
    ExternalSolver(SolverType type, int timeoutSeconds = 30);
    ~ExternalSolver();
    SatResult checkSat(const std::string& formula) override;
    SatResult checkSatIncremental(const std::string& assertion) override;
    void addAssertion(const std::string& assertion) override;
    SatResult checkSat() override;
    void push() override;
    void pop() override;
    void reset() override;
    std::string getModel() override;
    std::string getUnsatCore() override;

private:
    std::string getSolverPath() const;
    std::string createTempFile(const std::string& content) const;
    SatResult executeExternalSolver(const std::string& tempFile) const;
    void deleteTempFile(const std::string& filename) const;
    std::string buildCurrentFormula() const;
};

void dumpSMTLIB2(const SMTParser::NodePtr& node, std::stringstream& ss);

} 

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

} 
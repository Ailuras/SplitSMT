#pragma once

#include "Context.h"
#include "Solver.h"
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

int parseInteger(const std::string &str);

namespace strp {

class SplitSolver {
public:
  SplitSolver(SolverType solverType = SolverType::Z3_NOODLER,
              Context &ctx = Context::getInstance(), int timeout = 30);
  ~SplitSolver() = default;

  void setSolver(SolverType type);
  void initializeSolver();
  void resetSolver();
  SatResult solve();
  bool generateOnly(const std::string &outputFile);
  SatResult checkSat();
  std::string getModel();
  std::string getUnsatCore();
  std::string filterModel(const std::string &rawModel);

  void rewriteFormula(Context &ctx);
  void replaceSplitAtConstNodes(
      Context &ctx, const std::vector<SMTParser::NodePtr> &splitAtConstNodes);
  void replaceSplitEndConstNodes(
      Context &ctx, const std::vector<SMTParser::NodePtr> &splitEndConstNodes);
  void replaceNumSplitConstNodes(
      Context &ctx, const std::vector<SMTParser::NodePtr> &numSplitConstNodes);
  void replaceSplitAtVarNodes(
      Context &ctx, const std::vector<SMTParser::NodePtr> &splitAtVarNodes);
  void replaceSplitEndVarNodes(
      Context &ctx, const std::vector<SMTParser::NodePtr> &splitEndVarNodes);
  void replaceNumSplitVarNodes(
      Context &ctx, const std::vector<SMTParser::NodePtr> &numSplitVarNodes);

  void addAuxiliaryNodes(Context &ctx);
  void detectInvalidIndex(Context &ctx, Division *division);
  void addAuxiliaryVariables(Context &ctx, const Division *division);
  void addBasicConstraints(Context &ctx, const Division *division);
  void addEquivalenceConstraints(Context &ctx, const Division *division);
  void addNumSplitsConstraints(Context &ctx, const Division *division);
  void addAuxiliaryLemmas(Context &ctx);

private:
  std::unique_ptr<SolverInterface> solver;
  SolverType currentSolverType;
  Context &context;
  int timeout;
  std::vector<SMTParser::NodePtr> splitAtTerms;
};
} // namespace strp

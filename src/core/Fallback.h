#pragma once

#include "Solver.h"
#include <string>

namespace strp {

class FallbackManager {
public:
  static FallbackManager &getInstance();

  void setFallbackRequired(bool required, const std::string &reason,
                           const std::string &rawInput);
  bool isFallbackRequired() const;
  const std::string &getFallbackReason() const;

  SatResult executeFallback(SolverType preferredSolverType, int timeoutSeconds);

private:
  FallbackManager() = default;
  ~FallbackManager() = default;
  FallbackManager(const FallbackManager &) = delete;
  FallbackManager &operator=(const FallbackManager &) = delete;

  std::string buildFallbackFormula(const std::string &raw);
  std::string injectFallbackDefinitions(const std::string &formula);
  std::string rewriteSplitFunctions(const std::string &formula);
  std::string ensureFallbackLogic(const std::string &formula);
  const std::string &loadFallbackDefinitions();

  bool fallbackRequired = false;
  std::string fallbackReason;
  std::string fallbackRawInput;
  bool fallbackFormulaPrepared = false;
  std::string fallbackPreparedFormula;
};

} // namespace strp

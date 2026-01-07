#include "Fallback.h"
#include "utils/Config.h"
#include "utils/Logger.h"
#include <algorithm>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <memory>
#include <sstream>
#include <vector>

namespace {
std::string solverName(strp::SolverType type) {
  switch (type) {
  case strp::SolverType::Z3:
    return "Z3";
  case strp::SolverType::CVC5:
    return "CVC5";
  case strp::SolverType::OSTRICH:
    return "Ostrich";
  case strp::SolverType::Z3_NOODLER:
    return "Z3-Noodler";
  default:
    return "Unknown";
  }
}
} // namespace

namespace strp {

FallbackManager &FallbackManager::getInstance() {
  static FallbackManager instance;
  return instance;
}

void FallbackManager::setFallbackRequired(bool required,
                                          const std::string &reason,
                                          const std::string &rawInput) {
  fallbackRequired = required;
  fallbackReason = reason;
  fallbackRawInput = rawInput;
  fallbackFormulaPrepared = false;
  fallbackPreparedFormula.clear();
}

bool FallbackManager::isFallbackRequired() const { return fallbackRequired; }

const std::string &FallbackManager::getFallbackReason() const {
  return fallbackReason;
}

const std::string &FallbackManager::loadFallbackDefinitions() {
  static std::string definitions;
  static bool loaded = false;
  if (loaded) {
    return definitions;
  }

  try {
    auto path = strp::config::projectRoot() / "src" / "utils" / "RA.txt";
    std::ifstream file(path);
    if (!file.is_open()) {
      LOGGER.ERROR("Failed to open fallback definition file: ", path.string());
      return definitions;
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    definitions = buffer.str();
    loaded = true;
    LOGGER.DEBUG("Loaded fallback split definitions from ", path.string());
  } catch (const std::exception &e) {
    LOGGER.ERROR("Error loading fallback definition file: ", e.what());
  }
  return definitions;
}

std::string FallbackManager::ensureFallbackLogic(const std::string &formula) {
  std::istringstream input(formula);
  std::ostringstream body;
  std::string line;
  bool firstLine = true;

  while (std::getline(input, line)) {
    std::string trimmed = line;
    trimmed.erase(0, trimmed.find_first_not_of(" \t"));
    if (trimmed.rfind("(set-logic", 0) == 0) {
      continue;
    }
    if (!firstLine) {
      body << '\n';
    }
    body << line;
    firstLine = false;
  }

  std::ostringstream result;
  result << "(set-logic ALL)";
  if (!body.str().empty()) {
    result << '\n' << body.str();
  }
  return result.str();
}

std::string FallbackManager::rewriteSplitFunctions(const std::string &formula) {
  std::string result = formula;
  const std::vector<std::pair<std::string, std::string>> replacements = {
      {"(str.split_at", "(split_at"},
      {"(str.split_rest", "(split_rest"},
      {"(str.num_splits", "(num_splits"},
      {"(str.split_at_re", "(split_at_re"},
      {"(str.split_rest_re", "(split_rest_re"},
      {"(str.num_splits_re", "(num_splits_re"}};

  for (const auto &repl : replacements) {
    size_t pos = 0;
    while ((pos = result.find(repl.first, pos)) != std::string::npos) {
      result.replace(pos, repl.first.size(), repl.second);
      pos += repl.second.size();
    }
  }
  return result;
}

std::string
FallbackManager::injectFallbackDefinitions(const std::string &formula) {
  const std::string &definitions = loadFallbackDefinitions();
  if (definitions.empty()) {
    return formula;
  }

  if (formula.find("(define-fun split_at ") != std::string::npos) {
    return formula;
  }

  size_t insertPos = formula.size();
  size_t pos = 0;
  while (pos < formula.size()) {
    size_t lineEnd = formula.find('\n', pos);
    size_t nextPos =
        (lineEnd == std::string::npos) ? formula.size() : lineEnd + 1;
    std::string_view line(
        formula.c_str() + pos,
        (lineEnd == std::string::npos ? formula.size() : lineEnd) - pos);
    std::string trimmed(line);
    trimmed.erase(0, trimmed.find_first_not_of(" \t"));
    if (!trimmed.empty() && (trimmed.rfind("(declare", 0) == 0 ||
                             trimmed.rfind("(define", 0) == 0 ||
                             trimmed.rfind("(assert", 0) == 0)) {
      insertPos = pos;
      break;
    }
    pos = nextPos;
  }

  std::string result;
  std::string defs = definitions;
  if (!defs.empty() && defs.back() != '\n') {
    defs.push_back('\n');
  }
  result.reserve(formula.size() + defs.size() + 2);
  result.append(formula.substr(0, insertPos));
  if (!result.empty() && result.back() != '\n') {
    result.push_back('\n');
  }
  result.append(defs);
  if (insertPos < formula.size() && result.back() != '\n') {
    result.push_back('\n');
  }
  result.append(formula.substr(insertPos));
  return result;
}

std::string FallbackManager::buildFallbackFormula(const std::string &raw) {
  std::string formula = ensureFallbackLogic(raw);
  formula = rewriteSplitFunctions(formula);
  formula = injectFallbackDefinitions(formula);
  return formula;
}

SatResult FallbackManager::executeFallback(SolverType preferredSolverType,
                                          int timeoutSeconds) {
  if (!fallbackFormulaPrepared) {
    fallbackPreparedFormula = buildFallbackFormula(fallbackRawInput);
    fallbackFormulaPrepared = true;
  }

  try {
    LOGGER.INFO("Executing fallback via ", solverName(preferredSolverType));
    std::unique_ptr<SolverInterface> solver =
        std::make_unique<ExternalSolver>(preferredSolverType, timeoutSeconds);

    auto start = std::chrono::high_resolution_clock::now();
    SatResult result = solver->checkSat(fallbackPreparedFormula);
    auto end = std::chrono::high_resolution_clock::now();
    auto duration =
        std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    switch (result) {
    case SatResult::SAT:
      LOGGER.INFO("Fallback result: SAT (", duration.count(), "ms)");
      break;
    case SatResult::UNSAT:
      LOGGER.INFO("Fallback result: UNSAT (", duration.count(), "ms)");
      break;
    case SatResult::UNKNOWN:
      LOGGER.INFO("Fallback result: UNKNOWN (", duration.count(), "ms)");
      break;
    case SatResult::ERROR:
      LOGGER.WARN("Fallback solver ", solverName(preferredSolverType),
                  " returned ERROR (", duration.count(), "ms)");
      break;
    default:
      break;
    }

    return result;
  } catch (const std::exception &e) {
    LOGGER.WARN("Failed to run fallback solver ",
                solverName(preferredSolverType), ": ", e.what());
    return SatResult::ERROR;
  }
}

} // namespace strp

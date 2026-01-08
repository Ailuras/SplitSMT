#include "check.h"

#include "parser/Parser.h"
#include "utils/Logger.h"
#include "utils/StringHelper.h"

#include <algorithm>
#include <cctype>
#include <exception>
#include <optional>
#include <sstream>
#include <unordered_map>
#include <unordered_set>

namespace {

std::string cleanQuotes(const std::string &str) {
  if (str.length() >= 2 && str.front() == '"' && str.back() == '"') {
    return str.substr(1, str.length() - 2);
  }
  return str;
}

std::string normalizeDelimiterLiteral(const std::string &literal) {
  if (!literal.empty() && literal.front() == '"') {
    return strp::Parser::normalizeStringLiteral(literal);
  }
  return literal;
}

std::string trimCopy(const std::string &text) {
  size_t start = 0;
  while (start < text.size() &&
         std::isspace(static_cast<unsigned char>(text[start]))) {
    ++start;
  }
  size_t end = text.size();
  while (end > start &&
         std::isspace(static_cast<unsigned char>(text[end - 1]))) {
    --end;
  }
  return text.substr(start, end - start);
}

void replaceAll(std::string &text, const std::string &from,
                const std::string &to) {
  if (from.empty()) {
    return;
  }
  size_t pos = 0;
  while ((pos = text.find(from, pos)) != std::string::npos) {
    text.replace(pos, from.size(), to);
    pos += to.size();
  }
}

bool extractBalanced(const std::string &text, size_t start, size_t &end) {
  if (start >= text.size() || text[start] != '(') {
    return false;
  }

  int parenCount = 0;
  bool inString = false;

  for (size_t i = start; i < text.size(); ++i) {
    char c = text[i];

    if (c == ';' && !inString) {
      while (i < text.size() && text[i] != '\n') {
        ++i;
      }
      if (i >= text.size()) {
        break;
      }
      c = text[i];
    }

    if (c == '"') {
      if (inString) {
        if (i + 1 < text.size() && text[i + 1] == '"') {
          ++i;
        } else {
          inString = false;
        }
      } else {
        inString = true;
      }
      continue;
    }

    if (inString) {
      continue;
    }

    if (c == '(') {
      ++parenCount;
    } else if (c == ')') {
      --parenCount;
      if (parenCount == 0) {
        end = i + 1;
        return true;
      }
    }
  }

  return false;
}

std::vector<std::string> extractTopLevelSExprs(const std::string &content) {
  std::vector<std::string> exprs;

  size_t pos = 0;
  while (pos < content.size()) {
    while (pos < content.size() &&
           (std::isspace(static_cast<unsigned char>(content[pos])) ||
            content[pos] == ';')) {
      if (content[pos] == ';') {
        while (pos < content.size() && content[pos] != '\n') {
          ++pos;
        }
      } else {
        ++pos;
      }
    }

    if (pos >= content.size()) {
      break;
    }

    if (content[pos] != '(') {
      ++pos;
      continue;
    }

    size_t end = 0;
    if (!extractBalanced(content, pos, end)) {
      ++pos;
      continue;
    }

    exprs.push_back(content.substr(pos, end - pos));
    pos = end;
  }

  return exprs;
}

bool parseDefineFunConst(const std::string &expr, std::string &name,
                         std::string &value) {
  const std::string marker = "(define-fun";
  size_t pos = expr.find(marker);
  if (pos == std::string::npos) {
    return false;
  }

  size_t i = pos + marker.size();
  while (i < expr.size() && std::isspace(static_cast<unsigned char>(expr[i]))) {
    ++i;
  }

  size_t nameStart = i;
  while (i < expr.size() &&
         !std::isspace(static_cast<unsigned char>(expr[i])) && expr[i] != '(' &&
         expr[i] != ')') {
    ++i;
  }
  name = expr.substr(nameStart, i - nameStart);
  if (name.empty()) {
    return false;
  }

  while (i < expr.size() && std::isspace(static_cast<unsigned char>(expr[i]))) {
    ++i;
  }

  if (i >= expr.size() || expr[i] != '(') {
    return false;
  }

  size_t argsEnd = 0;
  if (!extractBalanced(expr, i, argsEnd)) {
    return false;
  }
  std::string args = trimCopy(expr.substr(i, argsEnd - i));
  if (args != "()") {
    return false; // only constants
  }
  i = argsEnd;

  while (i < expr.size() && std::isspace(static_cast<unsigned char>(expr[i]))) {
    ++i;
  }

  // Skip sort token.
  if (i < expr.size() && expr[i] == '(') {
    size_t sortEnd = 0;
    if (!extractBalanced(expr, i, sortEnd)) {
      return false;
    }
    i = sortEnd;
  } else {
    while (i < expr.size() &&
           !std::isspace(static_cast<unsigned char>(expr[i])) &&
           expr[i] != ')') {
      ++i;
    }
  }

  while (i < expr.size() && std::isspace(static_cast<unsigned char>(expr[i]))) {
    ++i;
  }

  if (expr.empty() || expr.back() != ')') {
    return false;
  }

  size_t valueStart = i;
  size_t valueEnd = expr.size() - 1;
  while (valueEnd > valueStart &&
         std::isspace(static_cast<unsigned char>(expr[valueEnd - 1]))) {
    --valueEnd;
  }
  value = trimCopy(expr.substr(valueStart, valueEnd - valueStart));
  return !value.empty();
}

std::unordered_map<std::string, std::string>
parseModelAssignments(const std::string &modelText) {
  std::unordered_map<std::string, std::string> assignments;

  size_t pos = 0;
  while (pos < modelText.size()) {
    size_t start = modelText.find("(define-fun", pos);
    if (start == std::string::npos) {
      break;
    }

    size_t end = 0;
    if (!extractBalanced(modelText, start, end)) {
      break;
    }

    std::string expr = modelText.substr(start, end - start);
    std::string name;
    std::string value;
    if (parseDefineFunConst(expr, name, value)) {
      assignments[name] = value;
    }

    pos = end;
  }

  return assignments;
}

std::unordered_set<std::string>
extractDeclaredConstantSymbols(const std::string &smt2) {
  std::unordered_set<std::string> declared;
  const auto exprs = extractTopLevelSExprs(smt2);

  for (const auto &expr : exprs) {
    size_t i = 0;
    while (i < expr.size() &&
           std::isspace(static_cast<unsigned char>(expr[i]))) {
      ++i;
    }
    if (i >= expr.size() || expr[i] != '(') {
      continue;
    }
    ++i;
    while (i < expr.size() &&
           std::isspace(static_cast<unsigned char>(expr[i]))) {
      ++i;
    }

    size_t headStart = i;
    while (i < expr.size() &&
           !std::isspace(static_cast<unsigned char>(expr[i])) &&
           expr[i] != '(' && expr[i] != ')') {
      ++i;
    }
    const std::string head = expr.substr(headStart, i - headStart);

    auto nextToken = [&](std::string &token) -> bool {
      while (i < expr.size() &&
             std::isspace(static_cast<unsigned char>(expr[i]))) {
        ++i;
      }
      if (i >= expr.size()) {
        return false;
      }
      if (expr[i] == '(') {
        size_t end = 0;
        if (!extractBalanced(expr, i, end)) {
          return false;
        }
        token = expr.substr(i, end - i);
        i = end;
        return true;
      }
      size_t start = i;
      while (i < expr.size() &&
             !std::isspace(static_cast<unsigned char>(expr[i])) &&
             expr[i] != '(' && expr[i] != ')') {
        ++i;
      }
      token = expr.substr(start, i - start);
      return !token.empty();
    };

    if (head == "declare-const") {
      std::string name;
      std::string sort;
      if (nextToken(name) && nextToken(sort)) {
        declared.insert(name);
      }
    } else if (head == "declare-fun") {
      std::string name;
      std::string args;
      std::string sort;
      if (nextToken(name) && nextToken(args) && nextToken(sort)) {
        if (trimCopy(args) == "()") {
          declared.insert(name);
        }
      }
    }
  }

  return declared;
}

std::string injectAssertionsBeforeCheckSat(const std::string &formula,
                                           const std::string &assertions) {
  if (assertions.empty()) {
    return formula;
  }

  const size_t checkPos = formula.find("(check-sat");
  if (checkPos == std::string::npos) {
    std::string result = formula;
    if (!result.empty() && result.back() != '\n') {
      result.push_back('\n');
    }
    result.append(assertions);
    if (!result.empty() && result.back() != '\n') {
      result.push_back('\n');
    }
    result.append("(check-sat)\n");
    return result;
  }

  size_t insertPos = formula.rfind('\n', checkPos);
  if (insertPos == std::string::npos) {
    insertPos = 0;
  } else {
    insertPos += 1;
  }

  std::string result;
  result.reserve(formula.size() + assertions.size() + 2);
  result.append(formula.substr(0, insertPos));
  result.append(assertions);
  if (!result.empty() && result.back() != '\n') {
    result.push_back('\n');
  }
  result.append(formula.substr(insertPos));
  return result;
}

} // namespace

namespace strp {

bool runSplitModelCheck(Context &context, SolverType solverType,
                        int timeoutSeconds, const std::string &rawInput,
                        const std::string &modelText,
                        const std::vector<SMTParser::NodePtr> &splitAtTerms,
                        const std::vector<SMTParser::NodePtr> &splitRestTerms,
                        const std::vector<SMTParser::NodePtr> &numSplitTerms) {
  if (rawInput.empty()) {
    ERROR("Original SMT-LIB content is empty; cannot check model");
    return false;
  }

  if (modelText.empty()) {
    ERROR("Failed to obtain model from solver");
    return false;
  }

  const auto assignments = parseModelAssignments(modelText);
  if (assignments.empty()) {
    ERROR("Failed to parse any constant assignments from solver model");
    return false;
  }

  std::string checkFormula = Parser::postProcessSMTLIB(rawInput);

  auto getAssignment =
      [&](const std::string &name) -> std::optional<std::string> {
    auto it = assignments.find(name);
    if (it == assignments.end()) {
      return std::nullopt;
    }
    return it->second;
  };

  auto emptyString = []() { return Parser::encodeStringLiteral(""); };

  auto replaceSplitAtNode = [&](const SMTParser::NodePtr &node) -> bool {
    if (!node || node->getChildrenSize() < 3) {
      return true;
    }

    const std::string exprText =
        Parser::postProcessSMTLIB(context.getParser().getString(node));

    auto arg1 = node->getChild(0);
    auto arg3 = node->getChild(2);
    const int index =
        utils::parseInteger(arg3 ? arg3->toString() : "").value_or(0);

    std::string replacement = emptyString();

    if (arg1 && arg1->isConst()) {
      const std::string str = cleanQuotes(arg1->toString());
      const std::string delimiter = normalizeDelimiterLiteral(
          context.getParser().getString(node->getChild(1)));

      if (Division *division = context.getDivision(str, delimiter)) {
        if (division->isConstType()) {
          auto *constDiv = static_cast<ConstDivision *>(division);
          if (index >= 0 &&
              static_cast<size_t>(index) < constDiv->getSplitNums()) {
            replacement =
                Parser::encodeStringLiteral(constDiv->getSplit(index));
          }
        }
      }
    } else if (arg1 && arg1->isVar()) {
      const std::string variable = arg1->toString();
      const std::string delimiter = normalizeDelimiterLiteral(
          context.getParser().getString(node->getChild(1)));

      if (Division *division = context.getDivision(variable, delimiter)) {
        if (division->isVarType()) {
          auto *varDiv = static_cast<VarDivision *>(division);
          const auto &indices = varDiv->getSplitAtNumsAppeared();
          if (std::find(indices.begin(), indices.end(), index) !=
              indices.end()) {
            const std::string xi =
                division->getHashString() + "_x_" + std::to_string(index);
            auto value = getAssignment(xi);
            if (!value) {
              WARN("Missing model assignment for ", xi);
              return false;
            }
            replacement = *value;
          }
        }
      }
    }

    if (exprText.empty()) {
      return true;
    }
    replaceAll(checkFormula, exprText, replacement);
    return true;
  };

  auto replaceSplitRestNode = [&](const SMTParser::NodePtr &node) -> bool {
    if (!node || node->getChildrenSize() < 3) {
      return true;
    }

    const std::string exprText =
        Parser::postProcessSMTLIB(context.getParser().getString(node));

    auto arg1 = node->getChild(0);
    auto arg3 = node->getChild(2);
    const int index =
        utils::parseInteger(arg3 ? arg3->toString() : "").value_or(0);

    std::string replacement = emptyString();

    if (arg1 && arg1->isConst()) {
      const std::string str = cleanQuotes(arg1->toString());
      const std::string delimiter = normalizeDelimiterLiteral(
          context.getParser().getString(node->getChild(1)));

      if (Division *division = context.getDivision(str, delimiter)) {
        if (division->isConstType()) {
          auto *constDiv = static_cast<ConstDivision *>(division);
          const auto &splits = constDiv->getSplits();
          const auto &splitDelimiters = constDiv->getSplitDelimiters();
          if (index >= 0 &&
              static_cast<size_t>(index) < constDiv->getSplitNums()) {
            std::string rest;
            for (int i = index; i < static_cast<int>(splits.size()); ++i) {
              if (i > index) {
                rest += splitDelimiters[i - 1];
              }
              rest += splits[i];
            }
            replacement = Parser::encodeStringLiteral(rest);
          }
        }
      }
    } else if (arg1 && arg1->isVar()) {
      const std::string variable = arg1->toString();
      const std::string delimiter = normalizeDelimiterLiteral(
          context.getParser().getString(node->getChild(1)));

      if (Division *division = context.getDivision(variable, delimiter)) {
        if (division->isVarType()) {
          auto *varDiv = static_cast<VarDivision *>(division);
          const auto &indices = varDiv->getSplitRestNumsAppeared();
          if (std::find(indices.begin(), indices.end(), index) !=
              indices.end()) {
            const std::string ri =
                division->getHashString() + "_r_" + std::to_string(index);
            auto value = getAssignment(ri);
            if (!value) {
              WARN("Missing model assignment for ", ri);
              return false;
            }
            replacement = *value;
          }
        }
      }
    }

    if (exprText.empty()) {
      return true;
    }
    replaceAll(checkFormula, exprText, replacement);
    return true;
  };

  auto replaceNumSplitsNode = [&](const SMTParser::NodePtr &node) -> bool {
    if (!node || node->getChildrenSize() < 2) {
      return true;
    }

    const std::string exprText =
        Parser::postProcessSMTLIB(context.getParser().getString(node));

    auto arg1 = node->getChild(0);
    std::string replacement = "0";

    if (arg1 && arg1->isConst()) {
      const std::string str = cleanQuotes(arg1->toString());
      const std::string delimiter = normalizeDelimiterLiteral(
          context.getParser().getString(node->getChild(1)));
      if (Division *division = context.getDivision(str, delimiter)) {
        if (division->isConstType()) {
          auto *constDiv = static_cast<ConstDivision *>(division);
          replacement = std::to_string(constDiv->getSplitNums());
        }
      }
    } else if (arg1 && arg1->isVar()) {
      const std::string variable = arg1->toString();
      const std::string delimiter = normalizeDelimiterLiteral(
          context.getParser().getString(node->getChild(1)));

      if (Division *division = context.getDivision(variable, delimiter)) {
        if (division->isVarType() && division->isNumSplitsUsed()) {
          const std::string numVar = division->getHashString() + "_num";
          auto value = getAssignment(numVar);
          if (!value) {
            WARN("Missing model assignment for ", numVar);
            return false;
          }
          replacement = *value;
        }
      }
    }

    if (exprText.empty()) {
      return true;
    }
    replaceAll(checkFormula, exprText, replacement);
    return true;
  };

  bool ok = true;
  for (const auto &node : splitAtTerms) {
    ok = replaceSplitAtNode(node) && ok;
  }
  for (const auto &node : splitRestTerms) {
    ok = replaceSplitRestNode(node) && ok;
  }
  for (const auto &node : numSplitTerms) {
    ok = replaceNumSplitsNode(node) && ok;
  }

  if (checkFormula.find("str.split_at") != std::string::npos ||
      checkFormula.find("str.split_rest") != std::string::npos ||
      checkFormula.find("str.num_splits") != std::string::npos) {
    ERROR("Check formula still contains unsupported split functions after "
          "replacement");
    ok = false;
  }

  const auto declared = extractDeclaredConstantSymbols(checkFormula);
  std::string injected;
  injected.reserve(declared.size() * 64);

  for (const auto &name : declared) {
    auto it = assignments.find(name);
    if (it == assignments.end()) {
      continue;
    }
    injected.append("(assert (= ");
    injected.append(name);
    injected.append(" ");
    injected.append(it->second);
    injected.append("))\n");
  }

  checkFormula = injectAssertionsBeforeCheckSat(checkFormula, injected);

  SatResult checkResult = SatResult::ERROR;
  try {
    ExternalSolver checker(solverType, timeoutSeconds);
    checkResult = checker.checkSat(checkFormula);
  } catch (const std::exception &e) {
    ERROR("Failed to execute check solver: ", e.what());
    return false;
  }

  if (checkResult != SatResult::SAT) {
    ERROR("Model check returned ", checkResult == SatResult::UNSAT ? "UNSAT"
                                   : checkResult == SatResult::UNKNOWN
                                       ? "UNKNOWN"
                                       : "ERROR");
    ok = false;
  }

  return ok;
}

} // namespace strp

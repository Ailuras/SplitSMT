#include "Parser.h"
#include "core/Context.h"
#include "core/Structures.h"
#include <algorithm>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <queue>
#include <regex>
#include <sstream>

namespace strp {

Parser &Parser::getInstance() {
  static Parser instance;
  return instance;
}

Parser::Parser() {}

void Parser::resetParser() {
  SMTParser = SMTParser::Parser();
  needDecomposition = false;
  fallbackRequired = false;
  fallbackReason.clear();
  rawContent.clear();
}

std::string Parser::decodeStringLiteral(const std::string &literal) {
  if (literal.size() < 2 || literal.front() != '"' || literal.back() != '"') {
    return literal;
  }

  std::string inner = literal.substr(1, literal.size() - 2);
  std::string result;
  result.reserve(inner.size());

  for (size_t i = 0; i < inner.size(); ++i) {
    char c = inner[i];
    if (c == '"') {
      if (i + 1 < inner.size() && inner[i + 1] == '"') {
        result.push_back('"');
        ++i;
      } else {
        result.push_back('"');
      }
    } else if (c == '\\') {
      if (i + 1 < inner.size()) {
        char next = inner[++i];
        switch (next) {
        case '\\':
          result.push_back('\\');
          break;
        case '"':
          result.push_back('"');
          break;
        case 'n':
          result.push_back('\n');
          break;
        case 'r':
          result.push_back('\r');
          break;
        case 't':
          result.push_back('\t');
          break;
        case 'u': {
          std::string hex;
          if (i + 1 < inner.size() && inner[i + 1] == '{') {
            size_t end = inner.find('}', i + 2);
            if (end != std::string::npos) {
              hex = inner.substr(i + 2, end - (i + 2));
              i = end;
            }
          } else if (i + 4 < inner.size()) {
            hex = inner.substr(i + 1, 4);
            i += 4;
          }
          if (!hex.empty()) {
            char32_t code =
                static_cast<char32_t>(std::strtoul(hex.c_str(), nullptr, 16));
            if (code <= 0x7F) {
              result.push_back(static_cast<char>(code));
            } else if (code <= 0x7FF) {
              result.push_back(static_cast<char>(0xC0 | ((code >> 6) & 0x1F)));
              result.push_back(static_cast<char>(0x80 | (code & 0x3F)));
            } else if (code <= 0xFFFF) {
              result.push_back(static_cast<char>(0xE0 | ((code >> 12) & 0x0F)));
              result.push_back(static_cast<char>(0x80 | ((code >> 6) & 0x3F)));
              result.push_back(static_cast<char>(0x80 | (code & 0x3F)));
            } else {
              result.push_back(static_cast<char>(0xF0 | ((code >> 18) & 0x07)));
              result.push_back(static_cast<char>(0x80 | ((code >> 12) & 0x3F)));
              result.push_back(static_cast<char>(0x80 | ((code >> 6) & 0x3F)));
              result.push_back(static_cast<char>(0x80 | (code & 0x3F)));
            }
          }
          break;
        }
        default:
          result.push_back(next);
          break;
        }
      } else {
        result.push_back('\\');
      }
    } else {
      result.push_back(c);
    }
  }

  return result;
}

std::string Parser::encodeStringLiteral(const std::string &value) {
  std::ostringstream oss;
  oss << '"';
  size_t i = 0;
  while (i < value.size()) {
    unsigned char c = static_cast<unsigned char>(value[i]);

    // Handle ASCII printable characters and common escapes
    if (c < 0x80) {
      switch (c) {
      case '"':
        oss << "\"\"";
        break;
      case '\\':
        oss << "\\\\";
        break;
      case '\n':
        oss << "\\n";
        break;
      case '\r':
        oss << "\\r";
        break;
      case '\t':
        oss << "\\t";
        break;
      default:
        if (c < 0x20 || c == 0x7F) {
          // Control characters - use \uXXXX format
          oss << "\\u" << std::hex << std::uppercase << std::setw(4)
              << std::setfill('0') << static_cast<int>(c) << std::dec
              << std::nouppercase;
        } else {
          oss << static_cast<char>(c);
        }
        break;
      }
      ++i;
    } else {
      // UTF-8 multi-byte sequence - pass through valid sequences directly
      size_t bytesNeeded = 0;

      if ((c & 0xE0) == 0xC0) {
        bytesNeeded = 2;
      } else if ((c & 0xF0) == 0xE0) {
        bytesNeeded = 3;
      } else if ((c & 0xF8) == 0xF0) {
        bytesNeeded = 4;
      } else {
        // Invalid UTF-8 leading byte - output as raw byte (most solvers handle
        // this)
        oss << static_cast<char>(c);
        ++i;
        continue;
      }

      // Check if we have enough bytes and they're valid continuation bytes
      bool valid = (i + bytesNeeded <= value.size());
      if (valid) {
        for (size_t j = 1; j < bytesNeeded; ++j) {
          unsigned char cont = static_cast<unsigned char>(value[i + j]);
          if ((cont & 0xC0) != 0x80) {
            valid = false;
            break;
          }
        }
      }

      if (valid) {
        // Valid UTF-8 sequence - output raw bytes directly
        for (size_t j = 0; j < bytesNeeded; ++j) {
          oss << value[i + j];
        }
        i += bytesNeeded;
      } else {
        // Invalid sequence - output first byte as raw
        oss << static_cast<char>(c);
        ++i;
      }
    }
  }
  oss << '"';
  return oss.str();
}

std::string Parser::normalizeStringLiteral(const std::string &literal) {
  if (literal.empty()) {
    return literal;
  }

  if (literal.front() == '"' && literal.back() == '"') {
    return encodeStringLiteral(decodeStringLiteral(literal));
  }

  if (literal.front() == '\\') {
    std::string decoded;
    decoded.reserve(literal.size());
    for (size_t i = 0; i < literal.size(); ++i) {
      char c = literal[i];
      if (c == '\\' && i + 1 < literal.size()) {
        decoded.push_back(literal[++i]);
      } else {
        decoded.push_back(c);
      }
    }
    return encodeStringLiteral(decoded);
  }

  return literal;
}

std::string Parser::postProcessSMTLIB(const std::string &content) {
  std::string result;
  result.reserve(content.size());

  size_t i = 0;
  while (i < content.size()) {
    char c = content[i];
    if (c != '"') {
      result.push_back(c);
      ++i;
      continue;
    }

    // We are at the start of a string literal. Extract it, normalise, and
    // append.
    size_t start = i;
    ++i; // skip the opening quote
    bool closed = false;
    while (i < content.size()) {
      char current = content[i];
      if (current == '\\' && i + 1 < content.size()) {
        // Skip escaped character.
        i += 2;
        continue;
      }
      if (current == '"') {
        if (i + 1 < content.size() && content[i + 1] == '"') {
          // SMT-LIB encodes a quote inside a string as "".
          i += 2;
          continue;
        }
        ++i; // include the closing quote
        closed = true;
        break;
      }
      ++i;
    }

    if (!closed) {
      // Unterminated literal, append the remainder as-is.
      result.append(content.substr(start));
      break;
    }

    std::string literal = content.substr(start, i - start);
    result.append(Parser::normalizeStringLiteral(literal));
  }

  return result;
}

bool Parser::containsUnsupportedSyntax(
    [[maybe_unused]] const std::string &content,
    [[maybe_unused]] std::string &reason) const {
  // Removed forall/exists/let/seq. detection - now handled by AST-based precise
  // detection This function is kept for potential future string-level checks
  return false;
}

// AST-based detection: check if node contains split operations
bool Parser::containsSplitOperation(const SMTParser::NodePtr &node) const {
  if (!node)
    return false;

  SMTParser::NODE_KIND kind = node->getKind();

  // Check if this is a split operation
  if (kind == SMTParser::NODE_KIND::NT_STR_SPLIT_AT ||
      kind == SMTParser::NODE_KIND::NT_STR_SPLIT_REST ||
      kind == SMTParser::NODE_KIND::NT_STR_NUM_SPLITS ||
      kind == SMTParser::NODE_KIND::NT_STR_SPLIT_AT_RE ||
      kind == SMTParser::NODE_KIND::NT_STR_SPLIT_REST_RE ||
      kind == SMTParser::NODE_KIND::NT_STR_NUM_SPLITS_RE) {
    return true;
  }

  // Recursively check children
  for (size_t i = 0; i < node->getChildrenSize(); ++i) {
    if (containsSplitOperation(node->getChild(i))) {
      return true;
    }
  }

  return false;
}

// AST-based detection: check if quantifier/let contains split operations
bool Parser::hasQuantifierOrLetWithSplit(const SMTParser::NodePtr &node,
                                         std::string &reason) const {
  if (!node)
    return false;

  SMTParser::NODE_KIND kind = node->getKind();

  // Check if current node is forall/exists/let
  if (kind == SMTParser::NODE_KIND::NT_FORALL ||
      kind == SMTParser::NODE_KIND::NT_EXISTS ||
      kind == SMTParser::NODE_KIND::NT_LET) {

    // Check if the body contains split operations
    if (containsSplitOperation(node)) {
      std::string kindName =
          (kind == SMTParser::NODE_KIND::NT_FORALL)   ? "forall"
          : (kind == SMTParser::NODE_KIND::NT_EXISTS) ? "exists"
                                                      : "let";
      reason =
          "Detected " + kindName + " construct containing split operations";
      return true;
    }
  }

  // Recursively check children
  for (size_t i = 0; i < node->getChildrenSize(); ++i) {
    if (hasQuantifierOrLetWithSplit(node->getChild(i), reason)) {
      return true;
    }
  }

  return false;
}

// AST-based detection: check if specific split node has variable index
bool Parser::isSplitIndexVariable(const SMTParser::NodePtr &splitNode) const {
  if (!splitNode)
    return false;

  SMTParser::NODE_KIND kind = splitNode->getKind();

  // Only split_at and split_rest have index parameter
  if (kind != SMTParser::NODE_KIND::NT_STR_SPLIT_AT &&
      kind != SMTParser::NODE_KIND::NT_STR_SPLIT_REST &&
      kind != SMTParser::NODE_KIND::NT_STR_SPLIT_AT_RE &&
      kind != SMTParser::NODE_KIND::NT_STR_SPLIT_REST_RE) {
    return false;
  }

  // Index is child[2]
  if (splitNode->getChildrenSize() < 3) {
    return false;
  }

  auto indexArg = splitNode->getChild(2);

  // Check if it's a constant (NT_CONST)
  // If not NT_CONST, it's a variable or expression
  return indexArg->getKind() != SMTParser::NODE_KIND::NT_CONST;
}

// AST-based detection: check if any split has variable index
bool Parser::hasSplitWithVariableIndex(const SMTParser::NodePtr &node) const {
  if (!node)
    return false;

  // Check current node
  if (isSplitIndexVariable(node)) {
    return true;
  }

  // Recursively check children
  for (size_t i = 0; i < node->getChildrenSize(); ++i) {
    if (hasSplitWithVariableIndex(node->getChild(i))) {
      return true;
    }
  }

  return false;
}

// AST-based detection: main entry point for precise fallback checking
bool Parser::containsUnsupportedSplitPattern(std::string &reason) {
  // Traverse all assertions
  auto assertions = getAssertions();
  for (const auto &assertion : assertions) {
    if (hasQuantifierOrLetWithSplit(assertion, reason)) {
      return true;
    }
  }
  return false;
}

bool Parser::parseFile(const std::string &filename,
                       Decomposition &decomposition) {
  LOG1("Starting to parse file: ", filename);

  decomposition = Decomposition{};
  resetParser();

  bool requiresDecomposition = need_decomposition(filename);
  needDecomposition = requiresDecomposition;

  if (requiresDecomposition) {
    LOG2("File requires decomposition, processing with split logic");
    decomposition = getDecomposition(filename);
    LOG3("Decomposition completed:");
    LOG3("  - Split constraints: ", decomposition.splitConstraints.size(),
         " items");
    LOG3("  - Other constraints: ", decomposition.otherConstraints.size(),
         " items");
    LOG3("  - Variables: ", decomposition.variables.size());
  } else {
    LOG2("File does not require decomposition, reading directly");
    std::ifstream file(filename);
    if (!file.is_open()) {
      ERROR("Failed to open file: ", filename);
      return false;
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    decomposition.splitSMTLIB2 = buffer.str();
    LOG3("Read ", decomposition.splitSMTLIB2.length(), " characters from file");
  }

  rawContent = decomposition.splitSMTLIB2;

  std::string fallbackDesc;
  if (containsUnsupportedSyntax(rawContent, fallbackDesc)) {
    fallbackRequired = true;
    fallbackReason = fallbackDesc;
    INFO("Input contains unsupported constructs (", fallbackReason,
         "); skipping rewrite pipeline");
    return true;
  }

  LOG2("Attempting to parse SMTLIB2 content with SMTParser");
  bool success = SMTParser.parseStr(decomposition.splitSMTLIB2);

  if (!success) {
    ERROR("Failed to parse file: ", filename);
    LOG1("Parse failure details:");
    LOG1("  - SMTLIB2 content preview: ",
         decomposition.splitSMTLIB2.substr(0, 200), "...");
    if (!fallbackRequired) {
      fallbackRequired = true;
      fallbackReason = "Internal SMT parser failed to read input";
    }
    INFO("Switching to fallback processing due to parser failure");
    return true;
  }

  // PHASE 2: AST-based precise detection (after successful parsing)
  std::string patternReason;

  // Check for quantifier/let with split operations
  if (containsUnsupportedSplitPattern(patternReason)) {
    fallbackRequired = true;
    fallbackReason = patternReason;
    INFO("Detected unsupported pattern: ", fallbackReason);
    return true;
  }

  // Check for split with variable index (applies to ALL splits)
  auto assertions = getAssertions();
  for (const auto &assertion : assertions) {
    if (hasSplitWithVariableIndex(assertion)) {
      fallbackRequired = true;
      fallbackReason = "Split operation with variable index detected";
      INFO("Detected split with variable index; switching to fallback");
      return true;
    }
  }

  INFO("Successfully parsed file: ", filename);
  LOG2("Parse result details:");
  LOG2("  - Total assertions: ", SMTParser.assertions.size());
  LOG2("  - Total variables: ", SMTParser.getVariables().size());
  LOG3("  - SMTLIB2 content length: ", decomposition.splitSMTLIB2.length());
  DEBUG("Found ", SMTParser.assertions.size(), " assertions and ",
        SMTParser.getVariables().size(), " variables");
  return success;
}

bool Parser::need_decomposition(const std::string &filename) {
  LOG3("Checking if file needs decomposition: ", filename);

  std::ifstream file(filename);
  if (!file.is_open()) {
    ERROR("Failed to open file: ", filename);
    return false;
  }

  std::string content((std::istreambuf_iterator<char>(file)),
                      std::istreambuf_iterator<char>());
  file.close();

  bool hasSplitLength = content.find("get_split_length") != std::string::npos;
  bool hasSplitElement = content.find("get_split_element") != std::string::npos;

  LOG4("Decomposition check results:");
  LOG4("  - Contains get_split_length: ", hasSplitLength);
  LOG4("  - Contains get_split_element: ", hasSplitElement);

  bool needsDecomp = hasSplitLength || hasSplitElement;
  LOG3("File needs decomposition: ", needsDecomp);

  return needsDecomp;
}

Decomposition Parser::getDecomposition(const std::string &filename) {
  LOG2("Starting decomposition of file: ", filename);
  Decomposition decomposition;

  std::ifstream file(filename);
  if (!file.is_open()) {
    ERROR("Failed to open file: ", filename);
    return decomposition;
  }

  std::string content((std::istreambuf_iterator<char>(file)),
                      std::istreambuf_iterator<char>());
  file.close();
  LOG3("Read ", content.length(), " characters from file");

  LOG2("Extracting and categorizing constraints");
  decomposition.splitRelatedFunctionNames.clear();
  std::pair<std::vector<std::string>, std::vector<std::string>> constraints =
      extractConstraints(content, decomposition.splitRelatedFunctionNames);
  decomposition.splitConstraints = constraints.first;
  decomposition.otherConstraints = constraints.second;
  LOG3("Split constraints: ", decomposition.splitConstraints.size(), " items");
  for (const auto &constraint : decomposition.splitConstraints) {
    LOG4("  - Constraint: ", constraint);
  }
  LOG3("Other constraints: ", decomposition.otherConstraints.size(), " items");

  LOG2("Extracting all variables");
  decomposition.variables = getAllVariables(decomposition);
  LOG3("Found ", decomposition.variables.size(), " total variables");

  LOG2("Generating split SMTLIB2 content");
  decomposition.splitSMTLIB2 = getSplitSMTLIB2(decomposition);
  LOG3("Generated SMTLIB2: ", decomposition.splitSMTLIB2.length(), " chars");

  LOG1("Decomposition completed successfully");
  return decomposition;
}

std::string Parser::extractFunctionName(const std::string &functionDef) {
  size_t start = functionDef.find("(define-fun ");
  if (start == std::string::npos)
    return "";

  start += 12;
  size_t end = functionDef.find(" ", start);
  if (end == std::string::npos)
    return "";

  return functionDef.substr(start, end - start);
}

std::pair<std::vector<std::string>, std::vector<std::string>>
Parser::extractConstraints(const std::string &content,
                           std::vector<std::string> &splitFunctionNames) {
  LOG4("Extracting and categorizing constraints from content");
  std::vector<std::string> splitConstraints;
  std::vector<std::string> otherConstraints;

  std::vector<std::string> allConstraints = extractAllConstraints(content);

  int totalConstraints = 0;
  for (const auto &constraint : allConstraints) {
    totalConstraints++;

    bool isCurrentSplit = isSplitRelated(constraint, splitFunctionNames);

    // Check if this is a define-fun constraint and extract function name if
    // it's split related
    if (constraint.find("(define-fun ") != std::string::npos &&
        isCurrentSplit) {
      std::string funcName = extractFunctionName(constraint);
      if (!funcName.empty()) {
        splitFunctionNames.push_back(funcName);
        LOG5("Found split function: ", funcName);
      }
    }

    if (isCurrentSplit) {
      splitConstraints.push_back(constraint);
    } else if (!constraint.empty() &&
               constraint.find("assert true") == std::string::npos) {
      otherConstraints.push_back(constraint);
    }
  }

  LOG4("Constraint extraction results:");
  LOG4("  - Total constraints found: ", totalConstraints);
  LOG4("  - Split constraints: ", splitConstraints.size());
  LOG4("  - Split function names: ", splitFunctionNames.size());
  LOG4("  - Other constraints: ", otherConstraints.size());

  return {splitConstraints, otherConstraints};
}

std::vector<std::string>
Parser::extractAllConstraints(const std::string &content) {
  std::vector<std::string> constraints;
  LOG4("Extracting all constraints from content (using balanced parentheses "
       "parsing)");

  size_t pos = 0;
  while (pos < content.length()) {
    // Skip whitespace and comments
    while (pos < content.length() &&
           (std::isspace(content[pos]) || content[pos] == ';')) {
      if (content[pos] == ';') {
        // Skip comment line
        while (pos < content.length() && content[pos] != '\n') {
          pos++;
        }
      } else {
        pos++;
      }
    }

    if (pos >= content.length())
      break;

    // Found start of a constraint (should be '(')
    if (content[pos] == '(') {
      size_t start = pos;
      int parenCount = 0;
      bool inString = false;

      // Parse balanced parentheses
      while (pos < content.length()) {
        char c = content[pos];
        if (c == '"' && (pos == 0 || content[pos - 1] != '\\')) {
          inString = !inString;
        }
        if (!inString) {
          if (c == '(')
            parenCount++;
          else if (c == ')') {
            parenCount--;
            if (parenCount == 0) {
              pos++; // Include the closing parenthesis
              break;
            }
          }
        }
        pos++;
      }

      if (parenCount == 0) {
        std::string constraint = content.substr(start, pos - start);
        constraints.push_back(constraint);
      } else {
        LOG4("Warning: Unbalanced parentheses starting at position ", start);
        pos = start + 1; // Skip this character and continue
      }
    } else {
      // Unexpected character, skip it
      pos++;
    }
  }

  LOG4("Extracted ", constraints.size(), " constraints from content");
  return constraints;
}

bool Parser::isSplitRelated(
    const std::string &constraint,
    const std::vector<std::string> &splitFunctionNames) {
  bool hasDirectSplit =
      constraint.find("str.split_at") != std::string::npos ||
      constraint.find("str.split_rest") != std::string::npos ||
      constraint.find("str.num_splits") != std::string::npos;

  if (hasDirectSplit) {
    // LOG5("Constraint has direct split syntax: ", constraint);
    return true;
  }

  for (const auto &funcName : splitFunctionNames) {
    if (constraint.find("(" + funcName + " ") != std::string::npos) {
      // LOG5("Constraint calls split function ", funcName, ": ", constraint);
      return true;
    }
  }

  return false;
}

std::vector<std::pair<std::string, std::string>>
Parser::getAllVariables(Decomposition &decomposition) {
  std::vector<std::pair<std::string, std::string>> allVars;
  std::vector<std::pair<std::string, std::string>> splitVars =
      extractVariablesFromConstraints(decomposition.splitConstraints);
  std::vector<std::pair<std::string, std::string>> otherVars =
      extractVariablesFromConstraints(decomposition.otherConstraints);

  std::set<std::string> seenVars;
  for (const auto &var : splitVars) {
    if (seenVars.find(var.first) == seenVars.end()) {
      allVars.push_back(var);
      seenVars.insert(var.first);
    }
  }
  for (const auto &var : otherVars) {
    if (seenVars.find(var.first) == seenVars.end()) {
      allVars.push_back(var);
      seenVars.insert(var.first);
    }
  }

  decomposition.variablesHasDefined = splitVars;
  std::set<std::string> allVarNames;
  for (const auto &var : allVars) {
    allVarNames.insert(var.first);
  }

  std::vector<std::string> variableAppeared =
      extractVariablesAppeared(decomposition.splitConstraints, allVarNames);
  std::set<std::string> hasDefinedNames;
  for (const auto &var : decomposition.variablesHasDefined) {
    hasDefinedNames.insert(var.first);
  }

  decomposition.variablesNeedDeclare.clear();
  for (const auto &varName : variableAppeared) {
    if (hasDefinedNames.find(varName) == hasDefinedNames.end()) {
      // 找到对应的变量类型
      for (const auto &var : allVars) {
        if (var.first == varName) {
          decomposition.variablesNeedDeclare.push_back(var);
          break;
        }
      }
    }
  }

  return allVars;
}

std::vector<std::pair<std::string, std::string>>
Parser::extractVariablesFromConstraints(
    const std::vector<std::string> &constraints) {
  std::vector<std::pair<std::string, std::string>> variables;
  LOG4("Extracting variables from constraints using regex matching");

  std::regex declFunRegex(R"(\(declare-fun\s+([^\s\)]+)\s+\(\)\s+([^\s\)]+))");
  std::regex declConstRegex(R"(\(declare-const\s+([^\s\)]+)\s+([^\s\)]+))");
  std::regex defConstRegex(R"(\(define-const\s+([^\s\)]+)\s+([^\s\)]+))");

  std::vector<std::regex> regexes = {declFunRegex, declConstRegex,
                                     defConstRegex};
  std::vector<std::string> types = {"declared function", "declared constant",
                                    "defined constant"};

  for (const auto &constraint : constraints) {
    for (size_t i = 0; i < regexes.size(); ++i) {
      std::sregex_iterator begin(constraint.begin(), constraint.end(),
                                 regexes[i]);
      std::sregex_iterator end;

      for (std::sregex_iterator it = begin; it != end; ++it) {
        std::string varName = (*it)[1].str();
        std::string varType = (*it)[2].str();
        if (!varName.empty() && !varType.empty()) {
          variables.push_back({varName, varType});
        }
      }
    }
  }

  LOG4("Extracted ", variables.size(), " variables from constraints");
  return variables;
}

std::vector<std::string>
Parser::extractVariablesAppeared(const std::vector<std::string> &constraints,
                                 const std::set<std::string> &allVars) {
  std::vector<std::string> appearedVars;
  LOG4("Extracting variables that appear in constraints from allVars set");

  for (const auto &var : allVars) {
    for (const auto &constraint : constraints) {
      if (constraint.find(var) != std::string::npos) {
        appearedVars.push_back(var);
        LOG5("Variable appeared in constraints: ", var);
        break;
      }
    }
  }

  LOG4("Found ", appearedVars.size(), " variables that appear in constraints");
  return appearedVars;
}

bool Parser::needConvert(const std::string &constraint,
                         const std::vector<std::pair<std::string, std::string>>
                             &variablesHasDefined) {
  std::regex defConstRegex(R"(\(define-const\s+([^\s\)]+)\s+([^\s\)]+))");

  std::smatch match;
  if (std::regex_search(constraint, match, defConstRegex)) {
    std::string varName = match[1].str();
    for (const auto &var : variablesHasDefined) {
      if (var.first == varName) {
        return true;
      }
    }
  }
  return false;
}

std::string Parser::convertDefineToAssert(const std::string &constraint) {
  std::regex defConstRegex(
      R"(\(define-const\s+([^\s\)]+)\s+([^\s\)]+)\s+(.+)\))");

  std::smatch match;
  if (std::regex_search(constraint, match, defConstRegex)) {
    std::string varName = match[1].str();
    std::string value = match[3].str();

    std::string result = "(assert (= " + varName + " " + value + "))";
    return result;
  }

  return constraint;
}

std::string Parser::getSplitSMTLIB2(const Decomposition &decomposition) {
  std::stringstream ss;

  ss << "(set-logic ALL)" << std::endl;
  LOG4("Added set-logic ALL");

  for (const auto &var : decomposition.variablesNeedDeclare) {
    ss << "(declare-fun " << var.first << " () " << var.second << ")"
       << std::endl;
    LOG5("Declared variable: ", var.first, " as ", var.second);
  }
  for (const auto &var : decomposition.variablesHasDefined) {
    ss << "(declare-fun " << var.first << " () " << var.second << ")"
       << std::endl;
    LOG5("Declared variable: ", var.first, " as ", var.second);
  }

  if (!decomposition.splitConstraints.empty()) {
    for (const auto &constraint : decomposition.splitConstraints) {
      if (needConvert(constraint, decomposition.variablesHasDefined)) {
        ss << convertDefineToAssert(constraint) << std::endl;
      } else {
        ss << constraint << std::endl;
      }
    }
    LOG4("Added split constraints (", decomposition.splitConstraints.size(),
         " items)");
  }

  ss << "(check-sat)" << std::endl;
  LOG4("Added check-sat");

  std::string result = ss.str();
  LOG3("Generated SMTLIB2 content: ", result.length(), " characters");
  LOG4("Generated SMTLIB2 content:");
  LOG4(result);
  return result;
}

bool Parser::needDelete(const std::string &constraint,
                        const Decomposition &decomposition) {
  if (isSplitRelated(constraint, decomposition.splitRelatedFunctionNames)) {
    return true;
  }

  std::regex declFunRegex(R"(\(declare-fun\s+([^\s\)]+)\s+\(\)\s+([^\s\)]+))");
  std::smatch match;
  if (std::regex_search(constraint, match, declFunRegex)) {
    std::string varName = match[1].str();
    for (const auto &var : decomposition.variablesNeedDeclare) {
      if (var.first == varName) {
        return true;
      }
    }
    for (const auto &var : decomposition.variablesHasDefined) {
      if (var.first == varName) {
        return true;
      }
    }
  }

  return false;
}

std::string Parser::getMergedSMTLIB2(const Decomposition &decomposition) {
  LOG2("Starting to merge SMTLIB2 content");

  std::string splitSMTLIB2 = getSMTLIB2(true);
  if (!needDecomposition) {
    return splitSMTLIB2;
  }
  std::vector<std::string> allConstraints = extractAllConstraints(splitSMTLIB2);
  std::vector<std::string> pureConstraints;
  for (const auto &constraint : allConstraints) {
    if (!needDelete(constraint, decomposition)) {
      pureConstraints.push_back(constraint);
    }
  }

  std::vector<std::string> mergedConstraints = decomposition.otherConstraints;
  for (const auto &var : decomposition.variablesHasDefined) {
    std::string declareStmt =
        "(declare-fun " + var.first + " () " + var.second + ")";
    bool varFound = false;

    for (size_t i = 0; i < mergedConstraints.size(); ++i) {
      if (mergedConstraints[i].find(var.first) != std::string::npos) {
        mergedConstraints.insert(mergedConstraints.begin() + i, declareStmt);
        varFound = true;
        LOG5("Inserted variable declaration for ", var.first, " at position ",
             i);
        break;
      }
    }

    if (!varFound) {
      bool insertedBeforeCheckSat = false;
      for (size_t i = 0; i < mergedConstraints.size(); ++i) {
        if (mergedConstraints[i].find("(check-sat") == 0) {
          mergedConstraints.insert(mergedConstraints.begin() + i, declareStmt);
          insertedBeforeCheckSat = true;
          LOG5("Inserted variable declaration for ", var.first,
               " before check-sat at position ", i);
          break;
        }
      }
      if (!insertedBeforeCheckSat) {
        mergedConstraints.push_back(declareStmt);
        LOG5("Appended variable declaration for ", var.first, " at end");
      }
    }
  }

  std::vector<std::string> pureDeclarations;
  std::vector<std::string> pureAssertions;

  for (const auto &constraint : pureConstraints) {
    if (constraint.find("(declare-") == 0 || constraint.find("(define-") == 0 ||
        constraint.find("(assert ") == 0) {
      if (constraint.find("(assert ") == 0) {
        pureAssertions.push_back(constraint);
      } else {
        pureDeclarations.push_back(constraint);
      }
    }
  }

  bool insertedBeforeCheckSat = false;
  for (size_t i = 0; i < mergedConstraints.size(); ++i) {
    if (mergedConstraints[i].find("(check-sat") == 0) {
      mergedConstraints.insert(mergedConstraints.begin() + i,
                               pureDeclarations.begin(),
                               pureDeclarations.end());
      mergedConstraints.insert(mergedConstraints.begin() + i +
                                   pureDeclarations.size(),
                               pureAssertions.begin(), pureAssertions.end());
      insertedBeforeCheckSat = true;
      LOG5("Inserted ", pureDeclarations.size(), " declarations and ",
           pureAssertions.size(), " assertions before check-sat");
      break;
    }
  }

  if (!insertedBeforeCheckSat) {
    mergedConstraints.insert(mergedConstraints.end(), pureDeclarations.begin(),
                             pureDeclarations.end());
    mergedConstraints.insert(mergedConstraints.end(), pureAssertions.begin(),
                             pureAssertions.end());
    LOG5("Appended ", pureDeclarations.size(), " declarations and ",
         pureAssertions.size(), " assertions at end");
  }

  std::stringstream result;
  for (const auto &constraint : mergedConstraints) {
    result << constraint << std::endl;
  }

  std::string merged = result.str();
  std::string processed = postProcessSMTLIB(merged);
  LOG2("Merged SMTLIB2 generation completed, total constraints: ",
       mergedConstraints.size());
  LOG4(processed);
  return processed;
}

TaskType Parser::parseTaskCommand(const std::string &command) {
  std::string cmd = command;
  if (cmd.front() == '(' && cmd.back() == ')') {
    cmd = cmd.substr(1, cmd.size() - 2);
  }

  if (cmd == "check-sat")
    return TaskType::CHECK_SAT;
  if (cmd == "get-model")
    return TaskType::GET_MODEL;
  if (cmd == "get-unsat-core")
    return TaskType::GET_UNSAT_CORE;
  if (cmd == "get-proof")
    return TaskType::GET_PROOF;
  if (cmd == "get-value")
    return TaskType::GET_VALUE;
  if (cmd == "get-assignment")
    return TaskType::GET_ASSIGNMENT;
  if (cmd == "get-info")
    return TaskType::GET_INFO;
  if (cmd == "get-option")
    return TaskType::GET_OPTION;
  if (cmd == "push")
    return TaskType::PUSH;
  if (cmd == "pop")
    return TaskType::POP;
  if (cmd == "reset")
    return TaskType::RESET;
  if (cmd == "exit")
    return TaskType::EXIT;

  throw std::invalid_argument("Unknown task command: " + command);
}

std::set<TaskType> Parser::getTask(const std::string &filename) const {
  std::set<TaskType> foundTasks;

  if (!std::filesystem::exists(filename)) {
    ERROR("File does not exist: ", filename);
    return foundTasks;
  }

  std::ifstream file(filename);
  if (!file.is_open()) {
    ERROR("Failed to open file: ", filename);
    return foundTasks;
  }

  std::string line;
  std::regex taskRegex(
      R"(\s*\(\s*(check-sat|get-model|get-unsat-core|get-proof|get-value|get-assignment|get-info|get-option|push|pop|reset|exit)\s*[\)\s])");

  while (std::getline(file, line)) {
    std::smatch match;
    if (std::regex_search(line, match, taskRegex)) {
      try {
        TaskType task = parseTaskCommand("(" + match[1].str() + ")");
        foundTasks.insert(task);
        DEBUG("Found task: ", match[1].str());
      } catch (const std::invalid_argument &) {
        continue;
      }
    }
  }

  file.close();
  return foundTasks;
}

std::vector<SMTParser::NodePtr> Parser::getVariables() {
  std::unordered_set<SMTParser::NodePtr> varSet;
  SMTParser.collectVars(SMTParser.assertions, varSet);
  std::vector<SMTParser::NodePtr> vars(varSet.begin(), varSet.end());
  return vars;
}

void Parser::declareStringVar(const std::string &name) {
  SMTParser.mkVarStr(name);
  DEBUG("Declared string variable: ", name);
}

void Parser::declareBoolVar(const std::string &name) {
  SMTParser.mkVarBool(name);
  DEBUG("Declared boolean variable: ", name);
}

void Parser::declareIntVar(const std::string &name) {
  SMTParser.mkVarInt(name);
  DEBUG("Declared integer variable: ", name);
}

void Parser::addAssertion(const std::string &constraint) {
#undef assert
  SMTParser.assert(constraint);
  DEBUG("Added assertion: ", constraint);
}

std::vector<SMTParser::NodePtr> Parser::getAssertions() {
  return SMTParser.assertions;
}

std::vector<SMTParser::NodePtr>
Parser::getAtoms(const SMTParser::NodePtr &node) {
  std::unordered_set<SMTParser::NodePtr> nodes;
  SMTParser.collectAtoms(node, nodes);
  std::vector<SMTParser::NodePtr> atoms(nodes.begin(), nodes.end());
  return atoms;
}

bool Parser::containsNode(const SMTParser::NodePtr &parent,
                          const SMTParser::NodePtr &target) {
  if (!parent || !target)
    return false;
  if (parent == target)
    return true;
  for (size_t i = 0; i < parent->getChildrenSize(); ++i) {
    if (containsNode(parent->getChild(i), target)) {
      return true;
    }
  }
  return false;
}

std::string Parser::getString(const SMTParser::NodePtr &node) {
  return SMTParser.toString(node);
}

std::string Parser::getSMTLIB2(bool from_parser) {
  if (from_parser) {
    return postProcessSMTLIB(SMTParser.dumpSMT2());
  } else {
    std::stringstream ss;
    ss << "(set-logic ALL)" << std::endl;
    std::vector<SMTParser::NodePtr> variables = getVariables();
    for (const auto &var : variables) {
      if (var) {
        ss << getString(var) << std::endl;
      }
    }
    std::vector<SMTParser::NodePtr> assertions = getAssertions();
    for (const auto &assertion : assertions) {
      ss << "(assert " << getString(assertion) << ")" << std::endl;
    }
    ss << "(check-sat)" << std::endl;
    return postProcessSMTLIB(ss.str());
  }
}

SMTParser::NodePtr Parser::replaceNodes(
    const SMTParser::NodePtr &expr,
    const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> &nodeMap) {
  if (!expr)
    return nullptr;

  auto it = nodeMap.find(expr);
  if (it != nodeMap.end()) {
    return it->second;
  }

  std::vector<SMTParser::NodePtr> newChildren;
  bool hasChanges = false;
  auto rebuildNode = [this](const SMTParser::NodePtr &original,
                            const std::vector<SMTParser::NodePtr> &children)
      -> SMTParser::NodePtr {
    if (!original) {
      return nullptr;
    }

    // Preserve names for function-related nodes while rebuilding them with
    // updated children.
    if (original->isFuncDef() || original->isFuncRec()) {
      std::vector<SMTParser::NodePtr> params;
      for (size_t i = 1; i < children.size(); ++i) {
        params.emplace_back(children[i]);
      }
      SMTParser::NodePtr body = children.empty() ? nullptr : children.front();
      if (!body) {
        body = original->getFuncBody();
      }
      auto outSort =
          body ? body->getSort() : original->getFuncBody()->getSort();
      original->updateFuncDef(outSort, body, params, original->isFuncRec());
      return original;
    }

    if (original->isFuncDec()) {
      std::vector<std::shared_ptr<SMTParser::Sort>> paramSorts;
      for (size_t i = 1; i < original->getChildrenSize(); ++i) {
        paramSorts.emplace_back(original->getChild(i)->getSort());
      }
      auto outSort = original->getChild(0)->getSort();
      return SMTParser.mkFuncDec(original->getName(), paramSorts, outSort);
    }

    if (original->isFuncApplication() || original->isFuncRecApplication()) {
      if (children.empty()) {
        return SMTParser.mkOper(original->getSort(), original->getKind(),
                                children);
      }
      SMTParser::NodePtr func = children.front();
      std::vector<SMTParser::NodePtr> args;
      for (size_t i = 1; i < children.size(); ++i) {
        args.emplace_back(children[i]);
      }
      original->updateApplyFunc(original->getSort(), func, args,
                                original->isFuncRecApplication());
      return original;
    }

    if (original->isUFApplication()) {
      return SMTParser.mkApplyUF(original->getSort(), original->getName(),
                                 children);
    }

    return SMTParser.mkOper(original->getSort(), original->getKind(), children);
  };

  for (size_t i = 0; i < expr->getChildrenSize(); ++i) {
    SMTParser::NodePtr child = expr->getChild(i);
    SMTParser::NodePtr newChild = replaceNodes(child, nodeMap);
    newChildren.push_back(newChild);
    if (newChild != child) {
      hasChanges = true;
    }
  }

  if (!hasChanges) {
    return expr;
  }

  return rebuildNode(expr, newChildren);
}

void Parser::replaceNodes(
    const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> &nodeMap) {
  for (size_t i = 0; i < SMTParser.assertions.size(); ++i) {
    SMTParser.assertions[i] = replaceNodes(SMTParser.assertions[i], nodeMap);
  }
}

SMTParser::NodePtr Parser::createNode(const std::string &node_str) {
  if (SMTParser.parseStr("(assert " + node_str + ")")) {
    if (!SMTParser.assertions.empty()) {
      return SMTParser.assertions.back();
    }
  }
  return nullptr;
}

SMTParser::NodePtr Parser::createStringConst(const std::string &value) {
  return SMTParser.mkConstStr(value);
}

SMTParser::NodePtr Parser::createIntConst(int value) {
  return SMTParser.mkConstInt(value);
}

SMTParser::NodePtr Parser::createBoolConst(bool value) {
  if (value) {
    return SMTParser.mkTrue();
  } else {
    return SMTParser.mkFalse();
  }
}

SMTParser::NodePtr Parser::createStringVar(const std::string &name) {
  auto var = SMTParser.getVariable(name);
  if (var) {
    return var;
  }

  std::string declareStmt = "(declare-fun " + name + " () String)";
  if (SMTParser.parseStr(declareStmt)) {
    var = SMTParser.getVariable(name);
    if (var) {
      DEBUG("Created new string variable: ", name);
      return var;
    }
  }

  WARN("Failed to create string variable: ", name);
  return nullptr;
}

SMTParser::NodePtr Parser::createIntVar(const std::string &name) {
  auto var = SMTParser.getVariable(name);
  if (var) {
    return var;
  }

  std::string declareStmt = "(declare-fun " + name + " () Int)";
  if (SMTParser.parseStr(declareStmt)) {
    var = SMTParser.getVariable(name);
    if (var) {
      DEBUG("Created new int variable: ", name);
      return var;
    }
  }

  WARN("Failed to create int variable: ", name);
  return nullptr;
}

SMTParser::NodePtr Parser::createBoolVar(const std::string &name) {
  auto var = SMTParser.getVariable(name);
  if (var) {
    return var;
  }

  std::string declareStmt = "(declare-fun " + name + " () Bool)";
  if (SMTParser.parseStr(declareStmt)) {
    var = SMTParser.getVariable(name);
    if (var) {
      DEBUG("Created new bool variable: ", name);
      return var;
    }
  }

  WARN("Failed to create bool variable: ", name);
  return nullptr;
}

} // namespace strp

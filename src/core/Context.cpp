// At the top of Context.cpp, ensure these includes are present:
#include "Context.h"
#include "Fallback.h"
#include "Split.h"
#include "Structures.h"
#include "utils/Config.h"
#include <algorithm>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <regex>
#include <sstream>
#include <unordered_set>

namespace {} // namespace

namespace strp {

Context &Context::getInstance() {
  static Context instance;
  return instance;
}

Context::Context() : logger(utils::Logger::getInstance()) {}

bool Context::parseFile(const std::string &filename) {
  clear();

  if (!parser.parseFile(filename, decomposition)) {
    ERROR("Failed to parse file: ", filename);
    currentFilename.clear();
    return false;
  }
  updateTasks(filename);
  currentFilename = filename;

  if (parser.isFallbackRequired()) {
    FallbackManager::getInstance().setFallbackRequired(
        true, parser.getFallbackReason(), parser.getRawContent());
    LOGGER.INFO("Switching to fallback processing: ",
                parser.getFallbackReason());
    return true;
  }

  updateDivisions();
  return true;
}

void Context::updateTasks(const std::string &filename) {
  tasks = parser.getTask(filename);
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes() {
  std::unordered_set<SMTParser::NodePtr> splitNodes;

  auto assertions = parser.getAssertions();
  for (const auto &assertion : assertions) {
    auto splitNodesInAssertion = getSplitAtNodes(assertion);
    for (const auto &node : splitNodesInAssertion) {
      splitNodes.insert(node);
    }
  }

  return std::vector<SMTParser::NodePtr>(splitNodes.begin(), splitNodes.end());
}

std::vector<SMTParser::NodePtr>
Context::getSplitAtNodes(const SMTParser::NodePtr &node) {
  std::unordered_set<SMTParser::NodePtr> splitNodes;

  std::function<void(const SMTParser::NodePtr &)> collectSplitNodes =
      [&](const SMTParser::NodePtr &node) {
        if (!node)
          return;
        if (node->isStrSplitAt() || node->isStrSplitAtRe()) {
          splitNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
          collectSplitNodes(node->getChild(i));
        }
      };

  collectSplitNodes(node);

  return std::vector<SMTParser::NodePtr>(splitNodes.begin(), splitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtConstNodes() {
  std::unordered_set<SMTParser::NodePtr> result;

  auto splitAtNodes = getSplitAtNodes();
  for (const auto &node : splitAtNodes) {
    if (node->getChildrenSize() >= 1) {
      auto arg1 = node->getChild(0);
      if (arg1->isConst()) {
        result.insert(node);
      }
    }
  }

  return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtVarNodes() {
  std::unordered_set<SMTParser::NodePtr> result;

  auto splitAtNodes = getSplitAtNodes();
  for (const auto &node : splitAtNodes) {
    if (node->getChildrenSize() >= 1) {
      auto arg1 = node->getChild(0);
      if (!arg1->isConst()) {
        result.insert(node);
      }
    }
  }

  return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestNodes() {
  std::unordered_set<SMTParser::NodePtr> splitEndNodes;

  auto assertions = parser.getAssertions();
  for (const auto &assertion : assertions) {
    auto splitEndNodesInAssertion = getSplitRestNodes(assertion);
    for (const auto &node : splitEndNodesInAssertion) {
      splitEndNodes.insert(node);
    }
  }

  return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(),
                                         splitEndNodes.end());
}

std::vector<SMTParser::NodePtr>
Context::getSplitRestNodes(const SMTParser::NodePtr &node) {
  std::unordered_set<SMTParser::NodePtr> splitEndNodes;

  std::function<void(const SMTParser::NodePtr &)> collectSplitEndNodes =
      [&](const SMTParser::NodePtr &node) {
        if (!node)
          return;
        if (node->isStrSplitRest() || node->isStrSplitRestRe()) {
          splitEndNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
          collectSplitEndNodes(node->getChild(i));
        }
      };

  collectSplitEndNodes(node);

  return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(),
                                         splitEndNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestConstNodes() {
  std::unordered_set<SMTParser::NodePtr> result;

  auto splitRestNodes = getSplitRestNodes();
  for (const auto &node : splitRestNodes) {
    if (node->getChildrenSize() >= 1) {
      auto arg1 = node->getChild(0);
      if (arg1->isConst()) {
        result.insert(node);
      }
    }
  }

  return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestVarNodes() {
  std::unordered_set<SMTParser::NodePtr> result;

  auto splitRestNodes = getSplitRestNodes();
  for (const auto &node : splitRestNodes) {
    if (node->getChildrenSize() >= 1) {
      auto arg1 = node->getChild(0);
      if (!arg1->isConst()) {
        result.insert(node);
      }
    }
  }

  return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitNodes() {
  std::unordered_set<SMTParser::NodePtr> numSplitNodes;

  auto assertions = parser.getAssertions();
  for (const auto &assertion : assertions) {
    auto numSplitNodesInAssertion = getNumSplitNodes(assertion);
    for (const auto &node : numSplitNodesInAssertion) {
      numSplitNodes.insert(node);
    }
  }

  return std::vector<SMTParser::NodePtr>(numSplitNodes.begin(),
                                         numSplitNodes.end());
}

std::vector<SMTParser::NodePtr>
Context::getNumSplitNodes(const SMTParser::NodePtr &node) {
  std::unordered_set<SMTParser::NodePtr> numSplitNodes;

  std::function<void(const SMTParser::NodePtr &)> collectNumSplitNodes =
      [&](const SMTParser::NodePtr &node) {
        if (!node)
          return;
        if (node->isStrNumSplits() || node->isStrNumSplitsRe()) {
          numSplitNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
          collectNumSplitNodes(node->getChild(i));
        }
      };

  collectNumSplitNodes(node);

  return std::vector<SMTParser::NodePtr>(numSplitNodes.begin(),
                                         numSplitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitConstNodes() {
  std::unordered_set<SMTParser::NodePtr> result;

  auto numSplitNodes = getNumSplitNodes();
  for (const auto &node : numSplitNodes) {
    if (node->getChildrenSize() >= 1) {
      auto arg1 = node->getChild(0);
      if (arg1->isConst()) {
        result.insert(node);
      }
    }
  }

  return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitVarNodes() {
  std::unordered_set<SMTParser::NodePtr> result;

  auto numSplitNodes = getNumSplitNodes();
  for (const auto &node : numSplitNodes) {
    if (node->getChildrenSize() >= 1) {
      auto arg1 = node->getChild(0);
      if (!arg1->isConst()) {
        result.insert(node);
      }
    }
  }

  return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

bool Context::isSplitAtConstNode(const SMTParser::NodePtr &node) {
  if (!node || !(node->isStrSplitAt() || node->isStrSplitAtRe())) {
    return false;
  }
  if (node->getChildrenSize() >= 1) {
    auto arg1 = node->getChild(0);
    return arg1->isConst();
  }
  return false;
}

bool Context::isSplitAtVarNode(const SMTParser::NodePtr &node) {
  if (!node || !(node->isStrSplitAt() || node->isStrSplitAtRe())) {
    return false;
  }
  if (node->getChildrenSize() >= 1) {
    auto arg1 = node->getChild(0);
    return arg1->isVar();
  }
  return false;
}

bool Context::isSplitRestConstNode(const SMTParser::NodePtr &node) {
  if (!node || !(node->isStrSplitRest() || node->isStrSplitRestRe())) {
    return false;
  }
  if (node->getChildrenSize() >= 1) {
    auto arg1 = node->getChild(0);
    return arg1->isConst();
  }
  return false;
}

bool Context::isSplitRestVarNode(const SMTParser::NodePtr &node) {
  if (!node || !(node->isStrSplitRest() || node->isStrSplitRestRe())) {
    return false;
  }
  if (node->getChildrenSize() >= 1) {
    auto arg1 = node->getChild(0);
    return arg1->isVar();
  }
  return false;
}

bool Context::isNumSplitConstNode(const SMTParser::NodePtr &node) {
  if (!node || !(node->isStrNumSplits() || node->isStrNumSplitsRe())) {
    return false;
  }
  if (node->getChildrenSize() >= 1) {
    auto arg1 = node->getChild(0);
    return arg1->isConst();
  }
  return false;
}

bool Context::isNumSplitVarNode(const SMTParser::NodePtr &node) {
  if (!node || !(node->isStrNumSplits() || node->isStrNumSplitsRe())) {
    return false;
  }
  if (node->getChildrenSize() >= 1) {
    auto arg1 = node->getChild(0);
    return arg1->isVar();
  }
  return false;
}

bool Context::hasTask(TaskType taskType) const {
  return tasks.find(taskType) != tasks.end();
}

std::set<TaskType> Context::getAllTasks() const { return tasks; }

void Context::clearTasks() { tasks.clear(); }

void Context::clearDivisions() {
  divisions.clear();
  divisionNodes.clear();
  nodeToVar.clear();
  varList.clear();
}

void Context::clearSplitNodeToAtoms() { splitNodeToAtoms.clear(); }

void Context::clear() {
  clearTasks();
  clearDivisions();
  clearSplitNodeToAtoms();
}

std::string Context::getVarName(const SMTParser::NodePtr &node) {
  std::string hash = std::to_string(node->hashCode());
  return "var_" + hash;
}

void Context::addDivision(std::unique_ptr<Division> division) {
  std::string key =
      Division::generateKey(division->getDivided(), division->getDelimiter());
  divisions[key] = std::move(division);
}

Division *Context::getDivision(const std::string &divided,
                               const std::string &delimiter) {
  std::string key = Division::generateKey(divided, delimiter);
  auto it = divisions.find(key);
  if (it != divisions.end()) {
    return it->second.get();
  }
  return nullptr;
}

bool Context::hasDivision(const std::string &divided,
                          const std::string &delimiter) const {
  std::string key = Division::generateKey(divided, delimiter);
  return divisions.find(key) != divisions.end();
}

bool Context::isDelimiterStringType(const std::string &delimiter) {
  if (delimiter.empty()) {
    return true;
  }
  if (delimiter[0] == '(') {
    return false;
  }
  return true;
}

bool Context::matchesDivision(const SMTParser::NodePtr &node,
                              const std::string &variable,
                              const std::string &delimiter) {
  if (!node || node->getChildrenSize() < 2) {
    return false;
  }
  auto arg1 = node->getChild(0);
  if (parser.getString(arg1) != variable) {
    return false;
  }
  std::string nodeDelimiter = parser.getString(node->getChild(1));
  bool match = (nodeDelimiter == delimiter);
  return match;
}

std::vector<SMTParser::NodePtr>
Context::getDivisionNodes(const std::string &divided,
                          const std::string &delimiter) const {
  std::string key = Division::generateKey(divided, delimiter);
  auto it = divisionNodes.find(key);
  if (it != divisionNodes.end()) {
    return it->second;
  }
  return std::vector<SMTParser::NodePtr>();
}

const std::unordered_map<std::string, std::unique_ptr<Division>> &
Context::getAllDivisions() const {
  return divisions;
}

void Context::updateDivisions() {
  DEBUG("Updating divisions from split nodes");

  auto splitAtConstNodes = getSplitAtConstNodes();
  auto splitRestConstNodes = getSplitRestConstNodes();
  auto numSplitConstNodes = getNumSplitConstNodes();
  auto splitAtVarNodes = getSplitAtVarNodes();
  auto splitRestVarNodes = getSplitRestVarNodes();
  auto numSplitVarNodes = getNumSplitVarNodes();

  for (auto &node : splitAtConstNodes) {
    try {
      if (node->getChildrenSize() >= 2) {
        auto arg1 = node->getChild(0);

        std::string divided = parser.getString(arg1);
        if (divided.size() >= 2 && divided.front() == '"' &&
            divided.back() == '"') {
          divided = divided.substr(1, divided.size() - 2);
        }

        std::string delimiter = parser.getString(node->getChild(1));
        if (isDelimiterStringType(delimiter)) {
          delimiter = Parser::normalizeStringLiteral(delimiter);
        }
        if (!hasDivision(divided, delimiter)) {
          addDivision(std::make_unique<ConstDivision>(divided, delimiter));
          std::string key = Division::generateKey(divided, delimiter);
          divisionNodes[key].push_back(node);
          DEBUG("Created new const division for: '", divided,
                "' with delimiter regex: ", delimiter);
        } else {
          std::string key = Division::generateKey(divided, delimiter);
          divisionNodes[key].push_back(node);
        }
      }
    } catch (const std::exception &e) {
      DEBUG("Error processing const split node: ", e.what());
    }
  }

  for (auto &node : splitRestConstNodes) {
    try {
      if (node->getChildrenSize() >= 3) {
        auto arg1 = node->getChild(0);
        auto arg3 = node->getChild(2);

        std::string divided = parser.getString(arg1);
        if (divided.size() >= 2 && divided.front() == '"' &&
            divided.back() == '"') {
          divided = divided.substr(1, divided.size() - 2);
        }

        std::string delimiter = parser.getString(node->getChild(1));
        if (isDelimiterStringType(delimiter)) {
          delimiter = Parser::normalizeStringLiteral(delimiter);
        }
        int index = parseInteger(parser.getString(arg3));

        if (!hasDivision(divided, delimiter)) {
          addDivision(std::make_unique<ConstDivision>(divided, delimiter));
          std::string key = Division::generateKey(divided, delimiter);
          divisionNodes[key].push_back(node);
          DEBUG("Created new const division for split_rest: '", divided,
                "' with delimiter regex: ", delimiter);
        } else {
          std::string key = Division::generateKey(divided, delimiter);
          divisionNodes[key].push_back(node);
        }

        Division *division = getDivision(divided, delimiter);
        if (division && division->isConstType()) {
          ConstDivision *constDiv = static_cast<ConstDivision *>(division);
          constDiv->setHasSplitNum(true);
          DEBUG("Marked split_rest usage for const division '", divided,
                "' at index ", index);
        }
      }
    } catch (const std::exception &e) {
      DEBUG("Error processing const split_rest node: ", e.what());
    }
  }

  for (auto &node : splitAtVarNodes) {
    try {
      if (node->getChildrenSize() >= 3) {
        auto arg1 = node->getChild(0);
        auto arg3 = node->getChild(2);

        std::string variable;
        if (arg1->isVar()) {
          variable = parser.getString(arg1);
        } else {
          if (nodeToVar.find(arg1) == nodeToVar.end()) {
            nodeToVar[arg1] = getVarName(arg1);
          }
          variable = nodeToVar[arg1];
        }
        std::string delimiter = parser.getString(node->getChild(1));
        if (isDelimiterStringType(delimiter)) {
          delimiter = Parser::normalizeStringLiteral(delimiter);
        }
        int index = parseInteger(parser.getString(arg3));

        Division *division = getDivision(variable, delimiter);
        if (!division) {
          addDivision(std::make_unique<VarDivision>(variable, delimiter));
          division = getDivision(variable, delimiter);
          std::string key = Division::generateKey(variable, delimiter);
          divisionNodes[key].push_back(node);
          DEBUG("Created new var division for: '", variable,
                "' with delimiter regex: ", delimiter);
        } else {
          std::string key = Division::generateKey(variable, delimiter);
          divisionNodes[key].push_back(node);
        }

        if (division && division->isVarType()) {
          VarDivision *varDiv = static_cast<VarDivision *>(division);
          varDiv->addSplitAtNumAppeared(index);
          DEBUG("Added split index ", index, " for variable '", variable, "'");
        }
      }
    } catch (const std::exception &e) {
      DEBUG("Error processing var split node: ", e.what());
    }
  }

  for (auto &node : splitRestVarNodes) {
    try {
      if (node->getChildrenSize() >= 3) {
        auto arg1 = node->getChild(0);
        auto arg3 = node->getChild(2);

        std::string variable;
        if (arg1->isVar()) {
          variable = parser.getString(arg1);
        } else {
          if (nodeToVar.find(arg1) == nodeToVar.end()) {
            nodeToVar[arg1] = getVarName(arg1);
          }
          variable = nodeToVar[arg1];
        }
        std::string delimiter = parser.getString(node->getChild(1));
        if (isDelimiterStringType(delimiter)) {
          delimiter = Parser::normalizeStringLiteral(delimiter);
        }
        int index = parseInteger(parser.getString(arg3));

        Division *division = getDivision(variable, delimiter);
        if (!division) {
          addDivision(std::make_unique<VarDivision>(variable, delimiter));
          division = getDivision(variable, delimiter);
          std::string key = Division::generateKey(variable, delimiter);
          divisionNodes[key].push_back(node);
          DEBUG("Created new var division for split_rest: '", variable,
                "' with delimiter regex: ", delimiter);
        } else {
          std::string key = Division::generateKey(variable, delimiter);
          divisionNodes[key].push_back(node);
        }

        if (division && division->isVarType()) {
          VarDivision *varDiv = static_cast<VarDivision *>(division);
          varDiv->addSplitRestNumAppeared(index);
          DEBUG("Added split_rest index ", index, " for variable '", variable,
                "'");
        }
      }
    } catch (const std::exception &e) {
      DEBUG("Error processing var split_rest node: ", e.what());
    }
  }

  for (auto &node : numSplitConstNodes) {
    try {
      if (node->getChildrenSize() >= 2) {
        auto arg1 = node->getChild(0);

        std::string divided = parser.getString(arg1);
        if (divided.size() >= 2 && divided.front() == '"' &&
            divided.back() == '"') {
          divided = divided.substr(1, divided.size() - 2);
        }

        std::string delimiter = parser.getString(node->getChild(1));
        if (isDelimiterStringType(delimiter)) {
          delimiter = Parser::normalizeStringLiteral(delimiter);
        }

        if (!hasDivision(divided, delimiter)) {
          addDivision(std::make_unique<ConstDivision>(divided, delimiter));
          std::string key = Division::generateKey(divided, delimiter);
          divisionNodes[key].push_back(node);
          DEBUG("Created new const division for num_splits: '", divided,
                "' with delimiter regex: ", delimiter);
        } else {
          std::string key = Division::generateKey(divided, delimiter);
          divisionNodes[key].push_back(node);
        }

        Division *division = getDivision(divided, delimiter);
        if (division && division->isConstType()) {
          ConstDivision *constDiv = static_cast<ConstDivision *>(division);
          constDiv->setHasSplitNum(true);
          DEBUG("Marked num_splits usage for const division '", divided, "'");
        }
      }
    } catch (const std::exception &e) {
      DEBUG("Error processing const num_splits node: ", e.what());
    }
  }

  for (auto &node : numSplitVarNodes) {
    try {
      if (node->getChildrenSize() >= 2) {
        auto arg1 = node->getChild(0);

        std::string variable;
        if (arg1->isVar()) {
          variable = parser.getString(arg1);
        } else {
          if (nodeToVar.find(arg1) == nodeToVar.end()) {
            nodeToVar[arg1] = getVarName(arg1);
          }
          variable = nodeToVar[arg1];
        }
        std::string delimiter = parser.getString(node->getChild(1));
        if (isDelimiterStringType(delimiter)) {
          delimiter = Parser::normalizeStringLiteral(delimiter);
        }
        Division *division = getDivision(variable, delimiter);

        if (!division) {
          addDivision(std::make_unique<VarDivision>(variable, delimiter));
          division = getDivision(variable, delimiter);
          std::string key = Division::generateKey(variable, delimiter);
          divisionNodes[key].push_back(node);
          DEBUG("Created new var division for num_splits: '", variable,
                "' with delimiter regex: ", delimiter);
        } else {
          std::string key = Division::generateKey(variable, delimiter);
          divisionNodes[key].push_back(node);
        }

        if (division) {
          division->setNumSplitsUsed(true);
          DEBUG("Marked num_splits usage for variable '", variable, "'");
        }
      }
    } catch (const std::exception &e) {
      DEBUG("Error processing var num_splits node: ", e.what());
    }
  }

  updateSplitNodeWithVar();
  updateSplitNodeToAtoms();
}

void Context::updateSplitNodeWithVar() {
  if (nodeToVar.empty()) {
    return;
  }

  std::unordered_set<std::string> processed(varList.begin(), varList.end());
  std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr> replacements;
  std::vector<std::pair<std::string, std::string>> pendingEqualities;

  for (const auto &entry : nodeToVar) {
    const SMTParser::NodePtr &node = entry.first;
    const std::string &varName = entry.second;

    if (!node) {
      continue;
    }

    parser.declareStringVar(varName);
    SMTParser::NodePtr varNode = parser.createStringVar(varName);
    if (!varNode) {
      continue;
    }

    if (processed.insert(varName).second) {
      varList.push_back(varName);
      pendingEqualities.emplace_back(varName, parser.getString(node));
    }

    replacements[node] = varNode;
  }

  if (!replacements.empty()) {
    parser.replaceNodes(replacements);
  }

  for (const auto &equality : pendingEqualities) {
    const std::string &varName = equality.first;
    const std::string &nodeStr = equality.second;
    std::string assertion = "(= " + varName + " " + nodeStr + ")";
    assertion = Parser::postProcessSMTLIB(assertion);
    parser.addAssertion(assertion);
  }
}

void Context::updateSplitNodeToAtoms() {
  clearSplitNodeToAtoms();

  auto assertions = parser.getAssertions();
  std::unordered_set<SMTParser::NodePtr> allAtoms;
  auto allSplitNodes = getSplitAtNodes();
  auto allSplitRestNodes = getSplitRestNodes();
  auto allNumSplitNodes = getNumSplitNodes();

  for (auto &assertion : assertions) {
    auto atomsInAssertion = parser.getAtoms(assertion);
    allAtoms.insert(atomsInAssertion.begin(), atomsInAssertion.end());
  }

  for (auto &splitNode : allSplitNodes) {
    std::unordered_set<SMTParser::NodePtr> relatedAtoms;

    for (auto &atom : allAtoms) {
      if (Parser::containsNode(atom, splitNode)) {
        relatedAtoms.insert(atom);
      }
    }

    if (!relatedAtoms.empty()) {
      splitNodeToAtoms[splitNode] = relatedAtoms;
    }
  }

  for (auto &splitRestNode : allSplitRestNodes) {
    std::unordered_set<SMTParser::NodePtr> relatedAtoms;

    for (auto &atom : allAtoms) {
      if (Parser::containsNode(atom, splitRestNode)) {
        relatedAtoms.insert(atom);
      }
    }

    if (!relatedAtoms.empty()) {
      splitNodeToAtoms[splitRestNode] = relatedAtoms;
    }
  }

  for (auto &numSplitNode : allNumSplitNodes) {
    std::unordered_set<SMTParser::NodePtr> relatedAtoms;

    for (auto &atom : allAtoms) {
      if (Parser::containsNode(atom, numSplitNode)) {
        relatedAtoms.insert(atom);
      }
    }

    if (!relatedAtoms.empty()) {
      splitNodeToAtoms[numSplitNode] = relatedAtoms;
    }
  }

  DEBUG("Updated split node to atoms mapping with ", splitNodeToAtoms.size(),
        " entries");
}

std::unordered_set<SMTParser::NodePtr>
Context::getAtomsForSplitNode(const SMTParser::NodePtr &splitNode) const {
  auto it = splitNodeToAtoms.find(splitNode);
  if (it != splitNodeToAtoms.end()) {
    return it->second;
  }
  return std::unordered_set<SMTParser::NodePtr>();
}

std::string Context::getFormula() {
  DEBUG("Getting formula");
  return parser.getMergedSMTLIB2(decomposition);
}

// executeFallback moved to FallbackManager

bool Context::reloadCurrentFile() {
  if (currentFilename.empty()) {
    ERROR("No previously loaded SMT-LIB file to reload");
    return false;
  }
  INFO("Reloading original SMT-LIB file: ", currentFilename);
  return parseFile(currentFilename);
}

} // namespace strp

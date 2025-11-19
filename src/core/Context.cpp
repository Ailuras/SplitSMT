// At the top of Context.cpp, ensure these includes are present:
#include "Context.h"
#include "Structures.h"
#include "Split.h"
#include "utils/Config.h"
#include <sstream>
#include <fstream>
#include <filesystem>
#include <regex>
#include <chrono>
#include <algorithm>
#include <iterator>
#include <unordered_set>

namespace {
const std::string& loadFallbackDefinitions() {
    static std::string definitions;
    static bool loaded = false;
    if (!loaded) {
        loaded = true;
        try {
            auto path = strp::config::projectRoot() / "src" / "utils" / "RA.txt";
            std::ifstream file(path);
            if (!file.is_open()) {
                LOGGER.ERROR("Failed to open fallback definition file: ", path.string());
            } else {
                std::stringstream buffer;
                buffer << file.rdbuf();
                definitions = buffer.str();
                LOGGER.DEBUG("Loaded fallback split definitions from ", path.string());
            }
        } catch (const std::exception& e) {
            LOGGER.ERROR("Error loading fallback definition file: ", e.what());
        }
    }
    return definitions;
}

std::string ensureFallbackLogic(const std::string& formula) {
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

std::string rewriteSplitFunctions(const std::string& formula) {
    std::string result = formula;
    const std::vector<std::pair<std::string, std::string>> replacements = {
        {"(str.split_at", "(split_at"},
        {"(str.split_rest", "(split_rest"},
        {"(str.num_splits", "(num_splits"},
        {"(str.split_at_re", "(split_at_re"},
        {"(str.split_rest_re", "(split_rest_re"},
        {"(str.num_splits_re", "(num_splits_re"}
    };

    for (const auto& repl : replacements) {
        size_t pos = 0;
        while ((pos = result.find(repl.first, pos)) != std::string::npos) {
            result.replace(pos, repl.first.size(), repl.second);
            pos += repl.second.size();
        }
    }
    return result;
}

std::string injectFallbackDefinitions(const std::string& formula) {
    const std::string& definitions = loadFallbackDefinitions();
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
        size_t nextPos = (lineEnd == std::string::npos) ? formula.size() : lineEnd + 1;
        std::string_view line(formula.c_str() + pos,
                              (lineEnd == std::string::npos ? formula.size() : lineEnd) - pos);
        std::string trimmed(line);
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        if (!trimmed.empty() && (trimmed.rfind("(declare", 0) == 0 || trimmed.rfind("(define", 0) == 0 || trimmed.rfind("(assert", 0) == 0)) {
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

std::string buildFallbackFormula(const std::string& raw) {
    std::string formula = ensureFallbackLogic(raw);
    formula = rewriteSplitFunctions(formula);
    formula = injectFallbackDefinitions(formula);
    return formula;
}

std::string solverName(strp::SolverType type) {
    switch (type) {
        case strp::SolverType::Z3: return "Z3";
        case strp::SolverType::CVC5: return "CVC5";
        case strp::SolverType::OSTRICH: return "Ostrich";
        case strp::SolverType::Z3_NOODLER: return "Z3-Noodler";
        default: return "Unknown";
    }
}

bool solverExecutableExists(strp::SolverType type) {
    using namespace strp::config;
    std::filesystem::path script;
    switch (type) {
        case strp::SolverType::Z3:
            script = projectRoot() / "solvers" / "z3" / "run.sh";
            break;
        case strp::SolverType::CVC5:
            script = projectRoot() / "solvers" / "cvc5" / "run.sh";
            break;
        case strp::SolverType::OSTRICH:
            script = projectRoot() / "solvers" / "ostrich" / "run.sh";
            break;
        case strp::SolverType::Z3_NOODLER:
            script = projectRoot() / "solvers" / "z3-noodler" / "run.sh";
            break;
        default:
            return false;
    }
    return std::filesystem::exists(script);
}

} // namespace

namespace strp {

Context& Context::getInstance() {
    static Context instance;
    return instance;
}

Context::Context() : logger(utils::Logger::getInstance()) {}

bool Context::parseFile(const std::string& filename) {
    clear();
    
    if (!parser.parseFile(filename, decomposition)) {
        ERROR("Failed to parse file: ", filename);
        currentFilename.clear();
        return false;
    }
    updateTasks(filename);
    currentFilename = filename;

    if (parser.isFallbackRequired()) {
        fallbackRequired = true;
        fallbackReason = parser.getFallbackReason();
        fallbackRawInput = parser.getRawContent();
        fallbackFormulaPrepared = false;
        LOGGER.INFO("Switching to fallback processing: ", fallbackReason);
        return true;
    }

    updateDivisions();
    return true;
}

void Context::updateTasks(const std::string& filename) {
    tasks = parser.getTask(filename);
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes() {
    std::unordered_set<SMTParser::NodePtr> splitNodes;
    
    auto assertions = parser.getAssertions();
    for (const auto& assertion : assertions) {
        auto splitNodesInAssertion = getSplitAtNodes(assertion);
        for (const auto& node : splitNodesInAssertion) {
            splitNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitNodes.begin(), splitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitAtNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> splitNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
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
    for (const auto& node : splitAtNodes) {
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
    for (const auto& node : splitAtNodes) {
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
    for (const auto& assertion : assertions) {
        auto splitEndNodesInAssertion = getSplitRestNodes(assertion);
        for (const auto& node : splitEndNodesInAssertion) {
            splitEndNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(), splitEndNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> splitEndNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectSplitEndNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrSplitRest() || node->isStrSplitRestRe()) {
            splitEndNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectSplitEndNodes(node->getChild(i));
        }
    };
    
    collectSplitEndNodes(node);
    
    return std::vector<SMTParser::NodePtr>(splitEndNodes.begin(), splitEndNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getSplitRestConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto splitRestNodes = getSplitRestNodes();
    for (const auto& node : splitRestNodes) {
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
    for (const auto& node : splitRestNodes) {
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
    for (const auto& assertion : assertions) {
        auto numSplitNodesInAssertion = getNumSplitNodes(assertion);
        for (const auto& node : numSplitNodesInAssertion) {
            numSplitNodes.insert(node);
        }
    }
    
    return std::vector<SMTParser::NodePtr>(numSplitNodes.begin(), numSplitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitNodes(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> numSplitNodes;
    
    std::function<void(const SMTParser::NodePtr&)> collectNumSplitNodes = [&](const SMTParser::NodePtr& node) {
        if (!node) return;
        if (node->isStrNumSplits() || node->isStrNumSplitsRe()) {
            numSplitNodes.insert(node);
        }
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            collectNumSplitNodes(node->getChild(i));
        }
    };
    
    collectNumSplitNodes(node);
    
    return std::vector<SMTParser::NodePtr>(numSplitNodes.begin(), numSplitNodes.end());
}

std::vector<SMTParser::NodePtr> Context::getNumSplitConstNodes() {
    std::unordered_set<SMTParser::NodePtr> result;
    
    auto numSplitNodes = getNumSplitNodes();
    for (const auto& node : numSplitNodes) {
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
    for (const auto& node : numSplitNodes) {
        if (node->getChildrenSize() >= 1) {
            auto arg1 = node->getChild(0);
            if (!arg1->isConst()) {
                result.insert(node);
            }
        }
    }
    
    return std::vector<SMTParser::NodePtr>(result.begin(), result.end());
}

bool Context::isSplitAtConstNode(const SMTParser::NodePtr& node) {
    if (!node || !(node->isStrSplitAt() || node->isStrSplitAtRe())) {
        return false;
    }
    if (node->getChildrenSize() >= 1) {
        auto arg1 = node->getChild(0);
        return arg1->isConst();
    }
    return false;
}

bool Context::isSplitAtVarNode(const SMTParser::NodePtr& node) {
    if (!node || !(node->isStrSplitAt() || node->isStrSplitAtRe())) {
        return false;
    }
    if (node->getChildrenSize() >= 1) {
        auto arg1 = node->getChild(0);
        return arg1->isVar();
    }
    return false;
}

bool Context::isSplitRestConstNode(const SMTParser::NodePtr& node) {
    if (!node || !(node->isStrSplitRest() || node->isStrSplitRestRe())) {
        return false;
    }
    if (node->getChildrenSize() >= 1) {
        auto arg1 = node->getChild(0);
        return arg1->isConst();
    }
    return false;
}

bool Context::isSplitRestVarNode(const SMTParser::NodePtr& node) {
    if (!node || !(node->isStrSplitRest() || node->isStrSplitRestRe())) {
        return false;
    }
    if (node->getChildrenSize() >= 1) {
        auto arg1 = node->getChild(0);
        return arg1->isVar();
    }
    return false;
}

bool Context::isNumSplitConstNode(const SMTParser::NodePtr& node) {
    if (!node || !(node->isStrNumSplits() || node->isStrNumSplitsRe())) {
        return false;
    }
    if (node->getChildrenSize() >= 1) {
        auto arg1 = node->getChild(0);
        return arg1->isConst();
    }
    return false;
}

bool Context::isNumSplitVarNode(const SMTParser::NodePtr& node) {
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

std::set<TaskType> Context::getAllTasks() const {
    return tasks;
}

void Context::clearTasks() {
    tasks.clear();
}

void Context::clearDivisions() {
    divisions.clear();
    divisionNodes.clear();
    nodeToVar.clear();
    varList.clear();
}

void Context::clearSplitNodeToAtoms() {
    splitNodeToAtoms.clear();
}

void Context::clear() {
    clearTasks();
    clearDivisions();
    clearSplitNodeToAtoms();
    fallbackRequired = false;
    fallbackReason.clear();
    fallbackRawInput.clear();
    fallbackFormulaPrepared = false;
    fallbackPreparedFormula.clear();
}

std::string Context::getVarName(const SMTParser::NodePtr& node) {
    std::string hash = std::to_string(node->hashCode());
    return "var_" + hash;
}

void Context::addDivision(std::unique_ptr<Division> division) {
    std::string key = Division::generateKey(division->getDivided(), division->getDelimiter());
    divisions[key] = std::move(division);
}

Division* Context::getDivision(const std::string& divided, const std::string& delimiter) {
    std::string key = Division::generateKey(divided, delimiter);
    auto it = divisions.find(key);
    if (it != divisions.end()) {
        return it->second.get();
    }
    return nullptr;
}

bool Context::hasDivision(const std::string& divided, const std::string& delimiter) const {
    std::string key = Division::generateKey(divided, delimiter);
    return divisions.find(key) != divisions.end();
}

bool Context::isDelimiterStringType(const std::string& delimiter) {
    if (delimiter.empty()) {
        return true;
    }
    if (delimiter[0] == '(') {
        return false;
    }
    return true;
}

bool Context::matchesDivision(const SMTParser::NodePtr& node, const std::string& variable, const std::string& delimiter) {
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

std::vector<SMTParser::NodePtr> Context::getDivisionNodes(const std::string& divided, const std::string& delimiter) const {
    std::string key = Division::generateKey(divided, delimiter);
    auto it = divisionNodes.find(key);
    if (it != divisionNodes.end()) {
        return it->second;
    }
    return std::vector<SMTParser::NodePtr>();
}

const std::unordered_map<std::string, std::unique_ptr<Division>>& Context::getAllDivisions() const {
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
    
    for (auto& node : splitAtConstNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                
                std::string divided = parser.getString(arg1);
                if (divided.size() >= 2 && divided.front() == '"' && divided.back() == '"') {
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
                    DEBUG("Created new const division for: '", divided, "' with delimiter regex: ", delimiter);
                } else {
                    std::string key = Division::generateKey(divided, delimiter);
                    divisionNodes[key].push_back(node);
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const split node: ", e.what());
        }
    }
    
    for (auto& node : splitRestConstNodes) {
        try {
            if (node->getChildrenSize() >= 3) {
                auto arg1 = node->getChild(0);
                auto arg3 = node->getChild(2);
                
                std::string divided = parser.getString(arg1);
                if (divided.size() >= 2 && divided.front() == '"' && divided.back() == '"') {
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
                    DEBUG("Created new const division for split_rest: '", divided, "' with delimiter regex: ", delimiter);
                } else {
                    std::string key = Division::generateKey(divided, delimiter);
                    divisionNodes[key].push_back(node);
                }
                
                Division* division = getDivision(divided, delimiter);
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    constDiv->setHasSplitNum(true);
                    DEBUG("Marked split_rest usage for const division '", divided, "' at index ", index);
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const split_rest node: ", e.what());
        }
    }
    
    for (auto& node : splitAtVarNodes) {
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
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    std::string key = Division::generateKey(variable, delimiter);
                    divisionNodes[key].push_back(node);
                    DEBUG("Created new var division for: '", variable, "' with delimiter regex: ", delimiter);
                } else {
                    std::string key = Division::generateKey(variable, delimiter);
                    divisionNodes[key].push_back(node);
                }
                
                if (division && division->isVarType()) {
                    VarDivision* varDiv = static_cast<VarDivision*>(division);
                    varDiv->addSplitAtNumAppeared(index);
                    DEBUG("Added split index ", index, " for variable '", variable, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split node: ", e.what());
        }
    }
    
    for (auto& node : splitRestVarNodes) {
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
                
                Division* division = getDivision(variable, delimiter);
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    std::string key = Division::generateKey(variable, delimiter);
                    divisionNodes[key].push_back(node);
                    DEBUG("Created new var division for split_rest: '", variable, "' with delimiter regex: ", delimiter);
                } else {
                    std::string key = Division::generateKey(variable, delimiter);
                    divisionNodes[key].push_back(node);
                }
                
                if (division && division->isVarType()) {
                    VarDivision* varDiv = static_cast<VarDivision*>(division);
                    varDiv->addSplitRestNumAppeared(index);
                    DEBUG("Added split_rest index ", index, " for variable '", variable, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing var split_rest node: ", e.what());
        }
    }
    
    for (auto& node : numSplitConstNodes) {
        try {
            if (node->getChildrenSize() >= 2) {
                auto arg1 = node->getChild(0);
                
                std::string divided = parser.getString(arg1);
                if (divided.size() >= 2 && divided.front() == '"' && divided.back() == '"') {
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
                    DEBUG("Created new const division for num_splits: '", divided, "' with delimiter regex: ", delimiter);
                } else {
                    std::string key = Division::generateKey(divided, delimiter);
                    divisionNodes[key].push_back(node);
                }
                
                Division* division = getDivision(divided, delimiter);
                if (division && division->isConstType()) {
                    ConstDivision* constDiv = static_cast<ConstDivision*>(division);
                    constDiv->setHasSplitNum(true);
                    DEBUG("Marked num_splits usage for const division '", divided, "'");
                }
            }
        } catch (const std::exception& e) {
            DEBUG("Error processing const num_splits node: ", e.what());
        }
    }
    
    for (auto& node : numSplitVarNodes) {
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
                Division* division = getDivision(variable, delimiter);
                
                if (!division) {
                    addDivision(std::make_unique<VarDivision>(variable, delimiter));
                    division = getDivision(variable, delimiter);
                    std::string key = Division::generateKey(variable, delimiter);
                    divisionNodes[key].push_back(node);
                    DEBUG("Created new var division for num_splits: '", variable, "' with delimiter regex: ", delimiter);
                } else {
                    std::string key = Division::generateKey(variable, delimiter);
                    divisionNodes[key].push_back(node);
                }
                
                if (division) {
                    division->setNumSplitsUsed(true);
                    DEBUG("Marked num_splits usage for variable '", variable, "'");
                }
            }
        } catch (const std::exception& e) {
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
    
    for (const auto& entry : nodeToVar) {
        const SMTParser::NodePtr& node = entry.first;
        const std::string& varName = entry.second;
        
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
    
    for (const auto& equality : pendingEqualities) {
        const std::string& varName = equality.first;
        const std::string& nodeStr = equality.second;
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
    
    for (auto& assertion : assertions) {
        auto atomsInAssertion = parser.getAtoms(assertion);
        allAtoms.insert(atomsInAssertion.begin(), atomsInAssertion.end());
    }
    
    for (auto& splitNode : allSplitNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitNode] = relatedAtoms;
        }
    }
    
    for (auto& splitRestNode : allSplitRestNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, splitRestNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[splitRestNode] = relatedAtoms;
        }
    }
    
    for (auto& numSplitNode : allNumSplitNodes) {
        std::unordered_set<SMTParser::NodePtr> relatedAtoms;
        
        for (auto& atom : allAtoms) {
            if (Parser::containsNode(atom, numSplitNode)) {
                relatedAtoms.insert(atom);
            }
        }
        
        if (!relatedAtoms.empty()) {
            splitNodeToAtoms[numSplitNode] = relatedAtoms;
        }
    }
    
    DEBUG("Updated split node to atoms mapping with ", splitNodeToAtoms.size(), " entries");
}

std::unordered_set<SMTParser::NodePtr> Context::getAtomsForSplitNode(const SMTParser::NodePtr& splitNode) const {
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

SatResult Context::executeFallback(SolverType preferredSolverType) {
    if (!fallbackRequired) {
        ERROR("Fallback requested but no fallback condition was detected");
        return SatResult::ERROR;
    }

    if (!fallbackFormulaPrepared) {
        if (fallbackRawInput.empty()) {
            ERROR("Fallback raw input is empty; cannot proceed");
            return SatResult::ERROR;
        }
        fallbackPreparedFormula = buildFallbackFormula(fallbackRawInput);
        fallbackFormulaPrepared = true;
    }

    std::vector<SolverType> candidates;
    auto addCandidate = [&](SolverType type) {
        if (std::find(candidates.begin(), candidates.end(), type) == candidates.end()) {
            candidates.push_back(type);
        }
    };

    addCandidate(preferredSolverType);
    if (preferredSolverType != SolverType::Z3) {
        addCandidate(SolverType::Z3);
    }
    if (preferredSolverType != SolverType::Z3_NOODLER) {
        addCandidate(SolverType::Z3_NOODLER);
    }

    DEBUG("Fallback solver candidates count: ", candidates.size());

    for (SolverType type : candidates) {
        if (!solverExecutableExists(type)) {
            WARN("Solver script not found for ", solverName(type), "; skipping");
            continue;
        }

        try {
            INFO("Executing fallback via ", solverName(type));
            ExternalSolver solver(type);
            auto start = std::chrono::high_resolution_clock::now();
            SatResult result = solver.checkSat(fallbackPreparedFormula);
            auto end = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

            if (result == SatResult::ERROR) {
                WARN("Fallback solver ", solverName(type), " returned ERROR (", duration.count(), "ms)");
                continue;
            }

            switch (result) {
                case SatResult::SAT:
                    INFO("Fallback result: SAT (", duration.count(), "ms)");
                    break;
                case SatResult::UNSAT:
                    INFO("Fallback result: UNSAT (", duration.count(), "ms)");
                    break;
                case SatResult::UNKNOWN:
                    INFO("Fallback result: UNKNOWN (", duration.count(), "ms)");
                    break;
                default:
                    break;
            }

            return result;
        } catch (const std::exception& e) {
            WARN("Failed to run fallback solver ", solverName(type), ": ", e.what());
        }
    }

    INFO("All fallback solver candidates failed to execute");
    return SatResult::UNKNOWN;
}

bool Context::reloadCurrentFile() {
    if (currentFilename.empty()) {
        ERROR("No previously loaded SMT-LIB file to reload");
        return false;
    }
    INFO("Reloading original SMT-LIB file: ", currentFilename);
    return parseFile(currentFilename);
}

} // namespace strp

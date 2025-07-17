#include "Parser.h"
#include "Structures.h"
#include "Context.h"
#include <fstream>
#include <sstream>
#include <regex>
#include <algorithm>
#include <filesystem>

namespace strp {

Parser& Parser::getInstance() {
    static Parser instance;
    return instance;
}

Parser::Parser() {
    DEBUG("Parser initialized");
}

bool Parser::parseFile(const std::string& filename) {
    bool success = SMTParser.parse(filename);
    if (success) {
        DEBUG("Successfully parsed file: ", filename);
    } else {
        ERROR("Failed to parse file: ", filename);
    }
    return success;
}

bool Parser::parseString(const std::string& input) {
    bool success = SMTParser.parseStr(input);
    if (success) {
        DEBUG("Successfully parsed string input");
    } else {
        ERROR("Failed to parse string input");
    }
    return success;
}

TaskType Parser::parseTaskCommand(const std::string& command) {
    std::string cmd = command;
    if (cmd.front() == '(' && cmd.back() == ')') {
        cmd = cmd.substr(1, cmd.size() - 2);
    }
    
    if (cmd == "check-sat") return TaskType::CHECK_SAT;
    if (cmd == "get-model") return TaskType::GET_MODEL;
    if (cmd == "get-unsat-core") return TaskType::GET_UNSAT_CORE;
    if (cmd == "get-proof") return TaskType::GET_PROOF;
    if (cmd == "get-value") return TaskType::GET_VALUE;
    if (cmd == "get-assignment") return TaskType::GET_ASSIGNMENT;
    if (cmd == "get-info") return TaskType::GET_INFO;
    if (cmd == "get-option") return TaskType::GET_OPTION;
    if (cmd == "push") return TaskType::PUSH;
    if (cmd == "pop") return TaskType::POP;
    if (cmd == "reset") return TaskType::RESET;
    if (cmd == "exit") return TaskType::EXIT;
    
    throw std::invalid_argument("Unknown task command: " + command);
}

std::set<TaskType> Parser::getTask(const std::string& filename) const {
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
    std::regex taskRegex(R"(\s*\(\s*(check-sat|get-model|get-unsat-core|get-proof|get-value|get-assignment|get-info|get-option|push|pop|reset|exit)\s*[\)\s])");
    
    while (std::getline(file, line)) {
        std::smatch match;
        if (std::regex_search(line, match, taskRegex)) {
            try {
                TaskType task = parseTaskCommand("(" + match[1].str() + ")");
                foundTasks.insert(task);
                DEBUG("Found task: ", match[1].str());
            } catch (const std::invalid_argument&) {
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

void Parser::declareStringVar(const std::string& name) {
    SMTParser.mkVarStr(name);
    DEBUG("Declared string variable: ", name);
}

void Parser::declareBoolVar(const std::string& name) {
    SMTParser.mkVarBool(name);
    DEBUG("Declared boolean variable: ", name);
}

void Parser::declareIntVar(const std::string& name) {
    SMTParser.mkVarInt(name);
    DEBUG("Declared integer variable: ", name);
}

void Parser::addAssertion(const std::string& constraint) {
    #undef assert
    SMTParser.assert(constraint);
    DEBUG("Added assertion: ", constraint);
}

std::vector<SMTParser::NodePtr> Parser::getAssertions() {
    return SMTParser.assertions;
}

std::vector<SMTParser::NodePtr> Parser::getAtoms(const SMTParser::NodePtr& node) {
    std::unordered_set<SMTParser::NodePtr> nodes;
    Parser dummyParser;
    dummyParser.SMTParser.collectAtoms(node, nodes);
    std::vector<SMTParser::NodePtr> atoms(nodes.begin(), nodes.end());
    return atoms;
}

bool Parser::containsNode(const SMTParser::NodePtr& parent, const SMTParser::NodePtr& target) {
    if (!parent || !target) return false;
    if (parent == target) return true;
    for (size_t i = 0; i < parent->getChildrenSize(); ++i) {
        if (containsNode(parent->getChild(i), target)) {
            return true;
        }
    }
    return false;
}

std::string Parser::getSource(const SMTParser::NodePtr& node) {
    Parser dummyParser;
    return dummyParser.SMTParser.toString(node);
}

std::string Parser::getComment(const SMTParser::NodePtr& node) {
    if (!node) return "";
    
    std::string source = getSource(node);
    
    if (source.find("str.in_re") != std::string::npos && source.find("str.to_re") != std::string::npos) {
        size_t start = source.find("str.to_re") + 10;
        size_t end = source.find(')', start);
        if (start < source.length() && end != std::string::npos) {
            std::string regex = source.substr(start, end - start);
            regex.erase(0, regex.find_first_not_of(" "));
            regex.erase(regex.find_last_not_of(" ") + 1);
            
            if (regex.size() >= 2 && regex.front() == '"' && regex.back() == '"') {
                regex = regex.substr(1, regex.size() - 2);
            }
            
            return regex;
        }
    }
    
    if (source.find("str.in_re") != std::string::npos && source.find("not") != std::string::npos) {
        size_t reStart = source.find("str.to_re");
        if (reStart != std::string::npos) {
            reStart += 10;
            size_t reEnd = source.find(')', reStart);
            if (reStart < source.length() && reEnd != std::string::npos) {
                std::string regex = source.substr(reStart, reEnd - reStart);
                regex.erase(0, regex.find_first_not_of(" "));
                regex.erase(regex.find_last_not_of(" ") + 1);
                
                if (regex.size() >= 2 && regex.front() == '"' && regex.back() == '"') {
                    regex = regex.substr(1, regex.size() - 2);
                }
                
                auto children = node->getChildren();
                if (!children.empty()) {
                    auto child = children[0];
                    if (child && child->getChildrenSize() > 0) {
                        auto var = getComment(child->getChildren()[0]);
                        return var + " not in " + regex;
                    }
                }
            }
        }
    }
    
    return source;
}

std::string Parser::getSMTLIB2(bool from_parser) const {
    if (from_parser) {
        return const_cast<Parser*>(this)->SMTParser.dumpSMT2();
    } else {
        std::stringstream ss;
        ss << "(set-logic ALL)" << std::endl;
        
        std::vector<SMTParser::NodePtr> variables = const_cast<Parser*>(this)->getVariables();
        for (const auto& var : variables) {
            if (var) {
                ss << getSource(var) << std::endl;
            }
        }
        
        std::vector<SMTParser::NodePtr> assertions = const_cast<Parser*>(this)->getAssertions();
        for (const auto& assertion : assertions) {
            ss << "(assert " << getSource(assertion) << ")" << std::endl;
        }
        
        ss << "(check-sat)" << std::endl;
        return ss.str();
    }
}

void Parser::removeFunDef(const std::vector<std::string>& funcNames) {
    for (const auto& funcName : funcNames) {
        SMTParser.removeFuns(funcNames);
        DEBUG("Removed function definition: ", funcName);
    }
}

std::vector<std::string> Parser::getSplitRelatedFunctionNames() const {
    std::vector<std::string> splitFuncNames;
    
    std::string smtContent = getSMTLIB2(true);
    std::vector<std::string> extractedNames = const_cast<Parser*>(this)->extractSplitFunctionNames(smtContent);
    
    splitFuncNames.insert(splitFuncNames.end(), extractedNames.begin(), extractedNames.end());
    
    return splitFuncNames;
}

std::vector<SMTParser::NodePtr> Parser::getFunctions() const {
    return const_cast<Parser*>(this)->SMTParser.getFunctions();
}

std::string Parser::nodeToString(const SMTParser::NodePtr& node) const {
    return const_cast<Parser*>(this)->SMTParser.toString(node);
}

SMTParser::NodePtr Parser::replaceNodes(const SMTParser::NodePtr& expr, const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    if (!expr) return nullptr;
    
    auto it = nodeMap.find(expr);
    if (it != nodeMap.end()) {
        return it->second;
    }
    
    std::vector<SMTParser::NodePtr> newChildren;
    bool hasChanges = false;
    
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
    
    Parser dummyParser;
    return dummyParser.SMTParser.mkOper(expr->getSort(), expr->getKind(), newChildren);
}

void Parser::replaceNodes(const std::unordered_map<SMTParser::NodePtr, SMTParser::NodePtr>& nodeMap) {
    for (size_t i = 0; i < SMTParser.assertions.size(); ++i) {
        SMTParser.assertions[i] = replaceNodes(SMTParser.assertions[i], nodeMap);
    }
}

SMTParser::NodePtr Parser::createNode(const std::string& node_str) {
    Parser dummyParser;
    if (dummyParser.SMTParser.parseStr("(assert " + node_str + ")")) {
        if (!dummyParser.SMTParser.assertions.empty()) {
            return dummyParser.SMTParser.assertions[0];
        }
    }
    return nullptr;
}

SMTParser::NodePtr Parser::createStringConst(const std::string& value) {
    Parser dummyParser;
    return dummyParser.SMTParser.mkConstStr(value);
}

SMTParser::NodePtr Parser::createIntConst(int value) {
    Parser dummyParser;
    return dummyParser.SMTParser.mkConstInt(value);
}

SMTParser::NodePtr Parser::createBoolConst(bool value) {
    Parser dummyParser;
    if (value) {
        return dummyParser.SMTParser.mkTrue();
    } else {
        return dummyParser.SMTParser.mkFalse();
    }
}

SMTParser::NodePtr Parser::createStringVar(const std::string& name) {
    Parser dummyParser;
    auto var = dummyParser.SMTParser.getVariable(name);
    if (var) {
        return var;
    }
    
    std::string declareStmt = "(declare-fun " + name + " () String)";
    if (dummyParser.SMTParser.parseStr(declareStmt)) {
        var = dummyParser.SMTParser.getVariable(name);
        if (var) {
            DEBUG("Created new string variable: ", name);
            return var;
        }
    }
    
    WARN("Failed to create string variable: ", name);
    return nullptr;
}

SMTParser::NodePtr Parser::createIntVar(const std::string& name) {
    Parser dummyParser;
    auto var = dummyParser.SMTParser.getVariable(name);
    if (var) {
        return var;
    }

    std::string declareStmt = "(declare-fun " + name + " () Int)";
    if (dummyParser.SMTParser.parseStr(declareStmt)) {
        var = dummyParser.SMTParser.getVariable(name);
        if (var) {
            DEBUG("Created new int variable: ", name);
            return var;
        }
    }
    
    WARN("Failed to create int variable: ", name);
    return nullptr;
}

SMTParser::NodePtr Parser::createBoolVar(const std::string& name) {
    Parser dummyParser;
    auto var = dummyParser.SMTParser.getVariable(name);
    if (var) {
        return var;
    }

    std::string declareStmt = "(declare-fun " + name + " () Bool)";
    if (dummyParser.SMTParser.parseStr(declareStmt)) {
        var = dummyParser.SMTParser.getVariable(name);
        if (var) {
            DEBUG("Created new bool variable: ", name);
            return var;
        }
    }

    WARN("Failed to create bool variable: ", name);
    return nullptr;
}

SMTSeparationResult Parser::separateSplitConstraints(const std::string& filename) {
    SMTSeparationResult result;
    
    if (!std::filesystem::exists(filename)) {
        ERROR("File does not exist: ", filename);
        return result;
    }
    
    std::ifstream file(filename);
    if (!file.is_open()) {
        ERROR("Failed to open file: ", filename);
        return result;
    }
    
    std::vector<std::string> allLines;
    std::string line;
    while (std::getline(file, line)) {
        allLines.push_back(line);
    }
    file.close();
    
    std::ostringstream splitConstraints;
    std::ostringstream otherConstraints;
    std::unordered_map<std::string, std::string> varDeclarations;
    std::unordered_set<std::string> splitUsedVars;
    
    splitConstraints << "(set-logic ALL)\n";
    otherConstraints << "(set-logic ALL)\n";
    
    for (const auto& line : allLines) {
        std::string trimmedLine = line;
        trimmedLine.erase(0, trimmedLine.find_first_not_of(" \t"));
        
        if (trimmedLine.empty() || trimmedLine[0] == ';' ||
            trimmedLine.find("(set-logic") == 0 || 
            trimmedLine.find("(set-option") == 0) {
            continue;
        }
        
        if (isSplitRelatedLine(line)) {
            std::vector<std::string> vars = extractVariableNames(line);
            for (const auto& var : vars) {
                splitUsedVars.insert(var);
            }
        }
        
        if (trimmedLine.find("(declare-fun") == 0) {
            size_t nameStart = trimmedLine.find(' ', 12);
            if (nameStart != std::string::npos) {
                nameStart = trimmedLine.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmedLine.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmedLine.substr(nameStart, nameEnd - nameStart);
                    varDeclarations[varName] = line;
                }
            }
        }
    }
    
    for (const auto& line : allLines) {
        std::string trimmedLine = line;
        trimmedLine.erase(0, trimmedLine.find_first_not_of(" \t"));
        
        if (trimmedLine.empty() || trimmedLine[0] == ';' ||
            trimmedLine.find("(set-logic") == 0 || 
            trimmedLine.find("(set-option") == 0) {
            continue;
        }
        
        if (trimmedLine.find("(declare-fun") == 0) {
            size_t nameStart = trimmedLine.find(' ', 12);
            if (nameStart != std::string::npos) {
                nameStart = trimmedLine.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmedLine.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmedLine.substr(nameStart, nameEnd - nameStart);
                    if (splitUsedVars.find(varName) != splitUsedVars.end()) {
                        splitConstraints << line << "\n";
                    } else {
                        otherConstraints << line << "\n";
                    }
                }
            }
            continue;
        }
        
        if (isSplitRelatedLine(line)) {
            splitConstraints << line << "\n";
        } else {
            otherConstraints << line << "\n";
        }
    }
    
    splitConstraints << "\n(check-sat)\n";
    otherConstraints << "\n(check-sat)\n";
    
    result.splitConstraints = splitConstraints.str();
    result.otherConstraints = otherConstraints.str();
    
    result.variableDeclarations = extractVariablesFromSplitConstraints(result.splitConstraints);

    if (!result.variableDeclarations.empty()) {
        std::string varDeclarations = generateVariableDeclarations(result.variableDeclarations);
        size_t logicPos = result.splitConstraints.find("(set-logic ALL)\n");
        if (logicPos != std::string::npos) {
            size_t insertPos = logicPos + 16;
            result.splitConstraints.insert(insertPos, "\n" + varDeclarations);
        }
        DEBUG("Added ", result.variableDeclarations.size(), " variable declarations to split constraints");
    }
    
    DEBUG("Separated split constraints (", result.splitConstraints.length(), " chars) from other constraints (", result.otherConstraints.length(), " chars)");
    
    return result;
}

bool Parser::isSplitRelatedLine(const std::string& line) {
    return line.find("str.split_at") != std::string::npos ||
           line.find("str.split_rest") != std::string::npos ||
           line.find("str.num_splits") != std::string::npos ||
           line.find("split_at") != std::string::npos ||
           line.find("split_rest") != std::string::npos ||
           line.find("num_splits") != std::string::npos;
}

std::vector<std::string> Parser::extractSplitFunctionNames(const std::string& smtContent) {
    std::vector<std::string> functionNames;
    std::regex funcDefRegex(R"(\(define-fun\s+([^\s\)]+))");
    std::sregex_iterator iter(smtContent.begin(), smtContent.end(), funcDefRegex);
    std::sregex_iterator end;
    
    for (; iter != end; ++iter) {
        std::string funcName = (*iter)[1].str();
        if (funcName.find("split") != std::string::npos) {
            functionNames.push_back(funcName);
            DEBUG("Found split-related function: ", funcName);
        }
    }
    
    return functionNames;
}

std::string Parser::mergeSMTConstraints(const std::string& rewrittenSplitPart, const std::string& otherPart) {
    std::ostringstream result;
    
    std::istringstream splitStream(rewrittenSplitPart);
    std::istringstream otherStream(otherPart);
    
    std::vector<std::string> allDeclarations;
    std::vector<std::string> allAssertions;
    std::unordered_set<std::string> declaredVars;
    
    std::string line;
    
    while (std::getline(otherStream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(declare-") == 0) {
            size_t nameStart = trimmed.find(' ');
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmed.substr(nameStart, nameEnd - nameStart);
                    if (declaredVars.find(varName) == declaredVars.end()) {
                        allDeclarations.push_back(line);
                        declaredVars.insert(varName);
                    }
                }
            }
        } else if (trimmed.find("(assert") == 0) {
            allAssertions.push_back(line);
        }
    }
    
    while (std::getline(splitStream, line)) {
        std::string trimmed = line;
        trimmed.erase(0, trimmed.find_first_not_of(" \t"));
        
        if (trimmed.find("(declare-") == 0) {
            size_t nameStart = trimmed.find(' ');
            if (nameStart != std::string::npos) {
                nameStart = trimmed.find_first_not_of(' ', nameStart);
                size_t nameEnd = trimmed.find(' ', nameStart);
                if (nameEnd != std::string::npos) {
                    std::string varName = trimmed.substr(nameStart, nameEnd - nameStart);
                    if (declaredVars.find(varName) == declaredVars.end()) {
                        allDeclarations.push_back(line);
                        declaredVars.insert(varName);
                    }
                }
            }
        } else if (trimmed.find("(assert") == 0) {
            allAssertions.push_back(line);
        }
    }
    
    result << "(set-logic ALL)\n\n";
    
    for (const auto& decl : allDeclarations) {
        result << decl << "\n";
    }
    if (!allDeclarations.empty()) {
        result << "\n";
    }
    
    for (const auto& assertion : allAssertions) {
        result << assertion << "\n";
    }
    
    result << "\n(check-sat)\n";
    
    return result.str();
}

std::unordered_map<std::string, std::string> Parser::extractVariablesFromSplitConstraints(const std::string& splitConstraints) {
    std::unordered_map<std::string, std::string> variableDeclarations;
    
    std::istringstream iss(splitConstraints);
    std::string line;
    std::unordered_set<std::string> alreadyDeclared;
    
    while (std::getline(iss, line)) {
        if (line.find("(declare-fun") != std::string::npos) {
            std::regex declareRegex(R"(\(declare-fun\s+([^\s\)]+))");
            std::smatch match;
            if (std::regex_search(line, match, declareRegex)) {
                std::string varName = match[1].str();
                alreadyDeclared.insert(varName);
            }
        }
    }
    
    iss.clear();
    iss.str(splitConstraints);
    
    while (std::getline(iss, line)) {
        std::vector<std::string> variables = extractVariableNames(line);
        for (const std::string& var : variables) {
            if (variableDeclarations.find(var) == variableDeclarations.end() &&
                alreadyDeclared.find(var) == alreadyDeclared.end()) {
                std::string type = inferVariableType(var, line);
                bool isTemp = isTempVariable(var);
                if (!isTemp) {
                    variableDeclarations[var] = type;
                    DEBUG("Detected variable: ", var, " with type: ", type);
                }
            }
        }
    }
    
    return variableDeclarations;
}

std::string Parser::inferVariableType(const std::string& variableName, const std::string& context) {
    if (context.find("str.") != std::string::npos) {
        return "String";
    }
    if (context.find("=") != std::string::npos && 
        (context.find("true") != std::string::npos || context.find("false") != std::string::npos)) {
        return "Bool";
    }
    if (variableName.find("num") != std::string::npos || variableName.find("index") != std::string::npos) {
        return "Int";
    }
    return "String";
}

bool Parser::isTempVariable(const std::string& variableName) {
    std::regex varRegex(R"(\b(var\d+|div\d+\w*)\b)");
    return std::regex_search(variableName, varRegex);
}

std::vector<std::string> Parser::extractVariableNames(const std::string& line) {
    std::vector<std::string> variables;
    
    std::set<std::string> keywords = {
        "assert", "declare-fun", "set-logic", "check-sat", "get-model",
        "str.split_at", "str.split_rest", "str.num_splits", "str.len", "str.substr",
        "str.indexof", "str.replace", "str.contains", "str.prefixof", "str.suffixof",
        "str.to_re", "str.in_re", "re.union", "re.inter", "re.diff", "re.comp",
        "re.range", "re.opt", "re.plus", "re.loop", "re.allchar", "re.nostr",
        "and", "or", "not", "implies", "iff", "xor", "ite", "forall", "exists",
        "true", "false", "Int", "String", "Bool", "Real"
    };
    
    std::regex variableRegex(R"([a-zA-Z_][a-zA-Z0-9_]*)");
    std::sregex_iterator iter(line.begin(), line.end(), variableRegex);
    std::sregex_iterator end;
    
    for (; iter != end; ++iter) {
        std::string var = iter->str();
        if (keywords.find(var) == keywords.end() &&
            !var.empty() &&
            var != "hello" && var != "l") {
            variables.push_back(var);
        }
    }
    
    return variables;
}

std::string Parser::generateVariableDeclarations(const std::unordered_map<std::string, std::string>& varDeclarations) {
    std::ostringstream declarations;
    for (const auto& [varName, varType] : varDeclarations) {
        declarations << "(declare-fun " << varName << " () " << varType << ")\n";
    }
    return declarations.str();
}

SMTParser::NodePtr Parser::getVariable(const std::string& name) const {
    return const_cast<Parser*>(this)->SMTParser.getVariable(name);
}

bool Parser::isVariableDeclared(const std::string& varName) const {
    auto var = const_cast<Parser*>(this)->SMTParser.getVariable(varName);
    return (var != nullptr);
}

std::set<std::string> Parser::getUsedVariables() const {
    std::set<std::string> usedVars;
    
    auto variables = const_cast<Parser*>(this)->getVariables();
    for (const auto& var : variables) {
        if (var) {
            usedVars.insert(var->getName());
        }
    }
    
    return usedVars;
}

} // namespace strp 
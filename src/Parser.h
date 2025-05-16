#pragma once

#include <string>
#include <vector>
#include <memory>
#include <unordered_map>
#include <set>
#include <functional>
#include <boost/unordered/unordered_set.hpp>

#include "parser.h"
#include "dag.h"
#include "kind.h"
#include "Logger.h"
#include "Structures.h"

namespace strp {

enum class VarType;
enum class AtomType;
enum class ClauseType;

class Parser {
public:
    static Parser& getInstance();
    bool parseFile(const std::string& filename);
    bool parseString(const std::string& input);
    std::vector<SMTLIBParser::NodePtr>& getVariables() { return variables; }
    std::vector<SMTLIBParser::NodePtr>& getAssertions() { return assertions; }
    
    static int getType(const SMTLIBParser::NodePtr& node);
    static VarType getVarType(const SMTLIBParser::NodePtr& node);
    static AtomType getAtomType(const SMTLIBParser::NodePtr& node);
    static ClauseType getClauseType(const SMTLIBParser::NodePtr& node);
    static std::string getSource(const SMTLIBParser::NodePtr& node);
    static std::string getComment(const SMTLIBParser::NodePtr& node);
    static boost::unordered_set<SMTLIBParser::NodePtr> getAtoms(const SMTLIBParser::NodePtr& node);
    
    void registerParseCallback(std::function<void(const Parser&)> callback);
    void reset(bool clearCallbacks = true);

private:
    Parser();
    ~Parser() = default;
    Parser(const Parser&) = delete;
    Parser& operator=(const Parser&) = delete;
    
    void executeCallbacks();

    std::vector<SMTLIBParser::NodePtr> variables;
    std::vector<SMTLIBParser::NodePtr> assertions;
    
    utils::Logger& logger = utils::Logger::getInstance();
    SMTLIBParser::Parser smtlibParser;
    bool infoUpdated = false;
    std::vector<std::function<void(const Parser&)>> parseCallbacks;
};

} // namespace strp
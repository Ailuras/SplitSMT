#include "Parser.h"
#include "Structures.h"
#include "Context.h"
#include <iostream>
#include <regex>

int main() {
    std::cout << "Testing complete parsing and conversion flow..." << std::endl;
    
    strp::Parser& parser = strp::Parser::getInstance();
    
    std::string testFile = "test.smt2";
    strp::Decomposition decomposition;
    
    std::cout << "Parsing file: " << testFile << std::endl;
    
    bool success = parser.parseFile(testFile, decomposition);
    
    if (success) {
        std::cout << "Parse successful!" << std::endl;
        std::cout << "Split constraints: " << decomposition.splitConstraints.size() << std::endl;
        std::cout << "Other constraints: " << decomposition.otherConstraints.size() << std::endl;
        std::cout << "Variables: " << decomposition.variables.size() << std::endl;
        std::cout << "Variables need declare: " << decomposition.variablesNeedDeclare.size() << std::endl;
        std::cout << "Variables has defined: " << decomposition.variablesHasDefined.size() << std::endl;
        
        std::cout << "\nSplit constraints:" << std::endl;
        for (const auto& constraint : decomposition.splitConstraints) {
            std::cout << "  - " << constraint << std::endl;
        }
        
        std::cout << "\nVariables that need declaration:" << std::endl;
        for (const auto& var : decomposition.variablesNeedDeclare) {
            std::cout << "  - " << var.first << " (" << var.second << ")" << std::endl;
        }
        
        std::cout << "\nVariables that are already defined:" << std::endl;
        for (const auto& var : decomposition.variablesHasDefined) {
            std::cout << "  - " << var.first << " (" << var.second << ")" << std::endl;
        }
        
        std::cout << "\nGenerated SMTLIB2:" << std::endl;
        std::cout << decomposition.splitSMTLIB2 << std::endl;
    } else {
        std::cout << "Parse failed!" << std::endl;
    }
    
    return 0;
}
#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "Context.h"

int main(int argc, char* argv[]) {
    LOGGER.setLevel(strp::utils::LogLevel::INFO);
    
    std::string inputFile = "test/test_split_mini.smt2";
    if (argc > 1) {
        inputFile = argv[1];
    }
    
    auto& context = strp::Context::getInstance();
    if (!context.parseFile(inputFile)) {
        std::cerr << "Failed to parse file: " << inputFile << std::endl;
        return 1;
    }
    
    std::cout << "=== Original SMTLIB2 (from parser) ===" << std::endl;
    std::cout << context.getSMTLIB2(true) << std::endl;
    
    std::cout << "\n=== Generated SMTLIB2 (from context) ===" << std::endl;
    std::cout << context.getSMTLIB2(false) << std::endl;
    
    std::cout << "\n=== Context Statistics ===" << std::endl;
    std::cout << "Variables: " << context.getVarCount() << std::endl;
    std::cout << "Atoms: " << context.getAtomCount() << std::endl;
    std::cout << "Clauses: " << context.getClauseCount() << std::endl;
    std::cout << "Lemmas: " << context.getLemmaCount() << std::endl;
    
    return 0;
} 
#include "Split.h"
#include "Logger.h"
#include "Context.h"
#include <iostream>
#include <fstream>
#include <sstream>

using namespace strp;

void analyzeNodeStructure(const SMTParser::NodePtr& node, const std::string& prefix = "") {
    if (!node) {
        std::cout << prefix << "NULL node" << std::endl;
        return;
    }
    
    std::cout << prefix << "Node: " << node->getName() 
              << " | Kind: " << SMTParser::kindToString(node->getKind())
              << " | Sort: " << node->getSort()->toString()
              << " | Children: " << node->getChildrenSize()
              << " | IsVar: " << node->isVar()
              << " | IsConst: " << node->isConst()
              << " | IsFuncDef: " << node->isFuncDef()
              << " | IsFuncApply: " << node->isFuncApply()
              << std::endl;
    
    if (node->isFuncDef()) {
        std::cout << prefix << "  FuncDef params: " << node->getFuncParamsSize() << std::endl;
        if (node->getFuncBody()) {
            std::cout << prefix << "  FuncBody: " << node->getFuncBody()->getName() << std::endl;
        }
    }
    
    // Recursively analyze children (but limit depth to avoid too much output)
    if (prefix.length() < 8) {  // Limit recursion depth
        for (size_t i = 0; i < node->getChildrenSize(); ++i) {
            std::cout << prefix << "  Child[" << i << "]:" << std::endl;
            analyzeNodeStructure(node->getChild(i), prefix + "    ");
        }
    }
}

void analyzeAssertions(Context& ctx) {
    std::cout << "\n=== Analyzing Assertions ===" << std::endl;
    
    auto assertions = ctx.getAssertions();
    std::cout << "Total assertions: " << assertions.size() << std::endl;
    
    for (size_t i = 0; i < assertions.size(); ++i) {
        std::cout << "\nAssertion[" << i << "]:" << std::endl;
        std::cout << "  String representation: " << ctx.nodeToString(assertions[i]) << std::endl;
        analyzeNodeStructure(assertions[i], "  ");
    }
}

void analyzeFunctions(Context& ctx) {
    std::cout << "\n=== Analyzing Functions ===" << std::endl;
    
    auto functions = ctx.getFunctions();
    std::cout << "Total functions: " << functions.size() << std::endl;
    
    for (size_t i = 0; i < functions.size(); ++i) {
        auto func = functions[i];
        if (func) {
            std::cout << "\nFunction[" << i << "]:" << std::endl;
            std::cout << "  Name: " << func->getName() << std::endl;
            std::cout << "  Params: " << func->getFuncParamsSize() << std::endl;
            std::cout << "  Sort: " << func->getSort()->toString() << std::endl;
            std::cout << "  String representation: " << ctx.nodeToString(func) << std::endl;
            
            if (func->getFuncBody()) {
                std::cout << "  Body string: " << ctx.nodeToString(func->getFuncBody()) << std::endl;
                std::cout << "  Body analysis:" << std::endl;
                analyzeNodeStructure(func->getFuncBody(), "    ");
            }
        }
    }
}

void searchForFuncDefReferences(const SMTParser::NodePtr& node, const std::string& targetFuncName, const std::string& prefix = "") {
    if (!node) return;
    
    // Check if this node references the target function
    if (node->getName() == targetFuncName || 
        node->getName() == "func_def" ||
        node->getName().find("func_def") != std::string::npos) {
        std::cout << prefix << "FOUND REFERENCE: " << node->getName() 
                  << " | Kind: " << SMTParser::kindToString(node->getKind())
                  << " | Sort: " << node->getSort()->toString()
                  << " | Address: " << node.get()
                  << std::endl;
    }
    
    // Recursively search children
    for (size_t i = 0; i < node->getChildrenSize(); ++i) {
        searchForFuncDefReferences(node->getChild(i), targetFuncName, prefix + "  ");
    }
}

void findAllFuncDefReferences(Context& ctx) {
    std::cout << "\n=== Searching for func_def References ===" << std::endl;
    
    auto assertions = ctx.getAssertions();
    for (size_t i = 0; i < assertions.size(); ++i) {
        std::cout << "\nSearching in Assertion[" << i << "]:" << std::endl;
        searchForFuncDefReferences(assertions[i], "var1498", "  ");
        searchForFuncDefReferences(assertions[i], "func_def", "  ");
    }
    
    auto functions = ctx.getFunctions();
    for (size_t i = 0; i < functions.size(); ++i) {
        auto func = functions[i];
        if (func && func->getFuncBody()) {
            std::cout << "\nSearching in Function[" << i << "] body:" << std::endl;
            searchForFuncDefReferences(func->getFuncBody(), "var1498", "  ");
            searchForFuncDefReferences(func->getFuncBody(), "func_def", "  ");
        }
    }
}

void testFunctionReplacement() {
    std::cout << "\n=== Testing Function Replacement ===" << std::endl;
    
    Context& ctx = Context::getInstance();
    ctx.clear();
    
    // Simplified test case focusing on the problem
    std::string testInput = R"(
        (set-logic ALL)
        (declare-fun x () String)
        (define-const var1498 Int 42)
        (assert (not (= var1498 4)))
        (check-sat)
    )";
    
    std::cout << "Original input:" << std::endl;
    std::cout << testInput << std::endl;
    
    try {
        // Parse the input
        ctx.parseString(testInput);
        std::cout << "\nParsing successful!" << std::endl;
        
        // Analyze the structure before conversion
        std::cout << "\n=== BEFORE CONVERSION ===" << std::endl;
        analyzeFunctions(ctx);
        analyzeAssertions(ctx);
        findAllFuncDefReferences(ctx);
        
        // Show SMT-LIB before conversion
        std::cout << "\nSMT-LIB before conversion:" << std::endl;
        std::cout << ctx.getSMTLIB2(true) << std::endl;
        
        // Create a split solver and test the conversion
        splitSolver solver(SolverType::EXTERNAL_CVC5);
        
        // Test the convertZeroParamDefineFuns function directly
        std::cout << "\n=== Testing convertZeroParamDefineFuns ===" << std::endl;
        solver.convertZeroParamDefineFuns(ctx);
        
        // Analyze the structure after conversion
        std::cout << "\n=== AFTER CONVERSION ===" << std::endl;
        analyzeFunctions(ctx);
        analyzeAssertions(ctx);
        findAllFuncDefReferences(ctx);
        
        // Show SMT-LIB after conversion
        std::cout << "\nSMT-LIB after conversion:" << std::endl;
        std::cout << ctx.getSMTLIB2(true) << std::endl;
        
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }
}

int main() {
    LOGGER.setLevel(strp::utils::LogLevel::DEBUG);
    
    try {
        auto& context = strp::Context::getInstance();
        std::string testFile = "benchmarks/test_ext_z3-noodler/error/4925.smt2";
        
        std::cout << "Testing problematic SMT2 file: " << testFile << std::endl;
        
        if (context.parseFile(testFile)) {
            std::cout << "File parsed successfully!" << std::endl;
            
            std::cout << "\n=== SMT-LIB2 OUTPUT IMMEDIATELY AFTER PARSING ===" << std::endl;
            std::string smtlib2_after_parse = context.getSMTLIB2(true);
            std::cout << smtlib2_after_parse << std::endl;
            
            std::cout << "\n=== FUNCTIONS BEFORE PROCESSING ===" << std::endl;
            auto allFunctions = context.getFunctions();
            for (const auto& func : allFunctions) {
                if (func) {
                    std::cout << "Function: " << func->getName() 
                              << ", Parameters: " << func->getFuncParamsSize()
                              << ", Has body: " << (func->getFuncBody() ? "Yes" : "No")
                              << std::endl;
                    if (func->getFuncBody()) {
                        std::cout << "  Body: " << context.nodeToString(func->getFuncBody()) << std::endl;
                    }
                }
            }
            
            std::cout << "\n=== PROCESSING ===" << std::endl;
            strp::splitSolver solver(strp::SolverType::Z3);
            
            std::cout << "\n=== SMT-LIB2 OUTPUT AFTER PROCESSING ===" << std::endl;
            std::string smtlib2_after_process = context.getSMTLIB2(true);
            std::cout << smtlib2_after_process << std::endl;
        } else {
            std::cout << "Failed to parse file!" << std::endl;
        }
    } catch (const std::exception& e) {
        std::cout << "Exception caught: " << e.what() << std::endl;
    }
    
    return 0;
} 
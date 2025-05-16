#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include "Logger.h"
#include "Parser.h"
#include "Context.h"

int main(int argc, char* argv[]) {
    // 设置日志级别
    LOGGER.setLevel(strp::utils::LogLevel::DEBUG);
    
    // 解析测试文件
    auto& parser = strp::Parser::getInstance();
    if (!parser.parseFile("test/test_split_mini.smt2")) {
        std::cerr << "Failed to parse file" << std::endl;
        return 1;
    }
    
    // 获取断言
    auto& assertions = parser.getAssertions();
    std::cout << "Found " << assertions.size() << " assertions" << std::endl;
    
    for (size_t i = 0; i < assertions.size(); ++i) {
        auto assertion = assertions[i];
        std::cout << "\n=== Assertion " << i << " ===" << std::endl;
        std::cout << "Source: " << strp::Parser::getSource(assertion) << std::endl;
        std::cout << "Comment: " << strp::Parser::getComment(assertion) << std::endl;
        std::cout << "Type: " << strp::Parser::getType(assertion) << std::endl;
        
        // 检查是否是等式
        std::cout << "isEq(): " << assertion->isEq() << std::endl;
        std::cout << "isEqBool(): " << assertion->isEqBool() << std::endl;
        std::cout << "isEqOther(): " << assertion->isEqOther() << std::endl;
        
        if (assertion->getChildrenSize() > 0) {
            auto child0 = assertion->getChild(0);
            std::cout << "Child 0 source: " << strp::Parser::getSource(child0) << std::endl;
            std::cout << "Child 0 isArithTerm(): " << child0->isArithTerm() << std::endl;
            std::cout << "Child 0 isVar(): " << child0->isVar() << std::endl;
            std::cout << "Child 0 isVStr(): " << child0->isVStr() << std::endl;
            std::cout << "Child 0 isVInt(): " << child0->isVInt() << std::endl;
            std::cout << "Child 0 isVReal(): " << child0->isVReal() << std::endl;
            
            if (assertion->getChildrenSize() > 1) {
                auto child1 = assertion->getChild(1);
                std::cout << "Child 1 source: " << strp::Parser::getSource(child1) << std::endl;
                std::cout << "Child 1 isArithTerm(): " << child1->isArithTerm() << std::endl;
                std::cout << "Child 1 isVar(): " << child1->isVar() << std::endl;
                std::cout << "Child 1 isVStr(): " << child1->isVStr() << std::endl;
            }
        }
        
        // 检查是否是算术比较
        std::cout << "isArithComp(): " << assertion->isArithComp() << std::endl;
        std::cout << "isStrComp(): " << assertion->isStrComp() << std::endl;
        std::cout << "isStrEq(): " << assertion->isStrEq() << std::endl;
        std::cout << "isStrProp(): " << assertion->isStrProp() << std::endl;
        std::cout << "isAtom(): " << assertion->isAtom() << std::endl;
        
        // 获取atoms
        auto atoms = strp::Parser::getAtoms(assertion);
        std::cout << "Number of atoms found: " << atoms.size() << std::endl;
        for (auto& atom : atoms) {
            std::cout << "  Atom: " << strp::Parser::getSource(atom) << std::endl;
        }
    }
    
    return 0;
} 
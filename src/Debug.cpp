#include "core/Context.h"
#include "core/Structures.h"
#include "core/Split.h"
#include "utils/Logger.h"
#include <iostream>
#include <memory>

int main() {
    strp::Context& ctx = strp::Context::getInstance();
    
    if (!ctx.parseFile("test.smt2")) {
        std::cerr << "Failed to parse file" << std::endl;
        return 1;
    }
    
    auto splitAtNodes = ctx.getSplitAtNodes();
    auto splitRestNodes = ctx.getSplitRestNodes();
    auto numSplitNodes = ctx.getNumSplitNodes();
    
    std::cout << "Split at nodes: " << splitAtNodes.size() << std::endl;
    std::cout << "Split rest nodes: " << splitRestNodes.size() << std::endl;
    std::cout << "Num split nodes: " << numSplitNodes.size() << std::endl;
    
    const auto& divisions = ctx.getAllDivisions();
    std::cout << "Divisions: " << divisions.size() << std::endl;
    
    for (const auto& [key, division] : divisions) {
        std::cout << "Division: " << division->getDivided() << " | ";
        std::cout << division->getDelimiter();
        std::cout << std::endl;
    }
    
    return 0;
}

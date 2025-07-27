#include "Context.h"
#include "Split.h"
#include "Solver.h"
#include <iostream>

using namespace strp;

int main() {
    Context& ctx = Context::getInstance();
    
    std::cout << "Testing regular expression delimiter split functionality" << std::endl;
    
    if (!ctx.parseFile("test/test_re.smt2")) {
        std::cerr << "Failed to parse test file" << std::endl;
        return 1;
    }
    
    std::cout << "Successfully parsed file with const splits" << std::endl;
    
    auto splitAtConstNodes = ctx.getSplitAtConstNodes();
    auto splitRestConstNodes = ctx.getSplitRestConstNodes();
    auto numSplitConstNodes = ctx.getNumSplitConstNodes();
    auto splitAtVarNodes = ctx.getSplitAtVarNodes();
    auto splitRestVarNodes = ctx.getSplitRestVarNodes();
    auto numSplitVarNodes = ctx.getNumSplitVarNodes();
    auto splitAtRegNodes = ctx.getSplitAtRegNodes();
    auto splitEndRegNodes = ctx.getSplitRestRegNodes();
    auto numSplitRegNodes = ctx.getNumSplitRegNodes();
    
    std::cout << "Found " << splitAtConstNodes.size() << " split_at const nodes" << std::endl;
    std::cout << "Found " << splitRestConstNodes.size() << " split_rest const nodes" << std::endl;
    std::cout << "Found " << numSplitConstNodes.size() << " num_splits const nodes" << std::endl;
    std::cout << "Found " << splitAtVarNodes.size() << " split_at var nodes" << std::endl;
    std::cout << "Found " << splitRestVarNodes.size() << " split_rest var nodes" << std::endl;
    std::cout << "Found " << numSplitVarNodes.size() << " num_splits var nodes" << std::endl;
    std::cout << "Found " << splitAtRegNodes.size() << " split_at_re nodes" << std::endl;
    std::cout << "Found " << splitEndRegNodes.size() << " split_rest_re nodes" << std::endl;
    std::cout << "Found " << numSplitRegNodes.size() << " num_splits_re nodes" << std::endl;
    
    const auto& allDivisions = ctx.getAllDivisions();
    std::cout << "Total divisions created: " << allDivisions.size() << std::endl;
    
    for (const auto& pair : allDivisions) {
        const auto& division = pair.second;
        std::cout << "Division: " << division->getDivided() << " | " << division->getDelimiter();
        if (division->isConstType()) {
            std::cout << " (Const)";
            const ConstDivision* constDiv = static_cast<const ConstDivision*>(division.get());
            if (constDiv->hasSplitNum()) {
                std::cout << " [has split operations]";
            }
        } else if (division->isVarType()) {
            std::cout << " (Var/Reg)";
        }
        if (division->isNumSplitsUsed()) {
            std::cout << " [num_splits used]";
        }
        std::cout << std::endl;
    }
    
    std::cout << "Test completed successfully" << std::endl;
    return 0;
}
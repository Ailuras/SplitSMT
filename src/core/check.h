#pragma once

#include "Context.h"
#include "Solver.h"
#include <string>
#include <vector>

namespace strp {

bool runSplitModelCheck(
    Context &context, SolverType solverType, int timeoutSeconds,
    const std::string &rawInput, const std::string &modelText,
    const std::vector<SMTParser::NodePtr> &splitAtTerms,
    const std::vector<SMTParser::NodePtr> &splitRestTerms,
    const std::vector<SMTParser::NodePtr> &numSplitTerms);

} // namespace strp

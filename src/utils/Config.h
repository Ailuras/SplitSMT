#pragma once

#include <cstdlib>
#include <filesystem>
#include <string>

namespace strp::config {

inline std::filesystem::path projectRoot() {
#ifdef STRP_PROJECT_ROOT
    return std::filesystem::path(STRP_PROJECT_ROOT);
#else
    return std::filesystem::current_path();
#endif
}

inline std::filesystem::path z3ScriptPath() {
    return projectRoot() / "solvers" / "z3" / "run.sh";
}

inline std::filesystem::path cvc5ScriptPath() {
    return projectRoot() / "solvers" / "cvc5" / "run.sh";
}

inline std::filesystem::path ostrichScriptPath() {
    return projectRoot() / "solvers" / "ostrich" / "run.sh";
}

inline std::filesystem::path z3NoodlerScriptPath() {
    return projectRoot() / "solvers" / "z3-noodler" / "run.sh";
}

} // namespace strp::config

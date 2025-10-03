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
    return projectRoot() / "external" / "z3-4.15.3-arm64-osx-13.7.6" / "run.sh";
}

inline std::filesystem::path cvc5ScriptPath() {
    return projectRoot() / "external" / "cvc5-macOS-arm64-static-gpl" / "run.sh";
}

inline std::filesystem::path ostrichScriptPath() {
    return {};
}

inline std::filesystem::path z3NoodlerScriptPath() {
    return {};
}

} // namespace strp::config

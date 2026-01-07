#pragma once

#include <cstdlib>
#include <filesystem>
#include <string>
#include <string_view>

namespace strp::config {

inline std::filesystem::path projectRoot() {
#ifdef STRP_PROJECT_ROOT
  return std::filesystem::path(STRP_PROJECT_ROOT);
#else
  return std::filesystem::current_path();
#endif
}

inline std::filesystem::path solversBase() {
#ifdef STRP_DEFAULT_SOLVER_DIR
  return std::filesystem::path(STRP_DEFAULT_SOLVER_DIR);
#else
  return projectRoot() / "solvers";
#endif
}

inline std::filesystem::path solversRoot() {
  const auto base = solversBase();

#ifdef STRP_SOLVER_PLATFORM_SUBDIR
  constexpr std::string_view configured{STRP_SOLVER_PLATFORM_SUBDIR};
#else
  constexpr std::string_view configured{};
#endif

  if (!configured.empty()) {
    const auto candidate = base / std::string(configured);
    if (std::filesystem::exists(candidate)) {
      return candidate;
    }
  }

#if defined(__APPLE__) && defined(__MACH__)
  const auto macosDir = base / "macos";
  if (std::filesystem::exists(macosDir)) {
    return macosDir;
  }
#elif defined(_WIN32) || defined(_WIN64)
  const auto windowsDir = base / "windows";
  if (std::filesystem::exists(windowsDir)) {
    return windowsDir;
  }
#else
  const auto linuxDir = base / "linux";
  if (std::filesystem::exists(linuxDir)) {
    return linuxDir;
  }
#endif

  return base;
}

inline std::filesystem::path solverScriptPath(std::string_view solverFolder) {
  // Simplified script path resolution (now handled by unified scripts)
  const auto solverName = std::string(solverFolder);
  return solversBase() / (solverName + ".sh");
}

inline std::filesystem::path z3ScriptPath() { return solverScriptPath("z3"); }

inline std::filesystem::path cvc5ScriptPath() {
  return solverScriptPath("cvc5");
}

inline std::filesystem::path ostrichScriptPath() {
  return solverScriptPath("ostrich");
}

inline std::filesystem::path z3NoodlerScriptPath() {
  return solverScriptPath("z3-noodler");
}

// Global constants
constexpr auto INTERNAL_DELIMITER = "\"\\u{2FFFF}\"";

} // namespace strp::config

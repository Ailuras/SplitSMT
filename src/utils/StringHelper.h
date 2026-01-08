#pragma once

#include <optional>
#include <string>
#include <string_view>

namespace strp {
namespace utils {

/**
 * @brief Trim whitespace from both ends of a string_view
 * @param text Input string_view to trim
 * @return Trimmed string_view
 */
std::string_view trimView(std::string_view text);

/**
 * @brief Parse an integer from a string_view
 *
 * Supports standard integer format and handles leading/trailing whitespace.
 *
 * @param text Input string_view to parse
 * @return std::optional<int> containing the parsed value, or std::nullopt on
 * error
 */
std::optional<int> parseIntegerView(std::string_view text);

/**
 * @brief Parse an integer from a string, supporting SMT-LIB format
 *
 * Supports:
 * - Standard integers: "123", "-456"
 * - SMT-LIB negative format: "(- 123)"
 * - Leading/trailing whitespace
 *
 * @param str Input string to parse
 * @return std::optional<int> containing the parsed value, or std::nullopt on
 * error
 */
std::optional<int> parseInteger(const std::string &str);

} // namespace utils
} // namespace strp

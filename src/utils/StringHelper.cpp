#include "StringHelper.h"
#include <cctype>
#include <charconv>

namespace strp {
namespace utils {

std::string_view trimView(std::string_view text) {
  size_t start = 0;
  while (start < text.size() &&
         std::isspace(static_cast<unsigned char>(text[start]))) {
    ++start;
  }
  size_t end = text.size();
  while (end > start &&
         std::isspace(static_cast<unsigned char>(text[end - 1]))) {
    --end;
  }
  return text.substr(start, end - start);
}

std::optional<int> parseIntegerView(std::string_view text) {
  text = trimView(text);
  if (text.empty()) {
    return std::nullopt;
  }

  int value = 0;
  auto [ptr, ec] =
      std::from_chars(text.data(), text.data() + text.size(), value);
  if (ec != std::errc() || ptr != text.data() + text.size()) {
    return std::nullopt;
  }
  return value;
}

std::optional<int> parseInteger(const std::string &str) {
  std::string_view text = trimView(str);
  if (text.empty()) {
    return std::nullopt;
  }

  // Handle the SMT-LIB negative numeral form: (- 123)
  if (text.front() == '(' && text.back() == ')') {
    const auto inner = trimView(text.substr(1, text.size() - 2));
    if (inner.size() < 2 || inner[0] != '-' ||
        !std::isspace(static_cast<unsigned char>(inner[1]))) {
      return std::nullopt;
    }
    auto mag = parseIntegerView(inner.substr(1));
    if (!mag) {
      return std::nullopt;
    }
    return -*mag;
  }

  return parseIntegerView(text);
}

} // namespace utils
} // namespace strp

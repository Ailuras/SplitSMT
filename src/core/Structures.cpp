#include "Structures.h"
#include "Context.h"
#include "parser/Parser.h"
#include <algorithm>
#include <sstream>
#include <functional>
#include <chrono>

struct SplitResult {
    std::vector<std::string> splits;
    std::vector<std::string> delimiters;
};

std::vector<std::string> parseDelimiterRegexToList(const std::string& delimiter_regex) {
    std::vector<std::string> delimiters;
    if (delimiter_regex.empty()) {
        return delimiters;
    }
    if (delimiter_regex.find("(re.union") == 0) {
        size_t pos = 10;
        int depth = 1;
        std::string current;
        while (pos < delimiter_regex.length() && depth > 0) {
            if (delimiter_regex[pos] == '(') {
                depth++;
                current += delimiter_regex[pos];
            } else if (delimiter_regex[pos] == ')') {
                depth--;
                if (depth > 0) {
                    current += delimiter_regex[pos];
                } else if (!current.empty()) {
                    size_t start = current.find('"');
                    size_t end = current.rfind('"');
                    if (start != std::string::npos && end != std::string::npos && start < end) {
                        delimiters.push_back(current.substr(start + 1, end - start - 1));
                    }
                }
            } else if (delimiter_regex[pos] == ' ' && depth == 1) {
                if (!current.empty()) {
                    size_t start = current.find('"');
                    size_t end = current.rfind('"');
                    if (start != std::string::npos && end != std::string::npos && start < end) {
                        delimiters.push_back(current.substr(start + 1, end - start - 1));
                    }
                    current.clear();
                }
            } else {
                current += delimiter_regex[pos];
            }
            pos++;
        }
    } else if (delimiter_regex.find("(str.to_re") == 0) {
        size_t start = delimiter_regex.find('"');
        size_t end = delimiter_regex.rfind('"');
        if (start != std::string::npos && end != std::string::npos && start < end) {
            delimiters.push_back(delimiter_regex.substr(start + 1, end - start - 1));
        }
    }
    return delimiters;
}

SplitResult splitStringWithDelimiters(const std::string& str, const std::vector<std::string>& delimiters) {
    SplitResult result;
    if (delimiters.empty()) {
        for (char c : str) {
            result.splits.push_back(std::string(1, c));
            result.delimiters.push_back("");
        }
        return result;
    }
    size_t start = 0;
    size_t pos = 0;
    while (pos < str.length()) {
        std::string longestMatch;
        size_t maxLength = 0;
        for (const auto& delimiter : delimiters) {
            size_t delimLen = delimiter.length();
            if (pos + delimLen <= str.length() && str.substr(pos, delimLen) == delimiter) {
                if (delimLen > maxLength) {
                    maxLength = delimLen;
                    longestMatch = delimiter;
                }
            }
        }
        if (maxLength > 0) {
            result.splits.push_back(str.substr(start, pos - start));
            result.delimiters.push_back(longestMatch);
            start = pos + maxLength;
            pos = start;
        } else {
            pos++;
        }
    }
    result.splits.push_back(str.substr(start));
    result.delimiters.push_back("");
    return result;
}

std::vector<std::string> splitString(const std::string& str, const std::vector<std::string>& delimiters) {
    auto result = splitStringWithDelimiters(str, delimiters);
    return result.splits;
}

std::vector<std::string> splitString(const std::string& str, const std::string& delimiter) {
    return splitString(str, std::vector<std::string>{delimiter});
}

namespace strp {

Division::Division(const std::string& divided, const std::string& delimiter_regex) :
    divided(divided),
    delimiter_regex(delimiter_regex),
    num_splits_used(false) {
    hash_string = generateHashString();
}

std::string Division::generateHashString() const {
    static int counter = 0;
    counter++;
    
    std::stringstream ss;
    ss << "div" << counter;
    return ss.str();
}

ConstDivision::ConstDivision(const std::string& divided, const std::string& delimiter_regex) :
    Division(divided, delimiter_regex),
    splitNums(0),
    has_split_num(false) {
    
    std::vector<std::string> delimiters = parseDelimiterRegexToList(delimiter_regex);
    
    if (delimiters.empty()) {
        for (char c : divided) {
            splits.push_back(std::string(1, c));
            splitDelimiters.push_back("");
        }
    } else {
        auto result = splitStringWithDelimiters(divided, delimiters);
        splits = result.splits;
        splitDelimiters = result.delimiters;
    }
    splitNums = static_cast<int>(splits.size());
}

VarDivision::VarDivision(const std::string& divided, const std::string& delimiter_regex) :
    Division(divided, delimiter_regex) {}

std::string Division::generateKey(const std::string& divided, const std::string& delimiter_regex) {
    std::stringstream ss;
    ss << divided << "##" << delimiter_regex;
    return ss.str();
}

} // namespace strp

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

Division::Division(const std::string& divided, const std::vector<std::string>& delimiters) :
    divided(divided),
    delimiters(delimiters),
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

ConstDivision::ConstDivision(const std::string& divided, const std::vector<std::string>& delimiters) :
    Division(divided, delimiters),
    splitNums(0),
    has_split_num(false) {
    
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

VarDivision::VarDivision(const std::string& divided, const std::vector<std::string>& delimiters) :
    Division(divided, delimiters) {}

std::string Division::generateKey(const std::string& divided, const std::vector<std::string>& delimiters) {
    std::stringstream ss;
    ss << divided << "##";
    for (size_t i = 0; i < delimiters.size(); ++i) {
        if (i > 0) ss << ",";
        ss << delimiters[i];
    }
    return ss.str();
}

} // namespace strp

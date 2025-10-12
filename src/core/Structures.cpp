#include "Structures.h"
#include "Context.h"
#include "parser/Parser.h"
#include "utils/RegexHelper.h"
#include <algorithm>
#include <sstream>
#include <functional>
#include <chrono>

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
    } else if (delimiter_regex.size() >= 2 && delimiter_regex.front() == '"' && delimiter_regex.back() == '"') {
        delimiters.push_back(delimiter_regex.substr(1, delimiter_regex.size() - 2));
    }
    return delimiters;
}

namespace strp {

Division::Division(const std::string& divided, const std::string& delimiter) :
    divided(divided),
    delimiter(delimiter),
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

ConstDivision::ConstDivision(const std::string& divided, const std::string& delimiter) :
    Division(divided, delimiter),
    splitNums(0),
    has_split_num(false) {
    
    SplitResult result;
    
    if (RegexHelper::isSMTRegexPattern(delimiter)) {
        result = RegexHelper::splitStringWithRegex(divided, delimiter);
    } else {
        std::vector<std::string> delimiters = parseDelimiterRegexToList(delimiter);
        if (delimiters.empty()) {
            for (char c : divided) {
                result.splits.push_back(std::string(1, c));
                result.delimiters.push_back("");
            }
        } else {
            result = RegexHelper::splitStringWithDelimiters(divided, delimiters);
        }
    }
    
    splits = result.splits;
    splitDelimiters = result.delimiters;
    splitNums = static_cast<int>(splits.size());
}

VarDivision::VarDivision(const std::string& divided, const std::string& delimiter) :
    Division(divided, delimiter) {}

std::string Division::generateKey(const std::string& divided, const std::string& delimiter) {
    std::stringstream ss;
    ss << divided << "##" << delimiter;
    return ss.str();
}

} // namespace strp

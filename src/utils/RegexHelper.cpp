#include "RegexHelper.h"
#include <sstream>
#include <algorithm>
#include <stdexcept>

namespace strp {

bool RegexHelper::isSMTRegexPattern(const std::string& delimiter) {
    if (delimiter.empty()) {
        return false;
    }
    return delimiter[0] == '(' && 
           (delimiter.find("(re.") == 0 || delimiter.find("(str.to_re") == 0);
}

std::string RegexHelper::extractStringLiteral(const std::string& str) {
    size_t start = str.find('"');
    size_t end = str.rfind('"');
    if (start != std::string::npos && end != std::string::npos && start < end) {
        return str.substr(start + 1, end - start - 1);
    }
    return "";
}

std::string RegexHelper::smtRegexToCppRegex(const std::string& smt_regex) {
    if (smt_regex.empty()) {
        return "";
    }
    
    if (smt_regex.find("(str.to_re") == 0) {
        std::string literal = extractStringLiteral(smt_regex);
        return std::regex_replace(literal, std::regex(R"([\.\*\+\?\|\(\)\[\]\{\}\^\$\\])"), R"(\$&)");
    }
    
    if (smt_regex.find("(re.union") == 0) {
        return parseReUnion(smt_regex);
    }
    
    if (smt_regex.find("(re.range") == 0) {
        return parseReRange(smt_regex);
    }
    
    if (smt_regex.find("(re.++") == 0 || smt_regex.find("(re.concat") == 0) {
        return parseReConcat(smt_regex);
    }
    
    if (smt_regex.find("(re.*") == 0) {
        size_t inner_start = smt_regex.find(' ') + 1;
        size_t inner_end = smt_regex.rfind(')');
        if (inner_start < inner_end) {
            std::string inner = smt_regex.substr(inner_start, inner_end - inner_start);
            return "(" + smtRegexToCppRegex(inner) + ")*";
        }
    }
    
    if (smt_regex.find("(re.+") == 0) {
        size_t inner_start = smt_regex.find(' ') + 1;
        size_t inner_end = smt_regex.rfind(')');
        if (inner_start < inner_end) {
            std::string inner = smt_regex.substr(inner_start, inner_end - inner_start);
            return "(" + smtRegexToCppRegex(inner) + ")+";
        }
    }
    
    if (smt_regex.size() >= 2 && smt_regex.front() == '"' && smt_regex.back() == '"') {
        std::string literal = smt_regex.substr(1, smt_regex.size() - 2);
        return std::regex_replace(literal, std::regex(R"([\.\*\+\?\|\(\)\[\]\{\}\^\$\\])"), R"(\$&)");
    }
    
    return "";
}

std::string RegexHelper::parseReUnion(const std::string& smt_regex) {
    std::vector<std::string> alternatives;
    size_t pos = 10;
    int depth = 1;
    std::string current;
    
    while (pos < smt_regex.length() && depth > 0) {
        if (smt_regex[pos] == '(') {
            depth++;
            current += smt_regex[pos];
        } else if (smt_regex[pos] == ')') {
            depth--;
            if (depth > 0) {
                current += smt_regex[pos];
            } else if (!current.empty()) {
                alternatives.push_back(smtRegexToCppRegex(current));
            }
        } else if (smt_regex[pos] == ' ' && depth == 1) {
            if (!current.empty()) {
                alternatives.push_back(smtRegexToCppRegex(current));
                current.clear();
            }
        } else {
            current += smt_regex[pos];
        }
        pos++;
    }
    
    if (alternatives.empty()) {
        return "";
    }
    
    if (alternatives.size() == 1) {
        return alternatives[0];
    }
    
    std::string result = "(";
    for (size_t i = 0; i < alternatives.size(); ++i) {
        if (i > 0) result += "|";
        result += alternatives[i];
    }
    result += ")";
    return result;
}

std::string RegexHelper::parseReRange(const std::string& smt_regex) {
    size_t first_quote = smt_regex.find('"');
    size_t second_quote = smt_regex.find('"', first_quote + 1);
    size_t third_quote = smt_regex.find('"', second_quote + 1);
    size_t fourth_quote = smt_regex.find('"', third_quote + 1);
    
    if (first_quote != std::string::npos && fourth_quote != std::string::npos) {
        char start_char = smt_regex[first_quote + 1];
        char end_char = smt_regex[third_quote + 1];
        return "[" + std::string(1, start_char) + "-" + std::string(1, end_char) + "]";
    }
    
    return "";
}

std::string RegexHelper::parseReConcat(const std::string& smt_regex) {
    std::vector<std::string> parts;
    size_t start_pos = smt_regex.find("(re.++") == 0 ? 7 : 10;
    size_t pos = start_pos;
    int depth = 1;
    std::string current;
    
    while (pos < smt_regex.length() && depth > 0) {
        if (smt_regex[pos] == '(') {
            depth++;
            current += smt_regex[pos];
        } else if (smt_regex[pos] == ')') {
            depth--;
            if (depth > 0) {
                current += smt_regex[pos];
            } else if (!current.empty()) {
                parts.push_back(smtRegexToCppRegex(current));
            }
        } else if (smt_regex[pos] == ' ' && depth == 1) {
            if (!current.empty()) {
                parts.push_back(smtRegexToCppRegex(current));
                current.clear();
            }
        } else {
            current += smt_regex[pos];
        }
        pos++;
    }
    
    std::string result;
    for (const auto& part : parts) {
        result += part;
    }
    return result;
}

SplitResult RegexHelper::splitStringWithRegex(const std::string& str, const std::string& smt_regex) {
    SplitResult result;
    
    if (smt_regex.empty() || str.empty()) {
        result.splits.push_back(str);
        result.delimiters.push_back("");
        return result;
    }
    
    std::string cpp_regex_pattern = smtRegexToCppRegex(smt_regex);
    
    if (cpp_regex_pattern.empty()) {
        result.splits.push_back(str);
        result.delimiters.push_back("");
        return result;
    }
    
    try {
        std::regex pattern(cpp_regex_pattern);
        
        auto words_begin = std::sregex_iterator(str.begin(), str.end(), pattern);
        auto words_end = std::sregex_iterator();
        
        size_t last_pos = 0;
        for (std::sregex_iterator i = words_begin; i != words_end; ++i) {
            std::smatch match = *i;
            
            result.splits.push_back(str.substr(last_pos, match.position() - last_pos));
            result.delimiters.push_back(match.str());
            
            last_pos = match.position() + match.length();
        }
        
        result.splits.push_back(str.substr(last_pos));
        result.delimiters.push_back("");
        
    } catch (const std::regex_error& e) {
        result.splits.push_back(str);
        result.delimiters.push_back("");
    }
    
    return result;
}

SplitResult RegexHelper::splitStringWithDelimiters(const std::string& str, const std::vector<std::string>& delimiters) {
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

} // namespace strp


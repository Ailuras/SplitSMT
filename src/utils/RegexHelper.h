#pragma once
#include <string>
#include <vector>
#include <regex>

namespace strp {

struct SplitResult {
    std::vector<std::string> splits;
    std::vector<std::string> delimiters;
};

class RegexHelper {
public:
    static std::string smtRegexToCppRegex(const std::string& smt_regex);
    
    static SplitResult splitStringWithRegex(const std::string& str, const std::string& smt_regex);
    
    static SplitResult splitStringWithDelimiters(const std::string& str, const std::vector<std::string>& delimiters);
    
    static bool isSMTRegexPattern(const std::string& delimiter);
    
private:
    static std::string extractStringLiteral(const std::string& str);
    
    static std::string parseReUnion(const std::string& smt_regex);
    
    static std::string parseReRange(const std::string& smt_regex);
    
    static std::string parseReConcat(const std::string& smt_regex);
};

} // namespace strp


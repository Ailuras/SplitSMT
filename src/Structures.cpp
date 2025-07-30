#include "Structures.h"
#include "Context.h"
#include "Parser.h"
#include <algorithm>
#include <sstream>
#include <functional>
#include <chrono>

std::vector<std::string> splitString(const std::string& str, const std::string& delimiter) {
    std::vector<std::string> result;
    if (delimiter.empty()) {
        for (char c : str) {
            result.push_back(std::string(1, c));
        }
        return result;
    }
    
    size_t start = 0;
    size_t end = str.find(delimiter);
    
    while (end != std::string::npos) {
        result.push_back(str.substr(start, end - start));
        start = end + delimiter.length();
        end = str.find(delimiter, start);
    }
    result.push_back(str.substr(start));
    
    return result;
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
        }
    } else {
        splits = splitString(divided, delimiters[0]);
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

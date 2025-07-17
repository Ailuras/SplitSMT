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
    
    splits = splitString(divided, delimiter);
    splitNums = static_cast<int>(splits.size());
}

VarDivision::VarDivision(const std::string& divided, const std::string& delimiter) :
    Division(divided, delimiter) {}

std::string Division::generateKey(const std::string& divided, const std::string& delimiter) {
    return divided + "##" + delimiter;
}

} // namespace strp

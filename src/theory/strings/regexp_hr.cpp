#include <unordered_set>
#include "theory/strings/regexp_hr.h"
#include "expr/node_manager.h"
#include "expr/node.h"

namespace cvc5::internal {
namespace theory {
namespace strings {

RegExpHR::RegExpHR() {
    // 构造函数实现
}

RegExpHR::~RegExpHR() {
    // 析构函数实现
}

bool RegExpHR::checkInclusion(Node r1, Node r2) {
    // 在此处实现包含检查逻辑
    return false; // 默认返回false，具体逻辑你可以自行添加
}

bool RegExpHR::checkReInclusion(const std::pair<const Node, std::vector<Node>>& mr) {
    Trace("test_Member") << "============================Begin checkReInclusion============================" << std::endl;
    Node variable = mr.first;
    const std::vector<Node>& constraints = mr.second;

    // 判断变量是否为连接变量
    bool isConcat = variable.getKind() == Kind::STRING_CONCAT;
    Trace("test_Member") << "isConcat: " << isConcat << ", variable: " << variable << std::endl;

    // 获取或创建变量的正则约束
    RegExpConstraints& regExpConstraints = isConcat ? d_concatConstraints[variable] : d_singleConstraints[variable];

    for (const Node& constraint : constraints) {
        // 判断约束是否已经存在
        if (constraint.getKind() == Kind::STRING_IN_REGEXP) {
            if (std::find(regExpConstraints.inclusionConstraints.begin(),
                          regExpConstraints.inclusionConstraints.end(),
                          constraint) == regExpConstraints.inclusionConstraints.end()) {
                Node tempConstraint = constraint[1];
                bool conflict = processReConstraint(variable, tempConstraint);
                if (std::find(regExpConstraints.inclusionConstraints.begin(),
                              regExpConstraints.inclusionConstraints.end(),
                              tempConstraint) == regExpConstraints.inclusionConstraints.end()) {
                    regExpConstraints.inclusionConstraints.push_back(tempConstraint);
                    // 添加长度约束
                    updateLengthConstraints(variable, regExpConstraints, d_allowedChars[variable].allowed);
                }
                saveToTextFile(d_savePath);
                if (conflict) {
                    return true; // 如果发现冲突，立即返回 true
                }
            }
        } else if (constraint.getKind() == Kind::NOT && constraint[0].getKind() == Kind::STRING_IN_REGEXP) {
            if (std::find(regExpConstraints.exclusionConstraints.begin(),
                          regExpConstraints.exclusionConstraints.end(),
                          constraint) == regExpConstraints.exclusionConstraints.end()) {
                Node tempConstraint = constraint[0][1];
                processNeConstraint(variable, tempConstraint);
                if (std::find(regExpConstraints.exclusionConstraints.begin(),
                              regExpConstraints.exclusionConstraints.end(),
                              tempConstraint) == regExpConstraints.exclusionConstraints.end()) {
                    regExpConstraints.exclusionConstraints.push_back(tempConstraint);
                    // 添加长度约束
                    updateLengthConstraints(variable, regExpConstraints, d_allowedChars[variable].allowed);
                }
                saveToTextFile(d_savePath);
            }
        }
    }
    Trace("test_Member") << "============================End checkReInclusion============================" << std::endl;
    return false; // 未发现冲突，返回 false
}

bool RegExpHR::processReConstraint(Node variable, Node& constraint) {

    if (variable.getKind() == Kind::STRING_CONCAT) return false;

    // 获取或创建 allowed 约束
    AllowedChars& allowedChars = d_allowedChars[variable];

    if (!allowedChars.isAllowedInitialized) {
        // 初始化 allowed 集合
        traverseAndCollect(constraint, allowedChars.allowed);
        allowedChars.isAllowedInitialized = true;
    } else {
        // 更新 allowed 集合
        bool updated = updateAllowed(allowedChars.allowed, constraint);
        if (updated) {
            // 如果 allowed 集合被更新，处理之前的约束
            RegExpConstraints& regExpConstraints = d_singleConstraints[variable];

            for (Node& prevConstraint : regExpConstraints.inclusionConstraints) {
                bool conflict = pruneConstraint(prevConstraint, allowedChars.allowed);
                if (conflict) {
                    return true; // 如果发现冲突，立即返回 true
                }
            }
        } else {
            // 处理当前的新约束
            bool conflict = pruneConstraint(constraint, allowedChars.allowed);
            if (conflict) {
                return true; // 如果发现冲突，立即返回 true
            }
        }
    }

    return false; // 未发现冲突，返回 false
}

void RegExpHR::processNeConstraint(Node variable, Node& constraint) {
    return; // 默认不做任何处理
}

void RegExpHR::traverseAndCollect(const Node& constraint, std::unordered_set<char>& chars) {
    if (constraint.getKind() == Kind::STRING_TO_REGEXP) {
        // 处理 str.to_re 类型的节点，获取其子节点（字符串）
        if (constraint[0].isConst()) {
            String s = constraint[0].getConst<String>();
            for (char c : s.toString()) {
                chars.insert(c);
            }
        }
    } else {
        // 递归处理子节点
        for (size_t i = 0; i < constraint.getNumChildren(); ++i) {
            traverseAndCollect(constraint[i], chars);
        }
    }
}

bool RegExpHR::pruneConstraint(Node& constraint, const std::unordered_set<char>& allowed) {
    bool conflict = false;
    return conflict;

    if (constraint.getKind() == Kind::STRING_TO_REGEXP) {
        // 处理 str.to_re 类型的节点
        std::string prunedValue;
        for (char c : constraint[1].getConst<String>().toString()) {
            if (allowed.find(c) != allowed.end()) {
                prunedValue.push_back(c);
            } else {
                conflict = true;
                break; // 发现冲突，停止处理
            }
        }
        return !conflict; // 如果没有冲突，返回 true
    }

    switch (constraint.getKind()) {
        case Kind::REGEXP_CONCAT: {
            // 处理 re.++ 类型的节点
            std::vector<Node> newChildren;
            for (size_t i = 0; i < constraint.getNumChildren(); ++i) {
                Node child = constraint[i];
                if (!pruneConstraint(child, allowed)) {
                    return false; // 如果有孩子节点返回 false，则返回 false
                }
                newChildren.push_back(child);
            }
            constraint = NodeManager::currentNM()->mkNode(Kind::REGEXP_CONCAT, newChildren);
            break;
        }
        case Kind::REGEXP_UNION: {
            // 处理 re.union 类型的节点
            std::vector<Node> prunedChildren;
            for (size_t i = 0; i < constraint.getNumChildren(); ++i) {
                Node child = constraint[i];
                if (pruneConstraint(child, allowed)) {
                    prunedChildren.push_back(child);
                }
            }
            if (prunedChildren.size() == 0) {
                return false; // 如果孩子节点变为 0 个，则返回 false
            } else if (prunedChildren.size() == 1) {
                constraint = prunedChildren[0]; // 如果孩子节点变为 1 个，使用该孩子节点替代当前节点
            } else {
                constraint = NodeManager::currentNM()->mkNode(Kind::REGEXP_UNION, prunedChildren);
            }
            break;
        }
        case Kind::REGEXP_RANGE: {
            // 处理 re.range 类型的节点
            std::vector<Node> prunedChildren;
            for (size_t i = 0; i < constraint.getNumChildren(); ++i) {
                Node child = constraint[i];
                if (pruneConstraint(child, allowed)) {
                    prunedChildren.push_back(child);
                }
            }
            if (prunedChildren.size() == 0) {
                return false; // 如果孩子节点变为 0 个，则返回 false
            } else if (prunedChildren.size() == 1) {
                constraint = prunedChildren[0]; // 如果孩子节点变为 1 个，使用该孩子节点替代当前节点
            } else {
                constraint = NodeManager::currentNM()->mkNode(Kind::REGEXP_UNION, prunedChildren);
            }
            break;
        }
        default: {
            std::vector<Node> newChildren;
            for (size_t i = 0; i < constraint.getNumChildren(); ++i) {
                Node child = constraint[i];
                if (!pruneConstraint(child, allowed)) {
                    return false; // 如果有孩子节点返回 false，则返回 false
                }
                newChildren.push_back(child);
            }
            constraint = NodeManager::currentNM()->mkNode(constraint.getKind(), newChildren);
            break;
        }
    }
    return true;
}

bool RegExpHR::updateAllowed(std::unordered_set<char>& allowed, const Node& constraint) {
    std::unordered_set<char> newAllowed;
    traverseAndCollect(constraint, newAllowed);

    bool updated = false;
    std::unordered_set<char> oldAllowed = allowed;
    for (char c : oldAllowed) {
        if (newAllowed.find(c) == newAllowed.end()) {
            allowed.erase(c);
            updated = true;
        }
    }
    return updated;
}

void RegExpHR::updateLengthConstraints(Node variable, RegExpConstraints& constraints, const std::unordered_set<char>& allowed) {
    Trace("test_Member") << "allowed size is " << allowed.size() << std::endl;
    if (allowed.size() == 1) {
        NodeManager* nm = NodeManager::currentNM();

        // 清空现有的长度约束
        constraints.lengthConstraints.clear();

        // 处理包含约束
        for (const Node& constraint : constraints.inclusionConstraints) {
            // Trace("test_Member") << constraint << std::endl;
            existentialVariables.clear();
            Node lengthExpr = handleLengthConstraint(constraint);
            if (!lengthExpr.isNull()) {
                Node lengthConstraint = nm->mkNode(Kind::EQUAL, nm->mkNode(Kind::STRING_LENGTH, variable), lengthExpr);
                // Node existsConstraint = lengthConstraint;
                // for (const Node& bvarList : existentialVariables) {
                //     existsConstraint = nm->mkNode(Kind::EXISTS, bvarList, existsConstraint);
                // }
                Node bvarList = nm->mkNode(Kind::BOUND_VAR_LIST, existentialVariables);
                Node existsConstraint = nm->mkNode(Kind::EXISTS, bvarList, lengthConstraint);
                constraints.lengthConstraints.push_back(existsConstraint);
            }
        }

        // 处理不包含约束
        for (const Node& constraint : constraints.exclusionConstraints) {
            // Trace("test_Member") << constraint << std::endl;
            existentialVariables.clear();
            Node lengthExpr = handleLengthConstraint(constraint);
            if (!lengthExpr.isNull()) {
                Node lengthConstraint = nm->mkNode(Kind::EQUAL, nm->mkNode(Kind::STRING_LENGTH, variable), lengthExpr);
                // Node existsConstraint = lengthConstraint;
                // for (const Node& bvarList : existentialVariables) {
                //     existsConstraint = nm->mkNode(Kind::EXISTS, bvarList, existsConstraint);
                // }
                Node bvarList = nm->mkNode(Kind::BOUND_VAR_LIST, existentialVariables);
                Node existsConstraint = nm->mkNode(Kind::EXISTS, bvarList, lengthConstraint);
                constraints.lengthConstraints.push_back(nm->mkNode(Kind::NOT, existsConstraint));
            }
        }
    }
}

Node RegExpHR::handleLengthConstraint(const Node& constraint) {
    NodeManager* nm = NodeManager::currentNM();

    if (constraint.getKind() == Kind::STRING_TO_REGEXP) {
        // 处理 str.to_re 类型的约束
        std::string str = constraint[0].getConst<String>().toString();
        int length = str.size();
        return nm->mkConstInt(Rational(length));
    } 
    else if (constraint.getKind() == Kind::REGEXP_CONCAT) {
        // 处理 re.++ 类型的约束
        Node lengthSum; // 不再初始化为0
        bool first = true; // 用于判断是否是第一个元素
        for (const Node& child : constraint) {
            Node childLength = handleLengthConstraint(child);
            if (first) {
                lengthSum = childLength;
                first = false;
            } else {
                lengthSum = nm->mkNode(Kind::ADD, lengthSum, childLength);
            }
        }
        return lengthSum;
    }
    else if (constraint.getKind() == Kind::REGEXP_STAR) {
        // 处理 re.* 类型的约束
        std::string newVarName = "tmp_" + std::to_string(existentialCount++);
        Node newVarNode = nm->mkBoundVar(newVarName, nm->integerType());
        Node bvarList = nm->mkNode(Kind::BOUND_VAR_LIST, newVarNode);

        // 将 bvarList 保存到 existentialVariables
        existentialVariables.push_back(newVarNode);

        Node subNode = constraint[0];
        Node subLengthExpr = handleLengthConstraint(subNode);
        Node lengthExpr = nm->mkNode(Kind::MULT, subLengthExpr, newVarNode);
        return lengthExpr;
    }

    // 默认返回空节点
    return Node::null();
}

void RegExpHR::saveToTextFile(const std::string& filename) {
    std::ofstream outFile(filename, std::ios::trunc); // 清空文件内容
    if (!outFile.is_open()) {
        throw std::runtime_error("Unable to open file");
    }

    // SMT-LIB v2 格式的头部
    outFile << "(set-logic ALL)" << std::endl;

    // 帮助函数，用于去除字符串中的所有@
    auto removeAtSymbol = [](const std::string& str) {
        std::string result = str;
        result.erase(std::remove(result.begin(), result.end(), '@'), result.end());
        return result;
    };

    // 保存单变量的约束
    outFile << "; Single Variables" << std::endl;
    for (const auto& entry : d_singleConstraints) {
        std::string variable = removeAtSymbol(entry.first.toString());
        const RegExpConstraints& constraints = entry.second;
        const AllowedChars& allowedChars = d_allowedChars[entry.first];

        outFile << "(declare-fun " << variable << " () String)" << std::endl;

        outFile << "; Inclusion Constraints" << std::endl;
        for (const auto& constraint : constraints.inclusionConstraints) {
            outFile << "(assert (str.in_re " << variable << " " << removeAtSymbol(constraint.toString()) << "))" << std::endl;
        }

        outFile << "; Exclusion Constraints" << std::endl;
        for (const auto& constraint : constraints.exclusionConstraints) {
            outFile << "(assert (not (str.in_re " << variable << " " << removeAtSymbol(constraint.toString()) << ")))" << std::endl;
        }

        outFile << "; Length Constraints" << std::endl;
        for (const auto& constraint : constraints.lengthConstraints) {
            outFile << "(assert " << removeAtSymbol(constraint.toString()) << ")" << std::endl;
        }

        outFile << "; Allowed Chars" << std::endl;
        if (allowedChars.allowed.size() == 1) {
            char singleChar = *allowedChars.allowed.begin();
            outFile << "(assert (str.in_re " << variable << " (re.* (str.to_re \"" << singleChar << "\"))))" << std::endl;
        } else {
            outFile << "(assert (str.in_re " << variable << "(re.* (re.union";
            for (const auto& c : allowedChars.allowed) {
                outFile << " (str.to_re \"" << c << "\")";
            }
            outFile << "))))" << std::endl;
        }
    }

    // SMT-LIB v2 格式的结尾
    outFile << "(check-sat)" << std::endl;
    // outFile << "(get-model)" << std::endl;

    outFile.close();
}

}  // namespace strings
}  // namespace theory
}  // namespace cvc5::internal
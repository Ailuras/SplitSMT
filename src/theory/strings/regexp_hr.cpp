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

    // 确定变量类型
    bool isIntermediate = variable.toString().find("@") == 0;

    // 获取或创建变量的正则约束
    RegExpConstraints& regExpConstraints = isIntermediate ? d_intermediateConstraints[variable] : d_originalConstraints[variable];

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
                }
                saveConstraintsToFile(d_savePath);
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
                }
                saveConstraintsToFile(d_savePath);
            }
        }
    }
    Trace("test_Member") << "============================End checkReInclusion============================" << std::endl;
    return false; // 未发现冲突，返回 false
}

bool RegExpHR::processReConstraint(Node variable, Node& constraint) {
    // 获取或创建 allowed 约束
    AllowedConstraints& allowedConstraints = d_allowedConstraints[variable];

    if (!allowedConstraints.isAllowedInitialized) {
        // 初始化 allowed 集合
        traverseAndCollect(constraint, allowedConstraints.allowed);
        allowedConstraints.isAllowedInitialized = true;
    } else {
        // 更新 allowed 集合
        bool updated = updateAllowed(allowedConstraints.allowed, constraint);
        if (updated) {
            // 如果 allowed 集合被更新，处理之前的约束
            RegExpConstraints& regExpConstraints = variable.toString().find("@") == 0 ? 
                d_intermediateConstraints[variable] : d_originalConstraints[variable];

            for (Node& prevConstraint : regExpConstraints.inclusionConstraints) {
                bool conflict = pruneConstraint(prevConstraint, allowedConstraints.allowed);
                if (conflict) {
                    return true; // 如果发现冲突，立即返回 true
                }
            }
        } else {
            // 处理当前的新约束
            Node modifiableConstraint = constraint;
            bool conflict = pruneConstraint(modifiableConstraint, allowedConstraints.allowed);
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
    if (constraint.getKind() == Kind::STRING_IN_REGEXP) {
        for (char c : constraint[1].getConst<std::string>()) {
            chars.insert(c);
        }
    } else {
        for (size_t i = 0; i < constraint.getNumChildren(); ++i) {
            traverseAndCollect(constraint[i], chars);
        }
    }
}

bool RegExpHR::pruneConstraint(Node& constraint, const std::unordered_set<char>& allowed) {
    bool conflict = false;
    return conflict;

    if (constraint.getKind() == Kind::STRING_IN_REGEXP) {
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
        constraint = NodeManager::currentNM()->mkNode(Kind::STRING_IN_REGEXP, NodeManager::currentNM()->mkConst(String(prunedValue)));
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

void RegExpHR::saveConstraintsToFile(const std::string& filename) {
    std::ofstream outFile(filename, std::ios::trunc); // 使用 std::ios::trunc 标志清空文件内容
    if (!outFile.is_open()) {
        throw std::runtime_error("Unable to open file");
    }

    // 保存原始变量的约束
    outFile << "Original Variables:" << std::endl;
    for (const auto& entry : d_originalConstraints) {
        const Node& variable = entry.first;
        const RegExpConstraints& constraints = entry.second;
        const AllowedConstraints& allowedConstraints = d_allowedConstraints[variable];

        outFile << "Variable: " << variable << std::endl;

        if (!constraints.inclusionConstraints.empty()) {
            outFile << "  Inclusion Constraints:" << std::endl;
            for (const Node& constraint : constraints.inclusionConstraints) {
                outFile << "    " << constraint << std::endl;
            }
        }

        if (!constraints.exclusionConstraints.empty()) {
            outFile << "  Exclusion Constraints:" << std::endl;
            for (const Node& constraint : constraints.exclusionConstraints) {
                outFile << "    " << constraint << std::endl;
            }
        }

        if (!allowedConstraints.allowed.empty() && allowedConstraints.isAllowedInitialized) {
            outFile << "  Allowed: ";
            for (char c : allowedConstraints.allowed) {
                outFile << c << " ";
            }
            outFile << std::endl;
        }
    }

    // 保存中间变量的约束
    outFile << "Intermediate Variables:" << std::endl;
    for (const auto& entry : d_intermediateConstraints) {
        const Node& variable = entry.first;
        const RegExpConstraints& constraints = entry.second;
        const AllowedConstraints& allowedConstraints = d_allowedConstraints[variable];

        outFile << "Variable: " << variable << std::endl;

        if (!constraints.inclusionConstraints.empty()) {
            outFile << "  Inclusion Constraints:" << std::endl;
            for (const Node& constraint : constraints.inclusionConstraints) {
                outFile << "    " << constraint << std::endl;
            }
        }

        if (!constraints.exclusionConstraints.empty()) {
            outFile << "  Exclusion Constraints:" << std::endl;
            for (const Node& constraint : constraints.exclusionConstraints) {
                outFile << "    " << constraint << std::endl;
            }
        }

        if (!allowedConstraints.allowed.empty() && allowedConstraints.isAllowedInitialized) {
            outFile << "  Allowed: ";
            for (char c : allowedConstraints.allowed) {
                outFile << c << " ";
            }
            outFile << std::endl;
        }
    }

    outFile.close();
}

bool RegExpHR::isConstRegExp(TNode t) {
    // 在此处实现常量正则表达式的检查逻辑
    return false; // 默认返回false，具体逻辑你可以自行添加
}

bool RegExpHR::testConstStringInRegExp(String& s, TNode r) {
    // 在此处实现字符串在正则表达式中的测试逻辑
    return false; // 默认返回false，具体逻辑你可以自行添加
}

}  // namespace strings
}  // namespace theory
}  // namespace cvc5::internal
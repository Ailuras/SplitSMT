#ifndef CVC5__THEORY__STRINGS__REGEXP_HR_H
#define CVC5__THEORY__STRINGS__REGEXP_HR_H

#include <map>
#include <vector>
#include <fstream>
#include <unordered_set>

#include "context/cdhashset.h"
#include "context/cdlist.h"
#include "context/context.h"
#include "expr/node.h"
#include "smt/env_obj.h"
#include "theory/strings/extf_solver.h"
#include "theory/strings/inference_manager.h"
#include "theory/strings/regexp_operation.h"
#include "theory/strings/sequences_stats.h"
#include "theory/strings/skolem_cache.h"
#include "theory/strings/solver_state.h"
#include "theory/strings/term_registry.h"
#include "util/string.h"

namespace cvc5::internal {
namespace theory {
namespace strings {

enum RegExpOp {
    CONCAT,
    STAR,
    UNION,
    STRING
};

class RegExpNode {
public:
    RegExpOp op;
    std::string value; // 仅用于 STRING 类型的节点
    std::vector<RegExpNode*> children;

    RegExpNode(RegExpOp o) : op(o) {}
    RegExpNode(RegExpOp o, const std::string& val) : op(o), value(val) {}
};

struct RegExpConstraints {
    std::vector<Node> inclusionConstraints; // 属于关系
    std::vector<Node> exclusionConstraints; // 不属于关系
};

struct AllowedConstraints {
    std::unordered_set<char> allowed; // 存储 allowed 集合
    bool isAllowedInitialized = false; // 标记 allowed 是否已初始化
};

class RegExpHR
{
 public:
    RegExpHR();
    ~RegExpHR();

    // 在此处声明你需要的函数
    bool checkInclusion(Node r1, Node r2);
    bool checkReInclusion(const std::pair<const Node, std::vector<Node>>& mr);
    bool checkEquivalence(Node r1, Node r2);

    // 将所有变量名的信息存储到文件
    void saveConstraintsToFile(const std::string& filename);

 private:
    Rewriter* d_rewriter;
    Node d_zero;
    Node d_one;
    // 存储变量名
    std::string d_savePath = "/home/hanrui/StrCvc5/test_hr/variable_constraints.txt";
    // 存储原始变量的正则约束
    std::map<Node, RegExpConstraints> d_originalConstraints;
    // 存储中间变量的正则约束
    std::map<Node, RegExpConstraints> d_intermediateConstraints;

    // 存储 allowed 集合的约束
    std::map<Node, AllowedConstraints> d_allowedConstraints;

    // 私有辅助函数
    bool processReConstraint(Node variable, Node& constraint);
    void processNeConstraint(Node variable, Node& constraint);
    bool pruneConstraint(Node& constraint, const std::unordered_set<char>& allowed);
    bool updateAllowed(std::unordered_set<char>& allowed, const Node& constraint);
    void traverseAndCollect(const Node& constraint, std::unordered_set<char>& chars);
    bool isConstRegExp(TNode t);
    bool testConstStringInRegExp(String& s, TNode r);
};

}  // namespace strings
}  // namespace theory
}  // namespace cvc5::internal

#endif // CVC5__THEORY__STRINGS__REGEXP_HR_H
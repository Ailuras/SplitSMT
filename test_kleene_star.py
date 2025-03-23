import sys
import logging
import re
from scripts.preprocess_0327 import RegexProcessor, InfoManager, Parser

# 设置日志级别
logging.basicConfig(level=logging.INFO)

# 创建处理器实例
info_manager = InfoManager()
regex_processor = RegexProcessor(info_manager)

def test_merge_kleene_star(expr, expected=None, name="Test"):
    print(f"--- {name} ---")
    print(f"Input:  {Parser.to_str(expr)}")
    
    # 打印更多调试信息
    if expr[0] == 're.++':
        kleene_parts = []
        for part in expr[1:]:
            if isinstance(part, list) and part and part[0] in ['re.*', 're.+']:
                chars = set(regex_processor.get_parikh_image(part[1], True).keys())
                kleene_parts.append((Parser.to_str(part), chars))
        
        if kleene_parts:
            print("Kleene星号表达式的字符集:")
            for i, (part_str, chars) in enumerate(kleene_parts):
                print(f"  {i+1}. {part_str}: {sorted(chars)}")
            
            # 计算字符并集
            all_chars = set()
            for _, chars in kleene_parts:
                all_chars.update(chars)
            print(f"所有字符的并集: {sorted(all_chars)}")
    
    # 执行合并操作
    result = regex_processor.merge_kleene_star(expr)
    print(f"Output: {Parser.to_str(result)}")
    
    if expected:
        expected_str = Parser.to_str(expected)
        is_equal = Parser.to_str(result) == expected_str
        print(f"Expected: {expected_str}")
        print(f"Result: {'✓ PASS' if is_equal else '✗ FAIL'}")
    print()

# 测试用例
# 1. 基本吸收律 - 应该被化简为 (a|b|c)*
test1 = [
    're.++',
    ['re.*', ['re.union', ['str.to_re', '"b"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]]
]
expected1 = ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]]

# 2. 无法化简的情况 - 应该保持不变
test2 = [
    're.++',
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"b"'], ['str.to_re', '"c"']]]
]

# 3. 连续的Kleene星号 - 应该被化简为 (a|b|c)*
test3 = [
    're.++',
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"b"'], ['str.to_re', '"c"']]]
]
expected3 = ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]]

# 4. 间隔的Kleene星号 - 中间有常量，应该保持部分不变
test4 = [
    're.++',
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]],
    ['str.to_re', '"b"'],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]]
]
expected4 = [
    're.++',
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]],
    ['str.to_re', '"b"'],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]]
]

# 5. 混合情况 - 应该部分化简
test5 = [
    're.++',
    ['str.to_re', '"a"'],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"']]],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]],
    ['str.to_re', '"c"'],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]]
]
expected5 = [
    're.++',
    ['str.to_re', '"a"'],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"b"'], ['str.to_re', '"c"']]],
    ['str.to_re', '"c"'],
    ['re.*', ['re.union', ['str.to_re', '"a"'], ['str.to_re', '"c"']]]
]

# 运行测试
test_merge_kleene_star(test1, expected1, "测试1: 基本吸收律")
test_merge_kleene_star(test2, None, "测试2: 无法化简的情况")
test_merge_kleene_star(test3, expected3, "测试3: 连续的Kleene星号")
test_merge_kleene_star(test4, expected4, "测试4: 间隔的Kleene星号")
test_merge_kleene_star(test5, expected5, "测试5: 混合情况") 
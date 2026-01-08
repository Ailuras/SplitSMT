#!/bin/bash
# 清理指定文件夹中的所有非 .smt2 文件
# 用法: ./clean_non_smt2.sh <directory_path> [--dry-run]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 显示用法
usage() {
    echo "用法: $0 <directory_path> [--dry-run]"
    echo ""
    echo "参数:"
    echo "  directory_path    要清理的目录路径"
    echo "  --dry-run         仅显示将要删除的文件，不实际删除"
    echo ""
    echo "示例:"
    echo "  $0 ~/test/data --dry-run"
    echo "  $0 /path/to/benchmarks"
    exit 1
}

# 检查参数
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    usage
fi

TARGET_DIR="$1"
DRY_RUN=false

# 检查是否为 dry-run 模式
if [ $# -eq 2 ]; then
    if [ "$2" = "--dry-run" ]; then
        DRY_RUN=true
    else
        echo -e "${RED}错误: 未知参数 '$2'${NC}"
        usage
    fi
fi

# 检查目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}错误: 目录不存在: $TARGET_DIR${NC}"
    exit 1
fi

# 获取绝对路径
TARGET_DIR=$(cd "$TARGET_DIR" && pwd)

echo -e "${YELLOW}目标目录: $TARGET_DIR${NC}"
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}[DRY-RUN 模式] 仅显示将要删除的文件，不会实际删除${NC}"
fi
echo ""

# 统计信息
total_files=0
deleted_files=0

# 查找所有非 .smt2 文件
while IFS= read -r -d '' file; do
    ((total_files++))
    
    # 检查是否为 .smt2 文件
    if [[ ! "$file" =~ \.smt2$ ]]; then
        if [ "$DRY_RUN" = true ]; then
            echo -e "${YELLOW}[DRY-RUN] 将删除: $file${NC}"
        else
            echo -e "${RED}删除: $file${NC}"
            rm -f "$file"
        fi
        ((deleted_files++))
    fi
done < <(find "$TARGET_DIR" -type f -print0)

# 清理空目录（可选）
echo ""
read -p "是否删除空目录? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$DRY_RUN" = true ]; then
        find "$TARGET_DIR" -type d -empty | while read -r dir; do
            echo -e "${YELLOW}[DRY-RUN] 将删除空目录: $dir${NC}"
        done
    else
        find "$TARGET_DIR" -type d -empty -delete
        echo -e "${GREEN}已删除所有空目录${NC}"
    fi
fi

# 显示总结
echo ""
echo "=========================================="
echo -e "${GREEN}总计扫描文件: $total_files${NC}"
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}将删除非 .smt2 文件: $deleted_files${NC}"
else
    echo -e "${RED}已删除非 .smt2 文件: $deleted_files${NC}"
fi
echo -e "${GREEN}保留 .smt2 文件: $((total_files - deleted_files))${NC}"
echo "=========================================="

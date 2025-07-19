#!/bin/bash
# 清理SMT文件脚本
# 功能：
# 1. 对于push/pop的例子只保留第一个check-sat之前的约束
# 2. 删除(push)、(pop)、(get-model)、(get-unsat-core)等命令
# 3. 将(set-logic QF_S)改为(set-logic QF_SLIA)

# set -e  # 注释掉，避免在错误时立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 显示帮助信息
show_help() {
    echo "用法: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -i, --input DIR        输入目录 (默认: ./benchmarks)"
    echo "  -o, --output DIR       输出目录 (默认: 覆盖原文件)"
    echo "  --backup               备份原文件"
    echo "  --dry-run              显示将要执行的操作，不实际修改文件"
    echo "  -h, --help             显示此帮助信息"
    echo ""
    echo "功能："
    echo "  1. 对于push/pop的例子只保留第一个check-sat之前的约束"
    echo "  2. 删除(push)、(pop)、(get-model)、(get-unsat-core)等命令"
    echo "  3. 将(set-logic QF_S)改为(set-logic QF_SLIA)"
}

# 清理单个SMT文件
clean_smt_file() {
    local input_file="$1"
    local output_file="$2"
    local dry_run="$3"
    
    local basename=$(basename "$input_file")
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "将要处理: $basename"
        return 0
    fi
    
    # 读取文件内容
    if [[ ! -r "$input_file" ]]; then
        log_error "文件不可读: $input_file"
        return 1
    fi
    
    # 直接使用 mapfile 读取文件，避免大文件内存问题
    local lines=()
    mapfile -t lines < "$input_file"
    
    if [[ ${#lines[@]} -eq 0 ]]; then
        log_error "文件为空或读取失败: $input_file"
        return 1
    fi
    
    local cleaned_lines=()
    local cleaned_index=0
    local found_first_check_sat=false
    local in_push_pop_block=false
    local push_count=0
    
    # 处理每一行
    for ((i=0; i<${#lines[@]}; i++)); do
        local line="${lines[i]}"
        local stripped=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        
        # 跳过空行
        if [[ -z "$stripped" ]]; then
            cleaned_lines[cleaned_index]="$line"
            ((cleaned_index++))
            continue
        fi
        
        # 替换 set-logic QF_S 为 QF_SLIA
        if [[ "$stripped" =~ ^\(set-logic[[:space:]]+QF_S\) ]]; then
            line=$(echo "$line" | sed 's/QF_S/QF_SLIA/g')
            cleaned_lines[cleaned_index]="$line"
            ((cleaned_index++))
            continue
        fi
        
        # 检查是否是第一个 check-sat
        if [[ "$stripped" =~ ^\(check-sat\) ]] && [[ "$found_first_check_sat" == "false" ]]; then
            found_first_check_sat=true
            cleaned_lines[cleaned_index]="$line"
            ((cleaned_index++))
            continue
        fi
        
        # 如果已经找到第一个 check-sat，检查是否进入 push/pop 块
        if [[ "$found_first_check_sat" == "true" ]]; then
            # 检查是否是 push
            if [[ "$stripped" =~ ^\(push\) ]]; then
                in_push_pop_block=true
                push_count=1
                continue
            fi
            
            # 如果在 push/pop 块中
            if [[ "$in_push_pop_block" == "true" ]]; then
                # 检查是否是 pop
                if [[ "$stripped" =~ ^\(pop\) ]]; then
                    push_count=$((push_count - 1))
                    if [[ $push_count -eq 0 ]]; then
                        in_push_pop_block=false
                    fi
                # 检查是否是 push（嵌套）
                elif [[ "$stripped" =~ ^\(push\) ]]; then
                    push_count=$((push_count + 1))
                fi
                continue
            fi
        fi
        
        # 跳过不需要的命令
        if [[ "$stripped" =~ ^\(pop\) ]] || \
           [[ "$stripped" =~ ^\(get-model\) ]] || \
           [[ "$stripped" =~ ^\(get-unsat-core\) ]] || \
           [[ "$stripped" =~ ^\(push\) ]]; then
            continue
        fi
        
        # 如果已经找到第一个 check-sat 且不在 push/pop 块中，跳过后续内容
        if [[ "$found_first_check_sat" == "true" ]] && [[ "$in_push_pop_block" == "false" ]]; then
            # 只保留 exit 命令
            if [[ "$stripped" =~ ^\(exit\) ]]; then
                cleaned_lines[cleaned_index]="$line"
                ((cleaned_index++))
            fi
            continue
        fi
        
        # 保留其他行
        cleaned_lines[cleaned_index]="$line"
        ((cleaned_index++))
    done
    
    # 写入输出文件
    if [[ "$dry_run" == "false" ]]; then
        # 确保输出目录存在
        local output_dir=$(dirname "$output_file")
        mkdir -p "$output_dir"
        
        # 使用更安全的方式写入文件
        {
            for line in "${cleaned_lines[@]}"; do
                echo "$line"
            done
        } > "$output_file"
        
        if [[ $? -eq 0 ]]; then
            log_success "已清理: $basename (${#lines[@]} -> ${#cleaned_lines[@]} 行)"
        else
            log_error "写入文件失败: $output_file"
            return 1
        fi
    fi
}

# 主函数
main() {
    local input_dir="./benchmarks"
    local output_dir=""
    local backup=false
    local dry_run=false
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i|--input)
                input_dir="$2"
                shift 2
                ;;
            -o|--output)
                output_dir="$2"
                shift 2
                ;;
            --backup)
                backup=true
                shift
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                log_error "未知选项: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # 检查输入目录
    if [[ ! -d "$input_dir" ]]; then
        log_error "输入目录不存在: $input_dir"
        exit 1
    fi
    
    # 查找所有以 seeds_ 开头的目录，如果没有找到则处理当前目录的 .smt2 文件
    local seeds_dirs=()
    while IFS= read -r -d '' dir; do
        seeds_dirs+=("$dir")
    done < <(find "$input_dir" -maxdepth 1 -type d -name "seeds_*" -print0)
    
    if [[ ${#seeds_dirs[@]} -eq 0 ]]; then
        log_info "在 $input_dir 中没有找到以 seeds_ 开头的目录，处理当前目录的 .smt2 文件"
        # 创建一个临时目录结构来统一处理
        local temp_dir="$input_dir/temp_single_files"
        mkdir -p "$temp_dir"
        
        # 移动所有 .smt2 文件到临时目录
        find "$input_dir" -maxdepth 1 -name "*.smt2" -exec mv {} "$temp_dir/" \;
        
        seeds_dirs=("$temp_dir")
    fi
    
    log_info "找到 ${#seeds_dirs[@]} 个 seeds_ 目录"
    
    # 处理每个目录
    for dir in "${seeds_dirs[@]}"; do
        local dirname=$(basename "$dir")
        log_info "处理目录: $dirname"
        
        # 确定输出目录
        local current_output_dir
        if [[ -n "$output_dir" ]]; then
            current_output_dir="$output_dir/$dirname"
        else
            current_output_dir="$dir"
        fi
        
        # 创建输出目录
        if [[ "$dry_run" == "false" ]]; then
            mkdir -p "$current_output_dir"
        fi
        
        # 查找所有 .smt2 文件
        local smt_files=()
        while IFS= read -r -d '' file; do
            smt_files+=("$file")
        done < <(find "$dir" -maxdepth 1 -name "*.smt2" -print0)
        
        if [[ ${#smt_files[@]} -eq 0 ]]; then
            log_warning "在 $dirname 中没有找到 .smt2 文件"
            continue
        fi
        
        log_info "  找到 ${#smt_files[@]} 个 .smt2 文件"
        
        # 处理每个文件
        local error_count=0
        local processed_count=0
        for file in "${smt_files[@]}"; do
            local basename=$(basename "$file")
            local output_file="$current_output_dir/$basename"
            
            ((processed_count++))
            log_info "处理文件 $processed_count/${#smt_files[@]}: $basename"
            
            # 备份原文件
            if [[ "$backup" == "true" ]] && [[ "$dry_run" == "false" ]]; then
                if ! cp "$file" "$file.backup" 2>/dev/null; then
                    log_error "备份文件失败: $basename"
                    ((error_count++))
                    continue
                fi
            fi
            
            # 清理文件
            if ! clean_smt_file "$file" "$output_file" "$dry_run"; then
                log_error "处理文件失败: $basename"
                ((error_count++))
                continue
            fi
        done
        
        if [[ $error_count -gt 0 ]]; then
            log_warning "目录 $dirname 中有 $error_count 个文件处理失败"
        fi
    done
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "DRY RUN 完成 - 没有实际修改文件"
    else
        log_success "所有文件处理完成"
    fi
}

# 捕获中断信号
trap 'echo ""; log_warning "用户中断，正在清理..."; exit 130' INT TERM

# 运行主函数
main "$@" 
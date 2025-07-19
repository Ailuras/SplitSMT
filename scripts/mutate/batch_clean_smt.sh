#!/bin/bash
# 批量清理SMT文件脚本
# 只负责批处理逻辑和文件管理，具体处理交给Python脚本

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
    echo "  --backup               备份原文件 (仅在覆盖原文件时生效，备份到backup_时间戳目录)"
    echo "  --dry-run              显示将要执行的操作，不实际修改文件"
    echo "  -j, --jobs N           并行处理的文件数 (默认: 4)"
    echo "  -h, --help             显示此帮助信息"
    echo ""
    echo "功能："
    echo "  1. 对于push/pop的例子只保留第一个check-sat之前的约束"
    echo "  2. 删除(push)、(pop)、(get-model)、(get-unsat-core)等命令"
    echo "  3. 将(set-logic QF_S)改为(set-logic QF_SLIA)"
}

# 主函数
main() {
    local input_dir="./benchmarks"
    local output_dir=""
    local backup=false
    local dry_run=false
    local parallel_jobs=4
    
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
            -j|--jobs)
                parallel_jobs="$2"
                shift 2
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
    
    # 检查Python脚本是否存在
    local script_dir=$(dirname "$0")
    local python_script="$script_dir/clean_smt_file.py"
    if [[ ! -f "$python_script" ]]; then
        log_error "Python脚本不存在: $python_script"
        exit 1
    fi
    
    # 查找所有以 seeds_ 开头的目录
    local seeds_dirs=()
    while IFS= read -r -d '' dir; do
        seeds_dirs+=("$dir")
    done < <(find "$input_dir" -maxdepth 1 -type d -name "seeds_*" -print0)
    
    if [[ ${#seeds_dirs[@]} -eq 0 ]]; then
        log_warning "在 $input_dir 中没有找到以 seeds_ 开头的目录"
        exit 0
    fi
    
    log_info "找到 ${#seeds_dirs[@]} 个 seeds_ 目录"
    log_info "使用 $parallel_jobs 个并行进程"
    
    local total_files=0
    local processed_files=0
    local error_files=0
    
    # 首先统计总文件数
    for dir in "${seeds_dirs[@]}"; do
        local count=$(find "$dir" -maxdepth 1 -name "*.smt2" | wc -l)
        total_files=$((total_files + count))
    done
    
    log_info "总共需要处理 $total_files 个文件"
    
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
        
                 log_info "  处理 ${#smt_files[@]} 个文件"
         
         # 创建备份目录（只有在需要备份且会覆盖原文件时）
         local backup_dir=""
         if [[ "$backup" == "true" ]] && [[ "$current_output_dir" == "$dir" ]]; then
             backup_dir="$dir/backup_$(date +%Y%m%d_%H%M%S)"
             mkdir -p "$backup_dir"
             log_info "  备份目录: $backup_dir"
         fi
         
         # 处理文件的函数
         process_file() {
             local file="$1"
             local current_output_dir="$2"
             local backup="$3"
             local dry_run="$4"
             local python_script="$5"
             local backup_dir="$6"
             
             local basename=$(basename "$file")
             local output_file="$current_output_dir/$basename"
             
             if [[ "$dry_run" == "true" ]]; then
                 echo "将要处理: $basename"
                 return 0
             fi
             
             # 只有在覆盖原文件时才需要备份
             if [[ "$backup" == "true" ]] && [[ "$current_output_dir" == "$(dirname "$file")" ]]; then
                 # 备份到专门的备份目录，不污染原始目录
                 local backup_file="$backup_dir/$(basename "$file")"
                 if ! cp "$file" "$backup_file" 2>/dev/null; then
                     echo "错误：备份文件失败: $basename" >&2
                     return 1
                 fi
             fi
             
             # 调用Python脚本处理文件
             if python3 "$python_script" "$file" "$output_file" 2>/dev/null; then
                 return 0
             else
                 echo "错误：处理文件失败: $basename" >&2
                 return 1
             fi
         }
        
        # 导出函数以便并行调用
        export -f process_file
        
                 # 使用并行处理
         if command -v parallel >/dev/null 2>&1; then
             # 使用 GNU parallel
             printf '%s\n' "${smt_files[@]}" | \
                 parallel -j "$parallel_jobs" process_file {} "$current_output_dir" "$backup" "$dry_run" "$python_script" "$backup_dir"
         else
             # 手动并行处理
             local job_count=0
             for file in "${smt_files[@]}"; do
                 if [[ $job_count -ge $parallel_jobs ]]; then
                     wait # 等待某个后台任务完成
                     job_count=$((job_count - 1))
                 fi
                 
                 process_file "$file" "$current_output_dir" "$backup" "$dry_run" "$python_script" "$backup_dir" &
                 job_count=$((job_count + 1))
             done
             
             # 等待所有后台任务完成
             wait
         fi
        
        processed_files=$((processed_files + ${#smt_files[@]}))
        log_info "  目录 $dirname 处理完成"
    done
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "DRY RUN 完成 - 没有实际修改文件"
    else
        log_success "批量处理完成！处理了 $processed_files 个文件"
    fi
}

# 捕获中断信号
trap 'echo ""; log_warning "用户中断，正在清理..."; exit 130' INT TERM

# 运行主函数
main "$@" 
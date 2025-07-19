#!/bin/bash
# 批量处理SMT文件 - 增强版本
# 用法: ./mutate.sh [method] [provider] [model] [timeout_seconds]

set -e  # 遇到错误立即退出

# 默认参数
DEFAULT_METHOD="rws"
DEFAULT_PROVIDER="openai"
DEFAULT_MODEL="gpt-4.1"
DEFAULT_TIMEOUT=300  # 5分钟超时
DEFAULT_INPUT_DIR="./benchmarks/seeds"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo "用法: $0 [method] [provider] [model] [timeout_seconds]"
    echo ""
    echo "参数:"
    echo "  method         生成方法: rws, sfc, cso (默认: $DEFAULT_METHOD)"
    echo "  provider       LLM提供商: openai, claude, deepseek (默认: $DEFAULT_PROVIDER)"
    echo "  model          模型名称 (默认: $DEFAULT_MODEL)"
    echo "  timeout_seconds 超时时间(秒) (默认: $DEFAULT_TIMEOUT)"
    echo ""
    echo "示例:"
    echo "  $0 rws openai gpt-4.1 300"
    echo "  $0 sfc claude claude-4-sonnet 600"
    echo "  $0 cso deepseek deepseek-chat 180"
    echo ""
    echo "环境变量:"
    echo "  INPUT_DIR      输入目录 (默认: $DEFAULT_INPUT_DIR)"
    echo "  OUTPUT_DIR     输出目录 (默认: {input_dir}_{method}_{model})"
}

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

# 检查依赖
check_dependencies() {
    if ! command -v python &> /dev/null; then
        log_error "Python 未安装或不在 PATH 中"
        exit 1
    fi
    
    if ! command -v timeout &> /dev/null; then
        log_warning "timeout 命令不可用，将使用内置超时控制"
        USE_BUILTIN_TIMEOUT=true
    else
        USE_BUILTIN_TIMEOUT=false
    fi
}

# 验证参数
validate_params() {
    local method=$1
    local provider=$2
    local model=$3
    
    # 验证方法
    case $method in
        rws|sfc|cso)
            ;;
        *)
            log_error "无效的方法: $method. 支持的方法: rws, sfc, cso"
            exit 1
            ;;
    esac
    
    # 验证提供商
    case $provider in
        openai|claude|deepseek)
            ;;
        *)
            log_error "无效的提供商: $provider. 支持的提供商: openai, claude, deepseek"
            exit 1
            ;;
    esac
}



# 处理单个文件
process_file() {
    local input_file=$1
    local output_dir=$2
    local method=$3
    local provider=$4
    local model=$5
    local timeout_seconds=$6
    
    local basename=$(basename "$input_file")
    local name_without_ext="${basename%.smt2}"
    local output_file="$output_dir/${name_without_ext}_${method}_${provider}.smt2"
    local start_time=$(date +%s)
    
    # 创建临时日志文件
    local temp_log=$(mktemp)
    
    # 执行命令
    if [ "$USE_BUILTIN_TIMEOUT" = true ]; then
        # 内置超时控制
        (
            python scripts/mutate/mutate_llm_new.py \
                -i "$input_file" \
                -o "$output_file" \
                --method "$method" \
                --provider "$provider" \
                --model "$model" \
                2>&1
        ) > "$temp_log" &
        
        local pid=$!
        local elapsed=0
        
        while kill -0 $pid 2>/dev/null && [ $elapsed -lt $timeout_seconds ]; do
            sleep 1
            elapsed=$((elapsed + 1))
        done
        
        if kill -0 $pid 2>/dev/null; then
            kill -9 $pid 2>/dev/null
            wait $pid 2>/dev/null
            echo "TIMEOUT" > "$temp_log"
        else
            wait $pid
        fi
    else
        # 使用系统 timeout 命令
        timeout $timeout_seconds python scripts/mutate/mutate_llm_new.py \
            -i "$input_file" \
            -o "$output_file" \
            --method "$method" \
            --provider "$provider" \
            --model "$model" \
            > "$temp_log" 2>&1
    fi
    
    local exit_code=$?
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # 检查结果
    if [ $exit_code -eq 0 ] && [ -f "$output_file" ] && [ -s "$output_file" ]; then
        # 验证输出文件是否为有效的 SMT-LIB 格式
        if head -1 "$output_file" | grep -qE '^[;(]'; then
            log_success "$basename (${duration}s)"
            return 0
        else
            log_warning "$basename - 输出格式无效 (${duration}s)"
            return 1
        fi
    elif [ $exit_code -eq 124 ] || grep -q "TIMEOUT" "$temp_log"; then
        log_warning "$basename - 超时 (${duration}s)"
        return 2
    else
        log_error "$basename - 处理失败 (${duration}s)"
        cat "$temp_log" | head -5  # 显示前5行错误信息
        return 3
    fi
}

# 主函数
main() {
    # 解析参数
    local method=${1:-$DEFAULT_METHOD}
    local provider=${2:-$DEFAULT_PROVIDER}
    local model=${3:-$DEFAULT_MODEL}
    local timeout_seconds=${4:-$DEFAULT_TIMEOUT}
    
    # 从环境变量获取目录
    local input_dir=${INPUT_DIR:-$DEFAULT_INPUT_DIR}
    local output_dir=${OUTPUT_DIR:-"${input_dir}_${method}_${model}"}
    
    # 显示帮助
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        show_help
        exit 0
    fi
    
    log_info "开始批量处理 SMT 文件"
    log_info "方法: $method"
    log_info "提供商: $provider"
    log_info "模型: $model"
    log_info "超时: ${timeout_seconds}秒"
    log_info "输入目录: $input_dir"
    log_info "输出目录: $output_dir"
    echo ""
    
    # 检查依赖
    check_dependencies
    
    # 验证参数
    validate_params "$method" "$provider" "$model"
    
    # 检查输入目录
    if [ ! -d "$input_dir" ]; then
        log_error "输入目录不存在: $input_dir"
        exit 1
    fi
    
    # 创建输出目录
    mkdir -p "$output_dir"
    
    # 获取文件列表
    local files=($input_dir/*.smt2)
    local total_files=${#files[@]}
    
    if [ $total_files -eq 0 ]; then
        log_warning "在 $input_dir 中没有找到 .smt2 文件"
        exit 0
    fi
    
    log_info "找到 $total_files 个文件待处理"
    echo ""
    
    # 统计变量
    local success_count=0
    local timeout_count=0
    local error_count=0
    local invalid_count=0
    
    # 处理文件
    for i in "${!files[@]}"; do
        local input_file="${files[$i]}"
        local basename=$(basename "$input_file")
        
        # 处理文件
        process_file "$input_file" "$output_dir" "$method" "$provider" "$model" "$timeout_seconds"
        local result=$?
        
        case $result in
            0) success_count=$((success_count + 1)) ;;
            1) invalid_count=$((invalid_count + 1)) ;;
            2) timeout_count=$((timeout_count + 1)) ;;
            3) error_count=$((error_count + 1)) ;;
        esac
    done
    
    echo ""  # 换行
    echo ""
    
    # 显示统计结果
    log_info "处理完成！统计结果："
    echo "  成功: $success_count"
    echo "  超时: $timeout_count"
    echo "  格式无效: $invalid_count"
    echo "  错误: $error_count"
    echo "  总计: $total_files"
    
    # 计算成功率
    local success_rate=$((success_count * 100 / total_files))
    echo "  成功率: ${success_rate}%"
    
    # 返回适当的退出码
    if [ $error_count -gt 0 ]; then
        exit 1
    elif [ $timeout_count -gt 0 ] || [ $invalid_count -gt 0 ]; then
        exit 2
    else
        exit 0
    fi
}

# 捕获中断信号
trap 'echo ""; log_warning "用户中断，正在清理..."; exit 130' INT TERM

# 运行主函数
main "$@"
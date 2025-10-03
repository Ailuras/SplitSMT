#pragma once
#include <string>
#include <iostream>
#include <sstream>
#include <chrono>
#include <iomanip>

namespace strp {
namespace utils {

template<typename T>
void appendToStream(std::stringstream& ss, T&& arg) {
    ss << std::forward<T>(arg);
}

template<typename T, typename... Args>
void appendToStream(std::stringstream& ss, T&& arg, Args&&... args) {
    ss << std::forward<T>(arg);
    appendToStream(ss, std::forward<Args>(args)...);
}

} // namespace utils
} // namespace strp

#define LOG_FMT(...) [&]() { \
    std::stringstream ss; \
    strp::utils::appendToStream(ss, __VA_ARGS__); \
    return ss.str(); \
}()

#define LOGGER strp::utils::Logger::getInstance()
#define LOG(level, ...) LOGGER.level(LOG_FMT(__VA_ARGS__))
#define INFO(...) LOG(info, __VA_ARGS__)
#define WARN(...) LOG(warning, __VA_ARGS__)
#define ERROR(...) LOG(error, __VA_ARGS__)
#define DEBUG(...) LOG(debug, __VA_ARGS__)
#define LOG1(...) LOG(log1, __VA_ARGS__)
#define LOG2(...) LOG(log2, __VA_ARGS__)
#define LOG3(...) LOG(log3, __VA_ARGS__)
#define LOG4(...) LOG(log4, __VA_ARGS__)
#define LOG5(...) LOG(log5, __VA_ARGS__)
namespace strp {
namespace utils {
enum class LogLevel {
    LOG5 = 10,
    LOG4 = 11,
    LOG3 = 12,
    LOG2 = 13,
    LOG1 = 14,
    DEBUG = 15,
    INFO = 20,
    WARNING = 30,
    ERROR = 40
};
class Logger {
public:
    static Logger& getInstance();
    void setLevel(LogLevel level);
    LogLevel getLevel() const;
    void error(const std::string& message);
    void warning(const std::string& message);
    void info(const std::string& message);
    void debug(const std::string& message);
    void log1(const std::string& message);
    void log2(const std::string& message);
    void log3(const std::string& message);
    void log4(const std::string& message);
    void log5(const std::string& message);
private:
    Logger() = default;
    ~Logger() = default;
    Logger(const Logger&) = delete;
    Logger& operator=(const Logger&) = delete;
    void log(LogLevel level, const std::string& color, const std::string& message);
    std::string getTimestamp() const;
    LogLevel currentLevel = LogLevel::INFO;
    static constexpr const char* RESET = "\033[0m";
    static constexpr const char* RED = "\033[31m";
    static constexpr const char* YELLOW = "\033[33m";
    static constexpr const char* GREEN = "\033[32m";
    static constexpr const char* BLUE = "\033[34m";
    static constexpr const char* MAGENTA = "\033[35m";
    static constexpr const char* CYAN = "\033[36m";
};
inline Logger& Logger::getInstance() {
    static Logger instance;
    return instance;
}
inline void Logger::setLevel(LogLevel level) {
    currentLevel = level;
}
inline LogLevel Logger::getLevel() const {
    return currentLevel;
}
inline void Logger::error(const std::string& message) {
    log(LogLevel::ERROR, RED, message);
}
inline void Logger::warning(const std::string& message) {
    log(LogLevel::WARNING, YELLOW, message);
}
inline void Logger::info(const std::string& message) {
    log(LogLevel::INFO, GREEN, message);
}
inline void Logger::debug(const std::string& message) {
    log(LogLevel::DEBUG, BLUE, message);
}
inline void Logger::log1(const std::string& message) {
    if (currentLevel <= LogLevel::LOG1) {
        log(LogLevel::LOG1, CYAN, "[LOG1] " + message);
    }
}
inline void Logger::log2(const std::string& message) {
    if (currentLevel <= LogLevel::LOG2) {
        log(LogLevel::LOG2, MAGENTA, "[LOG2] " + message);
    }
}
inline void Logger::log3(const std::string& message) {
    if (currentLevel <= LogLevel::LOG3) {
        log(LogLevel::LOG3, BLUE, "[LOG3] " + message);
    }
}
inline void Logger::log4(const std::string& message) {
    if (currentLevel <= LogLevel::LOG4) {
        log(LogLevel::LOG4, GREEN, "[LOG4] " + message);
    }
}
inline void Logger::log5(const std::string& message) {
    if (currentLevel <= LogLevel::LOG5) {
        log(LogLevel::LOG5, YELLOW, "[LOG5] " + message);
    }
}
inline std::string Logger::getTimestamp() const {
    auto now = std::chrono::system_clock::now();
    auto time = std::chrono::system_clock::to_time_t(now);
    std::stringstream ss;
    ss << std::put_time(std::localtime(&time), "%Y-%m-%d %H:%M:%S");
    return ss.str();
}
inline void Logger::log(LogLevel level, const std::string& color, const std::string& message) {
    if (static_cast<int>(level) >= static_cast<int>(currentLevel)) {
        std::cerr << color << "[" << getTimestamp() << "] " << message << RESET << std::endl;
    }
}
} // namespace utils
} // namespace strp
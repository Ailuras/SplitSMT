(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========
; Log Analysis Scenario
; Parsing structured server log entries separated by spaces and colons.
; Format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; =========

; ----------
; SAT instance: a consistent well-formed log
; ----------
(declare-const log_line_sat String)
(declare-const sat_date String)
(declare-const sat_time String)
(declare-const sat_level_colon String)
(declare-const sat_level String)
(declare-const sat_message String)
(declare-const sat_ts String)
(declare-const sat_year String)
(declare-const sat_month String)
(declare-const sat_day String)
(declare-const sat_hour String)
(declare-const sat_minute String)
(declare-const sat_second String)

; Split by spaces: [0]=date, [1]=time, [2]="LEVEL:", rest begins after index 3
(assert (= sat_date (split_at log_line_sat " " 0)))
(assert (= sat_time (split_at log_line_sat " " 1)))
(assert (= sat_level_colon (split_at log_line_sat " " 2)))
(assert (= sat_message (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Level extraction via split by ':'
(assert (= sat_level (split_at sat_level_colon ":" 0)))
(assert (= "" (split_at sat_level_colon ":" 1)))
(assert (= (num_splits sat_level_colon ":") 2))

; Timestamp formatting constraints
(assert (= sat_ts (str.++ sat_date " " sat_time)))
(assert (= (str.len sat_date) 10))
(assert (= (str.len sat_time) 8))
(assert (= (str.at sat_date 4) "-"))
(assert (= (str.at sat_date 7) "-"))
(assert (= (str.at sat_time 2) ":"))
(assert (= (str.at sat_time 5) ":"))

; Decompose date
(assert (= sat_year (str.substr sat_date 0 4)))
(assert (= sat_month (str.substr sat_date 5 2)))
(assert (= sat_day (str.substr sat_date 8 2)))

; Decompose time
(assert (= sat_hour (str.substr sat_time 0 2)))
(assert (= sat_minute (str.substr sat_time 3 2)))
(assert (= sat_second (str.substr sat_time 6 2)))

; Use regex to validate digit structure
(assert (str.in_re sat_year (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re sat_month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sat_day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sat_hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sat_minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sat_second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Concrete bounds via integer conversion (keep it simple but meaningful)
(declare-const sat_month_i Int)
(declare-const sat_day_i Int)
(declare-const sat_hour_i Int)
(declare-const sat_minute_i Int)
(declare-const sat_second_i Int)
(assert (= sat_month_i (str.to_int sat_month)))
(assert (= sat_day_i (str.to_int sat_day)))
(assert (= sat_hour_i (str.to_int sat_hour)))
(assert (= sat_minute_i (str.to_int sat_minute)))
(assert (= sat_second_i (str.to_int sat_second)))

(assert (and (>= sat_month_i 1) (<= sat_month_i 12)))
(assert (and (>= sat_day_i 1) (<= sat_day_i 31)))
(assert (and (>= sat_hour_i 0) (<= sat_hour_i 23)))
(assert (and (>= sat_minute_i 0) (<= sat_minute_i 59)))
(assert (and (>= sat_second_i 0) (<= sat_second_i 59)))

; Log level must be one of common levels
(assert (or (= sat_level "INFO") (= sat_level "WARN") (= sat_level "ERROR") (= sat_level "DEBUG")))

; Message should be non-empty and contain a keyword
(assert (> (str.len sat_message) 0))
(assert (str.contains sat_message "request"))

; Provide one concrete example witness while still exercising parsing
(assert (= log_line_sat "2025-01-09 12:34:56 INFO: request accepted"))


; ----------
; UNSAT instance: contradictory requirements about extracted log level and timestamp shape
; ----------
(declare-const log_line_unsat String)
(declare-const unsat_date String)
(declare-const unsat_time String)
(declare-const unsat_level_colon String)
(declare-const unsat_level String)
(declare-const unsat_message String)

(assert (= unsat_date (split_at log_line_unsat " " 0)))
(assert (= unsat_time (split_at log_line_unsat " " 1)))
(assert (= unsat_level_colon (split_at log_line_unsat " " 2)))
(assert (= unsat_message (split_rest log_line_unsat " " 3)))
(assert (>= (num_splits log_line_unsat " ") 4))

(assert (= unsat_level (split_at unsat_level_colon ":" 0)))
(assert (>= (num_splits unsat_level_colon ":") 2))

; Enforce that level is both INFO and ERROR (impossible)
(assert (= unsat_level "INFO"))
(assert (= unsat_level "ERROR"))

; Also enforce a malformed timestamp while requiring correct separators
(assert (= (str.len unsat_date) 9))
(assert (= (str.at unsat_date 4) "-"))
(assert (= (str.at unsat_date 7) "-"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
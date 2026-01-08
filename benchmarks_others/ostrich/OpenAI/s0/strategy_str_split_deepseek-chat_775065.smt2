(set-logic ALL)

; Uninterpreted interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Scenario: Log Analysis
; Expected rough structure (space-separated):
;   "YYYY-MM-DD HH:MM:SS:ms LEVEL: message..."
; Where LEVEL is one of INFO|WARN|ERROR and is followed by ':'

; ----------------------
; SAT instance variables
; ----------------------
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time_ms String)
(declare-const level_colon String)
(declare-const level String)
(declare-const message String)

; Basic tokenization by spaces
(assert (>= (num_splits log_line " ") 4))
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time_ms (split_at log_line " " 1)))
(assert (= level_colon (split_at log_line " " 2)))
(assert (= message (split_rest log_line " " 3)))

; Timestamp date format: YYYY-MM-DD
(assert (str.in_re ts_date (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "-")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "-")
                                 (re.range "0" "9") (re.range "0" "9"))))

; Time+ms format: HH:MM:SS:ms (ms exactly 3 digits)
(assert (str.in_re ts_time_ms (re.++ (re.range "0" "9") (re.range "0" "9")
                                    (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9")
                                    (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9")
                                    (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9") (re.range "0" "9"))))

; Extract LEVEL by splitting token "LEVEL:" on ':'
(assert (>= (num_splits level_colon ":") 2))
(assert (= level (split_at level_colon ":" 0)))

; Constrain log level values
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR")))

; Message sanity checks
(assert (>= (str.len message) 1))
(assert (not (str.contains message "\n")))

; Ensure the separator between level and message is a space in the original
; i.e., token 2 is level_colon and token 3 begins message; already enforced by split_rest

; Add a concrete satisfying example to ground the SAT portion
(assert (= log_line "2025-12-31 23:59:59:123 ERROR: disk full on /dev/sda1"))

; ------------------------
; UNSAT instance variables
; ------------------------
; Separate set of variables to create a clearly contradictory log constraint set
(declare-const bad_log_line String)
(declare-const bad_ts_date String)
(declare-const bad_ts_time_ms String)
(declare-const bad_level_colon String)
(declare-const bad_level String)

; Tokenization
(assert (>= (num_splits bad_log_line " ") 3))
(assert (= bad_ts_date (split_at bad_log_line " " 0)))
(assert (= bad_ts_time_ms (split_at bad_log_line " " 1)))
(assert (= bad_level_colon (split_at bad_log_line " " 2)))

; Bad timestamp constraints: require both correct date format and an impossible length
(assert (str.in_re bad_ts_date (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")
                                     (str.to_re "-")
                                     (re.range "0" "9") (re.range "0" "9")
                                     (str.to_re "-")
                                     (re.range "0" "9") (re.range "0" "9"))))
(assert (= (str.len bad_ts_date) 9))

; Level extraction, then contradictory constraints on the extracted level
(assert (>= (num_splits bad_level_colon ":") 2))
(assert (= bad_level (split_at bad_level_colon ":" 0)))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Ground the bad log line as well (still UNSAT due to contradictions above)
(assert (= bad_log_line "2026-01-01 00:00:00:000 INFO: boot"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

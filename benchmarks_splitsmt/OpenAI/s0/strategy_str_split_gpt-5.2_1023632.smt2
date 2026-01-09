(set-logic ALL)

; Uninterpreted interface for string split operations

; ------------------------
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by spaces to get timestamp date/time and the LEVEL:token
; Then split by ':' to extract LEVEL
; ------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_token String)
(declare-const level_str String)
(declare-const msg_str String)

; Basic splitting structure
(assert (>= (str.num_splits log_line " ") 4))
(assert (= date_str (str.split_at log_line " " 0)))
(assert (= time_str (str.split_at log_line " " 1)))
(assert (= level_token (str.split_at log_line " " 2)))
(assert (= msg_str (str.split_rest log_line " " 3)))

; Timestamp validation via regex
(assert (str.in_re date_str (str.to_re "2026-01-09")))
(assert (str.in_re time_str (str.to_re "12:34:56")))

; Level extraction and validation
(assert (>= (str.num_splits level_token ":") 2))
(assert (= level_str (str.split_at level_token ":" 0)))
(assert (str.in_re level_str (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (str.to_re "ERROR")))))

; Message sanity checks
(assert (>= (str.len msg_str) 1))
(assert (str.contains msg_str "request"))

; Constrain the full line to match intended structure using concatenation
(assert (= log_line (str.++ date_str " " time_str " " level_token " " msg_str)))

; Additional simple consistency checks
(assert (not (str.contains level_str " ")))
(assert (not (str.contains date_str " ")))
(assert (not (str.contains time_str " ")))

; ------------------------
; Scenario: Log Analysis (UNSAT instance)
; Same general structure, but contradictory timestamp and level constraints.
; ------------------------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_token String)
(declare-const bad_level String)

(assert (>= (str.num_splits bad_log_line " ") 3))
(assert (= bad_date (str.split_at bad_log_line " " 0)))
(assert (= bad_time (str.split_at bad_log_line " " 1)))
(assert (= bad_level_token (str.split_at bad_log_line " " 2)))

; Require a strict date pattern (fixed here) but also contradict it
(assert (str.in_re bad_date (str.to_re "2026-01-09")))
(assert (str.in_re bad_date (str.to_re "2026-02-30")))

; Require time to be two different fixed values simultaneously
(assert (str.in_re bad_time (str.to_re "00:00:00")))
(assert (str.in_re bad_time (str.to_re "23:59:59")))

; Level token must split and yield a known level, but also contradict it
(assert (>= (str.num_splits bad_level_token ":") 2))
(assert (= bad_level (str.split_at bad_level_token ":" 0)))
(assert (str.in_re bad_level (re.union (str.to_re "INFO") (str.to_re "ERROR"))))
(assert (str.in_re bad_level (str.to_re "DEBUG")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

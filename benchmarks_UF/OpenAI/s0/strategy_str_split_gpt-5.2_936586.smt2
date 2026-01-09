(set-logic ALL)

; Uninterpreted interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------------------------
; SAT instance: structured server log parsing
; Format (space-separated): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; ------------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_and_msg String)
(declare-const level_token String)
(declare-const msg_str String)

; Split by spaces: date, time, then the remainder
(assert (>= (num_splits log_line " ") 3))
(assert (= date_str (split_at log_line " " 0)))
(assert (= time_str (split_at log_line " " 1)))
(assert (= level_and_msg (split_rest log_line " " 2)))

; Split remainder by ": ": level token and message
(assert (>= (num_splits level_and_msg ": ") 2))
(assert (= level_token (split_at level_and_msg ": " 0)))
(assert (= msg_str (split_rest level_and_msg ": " 1)))

; Date format: YYYY-MM-DD
(assert (str.in_re date_str (re.++ (re.loop (str.to_re "0") 4 4) (str.to_re "-") (re.loop (str.to_re "0") 2 2) (str.to_re "-") (re.loop (str.to_re "0") 2 2))))

; Time format: HH:MM:SS
(assert (str.in_re time_str (re.++ (re.loop (str.to_re "0") 2 2) (str.to_re ":") (re.loop (str.to_re "0") 2 2) (str.to_re ":") (re.loop (str.to_re "0") 2 2))))

; Log level extraction: must be one of common levels
(assert (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG")))

; Message sanity checks
(assert (>= (str.len msg_str) 1))
(assert (not (str.contains msg_str "\n")))
(assert (not (str.contains msg_str "\r")))

; Provide a concrete satisfying example (still consistent with constraints)
(assert (= log_line "0000-00-00 00:00:00 INFO: service started"))

(check-sat)

; ------------------------------
; UNSAT instance: contradictory timestamp constraints for a separate log line
; ------------------------------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_rest String)

(assert (>= (num_splits bad_log_line " ") 3))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_rest (split_rest bad_log_line " " 2)))

; Force a specific bad_log_line
(assert (= bad_log_line "2025-12-31 23:59:59 ERROR: disk full"))

; Contradiction: assert bad_time equals a concrete value, but also must match an incompatible regex
(assert (= bad_time "23:59:59"))
(assert (str.in_re bad_time (str.to_re "bad")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
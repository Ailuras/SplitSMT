(set-logic ALL)

; Uninterpreted interface for split operations

; -----------------------------
; SAT instance: well-formed log line
; Format target (informal): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; -----------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_colon String)
(declare-const level_str String)
(declare-const msg_str String)
(declare-const year_str String)
(declare-const mon_str String)
(declare-const day_str String)
(declare-const hour_str String)
(declare-const min_str String)
(declare-const sec_str String)

; Space-separated tokens: date, time, level:, rest-of-message
(assert (>= (str.num_splits log_line " ") 4))
(assert (= date_str (str.split_at log_line " " 0)))
(assert (= time_str (str.split_at log_line " " 1)))
(assert (= level_colon (str.split_at log_line " " 2)))
(assert (= msg_str (str.split_rest log_line " " 3)))

; Timestamp date format checks: YYYY-MM-DD
(assert (= 10 (str.len date_str)))
(assert (= year_str (str.substr date_str 0 4)))
(assert (= "-" (str.substr date_str 4 1)))
(assert (= mon_str (str.substr date_str 5 2)))
(assert (= "-" (str.substr date_str 7 1)))
(assert (= day_str (str.substr date_str 8 2)))
(assert (str.in_re year_str (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon_str (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_str (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Timestamp time format checks: HH:MM:SS
(assert (= 8 (str.len time_str)))
(assert (= hour_str (str.substr time_str 0 2)))
(assert (= ":" (str.substr time_str 2 1)))
(assert (= min_str (str.substr time_str 3 2)))
(assert (= ":" (str.substr time_str 5 1)))
(assert (= sec_str (str.substr time_str 6 2)))
(assert (str.in_re hour_str (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_str (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_str (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Extract log level from the token like "INFO:" or "ERROR:" etc.
(assert (>= (str.num_splits level_colon ":") 2))
(assert (= level_str (str.split_at level_colon ":" 0)))
(assert (or (= level_str "INFO") (= level_str "WARN") (= level_str "ERROR") (= level_str "DEBUG")))

; Message checks
(assert (>= (str.len msg_str) 1))
(assert (not (str.contains msg_str "\n")))

; Concrete satisfiable witness-like constraints (keep still flexible)
(assert (str.prefixof "202" year_str))
(assert (str.prefixof "0" mon_str))
(assert (str.prefixof "0" day_str))
(assert (str.prefixof "1" hour_str))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory constraints on a second log line
; Intended contradiction: enforce both correct time separator ':' at pos 2
; and also '-' at pos 2.
; -----------------------------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_colon String)
(declare-const bad_level String)
(declare-const bad_msg String)

(assert (>= (str.num_splits bad_log_line " ") 4))
(assert (= bad_date (str.split_at bad_log_line " " 0)))
(assert (= bad_time (str.split_at bad_log_line " " 1)))
(assert (= bad_level_colon (str.split_at bad_log_line " " 2)))
(assert (= bad_msg (str.split_rest bad_log_line " " 3)))

(assert (= 8 (str.len bad_time)))
(assert (= ":" (str.substr bad_time 2 1)))
(assert (= "-" (str.substr bad_time 2 1)))

; Also constrain level extraction to look realistic (doesn't fix contradiction)
(assert (>= (str.num_splits bad_level_colon ":") 2))
(assert (= bad_level (str.split_at bad_level_colon ":" 0)))
(assert (or (= bad_level "INFO") (= bad_level "WARN") (= bad_level "ERROR") (= bad_level "DEBUG")))
(assert (>= (str.len bad_msg) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

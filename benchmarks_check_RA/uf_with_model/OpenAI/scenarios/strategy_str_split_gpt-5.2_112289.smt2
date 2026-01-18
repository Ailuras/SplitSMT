(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted functions for string split interface

; =====================
; Scenario: Log Analysis (SAT instance)
; Parsing structured server log entries separated by spaces and colons.
; Example shape: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; =====================

(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_full String)
(declare-const level_token String)
(declare-const level String)
(declare-const msg String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Split by spaces: [0]=date, [1]=time, [2]="LEVEL:", rest is message
(assert (>= (num_splits log_line " ") 4))
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level_token (split_at log_line " " 2)))
(assert (= msg (split_rest log_line " " 3)))
(assert (= ts_full (str.++ ts_date (str.++ " " ts_time))))

; Timestamp date validation: YYYY-MM-DD
(assert (>= (num_splits ts_date "-") 3))
(assert (= year (split_at ts_date "-" 0)))
(assert (= month (split_at ts_date "-" 1)))
(assert (= day (split_at ts_date "-" 2)))
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))

; Timestamp time validation: HH:MM:SS
(assert (>= (num_splits ts_time ":") 3))
(assert (= hour (split_at ts_time ":" 0)))
(assert (= minute (split_at ts_time ":" 1)))
(assert (= second (split_at ts_time ":" 2)))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level extraction: "LEVEL:" -> level
(assert (>= (num_splits level_token ":") 2))
(assert (= level (split_at level_token ":" 0)))

; Allowed log levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message constraints for realism
(assert (>= (str.len msg) 1))
(assert (not (str.contains msg "\n")))

; One concrete witness consistent with constraints
(assert (= log_line "2025-01-09 12:34:56 INFO: startup complete"))

; =====================
; Additional checks (still SAT): extract the first word of message and ensure it's alphabetic-ish
; =====================
(declare-const msg_first_word String)
(assert (>= (num_splits msg " ") 1))
(assert (= msg_first_word (split_at msg " " 0)))
(assert (>= (str.len msg_first_word) 3))

; =====================
; Independent UNSAT instance: conflicting timestamp format constraints
; =====================
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)

(assert (>= (num_splits bad_log_line " ") 2))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))

; Require date to look like YYYY-MM-DD but also force it to have only 2 segments when split by '-'
(assert (= (str.len (split_at bad_date "-" 0)) 4))
(assert (= (str.len (split_at bad_date "-" 1)) 2))
(assert (= (str.len (split_at bad_date "-" 2)) 2))
(assert (= (num_splits bad_date "-") 2))

; Pin a plausible bad_log_line (doesn't matter; constraints already inconsistent)
(assert (= bad_log_line "2025-01-09 12:34:56 ERROR: boom"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)

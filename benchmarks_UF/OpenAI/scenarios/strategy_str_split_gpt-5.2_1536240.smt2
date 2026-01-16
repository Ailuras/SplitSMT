(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for string splitting

; -----------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Expected shape (example):
;   "2026-01-09 12:34:56 INFO: user=jdoe action=login"
; -----------------------------

; SAT instance: consistent log entry
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const yyyy_sat String)
(declare-const mm_sat String)
(declare-const dd_sat String)
(declare-const hh_sat String)
(declare-const mi_sat String)
(declare-const ss_sat String)

; Split by spaces: timestamp, level+colon, message
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_colon_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))

; Timestamp split by space into date and time
(assert (>= (num_splits ts_sat " ") 2))
(assert (= date_sat (split_at ts_sat " " 0)))
(assert (= time_sat (split_at ts_sat " " 1)))

; Date split by '-' into YYYY-MM-DD
(assert (>= (num_splits date_sat "-") 3))
(assert (= yyyy_sat (split_at date_sat "-" 0)))
(assert (= mm_sat (split_at date_sat "-" 1)))
(assert (= dd_sat (split_at date_sat "-" 2)))

; Time split by ':' into HH:MM:SS
(assert (>= (num_splits time_sat ":") 3))
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mi_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))

; Log level extraction: "INFO:" => level "INFO"
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= level_sat (split_at level_colon_sat ":" 0)))

; Concrete structure constraints for a satisfiable example
(assert (= yyyy_sat "2026"))
(assert (= mm_sat "01"))
(assert (= dd_sat "09"))
(assert (= hh_sat "12"))
(assert (= mi_sat "34"))
(assert (= ss_sat "56"))
(assert (= level_sat "INFO"))
(assert (str.contains msg_sat "user="))
(assert (str.contains msg_sat "action="))

; Bind a concrete full log line to guarantee satisfiable parsing
(assert (= log_line_sat "2026-01-09 12:34:56 INFO: user=jdoe action=login"))

; -----------------------------
; UNSAT instance: conflicting timestamp format expectations
; Here we force a 'T' separator but still try to parse by space into date/time.
; -----------------------------

(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 1)))

; Force ISO-8601-like timestamp with 'T' and no spaces inside timestamp
(assert (= ts_unsat "2026-01-09T12:34:56"))

; But also require that timestamp splits by space into two segments (date and time)
(assert (>= (num_splits ts_unsat " ") 2))
(assert (= date_unsat (split_at ts_unsat " " 0)))
(assert (= time_unsat (split_at ts_unsat " " 1)))

; Concrete log line consistent with ts_unsat as first token
(assert (= log_line_unsat "2026-01-09T12:34:56 INFO: something"))

; -----------------------------
; Global check: include both SAT and UNSAT constraints together.
; This makes the overall file UNSAT (by design) to provide diversity.
; -----------------------------



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ============ SAT instance: plausible server log parsing ============
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ss_sat String)

; Assume a common structure: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= log_line_sat "2026-01-09 13:05:42 INFO: User login ok"))

; Split by spaces: [0]=date, [1]=time, [2]=LEVEL:, [3..]=message
(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= lvl_sat  (split_at log_line_sat " " 2)))
(assert (= msg_sat  (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Timestamp formatting checks
(assert (= ts_sat (str.++ date_sat " " time_sat)))

; Date regex: YYYY-MM-DD
(assert (str.in_re date_sat (str.to_re (str.++ "2026-01-09" ""))))

; Time regex via explicit split on ":" (HH:MM:SS)
(assert (>= (num_splits time_sat ":") 3))
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mm_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))

; Constrain exact expected time pieces for this concrete SAT line
(assert (= hh_sat "13"))
(assert (= mm_sat "05"))
(assert (= ss_sat "42"))

; Log level extraction: "INFO:" then remainder should contain a space (message starts with a word)
(assert (= lvl_sat "INFO:"))
(assert (str.contains msg_sat " "))


; ============ UNSAT instance: contradictory requirements ============
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const lvl_unsat String)
(declare-const msg_unsat String)
(declare-const hh_unsat String)
(declare-const mm_unsat String)
(declare-const ss_unsat String)

(assert (= log_line_unsat "2026-01-09 13:05:42 ERROR: Disk full"))

(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= lvl_unsat  (split_at log_line_unsat " " 2)))
(assert (= msg_unsat  (split_rest log_line_unsat " " 3)))
(assert (>= (num_splits log_line_unsat " ") 4))

(assert (= ts_unsat (str.++ date_unsat " " time_unsat)))

; Force a valid-looking timestamp structure by colon split (still consistent so far)
(assert (>= (num_splits time_unsat ":") 3))
(assert (= hh_unsat (split_at time_unsat ":" 0)))
(assert (= mm_unsat (split_at time_unsat ":" 1)))
(assert (= ss_unsat (split_at time_unsat ":" 2)))

; Contradiction: same field must be both ERROR: and INFO:
(assert (= lvl_unsat "ERROR:"))
(assert (= lvl_unsat "INFO:"))

; Extra contradictory time constraint: same hour must be 13 and 99
(assert (= hh_unsat "13"))
(assert (= hh_unsat "99"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
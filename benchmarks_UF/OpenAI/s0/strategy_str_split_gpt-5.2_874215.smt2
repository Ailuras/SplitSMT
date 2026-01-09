(set-logic ALL)

; Uninterpreted interface operations for splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --------- SAT instance: plausible log entry parsing ---------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ss_sat String)
(declare-const thread_sat String)

; Assume format: "YYYY-MM-DD HH:MM:SS LEVEL message..." (space-delimited)
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_sat (split_at log_line_sat " " 2)))
(assert (= msg_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Timestamp split by '-' into year, month, day
(assert (= date_sat ts_sat))
(assert (= (num_splits date_sat "-") 3))
(assert (= (str.len (split_at date_sat "-" 0)) 4))
(assert (= (str.len (split_at date_sat "-" 1)) 2))
(assert (= (str.len (split_at date_sat "-" 2)) 2))

; Time split by ':' into hh, mm, ss
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mm_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Basic digit-only checks for timestamp components
(assert (str.in_re (split_at date_sat "-" 0) (re.+ (re.range "0" "9"))))
(assert (str.in_re (split_at date_sat "-" 1) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (split_at date_sat "-" 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction: restrict to a standard set
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message constraints: non-empty and does not contain newline
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Optionally parse a thread token in message like "thread:XYZ" (colon-delimited)
; If message starts with "thread:" then split_at by ':' index 1 is the thread id
(assert (or (not (str.prefixof "thread:" msg_sat))
            (and (= thread_sat (split_at msg_sat ":" 1))
                 (>= (num_splits msg_sat ":") 2)
                 (> (str.len thread_sat) 0))))

; Provide at least one concrete satisfying example via additional constraints
(assert (= log_line_sat "2025-01-09 13:05:44 INFO thread:worker-7 processed=120"))

; --------- UNSAT instance: contradictory timestamp format requirements ---------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)
(declare-const yyyy_unsat String)
(declare-const mm_unsat String)
(declare-const dd_unsat String)
(declare-const hh_unsat String)
(declare-const mi_unsat String)
(declare-const ss_unsat String)

; Same intended overall format
(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_unsat (split_at log_line_unsat " " 2)))
(assert (= msg_unsat (split_rest log_line_unsat " " 3)))
(assert (>= (num_splits log_line_unsat " ") 4))

; Date expected to be YYYY-MM-DD (3 splits)
(assert (= yyyy_unsat (split_at date_unsat "-" 0)))
(assert (= mm_unsat (split_at date_unsat "-" 1)))
(assert (= dd_unsat (split_at date_unsat "-" 2)))
(assert (= (num_splits date_unsat "-") 3))
(assert (= (str.len yyyy_unsat) 4))
(assert (= (str.len mm_unsat) 2))
(assert (= (str.len dd_unsat) 2))

; Contradiction: also demand that splitting by '-' yields 4 segments
(assert (= (num_splits date_unsat "-") 4))

; Time expected HH:MM:SS but introduce another contradiction
(assert (= hh_unsat (split_at time_unsat ":" 0)))
(assert (= mi_unsat (split_at time_unsat ":" 1)))
(assert (= ss_unsat (split_at time_unsat ":" 2)))
(assert (= (num_splits time_unsat ":") 3))
(assert (= (str.len hh_unsat) 2))
(assert (= (str.len mi_unsat) 2))
(assert (= (str.len ss_unsat) 2))

; Contradiction: force time to contain no ':' at all
(assert (not (str.contains time_unsat ":")))

; Constrain a concrete line (still impossible due to contradictions above)
(assert (= log_line_unsat "2025-01-09 13:05:44 ERROR something happened"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
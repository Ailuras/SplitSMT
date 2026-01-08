(set-logic ALL)

; Uninterpreted interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; Scenario: Log Analysis
; Format (informal): "YYYY-MM-DD HH:MM:SS LEVEL: message"
; We model parsing by spaces and colons, validate timestamp shape, and extract log level.
; -----------------------------

; ===== SAT instance =====
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const ts_sat String)

; Split by spaces: [0]=date, [1]=time, [2]="LEVEL:", rest from 3 is message (possibly with spaces)
(assert (>= (num_splits log_line_sat " ") 4))
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= msg_sat (split_rest log_line_sat " " 3)))

; Validate date shape: YYYY-MM-DD
(assert (= (str.len ts_date_sat) 10))
(assert (= (str.at ts_date_sat 4) "-"))
(assert (= (str.at ts_date_sat 7) "-"))

; Validate time shape: HH:MM:SS
(assert (= (str.len ts_time_sat) 8))
(assert (= (str.at ts_time_sat 2) ":"))
(assert (= (str.at ts_time_sat 5) ":"))

; Combine timestamp and also require it is the prefix of the whole line
(assert (= ts_sat (str.++ ts_date_sat " " ts_time_sat)))
(assert (= ts_sat (str.substr log_line_sat 0 19)))

; Extract level using colon delimiter: level_colon_sat = level_sat ":"
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= level_sat (split_at level_colon_sat ":" 0)))

; Ensure the level token ends with ':' (i.e., there is an empty segment after the trailing colon)
(assert (= (split_at level_colon_sat ":" 1) ""))

; Restrict log level to common values
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message sanity checks
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Provide concrete witness to make the SAT instance satisfiable
(assert (= log_line_sat "2025-01-06 14:23:45 INFO: service started"))

; ===== UNSAT instance =====
; Contradictory timestamp checks: forces a specific line but imposes impossible character constraints.
(declare-const log_line_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)

(assert (= log_line_unsat "2025-01-06 14:23:45 ERROR: disk full"))
(assert (>= (num_splits log_line_unsat " ") 4))
(assert (= ts_date_unsat (split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (= msg_unsat (split_rest log_line_unsat " " 3)))

; Normal shape checks
(assert (= (str.len ts_date_unsat) 10))
(assert (= (str.at ts_date_unsat 4) "-"))
(assert (= (str.at ts_date_unsat 7) "-"))

(assert (= (str.len ts_time_unsat) 8))
(assert (= (str.at ts_time_unsat 2) ":"))
(assert (= (str.at ts_time_unsat 5) ":"))

; Contradiction: the 5th char of the date must be both '-' and 'X'
(assert (= (str.at ts_date_unsat 4) "X"))

; Level parsing constraints (consistent but irrelevant due to contradiction above)
(assert (>= (num_splits level_colon_unsat ":") 2))
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (= (split_at level_colon_unsat ":" 1) ""))
(assert (= level_unsat "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
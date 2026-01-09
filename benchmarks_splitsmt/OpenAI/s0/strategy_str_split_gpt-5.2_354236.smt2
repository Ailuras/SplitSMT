(set-logic ALL)

; Uninterpreted split interface (space/colon-based parsing)

; ========= SAT instance: well-formed log parsing =========
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Concrete example to make the instance robustly SAT
(assert (= log_line_sat "2026-01-09 13:05:59 INFO auth: User login ok"))

; Space-separated fields: <timestamp> <level> <component:> <message...>
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= level_sat (str.split_at log_line_sat " " 1)))
(assert (= component_sat (str.split_at log_line_sat " " 2)))
(assert (= msg_sat (str.split_rest log_line_sat " " 3)))
(assert (>= (str.num_splits log_line_sat " ") 4))

; Timestamp is further split by space: <date> <time>
(assert (= date_sat (str.split_at ts_sat " " 0)))
(assert (= time_sat (str.split_at ts_sat " " 1)))
(assert (>= (str.num_splits ts_sat " ") 2))

; Date format YYYY-MM-DD
(assert (= year_sat (str.split_at date_sat "-" 0)))
(assert (= mon_sat (str.split_at date_sat "-" 1)))
(assert (= day_sat (str.split_at date_sat "-" 2)))
(assert (= (str.num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (= (str.len mon_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re mon_sat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Time format HH:MM:SS
(assert (= hour_sat (str.split_at time_sat ":" 0)))
(assert (= min_sat (str.split_at time_sat ":" 1)))
(assert (= sec_sat (str.split_at time_sat ":" 2)))
(assert (= (str.num_splits time_sat ":") 3))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))
(assert (str.in_re hour_sat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re min_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction/validation
(assert (or (= level_sat "DEBUG") (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR")))

; Component field must end with ':' and have a non-empty name prefix
(assert (str.in_re component_sat (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9")))) (str.to_re ":"))))

; Message sanity check
(assert (> (str.len msg_sat) 0))
(assert (str.contains msg_sat "login"))

; ========= UNSAT instance: contradictory log checks =========
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const time_unsat String)
(declare-const hour_unsat String)
(declare-const sec_unsat String)
(declare-const component_unsat String)

; Concrete log line, but with contradictions below
(assert (= log_line_unsat "2026-01-09 13:05:59 INFO auth: test"))

(assert (= ts_unsat (str.split_at log_line_unsat " " 0)))
(assert (= level_unsat (str.split_at log_line_unsat " " 1)))
(assert (= component_unsat (str.split_at log_line_unsat " " 2)))
(assert (>= (str.num_splits log_line_unsat " ") 4))

; Enforce level is INFO and also ERROR (contradiction)
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Enforce timestamp has a time part, then contradict its colon split count
(assert (= time_unsat (str.split_at ts_unsat " " 1)))
(assert (>= (str.num_splits ts_unsat " ") 2))
(assert (= (str.num_splits time_unsat ":") 3))
(assert (= (str.num_splits time_unsat ":") 2))

; Additional contradiction: hour must be two chars and also empty
(assert (= hour_unsat (str.split_at time_unsat ":" 0)))
(assert (= (str.len hour_unsat) 2))
(assert (= hour_unsat ""))

; Component must end with ':' but also must not contain ':'
(assert (str.in_re component_unsat (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9")))) (str.to_re ":"))))
(assert (not (str.contains component_unsat ":")))

; A further inconsistent constraint tying seconds
(assert (= sec_unsat (str.split_at time_unsat ":" 2)))
(assert (= sec_unsat "59"))
(assert (= sec_unsat "00"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface (methodology: Solving String Split Constraints via Relaxation)

; ========= SAT instance: well-formed log analysis =========
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const host_sat String)
(declare-const service_sat String)
(declare-const pid_sat String)
(declare-const remainder_sat String)

(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= remainder_sat (split_rest log_line_sat " " 2)))
(assert (= msg_sat remainder_sat))

; Require at least: <timestamp> <level> <host> <service>:<pid> <message...>
(assert (>= (num_splits log_line_sat " ") 5))

; Timestamp must look like YYYY-MM-DDTHH:MM:SS
(assert (= date_sat (split_at ts_sat "T" 0)))
(assert (= time_sat (split_at ts_sat "T" 1)))
(assert (= (num_splits ts_sat "T") 2))

(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (num_splits date_sat "-") 3))

(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))

(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Use regex to constrain digits and allowed levels
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction: must be one of common levels
(assert (str.in_re level_sat (re.union (str.to_re "INFO")
                                      (re.union (str.to_re "WARN")
                                                (re.union (str.to_re "ERROR")
                                                          (str.to_re "DEBUG"))))))

; Host field and service:pid field
(assert (= host_sat (split_at log_line_sat " " 2)))
(assert (= service_sat (split_at (split_at log_line_sat " " 3) ":" 0)))
(assert (= pid_sat (split_at (split_at log_line_sat " " 3) ":" 1)))
(assert (= (num_splits (split_at log_line_sat " " 3) ":") 2))

; pid must be digits and non-empty
(assert (>= (str.len pid_sat) 1))
(assert (str.in_re pid_sat (re.+ (re.range "0" "9"))))

; Message should contain a colon-separated key:value somewhere (typical structured logs)
(assert (str.contains msg_sat ":"))

; Provide a concrete satisfying example (anchors the SAT instance)
(assert (= log_line_sat "2025-01-09T13:05:44 INFO web-01 auth:1234 user=alice action=login result=ok"))


; ========= UNSAT instance: contradictory timestamp/level constraints =========
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const year_unsat String)
(declare-const month_unsat String)
(declare-const day_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (>= (num_splits log_line_unsat " ") 2))

; Force a concrete log line that violates the extracted constraints below
(assert (= log_line_unsat "2025-1-09T13:05:44 TRACE anything"))

; Constrain timestamp to have two-digit month/day, but the concrete line has month "1"
(assert (= date_unsat (split_at ts_unsat "T" 0)))
(assert (= time_unsat (split_at ts_unsat "T" 1)))
(assert (= (num_splits ts_unsat "T") 2))

(assert (= year_unsat (split_at date_unsat "-" 0)))
(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (= day_unsat (split_at date_unsat "-" 2)))
(assert (= (num_splits date_unsat "-") 3))

(assert (= (str.len year_unsat) 4))
(assert (= (str.len month_unsat) 2))
(assert (= (str.len day_unsat) 2))

; Additionally require allowed levels, but the concrete line uses TRACE
(assert (str.in_re level_unsat (re.union (str.to_re "INFO")
                                        (re.union (str.to_re "WARN")
                                                  (re.union (str.to_re "ERROR")
                                                            (str.to_re "DEBUG"))))))

(check-sat)
(exit)

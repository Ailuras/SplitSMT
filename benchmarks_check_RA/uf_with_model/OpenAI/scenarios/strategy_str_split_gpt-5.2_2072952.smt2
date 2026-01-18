(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split (as provided)

; --------- SAT instance: plausible log parsing/validation ---------
(declare-const log_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Split on spaces: "<timestamp> <level>: <message>"
(assert (>= (num_splits log_sat " ") 3))
(assert (= ts_sat (split_at log_sat " " 0)))
(assert (= lvl_sat (split_at log_sat " " 1)))
(assert (= msg_sat (split_rest log_sat " " 2)))

; Level token ends with ':' and is one of common levels
(assert (str.in_re lvl_sat (re.union (str.to_re "INFO:")
                                     (str.to_re "WARN:")
                                     (str.to_re "ERROR:")
                                     (str.to_re "DEBUG:"))))

; Timestamp token: "YYYY-MM-DD:HH:MM:SS" validated via both splitting and regex
(assert (>= (num_splits ts_sat ":") 4))
(assert (= date_sat (split_at ts_sat ":" 0)))
(assert (= time_sat (str.++ (split_at ts_sat ":" 1)
                            ":" (split_at ts_sat ":" 2)
                            ":" (split_at ts_sat ":" 3))))

(assert (>= (num_splits time_sat ":") 3))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= min_sat (split_at time_sat ":" 1)))
(assert (= sec_sat (split_at time_sat ":" 2)))

; Ensure fixed widths
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))
(assert (= (str.len date_sat) 10))

; Regex for timestamp: 4 digits '-' 2 digits '-' 2 digits ':' 2 ':' 2 ':' 2 digits
(define-fun Digit () RegLan (re.range "0" "9"))
(define-fun TwoDigits () RegLan (re.++ Digit Digit))
(define-fun FourDigits () RegLan (re.++ Digit Digit Digit Digit))
(define-fun DateRE () RegLan (re.++ FourDigits (str.to_re "-") TwoDigits (str.to_re "-") TwoDigits))
(define-fun TimeRE () RegLan (re.++ TwoDigits (str.to_re ":") TwoDigits (str.to_re ":") TwoDigits))
(define-fun TsRE () RegLan (re.++ DateRE (str.to_re ":") TimeRE))
(assert (str.in_re ts_sat TsRE))

; Message constraints: non-empty and contains at least one alphabetic character
(define-fun Alpha () RegLan (re.union (re.range "a" "z") (re.range "A" "Z")))
(assert (>= (str.len msg_sat) 1))
(assert (str.in_re msg_sat (re.++ (re.* re.allchar) Alpha (re.* re.allchar))))

; Provide a concrete satisfying witness (still consistent with above constraints)
(assert (= log_sat "2025-01-09:13:07:59 INFO: Started worker"))

; --------- UNSAT instance: contradictory requirements on extracted log level ---------
(declare-const log_unsat String)
(declare-const lvl_unsat String)
(declare-const ts_unsat String)

(assert (>= (num_splits log_unsat " ") 2))
(assert (= ts_unsat (split_at log_unsat " " 0)))
(assert (= lvl_unsat (split_at log_unsat " " 1)))

; Force a concrete log where the second token is "INFO:" ...
(assert (= log_unsat "2025-01-09:13:07:59 INFO: Something happened"))

; ...but also require it to be "ERROR:" (contradiction)
(assert (= lvl_unsat "ERROR:"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)

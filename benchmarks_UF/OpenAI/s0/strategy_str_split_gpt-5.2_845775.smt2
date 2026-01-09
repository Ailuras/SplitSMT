(set-logic ALL)

; Uninterpreted str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --------- SAT instance: structured server log parsing ---------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Layout: "<timestamp> <LEVEL>:<COMPONENT>: <message>"
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= component_sat (split_at log_line_sat " " 2)))
(assert (= message_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; The third token is "<COMP>:" and the second token is "<LEVEL>:<COMP>:" is NOT assumed.
; We enforce: token1 is "LEVEL:" and token2 is "COMPONENT:" using colon split.
(assert (= (split_at level_sat ":" 0) "INFO"))
(assert (= (split_at level_sat ":" 1) ""))
(assert (= (num_splits level_sat ":") 2))

(assert (= (split_at component_sat ":" 0) "auth"))
(assert (= (split_at component_sat ":" 1) ""))
(assert (= (num_splits component_sat ":") 2))

; Message must be non-empty and contain a keyword
(assert (> (str.len message_sat) 0))
(assert (str.contains message_sat "login"))

; Timestamp format: "YYYY-MM-DDTHH:MM:SS" (length 19)
(assert (= (str.len ts_sat) 19))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) "T"))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))

; Split timestamp into date and time around 'T'
(assert (= date_sat (split_at ts_sat "T" 0)))
(assert (= time_sat (split_at ts_sat "T" 1)))
(assert (= (num_splits ts_sat "T") 2))

; Date: YYYY-MM-DD
(assert (= (str.len date_sat) 10))
(assert (= (str.at date_sat 4) "-"))
(assert (= (str.at date_sat 7) "-"))
(assert (str.in_re (str.substr date_sat 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_sat 5 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr date_sat 8 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Time: HH:MM:SS
(assert (= (str.len time_sat) 8))
(assert (= (str.at time_sat 2) ":"))
(assert (= (str.at time_sat 5) ":"))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= min_sat (split_at time_sat ":" 1)))
(assert (= sec_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))

; Require exactly 2 digits for each component (simple numeric validation)
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Provide one concrete satisfying example to anchor the instance
(assert (= log_line_sat "2025-01-09T12:34:56 INFO: auth: login ok"))

; --------- UNSAT instance: conflicting checks for log level and timestamp ---------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const rest_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (= rest_unsat (split_rest log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 3))

; Enforce level token to be both INFO: and ERROR: (impossible)
(assert (= (split_at level_unsat ":" 0) "INFO"))
(assert (= (split_at level_unsat ":" 0) "ERROR"))
(assert (= (split_at level_unsat ":" 1) ""))
(assert (= (num_splits level_unsat ":") 2))

; Enforce timestamp length 19 but also require 'T' missing by setting position 10 to space
(assert (= (str.len ts_unsat) 19))
(assert (= (str.at ts_unsat 10) "T"))
(assert (= (str.at ts_unsat 10) " "))

; Anchor the unsat instance to a concrete string (still unsat due to constraints above)
(assert (= log_line_unsat "2025-01-09 12:34:56 INFO: rest"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted string split interface (space and colon separated parsing)

; =========================
; SAT instance: well-formed log entry
; Format (informal): "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; =========================
(declare-const log_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const msg_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)

; Basic tokenization on spaces: [0]=date, [1]=time, [2]=LEVEL:, [3]=component:, [4..]=message
(assert (= ts_date_sat (split_at log_sat " " 0)))
(assert (= ts_time_sat (split_at log_sat " " 1)))
(assert (= level_colon_sat (split_at log_sat " " 2)))
(assert (>= (num_splits log_sat " ") 5))
(assert (= msg_sat (split_rest log_sat " " 4)))

; Timestamp format validation: date length and fixed '-' positions
(assert (= (str.len ts_date_sat) 10))
(assert (= (str.at ts_date_sat 4) "-"))
(assert (= (str.at ts_date_sat 7) "-"))
(assert (= year_sat (str.substr ts_date_sat 0 4)))
(assert (= month_sat (str.substr ts_date_sat 5 2)))
(assert (= day_sat (str.substr ts_date_sat 8 2)))

; Time format validation: "HH:MM:SS"
(assert (= (str.len ts_time_sat) 8))
(assert (= (str.at ts_time_sat 2) ":"))
(assert (= (str.at ts_time_sat 5) ":"))
(assert (= hour_sat (split_at ts_time_sat ":" 0)))
(assert (= min_sat (split_at ts_time_sat ":" 1)))
(assert (= sec_sat (split_at ts_time_sat ":" 2)))
(assert (= (num_splits ts_time_sat ":") 3))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Constrain overall timestamp to digits where expected using regex
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re month_sat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "3") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re min_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction: token 2 is like "INFO:"; split by ':' and take [0]
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component extraction: token 3 is like "auth:"; ensure it ends with ':' and extract prefix
(declare-const component_colon_sat String)
(assert (= component_colon_sat (split_at log_sat " " 3)))
(assert (>= (num_splits component_colon_sat ":") 2))
(assert (= component_sat (split_at component_colon_sat ":" 0)))
(assert (>= (str.len component_sat) 1))

; Message sanity checks
(assert (> (str.len msg_sat) 0))
(assert (str.contains msg_sat "="))

; Provide one concrete satisfying witness to anchor parsing
(assert (= log_sat "2025-01-09 13:05:47 INFO: auth: user=jdoe action=login status=ok"))


; =========================
; UNSAT instance: conflicting timestamp constraints
; =========================
(declare-const log_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_colon_unsat String)
(declare-const hour_unsat String)
(declare-const min_unsat String)
(declare-const sec_unsat String)
(declare-const year_unsat String)
(declare-const month_unsat String)
(declare-const day_unsat String)
(declare-const level_unsat String)

(assert (= ts_date_unsat (split_at log_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_unsat " " 2)))
(assert (>= (num_splits log_unsat " ") 4))

; Force a concrete log entry with an invalid time and then also require valid minute bound -> contradiction
(assert (= log_unsat "2025-01-09 13:65:47 WARN: core: something happened"))

; Parse date and time similarly
(assert (= (str.len ts_date_unsat) 10))
(assert (= (str.at ts_date_unsat 4) "-"))
(assert (= (str.at ts_date_unsat 7) "-"))
(assert (= year_unsat (str.substr ts_date_unsat 0 4)))
(assert (= month_unsat (str.substr ts_date_unsat 5 2)))
(assert (= day_unsat (str.substr ts_date_unsat 8 2)))
(assert (str.in_re year_unsat (re.+ (re.range "0" "9"))))

(assert (= (str.len ts_time_unsat) 8))
(assert (= (str.at ts_time_unsat 2) ":"))
(assert (= (str.at ts_time_unsat 5) ":"))
(assert (= hour_unsat (split_at ts_time_unsat ":" 0)))
(assert (= min_unsat (split_at ts_time_unsat ":" 1)))
(assert (= sec_unsat (split_at ts_time_unsat ":" 2)))
(assert (= (num_splits ts_time_unsat ":") 3))

; Validity constraints (minutes must be 00..59) conflict with concrete min="65"
(assert (str.in_re min_unsat (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction with allowed set (still consistent, included for completeness)
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (>= (num_splits level_colon_unsat ":") 2))
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))




; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

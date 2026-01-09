(set-logic ALL)

; Uninterpreted interface: str_split

; =========================
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Validating timestamp format and extracting log level.
; Include both SAT and UNSAT instances.
; =========================

; ---------- Shared declarations ----------
(declare-const log_line_sat String)
(declare-const log_line_unsat String)

(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_unsat String)
(declare-const component_unsat String)
(declare-const message_unsat String)

(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

(declare-const hour_unsat String)
(declare-const min_unsat String)
(declare-const sec_unsat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)

(declare-const year_unsat String)
(declare-const month_unsat String)
(declare-const day_unsat String)

; Helper regexes
(declare-const re_digit RegLan)
(declare-const re_2digit RegLan)
(declare-const re_4digit RegLan)
(declare-const re_level RegLan)

(assert (= re_digit (re.range "0" "9")))
(assert (= re_2digit (re.++ re_digit re_digit)))
(assert (= re_4digit (re.++ re_digit re_digit re_digit re_digit)))
(assert (= re_level (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; =====================================================
; SAT instance: a well-formed log line
; Format: YYYY-MM-DD HH:MM:SS LEVEL Component: message
; =====================================================

; Basic splitting by spaces
(assert (>= (str.num_splits log_line_sat " ") 4))
(assert (= ts_date_sat (str.split_at log_line_sat " " 0)))
(assert (= ts_time_sat (str.split_at log_line_sat " " 1)))
(assert (= level_sat (str.split_at log_line_sat " " 2)))
(assert (= component_sat (str.split_at log_line_sat " " 3)))
(assert (= message_sat (str.split_rest log_line_sat " " 4)))

; Timestamp date: YYYY-MM-DD using splits on '-'
(assert (= year_sat (str.split_at ts_date_sat "-" 0)))
(assert (= month_sat (str.split_at ts_date_sat "-" 1)))
(assert (= day_sat (str.split_at ts_date_sat "-" 2)))
(assert (= (str.num_splits ts_date_sat "-") 3))
(assert (str.in_re year_sat re_4digit))
(assert (str.in_re month_sat re_2digit))
(assert (str.in_re day_sat re_2digit))

; Timestamp time: HH:MM:SS using splits on ':'
(assert (= hour_sat (str.split_at ts_time_sat ":" 0)))
(assert (= min_sat (str.split_at ts_time_sat ":" 1)))
(assert (= sec_sat (str.split_at ts_time_sat ":" 2)))
(assert (= (str.num_splits ts_time_sat ":") 3))
(assert (str.in_re hour_sat re_2digit))
(assert (str.in_re min_sat re_2digit))
(assert (str.in_re sec_sat re_2digit))

; Log level extraction constraint
(assert (str.in_re level_sat re_level))

; Component has a trailing ':' (e.g., "Auth:")
(assert (str.suffixof ":" component_sat))
(assert (>= (str.len component_sat) 2))

; Message is non-empty and does not contain newline
(assert (> (str.len message_sat) 0))
(assert (not (str.contains message_sat "\n")))

; Concretize a consistent SAT example
(assert (= log_line_sat "2025-01-09 13:45:07 INFO Auth: user login ok"))

; =====================================================
; UNSAT instance: conflicting requirements
; Format intended same, but constraints contradict.
; =====================================================

; Split by spaces
(assert (>= (str.num_splits log_line_unsat " ") 4))
(assert (= ts_date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_unsat (str.split_at log_line_unsat " " 2)))
(assert (= component_unsat (str.split_at log_line_unsat " " 3)))
(assert (= message_unsat (str.split_rest log_line_unsat " " 4)))

; Require exactly the same general timestamp structure
(assert (= (str.num_splits ts_date_unsat "-") 3))
(assert (= year_unsat (str.split_at ts_date_unsat "-" 0)))
(assert (= month_unsat (str.split_at ts_date_unsat "-" 1)))
(assert (= day_unsat (str.split_at ts_date_unsat "-" 2)))
(assert (str.in_re year_unsat re_4digit))
(assert (str.in_re month_unsat re_2digit))
(assert (str.in_re day_unsat re_2digit))

(assert (= (str.num_splits ts_time_unsat ":") 3))
(assert (= hour_unsat (str.split_at ts_time_unsat ":" 0)))
(assert (= min_unsat (str.split_at ts_time_unsat ":" 1)))
(assert (= sec_unsat (str.split_at ts_time_unsat ":" 2)))
(assert (str.in_re hour_unsat re_2digit))
(assert (str.in_re min_unsat re_2digit))
(assert (str.in_re sec_unsat re_2digit))

; Log level must be valid per regex, but also constrained to an invalid value
(assert (str.in_re level_unsat re_level))
(assert (= level_unsat "TRACE"))

; Component must end with ':', but also forced to not contain ':'
(assert (str.suffixof ":" component_unsat))
(assert (not (str.contains component_unsat ":")))

; Fix a candidate line to show the intended structure (still UNSAT due to contradictions above)
(assert (= log_line_unsat "2025-01-09 13:45:07 TRACE Core: should be impossible"))

; Combined query: SAT and UNSAT constraints together => UNSAT overall.
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

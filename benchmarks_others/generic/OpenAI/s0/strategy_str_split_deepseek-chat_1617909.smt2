(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------- SAT instance: plausible log line --------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ss_sat String)
(declare-const rest_after_ts_sat String)
(declare-const rest_after_lvl_sat String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= rest_after_ts_sat (split_rest log_line_sat " " 1)))
(assert (= lvl_sat (split_at rest_after_ts_sat " " 0)))
(assert (= rest_after_lvl_sat (split_rest rest_after_ts_sat " " 1)))

; Level/message delimiter via ':' in the remainder after LEVEL
(assert (>= (num_splits rest_after_lvl_sat ":") 2))
(assert (= msg_sat (split_rest rest_after_lvl_sat ":" 1)))

; Timestamp format validation: length and character classes
(assert (= (str.len ts_sat) 19))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) " "))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))

; Split date/time by space
(assert (= date_sat (split_at ts_sat " " 0)))
(assert (= time_sat (split_at ts_sat " " 1)))
(assert (>= (num_splits ts_sat " ") 2))

; Date components: YYYY-MM-DD
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= mon_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (= (str.len mon_sat) 2))
(assert (= (str.len day_sat) 2))

; Time components: HH:MM:SS
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mm_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Digit regex
(define-fun DIGIT () RegLan (re.range "0" "9"))
(define-fun TWO_DIGITS () RegLan (re.++ DIGIT DIGIT))
(define-fun FOUR_DIGITS () RegLan (re.++ DIGIT (re.++ DIGIT (re.++ DIGIT DIGIT))))

; Enforce digits in components
(assert (str.in_re year_sat FOUR_DIGITS))
(assert (str.in_re mon_sat TWO_DIGITS))
(assert (str.in_re day_sat TWO_DIGITS))
(assert (str.in_re hh_sat TWO_DIGITS))
(assert (str.in_re mm_sat TWO_DIGITS))
(assert (str.in_re ss_sat TWO_DIGITS))

; Acceptable levels (mix of common ones)
(assert (or (= lvl_sat "INFO") (= lvl_sat "WARN") (= lvl_sat "ERROR") (= lvl_sat "DEBUG")))

; Message must be non-empty after ':' (allow leading space but require some content)
(assert (>= (str.len msg_sat) 1))

; Provide a concrete satisfying example to anchor SAT instance
(assert (= log_line_sat "2025-12-31 23:59:58 INFO: rotation completed"))

; -------- UNSAT instance: contradictory requirements --------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const year_unsat String)
(declare-const mon_unsat String)
(declare-const day_unsat String)
(declare-const hh_unsat String)
(declare-const mm_unsat String)
(declare-const ss_unsat String)
(declare-const rest_after_ts_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= rest_after_ts_unsat (split_rest log_line_unsat " " 1)))
(assert (= lvl_unsat (split_at rest_after_ts_unsat " " 0)))

; Same timestamp structure constraints
(assert (= (str.len ts_unsat) 19))
(assert (= (str.at ts_unsat 4) "-"))
(assert (= (str.at ts_unsat 7) "-"))
(assert (= (str.at ts_unsat 10) " "))
(assert (= (str.at ts_unsat 13) ":"))
(assert (= (str.at ts_unsat 16) ":"))

; Split date/time and enforce digit shapes
(assert (= date_unsat (split_at ts_unsat " " 0)))
(assert (= time_unsat (split_at ts_unsat " " 1)))
(assert (= (num_splits ts_unsat " ") 2))

(assert (= year_unsat (split_at date_unsat "-" 0)))
(assert (= mon_unsat (split_at date_unsat "-" 1)))
(assert (= day_unsat (split_at date_unsat "-" 2)))
(assert (= (num_splits date_unsat "-") 3))
(assert (= (str.len year_unsat) 4))
(assert (= (str.len mon_unsat) 2))
(assert (= (str.len day_unsat) 2))
(assert (str.in_re year_unsat FOUR_DIGITS))
(assert (str.in_re mon_unsat TWO_DIGITS))
(assert (str.in_re day_unsat TWO_DIGITS))

(assert (= hh_unsat (split_at time_unsat ":" 0)))
(assert (= mm_unsat (split_at time_unsat ":" 1)))
(assert (= ss_unsat (split_at time_unsat ":" 2)))
(assert (= (num_splits time_unsat ":") 3))
(assert (str.in_re hh_unsat TWO_DIGITS))
(assert (str.in_re mm_unsat TWO_DIGITS))
(assert (str.in_re ss_unsat TWO_DIGITS))

; Contradiction: require level to be both INFO and ERROR
(assert (= lvl_unsat "INFO"))
(assert (= lvl_unsat "ERROR"))

; Anchor with a plausible line (still unsat due to level contradiction)
(assert (= log_line_unsat "2026-01-01 00:00:00 INFO: happy new year"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

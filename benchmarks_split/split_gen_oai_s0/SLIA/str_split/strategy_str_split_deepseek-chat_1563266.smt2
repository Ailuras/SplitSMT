(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------ SAT instance: structured log parsing ------------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const rest_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const msg_sat String)

; Tokenize by spaces: "<timestamp> <level> <message...>"
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_sat   (split_at log_line_sat " " 0)))
(assert (= lvl_sat  (split_at log_line_sat " " 1)))
(assert (= rest_sat (split_rest log_line_sat " " 2)))

; Message should be non-empty and not contain newline
(assert (> (str.len rest_sat) 0))
(assert (not (str.contains rest_sat "\n")))

; Restrict log level
(assert (or (= lvl_sat "INFO") (= lvl_sat "WARN") (= lvl_sat "ERROR") (= lvl_sat "DEBUG")))

; Timestamp format validation: HH:MM:SS (very common in logs)
(assert (>= (num_splits ts_sat ":") 3))
(assert (= hour_sat   (split_at ts_sat ":" 0)))
(assert (= minute_sat (split_at ts_sat ":" 1)))
(assert (= second_sat (split_at ts_sat ":" 2)))

; Enforce exact two digits for each field
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Digit regex
(define-fun is2digits ((s String)) Bool
  (str.in_re s (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (is2digits hour_sat))
(assert (is2digits minute_sat))
(assert (is2digits second_sat))

; Additionally constrain minute and second to be 00-59 using regex
; 00-59 = [0-5][0-9]
(define-fun is00to59 ((s String)) Bool
  (str.in_re s (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (is00to59 minute_sat))
(assert (is00to59 second_sat))

; Constrain hour to be 00-23 using a union of 0[0-9],1[0-9],2[0-3]
(define-fun is00to23 ((s String)) Bool
  (str.in_re s (re.union
                 (re.++ (str.to_re "0") (re.range "0" "9"))
                 (re.++ (str.to_re "1") (re.range "0" "9"))
                 (re.++ (str.to_re "2") (re.range "0" "3")))))
(assert (is00to23 hour_sat))

; Build a more specific message structure: "user:<id> action:<word>"
; Split by spaces inside rest
(assert (>= (num_splits rest_sat " ") 2))
(assert (= msg_sat rest_sat))
(declare-const kv1_sat String)
(declare-const kv2_sat String)
(assert (= kv1_sat (split_at msg_sat " " 0)))
(assert (= kv2_sat (split_at msg_sat " " 1)))

; Each kv is key:value using colon
(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)
(assert (>= (num_splits kv1_sat ":") 2))
(assert (>= (num_splits kv2_sat ":") 2))
(assert (= key1_sat (split_at kv1_sat ":" 0)))
(assert (= val1_sat (split_at kv1_sat ":" 1)))
(assert (= key2_sat (split_at kv2_sat ":" 0)))
(assert (= val2_sat (split_at kv2_sat ":" 1)))

(assert (= key1_sat "user"))
(assert (= key2_sat "action"))
(assert (> (str.len val1_sat) 0))
(assert (> (str.len val2_sat) 0))

; user id is alphanumeric+underscore
(assert (str.in_re val1_sat (re.+ (re.union (re.range "a" "z")
                                         (re.range "A" "Z")
                                         (re.range "0" "9")
                                         (str.to_re "_")))))

; action is lowercase letters
(assert (str.in_re val2_sat (re.+ (re.range "a" "z"))))

; Ensure the overall line is consistent with the split (weak consistency check)
; Enforce that log_line_sat begins with ts_sat + space + lvl_sat + space
(assert (str.prefixof (str.++ ts_sat " " lvl_sat " ") log_line_sat))

; ------------ UNSAT instance: contradicting timestamp checks ------------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_unsat String)
(declare-const hour_unsat String)
(declare-const minute_unsat String)
(declare-const second_unsat String)

(assert (>= (num_splits log_line_unsat " ") 2))
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= lvl_unsat (split_at log_line_unsat " " 1)))
(assert (or (= lvl_unsat "INFO") (= lvl_unsat "ERROR")))

(assert (>= (num_splits ts_unsat ":") 3))
(assert (= hour_unsat   (split_at ts_unsat ":" 0)))
(assert (= minute_unsat (split_at ts_unsat ":" 1)))
(assert (= second_unsat (split_at ts_unsat ":" 2)))

(assert (= (str.len hour_unsat) 2))
(assert (= (str.len minute_unsat) 2))
(assert (= (str.len second_unsat) 2))

; Force minute to be in 00-59
(assert (is00to59 minute_unsat))

; Contradiction: also require minute to be "60"
(assert (= minute_unsat "60"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
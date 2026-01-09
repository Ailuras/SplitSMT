(set-logic ALL)

; Uninterpreted split interface (str_split)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed vars (preserved core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_193661 () String)

; Log-analysis variables
(declare-const logline String)
(declare-const ts String)
(declare-const lvl_field String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const day String)
(declare-const month String)
(declare-const year String)
(declare-const hh_i Int)
(declare-const mm_i Int)
(declare-const ss_i Int)

; Core structure from seed, but point input to the logline
(assert (= var_0xINPUT_193661 logline))
(assert (= T_1 (= var_0xINPUT_193661 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; Basic split expectations: "<timestamp> <LEVEL>: <message>"
(assert (= ts (split_at logline " " 0)))
(assert (= lvl_field (split_at logline " " 1)))
(assert (= msg (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Extract log level from something like "INFO:" / "WARN:" / "ERROR:" / "DEBUG:"
(assert (= level (split_at lvl_field ":" 0)))
(assert (>= (num_splits lvl_field ":") 2))

; Allowed levels (SAT branch)
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Timestamp format: "YYYY-MM-DDTHH:MM:SS"
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))
(assert (= (num_splits ts "T") 2))

(assert (= year (split_at date "-" 0)))
(assert (= month (split_at date "-" 1)))
(assert (= day (split_at date "-" 2)))
(assert (= (num_splits date "-") 3))

(assert (= hh (split_at time ":" 0)))
(assert (= mm (split_at time ":" 1)))
(assert (= ss (split_at time ":" 2)))
(assert (= (num_splits time ":") 3))

; Length checks
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Numeric parsing for time; enforce ranges
(assert (= hh_i (str.to_int hh)))
(assert (= mm_i (str.to_int mm)))
(assert (= ss_i (str.to_int ss)))
(assert (and (>= hh_i 0) (<= hh_i 23)))
(assert (and (>= mm_i 0) (<= mm_i 59)))
(assert (and (>= ss_i 0) (<= ss_i 59)))

; Message sanity
(assert (> (str.len msg) 0))
(assert (not (str.contains msg "\n")))

; Add an UNSAT-inducing constraint (kept alongside SAT constraints) for diversity
; This forces a contradiction whenever the level is one of the allowed values.
(assert (and (= level "INFO") (not (= level "INFO"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
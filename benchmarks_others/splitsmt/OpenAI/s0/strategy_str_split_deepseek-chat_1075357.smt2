(set-logic ALL)

; Uninterpreted interface for string split (as provided)

; --------- SAT instance: plausible structured log entry ---------
(declare-const log_line String)
(declare-const ts String)          ; full timestamp token, e.g., "2026-01-07T12:34:56"
(declare-const level String)       ; e.g., "INFO"
(declare-const module String)      ; e.g., "auth"
(declare-const msg String)         ; rest of the message after module

(declare-const date_part String)   ; "2026-01-07"
(declare-const time_part String)   ; "12:34:56"
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Assume a structure: "<ts> <level> <module>: <msg>"
(assert (= ts (str.split_at log_line " " 0)))
(assert (= level (str.split_at log_line " " 1)))
(assert (= module (str.split_at log_line " " 2)))
(assert (= msg (str.split_rest log_line " " 3)))

; Require at least 4 space-separated segments (ts, level, module:, msg...)
(assert (>= (str.num_splits log_line " ") 4))

; Module token must contain a colon and split into exactly 2 parts around ':'
(assert (str.contains module ":"))
(assert (>= (str.num_splits module ":") 2))
(assert (= (str.split_at module ":" 1) ""))

; Timestamp token must contain 'T' separating date and time
(assert (str.contains ts "T"))
(assert (>= (str.num_splits ts "T") 2))
(assert (= date_part (str.split_at ts "T" 0)))
(assert (= time_part (str.split_at ts "T" 1)))

; Date part is split by '-' into 3 components
(assert (= year (str.split_at date_part "-" 0)))
(assert (= month (str.split_at date_part "-" 1)))
(assert (= day (str.split_at date_part "-" 2)))
(assert (= (str.num_splits date_part "-") 3))

; Time part is split by ':' into 3 components
(assert (= hour (str.split_at time_part ":" 0)))
(assert (= minute (str.split_at time_part ":" 1)))
(assert (= second (str.split_at time_part ":" 2)))
(assert (= (str.num_splits time_part ":") 3))

; Log level must be one of a small set
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Basic timestamp format validation via regex for each piece
(assert (str.in_re year (re.range "0" "9"))) ; will be strengthened below
(assert (str.in_re month (re.range "0" "9")))
(assert (str.in_re day (re.range "0" "9")))
(assert (str.in_re hour (re.range "0" "9")))
(assert (str.in_re minute (re.range "0" "9")))
(assert (str.in_re second (re.range "0" "9")))

; Strengthen: fixed widths
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Ensure all characters in each component are digits by matching against digit-star and fixed length
(declare-const DIGIT_RE RegLan)
(assert (= DIGIT_RE (re.range "0" "9")))
(assert (str.in_re year (re.++ DIGIT_RE (re.++ DIGIT_RE (re.++ DIGIT_RE DIGIT_RE)))))
(assert (str.in_re month (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re day (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re hour (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re minute (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re second (re.++ DIGIT_RE DIGIT_RE)))

; Concrete anchoring to make the SAT instance definitely satisfiable
(assert (= log_line "2026-01-07T12:34:56 INFO auth: login succeeded"))

; --------- UNSAT instance: contradictory requirements about level extraction ---------
(declare-const bad_line String)
(declare-const bad_level String)
(declare-const bad_ts String)

(assert (= bad_ts (str.split_at bad_line " " 0)))
(assert (= bad_level (str.split_at bad_line " " 1)))
(assert (>= (str.num_splits bad_line " ") 3))

; Require that level is both INFO and ERROR simultaneously (impossible)
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Also put some timestamp structure constraints (irrelevant to inconsistency but realistic)
(assert (str.contains bad_ts "T"))
(assert (= (str.num_splits bad_ts "T") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]

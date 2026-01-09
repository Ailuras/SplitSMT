(set-logic ALL)

; Uninterpreted split interface (per scenario)

; Log analysis variables
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date String)
(declare-const time String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Auxiliary strings (mutated from seed: keep simple regex over + and *)
(declare-const x String)
(declare-const y String)

; Seed-like constraints retained but adjusted to connect with log parsing
(assert (str.in_re x (re.* (str.to_re "+*"))))
(assert (str.in_re y (re.* (str.to_re "+*"))))
(assert (= (str.len x) 2))
(assert (= (str.len y) 4))

; Core structure: parsing log entries separated by spaces and colons
; Expected shape: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (= ts (str.split_at logline " " 0)))
(assert (= level (str.split_at logline " " 1)))
(assert (= message (str.split_rest logline " " 2)))
(assert (>= (str.num_splits logline " ") 3))

; Timestamp validation: split into date and time by space inside ts
(assert (= date (str.split_at ts " " 0)))
(assert (= time (str.split_at ts " " 1)))
(assert (= (str.num_splits ts " ") 2))

; Basic timestamp length checks: "YYYY-MM-DD" is 10, "HH:MM:SS" is 8
(assert (= (str.len date) 10))
(assert (= (str.len time) 8))

; Time parts extraction by ':'
(assert (= hour (str.split_at time ":" 0)))
(assert (= minute (str.split_at time ":" 1)))
(assert (= second (str.split_at time ":" 2)))
(assert (= (str.num_splits time ":") 3))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level extraction: level must end with ':' and be one of common levels
; We encode by requiring a 2-way split on ':' with empty rest (i.e., exactly one colon at end)
(declare-const level_tag String)
(declare-const level_after_colon String)
(assert (= level_tag (str.split_at level ":" 0)))
(assert (= level_after_colon (str.split_at level ":" 1)))
(assert (= (str.num_splits level ":") 2))
(assert (= level_after_colon ""))
(assert (or (= level_tag "INFO") (= level_tag "WARN") (= level_tag "ERROR") (= level_tag "DEBUG")))

; Message must be non-empty
(assert (> (str.len message) 0))

; Use x and y to constrain message slightly (still within +/* alphabet via concatenation)
; Enforce message starts with x and contains y somewhere
(assert (str.prefixof x message))
(assert (str.contains message y))

; SAT/UNSAT mix: add a deliberate contradiction about level to create UNSAT
(assert (= level_tag "INFO"))
(assert (= level_tag "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

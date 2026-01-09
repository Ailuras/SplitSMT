(set-logic ALL)

; Uninterpreted interface operations for str_split

; -------- SAT instance: structured log parsing --------
(declare-const log_line String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const y String)
(declare-const mo String)
(declare-const da String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Expected rough structure: "YYYY-MM-DD:HH:MM:SS LEVEL MESSAGE..."
(assert (>= (str.num_splits log_line " ") 3))
(assert (= ts (str.split_at log_line " " 0)))
(assert (= level (str.split_at log_line " " 1)))
(assert (= message (str.split_rest log_line " " 2)))

; Timestamp split by ':' into date and time components
(assert (>= (str.num_splits ts ":") 4))
(assert (= date_part (str.split_at ts ":" 0)))
(assert (= hh (str.split_at ts ":" 1)))
(assert (= mm (str.split_at ts ":" 2)))
(assert (= ss (str.split_at ts ":" 3)))

; Date split by '-': YYYY-MM-DD
(assert (= y (str.split_at date_part "-" 0)))
(assert (= mo (str.split_at date_part "-" 1)))
(assert (= da (str.split_at date_part "-" 2)))
(assert (= (str.num_splits date_part "-") 3))

; Fixed lengths for components
(assert (= (str.len y) 4))
(assert (= (str.len mo) 2))
(assert (= (str.len da) 2))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Digits-only constraints using regex
(assert (str.in_re y (re.+ (re.range "0" "9"))))
(assert (str.in_re mo (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re da (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Common log levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message sanity: non-empty, and does not contain a newline
(assert (> (str.len message) 0))
(assert (not (str.contains message "\n")))

; Optional: ensure ts is exactly the expected concatenation shape
(assert (= ts (str.++ y "-" mo "-" da ":" hh ":" mm ":" ss)))

; Provide a concrete witness to ensure SAT
(assert (= log_line "2025-01-09:13:45:07 INFO Service started"))

; -------- UNSAT instance: contradicting level extraction --------
(declare-const bad_line String)
(declare-const bad_level String)

(assert (>= (str.num_splits bad_line " ") 2))
(assert (= bad_level (str.split_at bad_line " " 1)))
(assert (= bad_line "2025-01-09:13:45:07 ERROR Disk full"))

; Contradiction: extracted level must be both ERROR and INFO
(assert (= bad_level "ERROR"))
(assert (= bad_level "INFO"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

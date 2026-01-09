(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Log analysis variables
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const datepart String)
(declare-const timepart String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const kvpart String)
(declare-const key1 String)
(declare-const val1 String)

; Preserve seed-like structure with regex constraints (mutated)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "b") (re.* (str.to_re "a"))))))
(assert (str.in_re y (re.* (re.++ (str.to_re "b") (str.to_re "a")))))

; Core structure: parse structured server log entry separated by spaces
; Expected shape: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= message (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Timestamp format validation via splitting on '-' and ':'
(assert (= datepart (split_at ts " " 0)))
(assert (= timepart (split_at ts " " 1)))
(assert (= year (split_at datepart "-" 0)))
(assert (= month (split_at datepart "-" 1)))
(assert (= day (split_at datepart "-" 2)))
(assert (= hour (split_at timepart ":" 0)))
(assert (= minute (split_at timepart ":" 1)))
(assert (= second (split_at timepart ":" 2)))
(assert (= (num_splits datepart "-") 3))
(assert (= (num_splits timepart ":") 3))

; Regex helpers
(define-fun digit () RegLan (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9")))))))))))
(define-fun two_digits () RegLan (re.++ digit digit))
(define-fun four_digits () RegLan (re.++ digit (re.++ digit (re.++ digit digit))))

; Enforce exact numeric widths
(assert (str.in_re year four_digits))
(assert (str.in_re month two_digits))
(assert (str.in_re day two_digits))
(assert (str.in_re hour two_digits))
(assert (str.in_re minute two_digits))
(assert (str.in_re second two_digits))

; Level extraction: LEVEL must end with ':' and be one of INFO/WARN/ERROR/DEBUG
(assert (or (= level "INFO:") (= level "WARN:") (= level "ERROR:") (= level "DEBUG:")))

; Message must be non-empty and contain a key-value pair token separated by '=' somewhere
(assert (> (str.len message) 0))
(assert (str.contains message "="))

; Parse first key-value token from message by splitting on space, then '='
(assert (= kvpart (split_at message " " 0)))
(assert (= key1 (split_at kvpart "=" 0)))
(assert (= val1 (split_at kvpart "=" 1)))
(assert (>= (num_splits kvpart "=") 2))

; Key must be alphabetic-ish (simple over-approx): starts with 'b' then any number of 'a' (seed-themed)
(assert (str.in_re key1 (re.++ (str.to_re "b") (re.* (str.to_re "a")))))

; SAT branch constraints
(push 1)
  ; Concrete exemplifying constraints to ensure satisfiable instance exists
  (assert (= year "2024"))
  (assert (= month "01"))
  (assert (= day "09"))
  (assert (= hour "13"))
  (assert (= minute "37"))
  (assert (= second "42"))
  (assert (= level "INFO:"))
  (assert (= key1 "baaa"))
  (assert (= val1 "ok"))
  ; Tie together a consistent logline (not enforcing exact reconstruction due to uninterpreted split)
  (assert (>= (str.len logline) 10))
(pop 1)

; UNSAT branch constraints: contradict level and timestamp width simultaneously
(push 1)
  (assert (= level "INFO:"))
  (assert (= level "ERROR:"))
  (assert (str.in_re year two_digits))
  (assert (str.in_re year four_digits))
  (assert (not (= year "")))
  (check-sat)
(pop 1)

; Overall instance remains satisfiable without the UNSAT branch
(check-sat)


; [GENERATION STATUS: SUCCESS]
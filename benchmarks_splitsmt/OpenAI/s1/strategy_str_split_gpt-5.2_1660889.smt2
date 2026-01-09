(set-logic ALL)

; Uninterpreted interface for split operations

; Log analysis scenario: parse "timestamp level: message"
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const message String)

; Mutated seed variables preserved
(declare-const key2 String)
(declare-const value2 String)

; Core structure: space-separated fields
(assert (= timestamp (str.split_at log_entry " " 0)))
(assert (= level_with_colon (str.split_at log_entry " " 1)))
(assert (= message (str.split_rest log_entry " " 2)))
(assert (>= (str.num_splits log_entry " ") 3))

; Level extraction via colon separator
(assert (= level (str.split_at level_with_colon ":" 0)))
(assert (>= (str.num_splits level_with_colon ":") 2))

; Timestamp format validation: YYYY-MM-DDThh:mm:ssZ (length 20)
(assert (= (str.len timestamp) 20))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))
(assert (= (str.at timestamp 19) "Z"))

; Regex for digits-only positions in timestamp
(define-fun isDigit ((c String)) Bool (str.in_re c (re.range "0" "9")))
(assert (isDigit (str.at timestamp 0)))
(assert (isDigit (str.at timestamp 1)))
(assert (isDigit (str.at timestamp 2)))
(assert (isDigit (str.at timestamp 3)))
(assert (isDigit (str.at timestamp 5)))
(assert (isDigit (str.at timestamp 6)))
(assert (isDigit (str.at timestamp 8)))
(assert (isDigit (str.at timestamp 9)))
(assert (isDigit (str.at timestamp 11)))
(assert (isDigit (str.at timestamp 12)))
(assert (isDigit (str.at timestamp 14)))
(assert (isDigit (str.at timestamp 15)))
(assert (isDigit (str.at timestamp 17)))
(assert (isDigit (str.at timestamp 18)))

; Log level constraints: typical levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message must be non-empty and contain a colon-delimited kv pair somewhere
(assert (> (str.len message) 0))
(assert (str.contains message "="))

; Extend/mutate seed constraints: interpret key2/value2 as a parsed kv token inside message
(assert (= key2 (str.split_at message "=" 0)))
(assert (= value2 (str.split_at message "=" 1)))
(assert (>= (str.num_splits message "=") 2))

; Preserve some seed-like structure: index/bounds + contains checks
(assert (>= 1 0))
(assert (>= (- (str.len value2) 1) 0))
(assert (not (= (str.indexof value2 "=" 0) (- 1))))
(assert (str.contains value2 ","))

; Key should not be empty and must look like a header-ish token
(assert (> (str.len key2) 0))
(assert (str.in_re key2 (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "-"))))) (re.* (str.to_re "")))))

; SAT: consistent constraints
(check-sat)

; UNSAT variant: force contradictory timestamp length while keeping structure
(assert (= (str.len timestamp) 19))
(check-sat)
(exit)

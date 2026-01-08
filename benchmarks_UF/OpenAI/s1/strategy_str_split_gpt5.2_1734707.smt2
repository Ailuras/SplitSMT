(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; We model extraction via the provided str_split interface (uninterpreted functions).


(declare-const logline String)
(declare-const timestamp String)
(declare-const level_and_msg String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const mi String)
(declare-const ss String)

; Core structure: first token is timestamp, rest contains LEVEL: message
(assert (= timestamp (split_at logline " " 0)))
(assert (= level_and_msg (split_rest logline " " 1)))
(assert (>= (num_splits logline " ") 2))

; Parse LEVEL:message from the rest (delimiter ":")
(assert (= level (split_at level_and_msg ":" 0)))
(assert (= msg (split_rest level_and_msg ":" 1)))
(assert (>= (num_splits level_and_msg ":") 2))

; Timestamp is of form "YYYY-MM-DDTHH:MM:SS" (19 chars)
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Split timestamp into date and time parts
(assert (= date (split_at timestamp "T" 0)))
(assert (= time (split_at timestamp "T" 1)))
(assert (= (str.len date) 10))
(assert (= (str.len time) 8))

; Split date/time further by '-' and ':'
(assert (= yyyy (split_at date "-" 0)))
(assert (= mm   (split_at date "-" 1)))
(assert (= dd   (split_at date "-" 2)))
(assert (>= (num_splits date "-") 3))

(assert (= hh (split_at time ":" 0)))
(assert (= mi (split_at time ":" 1)))
(assert (= ss (split_at time ":" 2)))
(assert (>= (num_splits time ":") 3))

; Regex validation for numeric fields
(define-fun DIGIT () RegLan (re.range "0" "9"))
(define-fun D2 () RegLan ((_ re.loop 2 2) DIGIT))
(define-fun D4 () RegLan ((_ re.loop 4 4) DIGIT))

(assert (str.in_re yyyy D4))
(assert (str.in_re mm D2))
(assert (str.in_re dd D2))
(assert (str.in_re hh D2))
(assert (str.in_re mi D2))
(assert (str.in_re ss D2))

; Log level extraction: constrain to common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message constraints: non-empty and must not start with a space after colon
(assert (> (str.len msg) 0))
(assert (not (= (str.at msg 0) " ")))

; Preserve seed's core negated regex-style constraint, mutated to fit logline: disallow a specific unrelated pattern.
(assert (not (str.in_re logline (re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z") (str.to_re "|") (re.range "a" "z"))) (str.to_re "0") ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "\u{a}")))))

; UNSAT twist: additionally require the log level to be simultaneously INFO and ERROR
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

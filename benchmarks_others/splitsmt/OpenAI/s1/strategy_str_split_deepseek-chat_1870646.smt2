(set-logic ALL)

; Scenario: Log Analysis
; Parsing a structured server log entry: "YYYY-MM-DD HH:MM:SS LEVEL: message"

; Uninterpreted str_split interface

; Log entry and extracted fields
(declare-const log String)
(declare-const date String)
(declare-const time String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const message String)

; Auxiliary substrings for timestamp validation
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const mi String)
(declare-const ss String)

; Split by spaces: date time LEVEL: message...
(assert (= date (str.split_at log " " 0)))
(assert (= time (str.split_at log " " 1)))
(assert (= level_with_colon (str.split_at log " " 2)))
(assert (= message (str.split_rest log " " 3)))
(assert (>= (str.num_splits log " ") 4))

; Split LEVEL: by colon to extract level
(assert (= level (str.split_at level_with_colon ":" 0)))
(assert (= "" (str.split_at level_with_colon ":" 1)))
(assert (= 2 (str.num_splits level_with_colon ":")))

; Timestamp format checks (structural, via lengths and fixed separators)
(assert (= 10 (str.len date)))
(assert (= "-" (str.at date 4)))
(assert (= "-" (str.at date 7)))
(assert (= yyyy (str.substr date 0 4)))
(assert (= mm   (str.substr date 5 2)))
(assert (= dd   (str.substr date 8 2)))

(assert (= 8 (str.len time)))
(assert (= ":" (str.at time 2)))
(assert (= ":" (str.at time 5)))
(assert (= hh (str.substr time 0 2)))
(assert (= mi (str.substr time 3 2)))
(assert (= ss (str.substr time 6 2)))

; Regex digit constraints for each numeric component
(define-fun Digit () RegLan (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9")))))))))))
(define-fun TwoDigits () RegLan (re.++ Digit Digit))
(define-fun FourDigits () RegLan (re.++ TwoDigits TwoDigits))

(assert (str.in_re yyyy FourDigits))
(assert (str.in_re mm TwoDigits))
(assert (str.in_re dd TwoDigits))
(assert (str.in_re hh TwoDigits))
(assert (str.in_re mi TwoDigits))
(assert (str.in_re ss TwoDigits))

; Numeric range sanity checks
(assert (and (>= (str.to_int mm) 1) (<= (str.to_int mm) 12)))
(assert (and (>= (str.to_int dd) 1) (<= (str.to_int dd) 31)))
(assert (and (>= (str.to_int hh) 0) (<= (str.to_int hh) 23)))
(assert (and (>= (str.to_int mi) 0) (<= (str.to_int mi) 59)))
(assert (and (>= (str.to_int ss) 0) (<= (str.to_int ss) 59)))

; Log level extraction and validation
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))
(assert (>= (str.len message) 1))

; Keep a mutated core-style constraint from the seed: force a contradiction via x
(declare-const x String)
(assert (str.in_re x (re.+ (re.union (str.to_re "") (str.to_re "4")))))
(assert (= 2 (str.to_int x)))

; Force the log's year to be "4444" to tie in digit/seed flavor
(assert (= yyyy "4444"))

; UNSAT twist: enforce an impossible month while still requiring TwoDigits
(assert (= mm "00"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

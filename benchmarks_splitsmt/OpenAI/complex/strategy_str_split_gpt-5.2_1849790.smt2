(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Uninterpreted split interface

; Core input log line
(declare-const X String)

; Derived fields via space splitting
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)

(assert (= ts (str.split_at X " " 0)))
(assert (= level (str.split_at X " " 1)))
(assert (= component (str.split_at X " " 2)))
(assert (= message (str.split_rest X " " 3)))

; Must have at least: <timestamp> <LEVEL> <component> <message...>
(assert (>= (str.num_splits X " ") 4))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS
(assert (str.in_re ts
  (re.++
    ((_ re.loop 4 4) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "T")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9")))))

; Additional sanity checks using colon splitting over timestamp
(declare-const ts_date String)
(declare-const ts_time String)
(assert (= ts_date (str.split_at ts "T" 0)))
(assert (= ts_time (str.split_at ts "T" 1)))
(assert (= 2 (str.num_splits ts "T")))
(assert (= 3 (str.num_splits ts_time ":")))

; Log level extraction constraints
(assert (str.in_re level (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; Component format: letters/digits/underscore, length >= 3
(assert (>= (str.len component) 3))
(assert (str.in_re component (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_")))))

; Message must contain a key:value pair like "user:..." somewhere
(assert (str.contains message "user:"))

; Preserve some structural flavor from the seed via unrelated regex constraints,
; but adapted to be log-like and not HTML.
(assert (not (str.contains X "<img ")))
(assert (not (str.in_re X (re.++ (str.to_re "//{#") (re.+ (re.union (str.to_re "/") (str.to_re "{") (str.to_re "}"))) (str.to_re "}") (re.opt (str.to_re ".action")) (re.opt (str.to_re "/")) (str.to_re "/miU\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "//") ((_ re.loop 42 42) (re.union (re.range "0" "9") (re.range "A" "F"))) (str.to_re "/Um\u{a}")))))

; SAT instance: require message to contain a request id field, but do not overconstrain it.
(assert (str.contains message "req_id:"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

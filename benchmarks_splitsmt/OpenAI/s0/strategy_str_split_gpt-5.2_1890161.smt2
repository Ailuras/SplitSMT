(set-logic ALL)

; Uninterpreted interface for string split constraints

; -------------------------
; SAT instance: structured log parsing
; Format idea (space-separated):
;   <timestamp> <level>:<component>: <message>
; Example:
;   2026-01-09T12:34:56Z INFO:auth: user logged in
; -------------------------
(declare-const log_line String)
(declare-const ts String)
(declare-const level_and_more String)
(declare-const level_and_component String)
(declare-const message String)
(declare-const level String)
(declare-const component String)
(declare-const rest_after_level String)
(declare-const ts_date String)
(declare-const ts_time String)

; Ensure at least 3 space-separated fields: timestamp, level:component:, message...
(assert (>= (str.num_splits log_line " ") 3))
(assert (= ts (str.split_at log_line " " 0)))
(assert (= level_and_more (str.split_rest log_line " " 1)))
(assert (= level_and_component (str.split_at level_and_more " " 0)))
(assert (= message (str.split_rest level_and_more " " 1)))

; Parse level_and_component by ':'
(assert (>= (str.num_splits level_and_component ":") 3))
(assert (= level (str.split_at level_and_component ":" 0)))
(assert (= component (str.split_at level_and_component ":" 1)))
(assert (= rest_after_level (str.split_rest level_and_component ":" 1)))

; Timestamp basic structure: YYYY-MM-DDTHH:MM:SSZ
(assert (= (str.len ts) 20))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))

; Timestamp split into date and time parts around 'T'
(assert (>= (str.num_splits ts "T") 2))
(assert (= ts_date (str.split_at ts "T" 0)))
(assert (= ts_time (str.split_at ts "T" 1)))
(assert (= (str.len ts_date) 10))
(assert (= (str.len ts_time) 9))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))

; Regex validation for digits in date/time
(assert (str.in_re ts (re.++ (re.loop (str.to_re "0") 0 0) (str.to_re ""))))
; Use a direct digit regex to enforce timestamp well-formedness
(define-fun digit () RegLan (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9")))))))))))
(define-fun two_digits () RegLan (re.++ digit digit))
(define-fun four_digits () RegLan (re.++ two_digits two_digits))
(define-fun date_re () RegLan (re.++ four_digits (re.++ (str.to_re "-") (re.++ two_digits (re.++ (str.to_re "-") two_digits)))))
(define-fun time_re () RegLan (re.++ two_digits (re.++ (str.to_re ":") (re.++ two_digits (re.++ (str.to_re ":") (re.++ two_digits (str.to_re "Z")))))))
(define-fun ts_re () RegLan (re.++ date_re (re.++ (str.to_re "T") time_re)))
(assert (str.in_re ts ts_re))

; Level extraction constraints
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Component and message sanity constraints
(assert (>= (str.len component) 1))
(assert (not (str.contains component " ")))
(assert (>= (str.len message) 1))

; Additional structural check: rest_after_level begins with component followed by ':'
(assert (str.contains rest_after_level (str.++ component ":")))

; Provide a concrete satisfying example to anchor SAT
(assert (= log_line "2026-01-09T12:34:56Z INFO:auth: user logged in"))

(check-sat)

; -------------------------
; UNSAT instance: conflicting timestamp and level constraints
; -------------------------
(declare-const bad_line String)
(declare-const bad_ts String)
(declare-const bad_level_field String)
(declare-const bad_level String)

(assert (>= (str.num_splits bad_line " ") 2))
(assert (= bad_ts (str.split_at bad_line " " 0)))
(assert (= bad_level_field (str.split_at bad_line " " 1)))
(assert (= bad_level (str.split_at bad_level_field ":" 0)))

; Force a concrete bad log line
(assert (= bad_line "2026-01-09T12:34:56 INFO:core: missing Z suffix"))

; Require timestamp to match the strict regex (needs trailing 'Z'), but bad_line timestamp omits it
(assert (str.in_re bad_ts ts_re))

; Contradictory level requirement: extracted level must be INFO, but also must be ERROR
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

(check-sat)
(exit)

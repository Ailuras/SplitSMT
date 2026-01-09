(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; --- Uninterpreted interface for split operations ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const X String) ; full log entry
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Preserve seed's core structure: exclude specific HTML-ish pattern from X
(assert (not (str.in_re X (re.++ (str.to_re "<link href=\u{22}") re.allchar re.allchar (str.to_re "/Common/Styles/iLienStyle") re.allchar (str.to_re "css\u{22} type=\u{22}text/css\u{22} rel=\u{22}stylesheet\u{22} />\u{a}")))))

; --- Log structure assumptions ---
; Format: "<timestamp> <LEVEL> <component>: <message>"
(assert (>= (num_splits X " ") 4))
(assert (= ts (split_at X " " 0)))
(assert (= level (split_at X " " 1)))
(assert (= component (split_at X " " 2)))
(assert (= message (split_rest X " " 3)))

; Component ends with ':'
(assert (str.in_re component (re.++ re.allchar (str.to_re ":"))))

; Log level extraction/validation
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; --- Timestamp validation ---
; Accept ISO-like: YYYY-MM-DDTHH:MM:SSZ
(assert (= (split_at ts "T" 0) ts_date))
(assert (= (split_at ts "T" 1) ts_time))
(assert (= (num_splits ts "T") 2))

; Date: enforce fixed positions for '-'
(assert (= (str.len ts_date) 10))
(assert (= (str.at ts_date 4) "-"))
(assert (= (str.at ts_date 7) "-"))

; Date must be digits in other positions (relaxed: only require overall regex)
(assert (str.in_re ts_date (re.++ (re.loop (re.range "0" "9") 4 4)
                                 (str.to_re "-")
                                 (re.loop (re.range "0" "9") 2 2)
                                 (str.to_re "-")
                                 (re.loop (re.range "0" "9") 2 2))))

; Time: HH:MM:SSZ
(assert (= (str.len ts_time) 9))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))
(assert (= (str.at ts_time 8) "Z"))
(assert (= hh (str.substr ts_time 0 2)))
(assert (= mm (str.substr ts_time 3 2)))
(assert (= ss (str.substr ts_time 6 2)))
(assert (str.in_re hh (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re mm (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re ss (re.loop (re.range "0" "9") 2 2)))

; Message sanity: must not be empty and must contain at least one alphanumeric
(assert (> (str.len message) 0))
(assert (str.in_re message (re.++ re.allchar (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9"))) re.allchar)))

; --- Additional constraints to create diversity ---
; Example SAT shape constraint: if level is ERROR, message tends to include "exception" (relaxed)
(assert (or (not (= level "ERROR")) (str.contains message "exception")))

; Also constrain component to be a word followed by ':' (simple approximation)
(assert (str.in_re component (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "_"))))) (str.to_re ":"))))

(check-sat)

; --- UNSAT instance (separate via push/pop) ---
(push 1)
; Force a contradictory timestamp form: require Z at end, but also require last char not Z
(assert (= (str.at ts_time 8) "Z"))
(assert (not (= (str.at ts_time 8) "Z")))
(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)
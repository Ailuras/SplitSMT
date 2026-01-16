(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface (space/colon separated parsing)

; Seed-style booleans preserved/extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; Log entry input and extracted fields
(declare-const var_0xINPUT_364697 String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date String)
(declare-const time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Core non-empty input constraint preserved
(assert (= T_1 (= var_0xINPUT_364697 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; Basic structure: "<timestamp> <level>: <message>"
(assert (>= (num_splits var_0xINPUT_364697 " ") 3))
(assert (= ts (split_at var_0xINPUT_364697 " " 0)))
(assert (= level (split_at var_0xINPUT_364697 " " 1)))
(assert (= message (split_rest var_0xINPUT_364697 " " 2)))

; Level must end with ':' and be one of a small set
(assert (str.in_re level (re.union (str.to_re "INFO:") (re.union (str.to_re "WARN:") (str.to_re "ERROR:")))))

; Timestamp validation: "YYYY-MM-DD:HH:MM:SS"
(assert (>= (num_splits ts ":") 4))
(assert (= date (split_at ts ":" 0)))
(assert (= time (split_rest ts ":" 1)))
(assert (= hh (split_at ts ":" 1)))
(assert (= mm (split_at ts ":" 2)))
(assert (= ss (split_at ts ":" 3)))

; Enforce fixed widths
(assert (= (str.len date) 10))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Date pattern YYYY-MM-DD with digits and dashes
(assert (str.in_re date (re.++ (re.++ (re.++ (re.++ (re.* (re.range "0" "9")) (str.to_re "-")) (re.* (re.range "0" "9"))) (str.to_re "-")) (re.* (re.range "0" "9")))))

; Stronger digit-only checks for HH/MM/SS
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Message must be non-empty and contain a keyword indicating an action
(assert (not (= message "")))
(assert (or (str.contains message "user") (str.contains message "request") (str.contains message "failed")))

; Add a deliberately contradictory condition to make this instance UNSAT
; If level is ERROR:, require message to contain "failed"; then contradict with negation.
(assert (= T_3 (and (= level "ERROR:") (str.contains message "failed"))))
(assert (=> (= level "ERROR:") T_3))
(assert (=> (= level "ERROR:") (not (str.contains message "failed"))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

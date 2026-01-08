(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; str_split interface

; Log entry and extracted fields
(declare-const X String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Preserve mutated core seed constraints (kept but integrated into this scenario)
(assert (not (str.in_re X (str.to_re "/=\u{a}/P\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/")
                              (re.union (str.to_re "\u{17}\u{0}") (str.to_re "\u{0}\u{5c}"))
                              (str.to_re "\u{0}e\u{0}l\u{0}s\u{0}e\u{0}x\u{0}t\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")))))

; Expect at least: "<timestamp> <level>:<component>:<message...>"
(assert (>= (str.num_splits X " ") 3))
(assert (= ts (str.split_at X " " 0)))
(assert (= level (str.split_at X " " 1)))
(assert (= component (str.split_at (str.split_rest X " " 2) ":" 0)))
(assert (= message (str.split_rest (str.split_rest X " " 2) ":" 1)))

; Level extraction checks
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))
(assert (>= (str.len component) 1))
(assert (>= (str.len message) 1))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS
(assert (= date_part (str.split_at ts "T" 0)))
(assert (= time_part (str.split_at ts "T" 1)))
(assert (= (str.num_splits ts "T") 2))

; Date: 3 parts by '-'
(assert (= (str.num_splits date_part "-") 3))
(assert (= (str.len (str.split_at date_part "-" 0)) 4))
(assert (= (str.len (str.split_at date_part "-" 1)) 2))
(assert (= (str.len (str.split_at date_part "-" 2)) 2))

; Time: 3 parts by ':'
(assert (= (str.num_splits time_part ":") 3))
(assert (= hh (str.split_at time_part ":" 0)))
(assert (= mm (str.split_at time_part ":" 1)))
(assert (= ss (str.split_at time_part ":" 2)))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Regex digit constraints for timestamp fields
(assert (str.in_re (str.split_at date_part "-" 0) (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re (str.split_at date_part "-" 1) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.split_at date_part "-" 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Component should be alphanumeric/underscore only (simple policy)
(assert (str.in_re component (re.+ (re.union (re.range "a" "z")
                                            (re.union (re.range "A" "Z")
                                                      (re.union (re.range "0" "9") (str.to_re "_")))))))

; SAT instance: pick a concrete-looking pattern for message prefix, but keep X symbolic overall
(assert (str.contains message "started"))

(check-sat)

; UNSAT instance block (separate check) by contradicting log-level constraints
(push 1)
(assert (= level "INFO"))
(assert (= level "ERROR"))
(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)

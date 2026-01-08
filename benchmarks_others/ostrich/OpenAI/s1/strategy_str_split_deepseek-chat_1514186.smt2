(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Log Analysis: parsing a structured server log entry separated by spaces and colons
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const date String)
(declare-const time String)

; Keep seed-like regex constraints, but applied to message and component for diversity
(assert (str.in_re message (re.* (re.++ (str.to_re "_") (re.* (str.to_re "^"))))))
(assert (str.in_re component (re.* (re.++ (str.to_re "_") (re.* (str.to_re "^"))))))

; Core structure: split by spaces to extract tokens: "TS LEVEL COMPONENT: MESSAGE..."
(assert (>= (num_splits logline " ") 3))
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= component (split_at logline " " 2)))
(assert (= message (split_rest logline " " 3)))

; Timestamp format validation: "YYYY-MM-DDTHH:MM:SSZ"
(assert (>= (num_splits ts "T") 2))
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))

; Date must be three parts YYYY-MM-DD with fixed lengths
(assert (= (num_splits date "-") 3))
(assert (= (str.len (split_at date "-" 0)) 4))
(assert (= (str.len (split_at date "-" 1)) 2))
(assert (= (str.len (split_at date "-" 2)) 2))

; Time must end with Z and contain HH:MM:SS before it
(assert (str.in_re time (re.++ (re.++ (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re ":")) (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re ":"))) (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re "Z")))))

; Log level extraction: must be one of common levels
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Component must have a trailing colon token like "auth:" and be splitable by ":"
(assert (str.contains component ":"))
(assert (>= (num_splits component ":") 2))

; Additional structural check: message must exist (possibly empty) but ensure logline has some length
(assert (>= (str.len logline) 10))

; Deliberate contradiction to create an UNSAT instance while keeping the core structure
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

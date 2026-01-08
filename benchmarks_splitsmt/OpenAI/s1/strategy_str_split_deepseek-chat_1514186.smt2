(set-logic ALL)

; Uninterpreted split interface

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
(assert (>= (str.num_splits logline " ") 3))
(assert (= ts (str.split_at logline " " 0)))
(assert (= level (str.split_at logline " " 1)))
(assert (= component (str.split_at logline " " 2)))
(assert (= message (str.split_rest logline " " 3)))

; Timestamp format validation: "YYYY-MM-DDTHH:MM:SSZ"
(assert (>= (str.num_splits ts "T") 2))
(assert (= date (str.split_at ts "T" 0)))
(assert (= time (str.split_at ts "T" 1)))

; Date must be three parts YYYY-MM-DD with fixed lengths
(assert (= (str.num_splits date "-") 3))
(assert (= (str.len (str.split_at date "-" 0)) 4))
(assert (= (str.len (str.split_at date "-" 1)) 2))
(assert (= (str.len (str.split_at date "-" 2)) 2))

; Time must end with Z and contain HH:MM:SS before it
(assert (str.in_re time (re.++ (re.++ (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re ":")) (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re ":"))) (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re "Z")))))

; Log level extraction: must be one of common levels
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Component must have a trailing colon token like "auth:" and be splitable by ":"
(assert (str.contains component ":"))
(assert (>= (str.num_splits component ":") 2))

; Additional structural check: message must exist (possibly empty) but ensure logline has some length
(assert (>= (str.len logline) 10))

; Deliberate contradiction to create an UNSAT instance while keeping the core structure
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted string split interface

; Email validation scenario variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_head String)
(declare-const domain_tail String)
(declare-const tld String)
(declare-const label0 String)
(declare-const label1 String)

; Keep a trace of the seed structure with mutated regex usage
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (re.* (str.to_re "=")) (str.to_re "B")))))
(assert (str.in_re y (re.* (re.++ (re.* (str.to_re "=")) (str.to_re "B")))))

; Core split structure for email: local@domain
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))
(assert (<= (str.num_splits email "@") 2))

; Basic well-formedness
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; Domain must contain at least one '.' and have a TLD part
(assert (>= (str.num_splits domain ".") 2))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Split domain into head and tail at first dot, to talk about structure
(assert (= domain_head (str.split_at domain "." 0)))
(assert (= domain_tail (str.split_rest domain "." 1)))
(assert (> (str.len domain_head) 0))
(assert (> (str.len domain_tail) 0))

; Local-part: forbid dots at the ends via prefix/suffix constraints
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain labels: require first two labels non-empty and not starting/ending with '-'
(assert (= label0 (str.split_at domain "." 0)))
(assert (= label1 (str.split_at domain "." 1)))
(assert (> (str.len label0) 0))
(assert (> (str.len label1) 0))
(assert (not (= (str.at label0 0) "-")))
(assert (not (= (str.at label0 (- (str.len label0) 1)) "-")))
(assert (not (= (str.at label1 0) "-")))
(assert (not (= (str.at label1 (- (str.len label1) 1)) "-")))

; Introduce an intentional contradiction to create an UNSAT instance:
; Domain must have a dot (at least 2 splits), but also must have exactly 1 split.
(assert (= (str.num_splits domain ".") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted split interface

; Primary email inputs
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domainLabel0 String)
(declare-const domainLabel1 String)
(declare-const domainLabel2 String)
(declare-const tld String)
(declare-const reconstructedDomain String)
(declare-const userChar0 String)
(declare-const userCharLast String)

; -------------------------
; SAT instance: complex email validation constraints
; -------------------------

; Email must contain exactly one '@' => 2 segments when split by '@'
(assert (= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Local-part constraints: non-empty, no spaces, no '@'
(assert (>= (str.len local) 1))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; A lightweight structural check on local-part boundary characters
(assert (= userChar0 (str.at local 0)))
(assert (not (= userChar0 ".")))
(assert (= userCharLast (str.at local (- (str.len local) 1))))
(assert (not (= userCharLast ".")))

; Domain constraints: contains at least one dot (>= 2 labels)
(assert (>= (str.num_splits domain ".") 2))

; Enforce at least 3 labels in domain: e.g., mail.example.com
(assert (>= (str.num_splits domain ".") 3))
(assert (= domainLabel0 (str.split_at domain "." 0)))
(assert (= domainLabel1 (str.split_at domain "." 1)))
(assert (= domainLabel2 (str.split_at domain "." 2)))
(assert (= tld (str.split_rest domain "." 3)))

; Each of first 3 domain labels must be non-empty and must not contain '@' or spaces
(assert (>= (str.len domainLabel0) 1))
(assert (>= (str.len domainLabel1) 1))
(assert (>= (str.len domainLabel2) 1))
(assert (not (str.contains domainLabel0 "@")))
(assert (not (str.contains domainLabel1 "@")))
(assert (not (str.contains domainLabel2 "@")))
(assert (not (str.contains domainLabel0 " ")))
(assert (not (str.contains domainLabel1 " ")))
(assert (not (str.contains domainLabel2 " ")))

; Domain label boundary constraints: labels cannot start or end with '-'
(assert (not (= (str.at domainLabel0 0) "-")))
(assert (not (= (str.at domainLabel1 0) "-")))
(assert (not (= (str.at domainLabel2 0) "-")))
(assert (not (= (str.at domainLabel0 (- (str.len domainLabel0) 1)) "-")))
(assert (not (= (str.at domainLabel1 (- (str.len domainLabel1) 1)) "-")))
(assert (not (= (str.at domainLabel2 (- (str.len domainLabel2) 1)) "-")))

; TLD constraints: non-empty, at least 2 chars, contains no dots (since it is split_rest from 3)
(assert (>= (str.len tld) 2))
(assert (not (str.contains tld "@")))
(assert (not (str.contains tld " ")))

; Reconstruct domain in a canonical way: first three labels plus rest (tld may include additional dots)
(assert (= reconstructedDomain (str.++ domainLabel0 "." domainLabel1 "." domainLabel2 (ite (= tld "") "" (str.++ "." tld)))))
(assert (str.contains reconstructedDomain domainLabel0))

; Provide a concrete satisfiable example while still respecting the structure
(assert (= email "alice.smith+tag@dept.mail.example.co.uk"))

(check-sat)

; -------------------------
; UNSAT instance: contradictory email/domain constraints (same declarations reused)
; -------------------------


; Force exactly one '@'
(assert (= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Contradiction: also require zero '@' occurrences
(assert (not (str.contains email "@")))

(check-sat)
(exit)

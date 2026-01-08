(set-logic ALL)
; Scenario: Email Validation using '@' and '.' delimiters with str_split interface

; Uninterpreted functions for split reasoning

; Primary input email
(declare-const email String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const label0 String)
(declare-const label1 String)
(declare-const tld String)

; Basic split structure for email
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= (str.split_rest email "@" 1) domain))

; Exactly one '@' -> two segments
(assert (= (str.num_splits email "@") 2))

; Non-empty local and domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Disallow leading/trailing dots in local and domain
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Local-part regex: allow alnum plus '._%+-' but no spaces
(assert (str.in_re local (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))
(assert (not (str.contains local " ")))

; Domain structure via '.' split
(assert (= label0 (str.split_at domain "." 0)))
(assert (= label1 (str.split_at domain "." 1)))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Require at least one dot in domain (>= 2 labels)
(assert (>= (str.num_splits domain ".") 2))

; Labels must be non-empty
(assert (> (str.len label0) 0))
(assert (> (str.len tld) 0))

; Domain label regex: allow alnum and hyphen, but no underscores
(assert (str.in_re label0 (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (str.in_re label1 (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (str.contains domain "_")))

; Hyphen cannot be at start/end of first label and TLD
(assert (not (= (str.at label0 0) "-")))
(assert (not (= (str.at label0 (- (str.len label0) 1)) "-")))
(assert (not (= (str.at tld 0) "-")))
(assert (not (= (str.at tld (- (str.len tld) 1)) "-")))

; TLD: 2..24 alphabetic characters
(assert (str.in_re tld ((_ re.loop 2 24) (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Forbid consecutive dots in the domain
(assert (not (str.contains domain "..")))

; Optional additional guard: email must not contain newline characters
(assert (not (str.contains email "\n")))
(assert (not (str.contains email "\r")))

; Produce UNSAT by forcing an invalid domain structure simultaneously
; (Contradiction: require at least one dot, but also forbid any dot)
(assert (not (str.contains domain ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]

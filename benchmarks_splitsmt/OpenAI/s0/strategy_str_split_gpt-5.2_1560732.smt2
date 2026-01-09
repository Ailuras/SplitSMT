(set-logic ALL)

; Uninterpreted split interface

; Primary email under validation (intended SAT)
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const domain_suffix String)

; Secondary email constrained to be invalid (intended UNSAT)
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)

; ----------------------------
; SAT-style constraints: complex email format
; ----------------------------

; Exactly one '@' separator: local@domain
(assert (= (str.num_splits email "@") 2))
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain_part (str.split_at email "@" 1)))

; Non-empty local and domain parts
(assert (>= (str.len local_part) 1))
(assert (>= (str.len domain_part) 1))

; Basic local-part sanity (not exhaustive RFC): no spaces, no '@'
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "@")))

; Require at least one dot in the domain (i.e., at least 2 labels)
(assert (>= (str.num_splits domain_part ".") 2))

; Constrain domain structure: label0.label1.<suffix>
; Ensure at least 3 segments so we can name two labels and a TLD/suffix
(assert (>= (str.num_splits domain_part ".") 3))
(assert (= domain_label0 (str.split_at domain_part "." 0)))
(assert (= domain_label1 (str.split_at domain_part "." 1)))
(assert (= domain_suffix (str.split_rest domain_part "." 2)))

; domain_suffix must contain at least one dot so there is a final tld segment
(assert (>= (str.num_splits domain_suffix ".") 2))

; Define tld as the last segment by splitting domain_suffix on '.'
(assert (= tld (str.split_at domain_suffix "." (- (str.num_splits domain_suffix ".") 1))))

; Domain labels must be non-empty and should not contain '@' or spaces
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len domain_label1) 1))
(assert (not (str.contains domain_label0 "@")))
(assert (not (str.contains domain_label1 "@")))
(assert (not (str.contains domain_label0 " ")))
(assert (not (str.contains domain_label1 " ")))

; Disallow underscores in the first two domain labels (common hostname rule)
(assert (not (str.contains domain_label0 "_")))
(assert (not (str.contains domain_label1 "_")))

; tld constraints: at least 2 chars, no digits, no hyphen, no spaces
(assert (>= (str.len tld) 2))
(assert (not (str.contains tld "-")))
(assert (not (str.contains tld " ")))
(assert (not (str.contains tld "0")))
(assert (not (str.contains tld "1")))
(assert (not (str.contains tld "2")))
(assert (not (str.contains tld "3")))
(assert (not (str.contains tld "4")))
(assert (not (str.contains tld "5")))
(assert (not (str.contains tld "6")))
(assert (not (str.contains tld "7")))
(assert (not (str.contains tld "8")))
(assert (not (str.contains tld "9")))

; Ensure the overall email contains '@' and '.' in the domain
(assert (str.contains email "@"))
(assert (str.contains domain_part "."))

; Provide a concrete witness pattern to keep this part satisfiable
(assert (= email "alice.smith+tag@sub.example.co.uk"))

; ----------------------------
; UNSAT-style constraints: force contradictory email requirements
; ----------------------------

; bad_email is constrained to have exactly one '@'
(assert (= (str.num_splits bad_email "@") 2))
(assert (= bad_local (str.split_at bad_email "@" 0)))
(assert (= bad_domain (str.split_at bad_email "@" 1)))

; But simultaneously require it has zero '@' occurrences (contradiction with contains)
(assert (not (str.contains bad_email "@")))

; Additionally require domain has at least one dot, yet also assert it has only 1 segment on '.' (contradiction)
(assert (str.contains bad_domain "."))
(assert (= (str.num_splits bad_domain ".") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------------
; Scenario: Email Validation
; We build both SAT and UNSAT instances in one file by using disjoint cases.
; Exactly one case must hold.
; ----------------------------

(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const dom_label2 String)
(declare-const tld String)
(declare-const rest_after_at String)
(declare-const rest_after_first_dot String)

(declare-const case_sat Bool)
(declare-const case_unsat Bool)

(assert (xor case_sat case_unsat))

; Helper-ish bounds and sanity constraints for split indices
(assert (>= (str.len email) 3))

; ============================
; Case 1: SAT email constraints
; - exactly one '@'
; - local part non-empty, no '.' in local part
; - domain has at least two labels separated by '.'
; - TLD length >= 2
; - additional structure: domain labels non-empty
; ============================

(assert (=> case_sat
  (and
    ; exactly one '@' -> split by '@' gives exactly 2 segments
    (= (num_splits email "@") 2)
    (= local_part (split_at email "@" 0))
    (= domain (split_at email "@" 1))
    (= rest_after_at (split_rest email "@" 1))
    (= rest_after_at domain)

    ; local part constraints
    (>= (str.len local_part) 1)
    (not (str.contains local_part "@"))
    (not (str.contains local_part "."))

    ; domain constraints
    (>= (str.len domain) 3)
    (>= (num_splits domain ".") 2)
    (= dom_label0 (split_at domain "." 0))
    (= dom_label1 (split_at domain "." 1))
    (= rest_after_first_dot (split_rest domain "." 1))
    (>= (str.len dom_label0) 1)
    (>= (str.len dom_label1) 1)

    ; choose the last label to be the tld using split_at with index 2 under a 3-part domain
    ; enforce exactly 3 labels here for a more complex structure: a.b.c
    (= (num_splits domain ".") 3)
    (= dom_label2 (split_at domain "." 2))
    (= tld dom_label2)

    ; TLD constraints
    (>= (str.len tld) 2)
    (not (str.contains tld "@"))
    (not (str.contains tld "."))

    ; Concrete witness to ensure satisfiable
    (= email "alice@sub.example")
  )))

; ============================
; Case 2: UNSAT email constraints
; Force contradictions about delimiter counts and structure.
; ============================

(assert (=> case_unsat
  (and
    ; claim exactly one '@'
    (= (num_splits email "@") 2)
    (= local_part (split_at email "@" 0))
    (= domain (split_at email "@" 1))

    ; simultaneously require no '@' at all (contradiction with split count intention)
    (not (str.contains email "@"))

    ; additionally, require domain to have at least 2 dot labels
    (>= (num_splits domain ".") 2)
    (= tld (split_at domain "." 1))
    (>= (str.len tld) 2)

    ; and force email to a concrete string with an '@' to intensify inconsistency
    (= email "bob@x.y")
  )))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

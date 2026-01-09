(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------
; SAT instance: complex but valid-ish email structure
; ----------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_rest_ok String)
(declare-const label0_ok String)
(declare-const label1_ok String)
(declare-const tld_ok String)
(declare-const tld2_ok String)
(declare-const plus_tag_ok String)

; Enforce exactly one '@' (2 segments when splitting by '@')
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local part: non-empty, no '@', and uses '+' tag (at least 2 segments by '+')
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (>= (num_splits local_ok "+") 2))
(assert (= plus_tag_ok (split_at local_ok "+" 1)))
(assert (> (str.len plus_tag_ok) 0))

; Domain: must contain dots and have at least 3 labels (e.g., mail.example.co.uk => >= 5 labels)
(assert (>= (num_splits domain_ok ".") 3))
(assert (= label0_ok (split_at domain_ok "." 0)))
(assert (= label1_ok (split_at domain_ok "." 1)))
(assert (> (str.len label0_ok) 0))
(assert (> (str.len label1_ok) 0))

; TLD structure: last label length between 2 and 6, no dot inside it
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (and (>= (str.len tld_ok) 2) (<= (str.len tld_ok) 6)))
(assert (not (str.contains tld_ok ".")))

; Domain rest (everything from label index 1 onward) must still contain at least one dot
(assert (= domain_rest_ok (split_rest domain_ok "." 1)))
(assert (str.contains domain_rest_ok "."))

; Provide a concrete satisfying witness to make the SAT part easy for solvers
(assert (= email_ok "john.doe+news@mail.example.co.uk"))

; ----------------------
; UNSAT instance: contradictory email constraints
; ----------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const last_char_bad String)

; Require exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Domain must have at least one dot
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." 1)))

; Contradiction: enforce tld_bad is non-empty and also empty
(assert (> (str.len tld_bad) 0))
(assert (= tld_bad ""))

; Additional contradiction: force last character of email_bad to be '.' but also require it not to contain '.'
(assert (= last_char_bad (str.at email_bad (- (str.len email_bad) 1))))
(assert (= last_char_bad "."))
(assert (not (str.contains email_bad ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
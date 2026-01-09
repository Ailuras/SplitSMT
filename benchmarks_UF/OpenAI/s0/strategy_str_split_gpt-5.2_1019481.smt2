(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: complex-but-valid email
; =====================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_labels Int)
(declare-const tld_ok String)
(declare-const sld_ok String)
(declare-const sub_ok String)
(declare-const rest_after_sld String)

; Basic split around '@'
(assert (>= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Exactly one '@' (two segments total)
(assert (= (num_splits email_ok "@") 2))

; Local part constraints (non-empty, no '@', no spaces)
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Domain constraints: must have at least one '.' => at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))
(assert (= domain_labels (num_splits domain_ok ".")))
(assert (>= domain_labels 3))

; Constrain first three labels (subdomain, second-level, top-level)
(assert (= sub_ok (split_at domain_ok "." 0)))
(assert (= sld_ok (split_at domain_ok "." 1)))
(assert (= tld_ok (split_at domain_ok "." 2)))

; Ensure non-empty labels and no spaces
(assert (> (str.len sub_ok) 0))
(assert (> (str.len sld_ok) 0))
(assert (> (str.len tld_ok) 0))
(assert (not (str.contains domain_ok " ")))

; Require the rest from index 1 onward contains at least one dot (enforces >=3 labels in a way using split_rest)
(assert (= rest_after_sld (split_rest domain_ok "." 1)))
(assert (str.contains rest_after_sld "."))

; Enforce a realistic domain ending: tld is either "com" or "org"
(assert (or (= tld_ok "com") (= tld_ok "org")))

; Pin down a concrete satisfying example while still consistent with the above
(assert (= email_ok "alice.smith+tag@dept.example.com"))

(check-sat)

; =====================
; UNSAT instance: contradictory email requirements
; =====================
(push 1)
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const labels_bad Int)

; Must have exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Domain must have at least 2 labels
(assert (= labels_bad (num_splits domain_bad ".")))
(assert (>= labels_bad 2))
(assert (= tld_bad (split_at domain_bad "." (- labels_bad 1))))

; Contradiction: require both that domain contains '.' and that it does not contain '.'
(assert (str.contains domain_bad "."))
(assert (not (str.contains domain_bad ".")))

; Additional constraints (non-empty)
(assert (> (str.len local_bad) 0))
(assert (> (str.len domain_bad) 0))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split operations

; =====================
; Scenario: Email Validation
; =====================

; ---------- SAT instance: a plausible email meeting constraints ----------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dom_label0_ok String)
(declare-const dom_tail_ok String)
(declare-const tld_ok String)
(declare-const local_first_ok String)
(declare-const local_second_ok String)

; Shape around '@'
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= "" (split_rest email_ok "@" 2)))
(assert (= (num_splits email_ok "@") 2))

; Domain split around '.' (must have at least one '.')
(assert (= dom_label0_ok (split_at domain_ok "." 0)))
(assert (= dom_tail_ok (split_rest domain_ok "." 1)))
(assert (>= (num_splits domain_ok ".") 2))

; TLD is last segment when exactly 2 labels (one '.')
(assert (= (num_splits domain_ok ".") 2))
(assert (= tld_ok (split_at domain_ok "." 1)))
(assert (= "" (split_rest domain_ok "." 2)))

; Local-part further constraints with '.' (allow either one segment or two segments, but no empty segment)
(assert (or (= (num_splits local_ok ".") 1)
            (= (num_splits local_ok ".") 2)))
(assert (= local_first_ok (split_at local_ok "." 0)))
(assert (or (= (num_splits local_ok ".") 1)
            (= local_second_ok (split_at local_ok "." 1))))

; Non-emptiness and basic structure (use string/regex for concreteness)
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))
(assert (> (str.len dom_label0_ok) 0))
(assert (> (str.len tld_ok) 0))
(assert (>= (str.len tld_ok) 2))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok "..")))
(assert (not (str.contains domain_ok ".-")))
(assert (not (str.contains domain_ok "-.")))
(assert (not (str.contains domain_ok "-")))

; Constrain character classes for local and domain labels (simple relaxed email rules)
(assert (str.in_re local_ok (re.++ (re.+ (re.range "a" "z"))
                                  (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))))))
(assert (str.in_re dom_label0_ok (re.+ (re.union (re.range "a" "z") (re.range "0" "9")))))
(assert (str.in_re tld_ok (re.+ (re.range "a" "z"))))

; Force a concrete satisfying example for the SAT block
(assert (= email_ok "alice+dev@acme.io"))

; ---------- UNSAT instance: contradictory email constraints ----------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const dom_label0_bad String)

; Shape around '@' (require exactly one '@')
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= "" (split_rest email_bad "@" 2)))
(assert (= (num_splits email_bad "@") 2))

; Domain must have exactly one '.'
(assert (= dom_label0_bad (split_at domain_bad "." 0)))
(assert (= tld_bad (split_at domain_bad "." 1)))
(assert (= (num_splits domain_bad ".") 2))
(assert (= "" (split_rest domain_bad "." 2)))

; Contradiction: simultaneously enforce no '.' in the domain string
(assert (not (str.contains domain_bad ".")))

; Also pin an example domain that does contain a '.' to intensify inconsistency
(assert (= email_bad "bob@x.y"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

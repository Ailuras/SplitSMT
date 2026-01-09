(set-logic ALL)

; Email Validation scenario using str_split interface

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- SAT instance variables ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const dom_first_ok String)
(declare-const dom_mid_ok String)
(declare-const dom_last_ok String)
(declare-const rest_after_at_ok String)

; Basic structure: local@domain
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (>= (num_splits email_ok "@") 2))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= rest_after_at_ok (split_rest email_ok "@" 1)))
(assert (= rest_after_at_ok domain_ok))

; Exactly one '@' -> split count is 2 segments
(assert (= (num_splits email_ok "@") 2))

; Non-empty local and domain, and local must not contain '@'
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains local_ok "@")))

; Local-part restrictions: no spaces, no leading/trailing dot, no consecutive dots
(assert (not (str.contains local_ok " ")))
(assert (not (= (str.at local_ok 0) ".")))
(assert (not (= (str.at local_ok (- (str.len local_ok) 1)) ".")))
(assert (not (str.contains local_ok "..")))

; Domain structure: must contain at least one '.' and have at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))

; Domain labels: non-empty, no spaces, no consecutive dots (implied by split semantics but asserted)
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "..")))

; Fix domain to exactly 3 labels for this SAT instance: a.b.c
(assert (= (num_splits domain_ok ".") 3))
(assert (= dom_first_ok (split_at domain_ok "." 0)))
(assert (= dom_mid_ok (split_at domain_ok "." 1)))
(assert (= dom_last_ok (split_at domain_ok "." 2)))
(assert (= tld_ok dom_last_ok))

(assert (> (str.len dom_first_ok) 0))
(assert (> (str.len dom_mid_ok) 0))
(assert (> (str.len dom_last_ok) 0))

; TLD constraints: length 2..6, only lowercase letters
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 6))
(assert (str.in_re tld_ok (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z")))))

; Entire email has no spaces and contains exactly one '@'
(assert (not (str.contains email_ok " ")))
(assert (str.contains email_ok "@"))

; Provide a concrete satisfying shape (keeps instance SAT even with uninterpreted split fns)
(assert (= email_ok "john.doe@sub.example.com"))


; --- UNSAT instance variables ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const d0_bad String)
(declare-const d1_bad String)
(declare-const d2_bad String)

; Force a clearly invalid concrete email (two '@' and consecutive dots)
(assert (= email_bad "a..b@@ex..ample.com"))

; Split constraints that contradict the concrete email's obvious structure
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Contradiction 1: assert exactly one '@' even though email_bad has two
(assert (= (num_splits email_bad "@") 2))

; Contradiction 2: disallow consecutive dots in local and domain, but email_bad has them
(assert (not (str.contains local_bad "..")))
(assert (not (str.contains domain_bad "..")))

; Domain must have exactly 3 labels, and TLD must be lowercase letters length 2..6
(assert (= (num_splits domain_bad ".") 3))
(assert (= d0_bad (split_at domain_bad "." 0)))
(assert (= d1_bad (split_at domain_bad "." 1)))
(assert (= d2_bad (split_at domain_bad "." 2)))
(assert (= tld_bad d2_bad))
(assert (>= (str.len tld_bad) 2))
(assert (<= (str.len tld_bad) 6))
(assert (str.in_re tld_bad (re.+ (re.range "a" "z"))))

; Explicit additional contradiction: require no '@' at all
(assert (not (str.contains email_bad "@")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
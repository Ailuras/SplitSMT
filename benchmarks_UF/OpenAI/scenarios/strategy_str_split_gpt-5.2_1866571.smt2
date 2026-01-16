(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface

; Shared symbols
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; -----------------------------
; SAT instance: complex-but-valid email structure
; -----------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const user_ok String)
(declare-const tag_ok String)
(declare-const sub1_ok String)
(declare-const sub2_ok String)
(declare-const tld_ok String)
(declare-const remainder_domain_ok String)

; Split by '@' into exactly two segments
(assert (= local_ok (split_at email_ok at_delim 0)))
(assert (= domain_ok (split_at email_ok at_delim 1)))
(assert (= (num_splits email_ok at_delim) 2))
(assert (= "" (split_rest email_ok at_delim 2)))

; Local part must be non-empty and contain a '+' tag (common pattern)
(assert (> (str.len local_ok) 0))
(assert (str.contains local_ok "+"))

; Constrain local part using split by '+' into [user, tag]
(assert (= user_ok (split_at local_ok "+" 0)))
(assert (= tag_ok (split_at local_ok "+" 1)))
(assert (= (num_splits local_ok "+") 2))
(assert (= "" (split_rest local_ok "+" 2)))
(assert (> (str.len user_ok) 0))
(assert (> (str.len tag_ok) 0))

; Domain must have at least 3 dot-separated segments (e.g., sub.sub.tld)
(assert (>= (num_splits domain_ok dot_delim) 3))
(assert (= sub1_ok (split_at domain_ok dot_delim 0)))
(assert (= sub2_ok (split_at domain_ok dot_delim 1)))
(assert (= remainder_domain_ok (split_rest domain_ok dot_delim 2)))

; Remainder must itself look like something.tld (at least one dot in remainder)
(assert (>= (num_splits remainder_domain_ok dot_delim) 2))
(assert (= tld_ok (split_at remainder_domain_ok dot_delim (- (num_splits remainder_domain_ok dot_delim) 1))))

; Non-empty labels and minimal TLD length
(assert (> (str.len sub1_ok) 0))
(assert (> (str.len sub2_ok) 0))
(assert (> (str.len tld_ok) 1))

; Basic sanity: no additional '@' in either local/domain
(assert (= (num_splits local_ok at_delim) 1))
(assert (= (num_splits domain_ok at_delim) 1))

; Ensure email contains delimiters in expected places (redundant but realistic)
(assert (str.contains email_ok "@"))
(assert (str.contains domain_ok "."))

; Witness construction to guarantee SAT
(assert (= email_ok (str.++ user_ok "+" tag_ok "@" sub1_ok "." sub2_ok "." remainder_domain_ok)))
(assert (= user_ok "alice"))
(assert (= tag_ok "dev"))
(assert (= sub1_ok "mail"))
(assert (= sub2_ok "example"))
(assert (= remainder_domain_ok "co.uk"))

; -----------------------------
; UNSAT instance: conflicting email requirements
; -----------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Exactly two segments by '@'
(assert (= local_bad (split_at email_bad at_delim 0)))
(assert (= domain_bad (split_at email_bad at_delim 1)))
(assert (= (num_splits email_bad at_delim) 2))

; Domain must have at least 2 dot-separated segments
(assert (>= (num_splits domain_bad dot_delim) 2))

; Contradiction: force domain to have no dots while requiring >=2 splits by '.'
(assert (= domain_bad "example"))

; Additional constraints resembling typical validation
(assert (> (str.len local_bad) 0))
(assert (= (num_splits local_bad dot_delim) 1))

; TLD extraction constraint (won't rescue inconsistency)
(assert (= tld_bad (split_at domain_bad dot_delim (- (num_splits domain_bad dot_delim) 1))))
(assert (> (str.len tld_bad) 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

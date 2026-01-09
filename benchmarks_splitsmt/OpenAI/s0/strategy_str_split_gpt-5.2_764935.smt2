(set-logic ALL)

; Uninterpreted split interface

; Shared helpers
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; ------------------------------------------------------------
; SAT instance: a structurally valid email
; ------------------------------------------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_first_ok String)
(declare-const rest_after_first_ok String)

; Basic split around '@'
(assert (= local_ok (str.split_at email_ok at_delim 0)))
(assert (= domain_ok (str.split_at email_ok at_delim 1)))
(assert (= "" (str.split_rest email_ok at_delim 2)))
(assert (= 2 (str.num_splits email_ok at_delim)))

; Local-part constraints
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "..")))
(assert (not (= (str.at local_ok 0) ".")))

; Domain constraints: at least one dot, non-empty segments, plausible TLD length
(assert (>= (str.num_splits domain_ok dot_delim) 2))
(assert (= domain_first_ok (str.split_at domain_ok dot_delim 0)))
(assert (= tld_ok (str.split_at domain_ok dot_delim (- (str.num_splits domain_ok dot_delim) 1))))
(assert (= rest_after_first_ok (str.split_rest domain_ok dot_delim 1)))
(assert (> (str.len domain_first_ok) 0))
(assert (> (str.len tld_ok) 1))
(assert (<= (str.len tld_ok) 24))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok "..")))
(assert (not (= (str.at domain_ok 0) ".")))

; Ensure domain contains the dot delimiter via split reconstruction shape (relaxed)
(assert (> (str.len rest_after_first_ok) 0))

; Make SAT concrete
(assert (= email_ok "alice.smith@sub.example.com"))

; ------------------------------------------------------------
; UNSAT instance: contradictory constraints (two '@' but also exactly one split)
; ------------------------------------------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)

(assert (= local_bad (str.split_at email_bad at_delim 0)))
(assert (= domain_bad (str.split_at email_bad at_delim 1)))

; Require exactly one '@' split (two segments)
(assert (= 2 (str.num_splits email_bad at_delim)))
(assert (= "" (str.split_rest email_bad at_delim 2)))

; But also require the domain to still contain an '@', forcing a second '@' occurrence
(assert (str.contains domain_bad "@"))

; Make it concrete with two '@'
(assert (= email_bad "bob@@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

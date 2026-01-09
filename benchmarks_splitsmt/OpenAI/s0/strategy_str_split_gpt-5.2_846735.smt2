(set-logic ALL)

; Email Validation via str_split abstraction

; --- Uninterpreted str_split interface ---

; --- Shared helpers ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; ---------------------------
; SAT instance: plausible complex email
; ---------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_first_ok String)
(declare-const domain_rest_ok String)
(declare-const tld_ok String)
(declare-const user_prefix_ok String)
(declare-const user_suffix_ok String)

; Split at '@' must yield exactly 2 segments: local and domain
(assert (= (str.num_splits email_ok at_delim) 2))
(assert (= local_ok (str.split_at email_ok at_delim 0)))
(assert (= domain_ok (str.split_at email_ok at_delim 1)))

; Local-part structural constraints
(assert (>= (str.len local_ok) 3))
(assert (not (str.contains local_ok at_delim)))
(assert (not (str.contains local_ok " ")))
(assert (not (= (str.at local_ok 0) ".")))
(assert (not (= (str.at local_ok (- (str.len local_ok) 1)) ".")))
(assert (not (str.contains local_ok "..")))

; Enforce a plus-tag pattern: prefix + '+' + suffix
(assert (str.contains local_ok "+"))
(assert (= user_prefix_ok (str.split_at local_ok "+" 0)))
(assert (= user_suffix_ok (str.split_at local_ok "+" 1)))
(assert (>= (str.len user_prefix_ok) 1))
(assert (>= (str.len user_suffix_ok) 1))
(assert (not (str.contains user_prefix_ok "+")))
(assert (not (str.contains user_suffix_ok "+")))

; Domain constraints: at least 2 labels separated by '.' and a reasonable TLD
(assert (>= (str.num_splits domain_ok dot_delim) 2))
(assert (= domain_first_ok (str.split_at domain_ok dot_delim 0)))
(assert (= tld_ok (str.split_at domain_ok dot_delim (- (str.num_splits domain_ok dot_delim) 1))))
(assert (>= (str.len domain_first_ok) 1))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 10))

; Domain must not start/end with '.' and cannot contain '..'
(assert (not (= (str.at domain_ok 0) ".")))
(assert (not (= (str.at domain_ok (- (str.len domain_ok) 1)) ".")))
(assert (not (str.contains domain_ok "..")))

; Domain must not contain '@' or spaces
(assert (not (str.contains domain_ok at_delim)))
(assert (not (str.contains domain_ok " ")))

; Use split_rest to describe suffix of domain after first label
(assert (= domain_rest_ok (str.split_rest domain_ok dot_delim 1)))
(assert (>= (str.len domain_rest_ok) (str.len tld_ok)))

; Constrain email_ok to a concrete valid example satisfying above
(assert (= email_ok "john.doe+news@sub.example.co.uk"))

; ---------------------------
; UNSAT instance: contradicting constraints for an invalid email
; ---------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Force a bad email shape while asserting it should be well-formed
(assert (= email_bad "a..b@x."))

; Claims of well-formedness
(assert (= (str.num_splits email_bad at_delim) 2))
(assert (= local_bad (str.split_at email_bad at_delim 0)))
(assert (= domain_bad (str.split_at email_bad at_delim 1)))

; Require local does NOT contain consecutive dots, but the concrete email does
(assert (not (str.contains local_bad "..")))

; Require domain does not end with '.', but the concrete email's domain does
(assert (not (= (str.at domain_bad (- (str.len domain_bad) 1)) ".")))

; Require at least two domain labels and a TLD of length >= 2
(assert (>= (str.num_splits domain_bad dot_delim) 2))
(assert (= tld_bad (str.split_at domain_bad dot_delim (- (str.num_splits domain_bad dot_delim) 1))))
(assert (>= (str.len tld_bad) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

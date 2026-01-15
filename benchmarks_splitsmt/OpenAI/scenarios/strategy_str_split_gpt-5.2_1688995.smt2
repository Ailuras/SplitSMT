(set-logic ALL)

; Email Validation via str_split: '@' separates local-part and domain, '.' separates domain labels.

; --- Uninterpreted split interface ---

; --- Common helper uninterpreted predicates for readability (non-primitive operations) ---
(declare-fun is_alnum_underscore_plus_hyphen (String) Bool)
(declare-fun is_domain_label (String) Bool)
(declare-fun is_tld (String) Bool)

; --- SAT instance variables ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dom_first_ok String)
(declare-const tld_ok String)
(declare-const dom_rest_ok String)

; Shape: exactly one '@'
(assert (= (str.num_splits email_ok "@") 2))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))

; Local-part constraints: non-empty, no '@', allow complex characters abstractly
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (is_alnum_underscore_plus_hyphen local_ok))

; Domain constraints: must have at least one dot => at least 2 labels
(assert (>= (str.num_splits domain_ok ".") 2))
(assert (= dom_first_ok (str.split_at domain_ok "." 0)))
(assert (= tld_ok (str.split_at domain_ok "." (- (str.num_splits domain_ok ".") 1))))
(assert (= dom_rest_ok (str.split_rest domain_ok "." 1)))

; Each label constraints (abstract): first label non-empty, TLD looks like a TLD
(assert (> (str.len dom_first_ok) 0))
(assert (is_domain_label dom_first_ok))
(assert (> (str.len tld_ok) 1))
(assert (is_tld tld_ok))

; Ensure domain does not start/end with dot and no consecutive dots via split properties (non-empty labels)
(assert (forall ((i Int))
  (=> (and (>= i 0) (< i (str.num_splits domain_ok ".")))
      (> (str.len (str.split_at domain_ok "." i)) 0))))

; Provide a concrete satisfying witness while still exercising split constraints
(assert (= email_ok "john_doe+tag@example.co.uk"))

(check-sat)

; --------------------
; UNSAT instance: forces conflicting structure
; --------------------

(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Claim: exactly one '@'
(assert (= (str.num_splits email_bad "@") 2))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Also claim: domain has at least one dot
(assert (>= (str.num_splits domain_bad ".") 2))
(assert (= tld_bad (str.split_at domain_bad "." (- (str.num_splits domain_bad ".") 1))))

; Contradiction: force email_bad to be a string with no '@' and no '.' in domain
(assert (= email_bad "nodomainseparators"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

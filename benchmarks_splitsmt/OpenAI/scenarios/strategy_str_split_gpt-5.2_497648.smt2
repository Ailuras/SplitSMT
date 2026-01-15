(set-logic ALL)

; Uninterpreted interface for str_split

; Uninterpreted helper predicates/functions for readability
(declare-fun is_nonempty (String) Bool)
(declare-fun is_ascii_atom (String) Bool)
(declare-fun is_domain_label (String) Bool)
(declare-fun is_tld (String) Bool)

; -----------------------------
; SAT instance: a well-formed email
; -----------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const label0_ok String)
(declare-const rest_after_at_ok String)
(declare-const domain_parts_ok Int)

(assert (= email_ok "alice.smith+tag@example.co.uk"))

; Split at '@' into local and domain
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= rest_after_at_ok (str.split_rest email_ok "@" 1)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))
(assert (= domain_ok rest_after_at_ok))
(assert (= (str.num_splits email_ok "@") 2))

; Basic local-part constraints
(assert (is_nonempty local_ok))
(assert (is_ascii_atom local_ok))
(assert (not (str.contains local_ok "@")))
(assert (>= (str.len local_ok) 1))

; Domain structure: split on '.' and require at least 2 parts
(assert (= domain_parts_ok (str.num_splits domain_ok ".")))
(assert (>= domain_parts_ok 2))

; First domain label non-empty and plausible
(assert (= label0_ok (str.split_at domain_ok "." 0)))
(assert (is_nonempty label0_ok))
(assert (is_domain_label label0_ok))

; TLD = last segment: use split_at with known index for this concrete email ("uk" is index 3)
(assert (= tld_ok (str.split_at domain_ok "." 3)))
(assert (is_tld tld_ok))
(assert (= tld_ok "uk"))

; Disallow empty labels via additional constraints on known positions for this concrete domain
(assert (is_domain_label (str.split_at domain_ok "." 1)))
(assert (is_domain_label (str.split_at domain_ok "." 2)))

; Extra structural sanity checks
(assert (not (str.contains domain_ok "@")))
(assert (not (= (str.at email_ok 0) "@")))
(assert (not (= (str.at email_ok (- (str.len email_ok) 1)) "@")))

; -----------------------------
; UNSAT instance: contradictory constraints for email
; -----------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const domain_parts_bad Int)

(assert (= email_bad "bob@example.com"))

; Must split into exactly two parts at '@'
(assert (= (str.num_splits email_bad "@") 2))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Contradiction 1: local part is required to contain '@' even though it is before '@'
(assert (str.contains local_bad "@"))

; Contradiction 2: domain must have at least 3 dot-separated parts, but concrete domain has only 2 (example, com)
(assert (= domain_parts_bad (str.num_splits domain_bad ".")))
(assert (>= domain_parts_bad 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

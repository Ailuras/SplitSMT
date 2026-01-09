(set-logic ALL)

; Uninterpreted interface operations for string splitting

; ------------------------------
; SAT instance: a valid-looking email structure
; ------------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dot_count_ok Int)
(declare-const label0_ok String)
(declare-const label1_ok String)
(declare-const tld_ok String)
(declare-const domain_prefix_ok String)

; Split at '@': require exactly two segments (local, domain)
(assert (= (str.num_splits email_ok "@") 2))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))

; Basic local-part constraints (non-empty, no embedded '@')
(assert (> (str.len local_ok) 0))
(assert (= (str.num_splits local_ok "@") 1))

; Domain must contain at least one '.' meaning >= 2 labels
(assert (>= (str.num_splits domain_ok ".") 2))
(assert (= dot_count_ok (str.num_splits domain_ok ".")))

; Constrain first two labels to be non-empty
(assert (= label0_ok (str.split_at domain_ok "." 0)))
(assert (= label1_ok (str.split_at domain_ok "." 1)))
(assert (> (str.len label0_ok) 0))
(assert (> (str.len label1_ok) 0))

; Define TLD as the last label: split_rest from (dot_count-1) yields that last segment
(assert (>= dot_count_ok 2))
(assert (= tld_ok (str.split_rest domain_ok "." (- dot_count_ok 1))))
(assert (>= (str.len tld_ok) 2))

; Domain prefix before the last dot: split_rest from 0 should be whole domain,
; and domain is prefix + '.' + tld when there are at least 2 labels
(assert (= (str.split_rest domain_ok "." 0) domain_ok))
(assert (= domain_prefix_ok (str.split_at domain_ok "." 0)))

; Ensure no empty label at the end (domain must not end with '.') and no consecutive dots by a simple ban
(assert (not (str.contains domain_ok "..")))

; One concrete satisfying example consistent with the above
(assert (= email_ok "alice.smith@sub.example.com"))

; ------------------------------
; UNSAT instance: conflicting requirements on email structure
; ------------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const dot_count_bad Int)

; Require exactly two segments at '@'
(assert (= (str.num_splits email_bad "@") 2))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Contradictory: local part must be empty and non-empty simultaneously
(assert (= (str.len local_bad) 0))
(assert (> (str.len local_bad) 0))

; Additional domain constraints (won't matter due to contradiction but still meaningful)
(assert (>= (str.num_splits domain_bad ".") 2))
(assert (= dot_count_bad (str.num_splits domain_bad ".")))
(assert (= tld_bad (str.split_rest domain_bad "." (- dot_count_bad 1))))
(assert (>= (str.len tld_bad) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

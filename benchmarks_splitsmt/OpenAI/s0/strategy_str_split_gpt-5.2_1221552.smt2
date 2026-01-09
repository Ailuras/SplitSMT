(set-logic ALL)

; Uninterpreted split interface

; -----------------------------
; SAT instance: complex but valid email constraints
; -----------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_core_ok String)
(declare-const first_label_ok String)
(declare-const suffix_ok String)
(declare-const at_count_ok Int)
(declare-const dot_count_ok Int)

; Define local/domain via split at '@'
(assert (= at_count_ok (str.num_splits email_ok "@")))
(assert (= at_count_ok 2))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))

; Local-part sanity: non-empty, no spaces, no '@'
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "@")))

; Domain sanity: non-empty, no spaces, no '@'
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "@")))

; Domain must have at least one dot to separate TLD
(assert (= dot_count_ok (str.num_splits domain_ok ".")))
(assert (>= dot_count_ok 2))

; Ensure last label (TLD) exists and is non-trivial
; Using split_at at a fixed index (1) for a 2-label requirement or more.
; Also ensure there is at least one additional label before it.
(assert (not (= (str.split_at domain_ok "." 0) "")))
(assert (not (= (str.split_at domain_ok "." 1) "")))

; Strengthen: enforce at least 2 labels by using split_rest from label 1 onward to include a dot
(assert (= tld_ok (str.split_at domain_ok "." (- dot_count_ok 1))))
(assert (>= (str.len tld_ok) 2))

; Enforce a 3-label structure example: sub.domain.tld (at least)
; Require that domain has at least 3 segments when split by '.'
(assert (>= (str.num_splits domain_ok ".") 3))
(assert (= first_label_ok (str.split_at domain_ok "." 0)))
(assert (= domain_core_ok (str.split_at domain_ok "." 1)))
(assert (= suffix_ok (str.split_rest domain_ok "." 2)))
(assert (> (str.len first_label_ok) 0))
(assert (> (str.len domain_core_ok) 0))
(assert (> (str.len suffix_ok) 0))

; Constrain that the suffix_ok contains a dot (so there is at least a tld beyond index 2)
(assert (str.contains suffix_ok "."))

; Concrete witness to make the SAT instance satisfiable
(assert (= email_ok "john.doe+tag@sub.example.co.uk"))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory email constraints
; -----------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const at_count_bad Int)
(declare-const dot_count_bad Int)

; Split at '@' and require exactly one '@'
(assert (= at_count_bad (str.num_splits email_bad "@")))
(assert (= at_count_bad 2))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Contradiction: force local to contain '@' while also requiring exactly one '@' total
(assert (str.contains local_bad "@"))

; Domain dot structure constraints also contradictory
(assert (= dot_count_bad (str.num_splits domain_bad ".")))
(assert (= dot_count_bad 1))
(assert (>= dot_count_bad 2))

; Concrete email candidate that would otherwise be reasonable
(assert (= email_bad "alice@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

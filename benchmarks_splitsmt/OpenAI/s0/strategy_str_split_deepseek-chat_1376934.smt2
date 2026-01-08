(set-logic ALL)

; Uninterpreted interface operations for string split

; -----------------------------
; Scenario: Email Validation
; We model splitting by '@' and '.' and constrain segment counts and structure.
; This file contains both SAT and UNSAT instances in one run.
; -----------------------------

; ===== SAT instance =====
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_labels_ok Int)

; Basic split by '@'
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))
(assert (= (str.num_splits email_ok "@") 2))

; Local-part constraints
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "..")))

; Domain constraints via '.'
(assert (>= (str.len domain_ok) 3))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "..")))

(assert (= domain_labels_ok (str.num_splits domain_ok ".")))
(assert (>= domain_labels_ok 2))

; TLD is last label; ensure at least 2 chars
(assert (= tld_ok (str.split_at domain_ok "." (- domain_labels_ok 1))))
(assert (>= (str.len tld_ok) 2))

; Domain label sanity: first label non-empty and doesn't contain '.'
(assert (>= (str.len (str.split_at domain_ok "." 0)) 1))
(assert (not (str.contains (str.split_at domain_ok "." 0) ".")))

; Also ensure the remainder from first dot onwards is non-empty
(assert (>= (str.len (str.split_rest domain_ok "." 1)) 1))

; Tie to a concrete satisfying example (still consistent with above)
(assert (= email_ok "john.doe+tag@sub.example.co"))

; ===== UNSAT instance =====
; Force inconsistent '@' splitting and domain structure simultaneously.
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const domain_labels_bad Int)

(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Contradiction: require exactly one segment, but also refer to segment 1 and nonempty domain.
(assert (= (str.num_splits email_bad "@") 1))
(assert (>= (str.len domain_bad) 1))

; Additionally require domain to have at least 2 dot-separated labels and a long TLD.
(assert (= domain_labels_bad (str.num_splits domain_bad ".")))
(assert (>= domain_labels_bad 2))
(assert (= tld_bad (str.split_at domain_bad "." (- domain_labels_bad 1))))
(assert (>= (str.len tld_bad) 10))

; Provide a candidate bad email that still cannot satisfy the '@' constraint combo above.
(assert (= email_bad "a@b.co"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Email Validation via str_split: mix SAT and UNSAT branches with domain structure checks

; --- Uninterpreted split interface ---

; --- Variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_rest_labels String)
(declare-const tld String)
(declare-const second_level String)

(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)

; --- Basic parsing using '@' ---
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= at_count (str.num_splits email "@")))

; Must have exactly one '@' => two segments
(assert (= at_count 2))

; Non-empty local and domain
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (>= local_len 1))
(assert (>= domain_len 1))

; Disallow spaces in email (simple hygiene)
(assert (not (str.contains email " ")))

; --- Domain parsing using '.' ---
(assert (= dot_count (str.num_splits domain ".")))

; Require at least one dot in domain => at least 2 labels
(assert (>= dot_count 2))

; Pull first label and the rest
(assert (= domain_first_label (str.split_at domain "." 0)))
(assert (= domain_rest_labels (str.split_rest domain "." 1)))
(assert (>= (str.len domain_first_label) 1))
(assert (>= (str.len domain_rest_labels) 1))

; Ensure domain isn't starting/ending with '.' by enforcing non-empty last label (TLD)
(assert (= tld (str.split_at domain "." (- dot_count 1))))
(assert (= tld_len (str.len tld)))
(assert (>= tld_len 2))
(assert (<= tld_len 24))

; If there are exactly two labels, extract second-level directly; otherwise it is the first of the "rest"
; This is a loose structural constraint to exercise split_at with computed indices.
(assert (= second_level (str.split_at domain "." (- dot_count 2))))
(assert (>= (str.len second_level) 1))

; A concrete SAT example witness (still consistent with constraints)
(assert (= email "alice.smith@sub.example.com"))

; --- UNSAT branch: contradict the derived segment count ---
; With the concrete email above, at_count must be 2; forcing 3 makes the whole set UNSAT.
(assert (= at_count 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

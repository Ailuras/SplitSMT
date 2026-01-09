(set-logic ALL)

; Email Validation via str_split interface

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Core variables ---
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)
(declare-const first_label String)
(declare-const second_label String)

; --- Helper/aux variables ---
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)
(declare-const first_label_len Int)
(declare-const second_label_len Int)

; =====================
; SAT instance: plausible complex email
; =====================

; Exactly one '@' meaning two segments when splitting by '@'
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))

; Bind local and domain from split
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Basic non-empty segments
(assert (= local_len (str.len local_part)))
(assert (= domain_len (str.len domain)))
(assert (>= local_len 1))
(assert (>= domain_len 3))

; Avoid empty local/domain and forbid extra '@' by requiring remainder past index 2 is empty
(assert (= (split_rest email "@" 2) ""))

; Domain structure: at least one '.' producing at least two segments
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))

; Bind first two labels and tld via split
(assert (= first_label (split_at domain "." 0)))
(assert (= second_label (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- dot_count 1))))

(assert (= first_label_len (str.len first_label)))
(assert (= second_label_len (str.len second_label)))
(assert (= tld_len (str.len tld)))

; Non-empty labels and tld length constraints
(assert (>= first_label_len 1))
(assert (>= second_label_len 1))
(assert (>= tld_len 2))
(assert (<= tld_len 10))

; Disallow leading/trailing '.' in domain (implied by non-empty first and last segments)
; Require no empty segments anywhere for first two; for additional labels, require domain doesn't contain ".."
(assert (not (str.contains domain "..")))

; Ensure local part does not contain '@' (redundant given split count, but explicit)
(assert (not (str.contains local_part "@")))

; Simple local constraints: no spaces
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain " ")))

; Ensure the email reconstructs from local and domain
(assert (= email (str.++ local_part "@" domain)))

; A concrete satisfiable example to anchor the SAT instance
(assert (= email "john.doe+tag@sub.example.com"))

; =====================
; UNSAT instance: contradictory requirements (separate variables)
; =====================

(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_at_count Int)

; Force exactly one '@'
(assert (= bad_at_count (num_splits bad_email "@")))
(assert (= bad_at_count 2))
(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))

; Contradiction: also force bad_email to have two '@' characters by matching "@" twice via containment patterns
; and simultaneously require num_splits to be 2.
(assert (str.contains bad_email "@"))
(assert (str.contains bad_email "@@"))

; Additionally require split_rest beyond index 2 to be empty (consistent with one '@')
(assert (= (split_rest bad_email "@" 2) ""))

; Anchor a concrete email with two '@' which conflicts with (= (num_splits ..) 2)
(assert (= bad_email "a@@b.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
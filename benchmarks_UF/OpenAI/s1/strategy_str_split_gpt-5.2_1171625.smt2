(set-logic ALL)

; --- Uninterpreted interface for string split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed-derived declarations ---
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_157058 () String)

; --- Additional variables for email validation scenario ---
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_first_label String)
(declare-const domain_tld String)
(declare-const domain_mid String)
(declare-const email_again String)
(declare-const bad_email String)
(declare-const bad_domain String)
(declare-const bad_tld String)

; Keep the seed core structure but decouple from the email instance
(assert (= T_1 (= var_0xINPUT_157058 "Type")))
(assert T_1)

; --- Email parsing using '@' ---
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_part (split_at email "@" 1)))
(assert (= email_again (str.++ local_part "@" domain_part)))
(assert (= email email_again))

; Must have exactly one '@' -> two segments
(assert (= (num_splits email "@") 2))

; Non-empty local and domain parts
(assert (> (str.len local_part) 0))
(assert (> (str.len domain_part) 0))

; Local-part must not contain '@'
(assert (not (str.contains local_part "@")))

; --- Domain validation using '.' ---
; At least one dot in domain -> at least 2 labels
(assert (>= (num_splits domain_part ".") 2))

; First label and final label (TLD)
(assert (= domain_first_label (split_at domain_part "." 0)))
(assert (> (str.len domain_first_label) 0))

; TLD: use split_rest for last segment by requiring exactly 2 splits in a derived case
; Here we enforce a common structure: domain has exactly 3 labels: a.b.c (subdomain + domain + tld)
(assert (= (num_splits domain_part ".") 3))
(assert (= domain_mid (split_at domain_part "." 1)))
(assert (= domain_tld (split_at domain_part "." 2)))
(assert (> (str.len domain_mid) 0))
(assert (> (str.len domain_tld) 1))

; Domain should not start or end with '.' (implied by non-empty labels + exact split count)
; Also disallow consecutive '..' by requiring each label non-empty (already ensured)

; Simple sanity: domain_part must contain a '.'
(assert (str.contains domain_part "."))

; --- A separate UNSAT email instance to ensure diversity ---
; bad_email is forced to violate "exactly one '@'"
(assert (= bad_email "a@@b.com"))
(assert (= (num_splits bad_email "@") 2))

; bad_domain is forced to violate domain structure: exactly 3 labels but also no '.'
(assert (= bad_domain "examplecom"))
(assert (= (num_splits bad_domain ".") 3))
(assert (not (str.contains bad_domain ".")))

; bad_tld contradiction: tld length both >1 and =1
(assert (= bad_tld "x"))
(assert (> (str.len bad_tld) 1))
(assert (= (str.len bad_tld) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
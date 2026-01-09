(set-logic ALL)

; Uninterpreted split interface

; =========
; Scenario: Email Validation
; Validating complex email address formats using '@' and '.' as delimiters.
; We create one SAT instance (email_ok) and one UNSAT instance (email_bad).
; =========

; --- SAT instance variables ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const first_label_ok String)
(declare-const tld_ok String)

; --- UNSAT instance variables ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; -----------------------------
; SAT constraints: well-formed email
; -----------------------------

; Exactly one '@' => exactly 2 segments when splitting by '@'
(assert (= (str.num_splits email_ok "@") 2))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))

; Local part constraints: non-empty, no '@', no spaces
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Domain constraints: non-empty, contains '.', no '@', no spaces
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok " ")))
(assert (str.contains domain_ok "."))

; Domain structure: at least 2 labels (e.g., example.com)
(assert (>= (str.num_splits domain_ok ".") 2))
(assert (= first_label_ok (str.split_at domain_ok "." 0)))
(assert (= tld_ok (str.split_at domain_ok "." (- (str.num_splits domain_ok ".") 1))))

; Labels must be non-empty
(assert (> (str.len first_label_ok) 0))
(assert (> (str.len tld_ok) 0))

; TLD should be length 2..63
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 63))

; Ensure domain does not start or end with '.' (approximated by non-empty first/last labels)
; Already implied by first_label_ok and tld_ok being non-empty.

; Provide a concrete witness to ensure SAT
(assert (= email_ok "alice.smith+tag@example.co.uk"))

; -----------------------------
; UNSAT constraints: contradictory email requirements
; -----------------------------

; Force a fixed simple-looking email
(assert (= email_bad "bob@example.com"))

; Split by '@' and bind parts
(assert (= (str.num_splits email_bad "@") 2))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Require domain to have at least one '.' and a TLD
(assert (>= (str.num_splits domain_bad ".") 2))
(assert (= tld_bad (str.split_at domain_bad "." (- (str.num_splits domain_bad ".") 1))))

; Contradiction: demand TLD be empty but also length >= 2
(assert (= tld_bad ""))
(assert (>= (str.len tld_bad) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

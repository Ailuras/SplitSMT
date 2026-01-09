(set-logic ALL)

; Uninterpreted functions for str_split interface

; -------------------------------
; Scenario: Email Validation
; We create two instances:
;  - SAT instance: an email that satisfies structural constraints
;  - UNSAT instance: contradictory requirements on the local-part
; Both validate complex formats using '@' and '.' delimiters.
; -------------------------------

; ===== SAT instance variables =====
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_no_tld_ok String)
(declare-const host1_ok String)
(declare-const host2_ok String)

; Email must have exactly one '@' => 2 segments when split by '@'
(assert (= (str.num_splits email_ok "@") 2))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))

; Non-empty local and domain
(assert (>= (str.len local_ok) 1))
(assert (>= (str.len domain_ok) 1))

; Local-part restrictions (simple, realistic structure):
; - cannot contain '@'
; - cannot start with '.'
; - cannot end with '.'
; - no consecutive dots (approximated by forbidding "..")
(assert (not (str.contains local_ok "@")))
(assert (not (= (str.at local_ok 0) ".")))
(assert (not (= (str.at local_ok (- (str.len local_ok) 1)) ".")))
(assert (not (str.contains local_ok "..")))

; Force local-part to match a complex pattern using regex:
; starts with an alnum, followed by alnum or [._+-] and alnum, repeated.
; This avoids trailing special characters without overcomplicating.
(assert (str.in_re local_ok
  (re.++
    (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))
    (re.*
      (re.++
        (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))
        (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))
      )
    )
  )
))

; Domain must have at least one '.' separating TLD
(assert (>= (str.num_splits domain_ok ".") 2))

; Define the TLD as the last dot-segment, and the rest as everything before it
(assert (= tld_ok (str.split_at domain_ok "." (- (str.num_splits domain_ok ".") 1))))
(assert (= domain_no_tld_ok (str.split_rest domain_ok "." 0)))

; TLD constraints: length 2..6 and letters only
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 6))
(assert (str.in_re tld_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Domain structure: at least two labels before TLD for "complex" domains
; e.g., host1.host2.tld (3 segments minimum)
(assert (>= (str.num_splits domain_ok ".") 3))
(assert (= host1_ok (str.split_at domain_ok "." 0)))
(assert (= host2_ok (str.split_at domain_ok "." 1)))

; Host labels are non-empty, cannot contain '@', cannot start/end with '-'
(assert (>= (str.len host1_ok) 1))
(assert (>= (str.len host2_ok) 1))
(assert (not (str.contains domain_ok "@")))
(assert (not (= (str.at host1_ok 0) "-")))
(assert (not (= (str.at host2_ok 0) "-")))
(assert (not (= (str.at host1_ok (- (str.len host1_ok) 1)) "-")))
(assert (not (= (str.at host2_ok (- (str.len host2_ok) 1)) "-")))

; Also forbid consecutive dots in domain
(assert (not (str.contains domain_ok "..")))

; Make SAT instance concrete enough to avoid vacuity
(assert (= email_ok "john.doe+tag@sub.mail.Example.com"))

; ===== UNSAT instance variables =====
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Email has exactly one '@'
(assert (= (str.num_splits email_bad "@") 2))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Domain has at least one '.' and has a valid-looking TLD
(assert (>= (str.num_splits domain_bad ".") 2))
(assert (= tld_bad (str.split_at domain_bad "." (- (str.num_splits domain_bad ".") 1))))
(assert (>= (str.len tld_bad) 2))
(assert (<= (str.len tld_bad) 6))
(assert (str.in_re tld_bad (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Contradictory local-part constraints to force UNSAT:
; local_bad must contain ".." but also must NOT contain ".."
(assert (str.contains local_bad ".."))
(assert (not (str.contains local_bad "..")))

; Make other parts reasonable (these do not resolve the contradiction)
(assert (>= (str.len local_bad) 1))
(assert (>= (str.len domain_bad) 1))
(assert (not (str.contains local_bad "@")))
(assert (not (str.contains domain_bad "@")))

; Provide a concrete candidate (still UNSAT due to contradiction)
(assert (= email_bad "a..b@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

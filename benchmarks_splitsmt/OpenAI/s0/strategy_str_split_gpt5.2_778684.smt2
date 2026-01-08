(set-logic ALL)

; Uninterpreted split interface

; Email validation scenario variables
(declare-const email_ok String)
(declare-const email_bad String)

(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const sld_ok String)
(declare-const host_ok String)

(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

(declare-const dot_count_ok Int)
(declare-const dot_count_bad Int)

; -----------------------------
; SAT instance: a complex but valid-looking email address
; Structure: local@sub.example.co
; local has no '@', non-empty, and contains a '.'
; domain has at least 3 dot-separated segments, last segment is a 2-letter TLD
; -----------------------------
(assert (>= (str.len email_ok) 6))
(assert (not (str.contains email_ok " ")))

; Exactly one '@' => two segments when split by '@'
(assert (= (str.num_splits email_ok "@") 2))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))
(assert (= email_ok (str.++ local_ok "@" domain_ok)))

; local-part basic properties
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok "..")))
(assert (not (str.contains local_ok ".@")))
(assert (not (str.contains local_ok "@.")))
(assert (str.contains local_ok "."))

; domain basic properties
(assert (>= (str.len domain_ok) 3))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok "..")))
(assert (not (str.contains domain_ok ".-")))
(assert (not (str.contains domain_ok "-.")))

; Require at least 3 dot-separated segments in domain (sub + sld + tld)
(assert (>= (str.num_splits domain_ok ".") 3))
(assert (= dot_count_ok (str.num_splits domain_ok ".")))

; Extract host and TLD from domain using split_rest
; host_ok = all but last segment; tld_ok = last segment
(assert (= host_ok (str.split_rest domain_ok "." 0)))
(assert (= tld_ok (str.split_at domain_ok "." (- dot_count_ok 1))))

; Also constrain the second-level domain to be non-empty
(assert (= sld_ok (str.split_at domain_ok "." (- dot_count_ok 2))))
(assert (>= (str.len sld_ok) 1))

; TLD constraints: exactly 2 lowercase letters
(assert (= (str.len tld_ok) 2))
(assert (str.in_re tld_ok (re.++ (re.range "a" "z") (re.range "a" "z"))))

; Ensure domain doesn't start or end with '.'
(assert (not (= (str.at domain_ok 0) ".")))
(assert (not (= (str.at domain_ok (- (str.len domain_ok) 1)) ".")))

; Provide a concrete satisfying witness for the SAT instance
(assert (= email_ok "first.last@sub.example.co"))

; -----------------------------
; UNSAT instance: impose contradictory requirements for a malformed email
; Requires exactly one '@' but also requires three segments after splitting by '@'
; Also makes domain_bad both contain and not contain '.' simultaneously
; -----------------------------
(assert (>= (str.len email_bad) 3))
(assert (not (str.contains email_bad " ")))

(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))
(assert (= email_bad (str.++ local_bad "@" domain_bad)))

; Contradiction on number of splits by '@'
(assert (= (str.num_splits email_bad "@") 2))
(assert (= (str.num_splits email_bad "@") 3))

; Additional conflicting domain constraints
(assert (= dot_count_bad (str.num_splits domain_bad ".")))
(assert (>= (str.len domain_bad) 1))
(assert (str.contains domain_bad "."))
(assert (not (str.contains domain_bad ".")))

; Force a recognizable malformed shape for readability (still UNSAT due to above)
(assert (= email_bad "a@@b"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

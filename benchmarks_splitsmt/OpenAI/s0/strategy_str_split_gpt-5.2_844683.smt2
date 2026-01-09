(set-logic ALL)

; Uninterpreted str_split interface

; Primary inputs
(declare-const email String)
(declare-const email_unsat String)

; Derived components (intended parsing)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_rest1 String)
(declare-const tld String)
(declare-const subdomain String)

; Auxiliary integers
(declare-const at_splits Int)
(declare-const dot_splits Int)
(declare-const dot_splits_unsat Int)

; -------------------------------
; SAT instance: complex email validation
; -------------------------------

; Basic sanity: non-empty email and must contain exactly one '@'
(assert (> (str.len email) 5))
(assert (= at_splits (str.num_splits email "@")))
(assert (= at_splits 2))

; Bind local and domain parts via split_at
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Local-part constraints: non-empty, no spaces, no '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Domain constraints: must have at least one '.' (i.e., >= 2 segments)
(assert (= dot_splits (str.num_splits domain ".")))
(assert (>= dot_splits 2))

; Bind first domain label and the rest
(assert (= domain_label0 (str.split_at domain "." 0)))
(assert (= domain_rest1 (str.split_rest domain "." 1)))
(assert (> (str.len domain_label0) 0))

; Domain labels should not contain '@' or spaces
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain " ")))

; Require at least one subdomain label before TLD when there are >= 3 labels
; (if exactly 2 labels, subdomain is empty and domain_rest1 is just the TLD)
(assert (= subdomain (str.split_at domain_rest1 "." 0)))

; TLD: last segment (approximated by taking last segment of domain_rest1)
; For dot_splits >= 2, domain_rest1 has at least 1 segment.
(assert (= tld (str.split_at domain_rest1 "." (- (str.num_splits domain_rest1 ".") 1))))

; TLD constraints: length 2..6, no digits (approx via regex), no hyphen at start (weak check)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Enforce that domain starts with a letter and contains at least one dot (already via dot_splits)
(assert (str.in_re domain_label0 (re.++ (re.range "a" "z") (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-"))))))

; Provide a witness shape to ensure satisfiable and "complex": local contains a '+' tag
(assert (str.contains local "+"))
(assert (str.in_re local (re.++ (re.+ (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-"))) (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-"))))))

; Make the overall email lower-case and constrained (single '@' already)
(assert (= email (str.++ local "@" domain)))
(assert (str.in_re email (re.++ (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-"))) (str.to_re "@") (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re "."))))))

; -------------------------------
; UNSAT instance: contradictory constraints about '@' and '.' structure
; -------------------------------

; Force exactly one '@' but also require the email to have no '@'
(assert (= (str.num_splits email_unsat "@") 2))
(assert (not (str.contains email_unsat "@")))

; Additionally require a domain part after '@' while claiming no '.' segments exist
(assert (= dot_splits_unsat (str.num_splits (str.split_at email_unsat "@" 1) ".")))
(assert (>= dot_splits_unsat 2))
(assert (= dot_splits_unsat 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

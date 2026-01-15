; Email Validation Scenario: Complex email address validation using str_split operations
(set-logic ALL)
; Declare string variables for email and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)
; Declare integer variables for segment counts
(declare-const at_splits Int)
(declare-const dot_splits Int)
; Declare boolean variables for validation conditions
(declare-const valid_email Bool)
(declare-const valid_local Bool)
(declare-const valid_domain Bool)
(declare-const valid_tld Bool)
; Declare uninterpreted functions for str_split interface
; Core constraints for email validation
; Split email at '@' to get local part and domain
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_rest email "@" 1)))
(assert (= at_splits (str.num_splits email "@")))
; Validate exactly one '@' in email (at least 2 segments)
(assert (>= at_splits 2))
(assert (<= at_splits 2))
; Validate local part is non-empty and contains no spaces
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part " ")))
; Split domain at '.' to get domain name and TLD
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))
(assert (= dot_splits (str.num_splits domain ".")))
; Validate domain has at least one '.' (at least 2 segments)
(assert (>= dot_splits 2))
; Validate domain name is non-empty and alphanumeric
(assert (> (str.len domain_name) 0))
(assert (str.in_re domain_name (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))
; Validate TLD is non-empty and alphabetic
(assert (> (str.len tld) 0))
(assert (str.in_re tld (re.++ (re.+ (re.range "a" "z")) )))
; Combine validation conditions
(assert (= valid_local (and (> (str.len local_part) 0) (not (str.contains local_part " ")))))
(assert (= valid_domain (and (> (str.len domain_name) 0) (>= dot_splits 2))))
(assert (= valid_tld (and (> (str.len tld) 0) (str.in_re tld (re.++ (re.+ (re.range "a" "z")) )))))
(assert (= valid_email (and valid_local valid_domain valid_tld (= at_splits 2))))
; Additional constraints for diversity: email must contain at least one '.' in domain beyond TLD separation
(assert (str.contains domain "."))
; Final assertion: email must be valid
(assert valid_email)
; Add a specific example constraint to make it SAT (e.g., email ends with ".com")
(assert (str.suffixof ".com" email))
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

; Email Validation Scenario: Complex email address validation using '@' and '.' as delimiters
; This scenario verifies segment counts and domain structure for email addresses
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
(declare-const has_at Bool)
(declare-const has_dot_in_domain Bool)
(declare-const valid_local_length Bool)
(declare-const valid_domain_length Bool)
(declare-const valid_tld Bool)
(declare-const overall_valid Bool)

; Define interface functions for string splitting operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core constraints for email validation
; 1. Check that email contains exactly one '@' character
(assert (= at_splits (num_splits email "@")))
(assert (= has_at (= at_splits 2)))

; 2. Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; 3. Check that domain contains at least one '.'
(assert (= dot_splits (num_splits domain ".")))
(assert (= has_dot_in_domain (>= dot_splits 2)))

; 4. Extract domain name and TLD from domain
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; 5. Validate lengths of components
(assert (= valid_local_length (and (>= (str.len local_part) 1) (<= (str.len local_part) 64))))
(assert (= valid_domain_length (and (>= (str.len domain_name) 1) (<= (str.len domain_name) 255))))
(assert (= valid_tld (and (>= (str.len tld) 2) (<= (str.len tld) 6))))

; 6. Combine all validation conditions
(assert (= overall_valid (and has_at has_dot_in_domain valid_local_length valid_domain_length valid_tld)))

; 7. Add specific constraints to create a SAT instance
; Example: email must be "user@example.com"
(assert (str.contains email "user"))
(assert (str.contains email "example"))
(assert (str.contains email ".com"))
(assert (>= (str.len email) 10))

; 8. Final assertion requiring overall validity
(assert overall_valid)

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
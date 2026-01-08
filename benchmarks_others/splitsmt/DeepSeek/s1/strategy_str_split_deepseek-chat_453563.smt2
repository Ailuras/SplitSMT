; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure: Use str_split operations to verify segment counts and domain structure
(set-logic ALL)

; Declare string variables for email and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_name String)
(declare-const tld String)

; Declare integer variables for segment counts
(declare-const num_at_splits Int)
(declare-const num_dot_splits Int)

; Declare uninterpreted functions for str_split interface

; Constraint 1: Email must contain exactly one '@' character
(assert (= num_at_splits (str.num_splits email "@")))
(assert (= num_at_splits 2))

; Constraint 2: Extract local part (before '@') and domain part (after '@')
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain_part (str.split_at email "@" 1)))

; Constraint 3: Domain part must contain at least one '.' character
(assert (= num_dot_splits (str.num_splits domain_part ".")))
(assert (>= num_dot_splits 2))

; Constraint 4: Extract domain name (first part before last '.') and TLD (last part after last '.')
(assert (= domain_name (str.split_at domain_part "." 0)))
(assert (= tld (str.split_at domain_part "." (- num_dot_splits 1))))

; Constraint 5: Local part must be non-empty and contain only alphanumeric characters, dots, underscores, or hyphens
(assert (> (str.len local_part) 0))
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-")))))

; Constraint 6: Domain name must be non-empty and contain only alphanumeric characters or hyphens
(assert (> (str.len domain_name) 0))
(assert (str.in_re domain_name (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 7: TLD must be 2-6 letters long and contain only alphabetic characters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Constraint 8: Additional validation - email must not contain consecutive dots in local part
(assert (not (str.contains local_part "..")))

; Constraint 9: Ensure the entire email string ends with a newline character (as in seed)
(assert (str.suffixof "\u{a}" email))

; Constraint 10: Make the problem SAT by adding a concrete example that satisfies all constraints
(assert (or (= email "john.doe@example.com\u{a}") (= email "alice_smith123@test-domain.org\u{a}")))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)

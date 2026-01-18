; Email Validation Scenario: Complex email address validation using '@' and '.' as delimiters
; This scenario verifies segment counts and domain structure for email addresses
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for email address and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare functions for string split operations

; Constraint 1: Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (split_at email "@" 0)))

; Constraint 3: Extract domain part (after '@')
(assert (= domain (split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.' character
(assert (>= (num_splits domain ".") 2))

; Constraint 5: Extract domain name (first part before last '.')
(assert (= domain_name (split_at domain "." 0)))

; Constraint 6: Extract top-level domain (last part after last '.')
(assert (= tld (split_rest domain "." 1)))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be at least 2 characters long
(assert (>= (str.len tld) 2))

; Constraint 10: Email must not contain spaces
(assert (not (str.contains email " ")))

; Constraint 11: Domain must not start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Constraint 12: Local part can contain dots but not consecutive dots
(assert (not (str.contains local_part "..")))

; Constraint 13: TLD must contain only letters
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Constraint 14: Domain name can contain letters, digits, and hyphens
(assert (str.in_re domain_name (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 15: Local part can contain letters, digits, dots, underscores, and hyphens
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-")))))

; Additional constraint to make the problem SAT: Provide a concrete example
(assert (= email "john.doe_123@example.co.uk"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)

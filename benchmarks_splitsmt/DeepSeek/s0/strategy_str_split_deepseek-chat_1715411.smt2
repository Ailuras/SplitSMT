; Email Validation Scenario: Complex email address format validation using str_split operations
(set-logic ALL)

; Declare variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts String)
(declare-const tld String)
(declare-const subdomain String)

; Declare str_split interface functions

; Constraint 1: Email must contain exactly one '@' character
(assert (= (str.num_splits email "@") 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (str.split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (str.split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
(assert (>= (str.num_splits domain ".") 2))

; Constraint 5: Extract top-level domain (last part after last '.')
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Constraint 6: TLD must be between 2 and 6 characters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain must be non-empty
(assert (> (str.len domain) 0))

; Constraint 9: If domain has more than 2 parts, extract subdomain
(assert (=> (> (str.num_splits domain ".") 2) (= subdomain (str.split_at domain "." 0))))

; Constraint 10: Subdomain (if exists) must not be empty
(assert (=> (> (str.num_splits domain ".") 2) (> (str.len subdomain) 0)))

; Constraint 11: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 12: Local part cannot contain consecutive dots
(assert (not (str.contains (str.++ local_part "..") "..")))

; Additional constraint for complex pattern: Domain parts concatenation
(assert (= domain_parts (str.split_rest domain "." 0)))

; Final check
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

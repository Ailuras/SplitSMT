; Email Validation Scenario: Complex email address format validation using str_split operations
(set-logic ALL)

; Declare variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_name String)
(declare-const tld String)

; Declare str_split interface functions

; Constraint 1: Email must contain exactly one '@' character
(assert (= (str.num_splits email "@") 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (str.split_at email "@" 0)))

; Constraint 3: Extract domain part (after '@')
(assert (= domain_part (str.split_at email "@" 1)))

; Constraint 4: Domain part must contain at least one '.'
(assert (>= (str.num_splits domain_part ".") 2))

; Constraint 5: Extract domain name (before last '.' in domain part)
(assert (= domain_name (str.split_at domain_part "." 0)))

; Constraint 6: Extract top-level domain (after last '.' in domain part)
(assert (= tld (str.split_rest domain_part "." 1)))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be between 2 and 6 characters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 10: Email must not start or end with '.'
(assert (not (= (str.at email 0) ".")))
(assert (not (= (str.at email (- (str.len email) 1)) ".")))

; Constraint 11: Additional validation - domain part must not contain consecutive dots
(assert (not (str.contains domain_part "..")))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

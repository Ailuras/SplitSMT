; Email Validation Scenario: Complex email address formats using '@' and '.' as delimiters
(set-logic ALL)

; Declare variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts String)
(declare-const tld String)

; Declare functions for str_split interface

; Constraint 1: Split email at '@' to get local part and domain
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_rest email "@" 1)))
(assert (>= (str.num_splits email "@") 2))

; Constraint 2: Domain must contain at least one '.' for TLD separation
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_parts (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))

; Constraint 3: Local part must be non-empty and not contain '@'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))

; Constraint 4: Domain parts (excluding TLD) must be non-empty
(assert (> (str.len domain_parts) 0))

; Constraint 5: TLD must be at least 2 characters long (common email standard)
(assert (>= (str.len tld) 2))

; Constraint 6: Ensure email does not start or end with '.' or '@'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))
(assert (not (str.prefixof "@" email)))
(assert (not (str.suffixof "@" email)))

; Constraint 7: Additional complexity: domain must not have consecutive '.'
(assert (not (str.contains domain "..")))

; Check satisfiability
(check-sat)
(get-value (email local_part domain tld))


; [GENERATION STATUS: SUCCESS]

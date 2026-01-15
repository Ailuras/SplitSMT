; Email Validation Scenario: Complex email address formats using '@' and '.' as delimiters
(set-logic ALL)

; Declare variables for email address and its segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare functions for string split operations

; Constraint 1: Split email at '@' to get local part and domain
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_rest email "@" 1)))
(assert (>= (str.num_splits email "@") 2))

; Constraint 2: Split domain at '.' to get domain name and TLD
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))
(assert (>= (str.num_splits domain ".") 2))

; Constraint 3: Ensure local part is non-empty and contains only allowed characters (simplified)
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))

; Constraint 4: Ensure domain name is non-empty and TLD has at least 2 characters
(assert (> (str.len domain_name) 0))
(assert (>= (str.len tld) 2))

; Constraint 5: Additional complexity: Domain must not start or end with '.' (handled via split)
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Constraint 6: SAT instance: Allow a valid email format
(assert (str.contains email "example@domain.com"))

; Check satisfiability
(check-sat)
(get-value (email local_part domain domain_name tld))

; [GENERATION STATUS: SUCCESS]
(exit)

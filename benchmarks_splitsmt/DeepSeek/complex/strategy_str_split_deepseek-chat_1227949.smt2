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

; Constraint 2: Domain must contain at least one '.' for domain name and TLD
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))

; Constraint 3: Local part must be non-empty and not contain '@'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))

; Constraint 4: Domain name must be non-empty and not contain '.'
(assert (> (str.len domain_name) 0))
(assert (not (str.contains domain_name ".")))

; Constraint 5: TLD must be non-empty and at least 2 characters long
(assert (> (str.len tld) 0))
(assert (>= (str.len tld) 2))

; Constraint 6: Email must not start or end with '.' or '@'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))
(assert (not (str.prefixof "@" email)))
(assert (not (str.suffixof "@" email)))

; Constraint 7: Ensure no consecutive '.' in the domain part
(assert (not (str.contains domain "..")))

; Additional constraint for SAT instance: Example email pattern
(assert (str.contains email "example"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

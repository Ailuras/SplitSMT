; Email Validation Scenario: Complex email address formats using '@' and '.' as delimiters
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for email address and its segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare functions for string split operations

; Constraint 1: Split email by '@' to get local_part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_rest email "@" 1)))
(assert (>= (num_splits email "@") 2))

; Constraint 2: Split domain by '.' to get domain_name and tld
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (>= (num_splits domain ".") 2))

; Constraint 3: Ensure local_part is non-empty and contains only allowed characters (simplified)
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))

; Constraint 4: Ensure domain_name is non-empty and tld has at least 2 characters
(assert (> (str.len domain_name) 0))
(assert (>= (str.len tld) 2))

; Constraint 5: Additional complexity: email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 6: Make it SAT by allowing a specific valid email pattern
(assert (str.contains email "example.com"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

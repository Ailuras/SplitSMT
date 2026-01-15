; Email Validation Scenario
; Validating complex email address formats using '@' and '.' as delimiters
; Constraints verify segment counts and domain structure
(set-logic ALL)

; Declare string variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare integer variables for segment counts
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Declare interface functions for string splitting

; Constraint 1: Email must contain exactly one '@' character
(assert (= at_splits (str.num_splits email "@")))
(assert (= at_splits 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (str.split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (str.split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
(assert (>= (str.num_splits domain ".") 2))

; Constraint 5: Extract domain name (before last '.' in domain)
(assert (= domain_name (str.split_at domain "." 0)))

; Constraint 6: Extract top-level domain (after last '.' in domain)
(assert (= tld (str.split_rest domain "." 1)))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be 2-4 characters long
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 4))

; Constraint 10: TLD must contain only letters
(assert (str.in_re tld (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))) )))

; Constraint 11: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 12: Create a complex pattern - domain must have at least 3 characters
(assert (>= (str.len domain) 3))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

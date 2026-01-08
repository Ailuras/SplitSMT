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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Email must contain exactly one '@' character
(assert (= at_splits (num_splits email "@")))
(assert (= at_splits 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
(assert (= dot_splits (num_splits domain ".")))
(assert (>= dot_splits 2))

; Constraint 5: Extract domain name (first part of domain)
(assert (= domain_name (split_at domain "." 0)))

; Constraint 6: Extract TLD (last part of domain)
(assert (= tld (split_at domain "." (- dot_splits 1))))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be at least 2 characters
(assert (>= (str.len tld) 2))

; Constraint 10: Domain must not start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Constraint 11: Local part cannot contain '@'
(assert (not (str.contains local_part "@")))

; Constraint 12: Additional validation - email must be at least 6 characters
(assert (>= (str.len email) 6))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)

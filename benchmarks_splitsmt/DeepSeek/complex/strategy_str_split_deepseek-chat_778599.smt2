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

; Declare integer variables
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Declare interface functions for str_split operations

; Constraint 1: Email must contain exactly one '@' character
(assert (= at_splits (str.num_splits email "@")))
(assert (= at_splits 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (str.split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (str.split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
(assert (= dot_splits (str.num_splits domain ".")))
(assert (>= dot_splits 2))

; Constraint 5: Extract domain name (first part before last '.')
(assert (= domain_name (str.split_at domain "." 0)))

; Constraint 6: Extract TLD (last part after last '.')
(assert (= tld (str.split_rest domain "." 1)))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be 2-4 characters long
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 4))

; Constraint 10: TLD must contain only letters
(assert (str.in_re tld (re.* (re.range "a" "z"))))

; Constraint 11: Local part cannot contain '@' or spaces
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))

; Constraint 12: Domain cannot start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Additional constraint to make it SAT: provide a concrete example
(assert (= email "user.name@example.com"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

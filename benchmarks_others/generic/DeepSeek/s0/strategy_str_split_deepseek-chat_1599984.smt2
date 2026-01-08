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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Email must contain exactly one '@' character
; This means splitting by '@' should produce exactly 2 segments
(assert (= at_splits (num_splits email "@")))
(assert (= at_splits 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (split_at email "@" 1)))

; Constraint 4: Local part must not be empty
(assert (> (str.len local_part) 0))

; Constraint 5: Domain must contain at least one '.'
; This means splitting domain by '.' should produce at least 2 segments
(assert (= dot_splits (num_splits domain ".")))
(assert (>= dot_splits 2))

; Constraint 6: Extract domain name (part before last '.')
; Using split_rest to get all parts except the last one
(assert (= domain_name (split_rest domain "." 0)))

; Constraint 7: Extract TLD (last part after '.')
; Using split_at with index (dot_splits - 1) to get the last segment
(assert (= tld (split_at domain "." (- dot_splits 1))))

; Constraint 8: TLD must be between 2 and 6 characters long
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 9: Domain name must not be empty
(assert (> (str.len domain_name) 0))

; Constraint 10: Email must end with a valid domain structure
; This ensures the domain ends with '.' followed by TLD
(assert (str.suffixof (str.++ "." tld) domain))

; Constraint 11: Additional complexity - local part cannot start or end with '.'
(assert (not (str.prefixof "." local_part)))
(assert (not (str.suffixof "." local_part)))

; Constraint 12: Domain cannot have consecutive '.' characters
; Using str.contains to check for ".." in domain
(assert (not (str.contains domain "..")))

; Constraint 13: Email total length constraint
(assert (<= (str.len email) 254))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)

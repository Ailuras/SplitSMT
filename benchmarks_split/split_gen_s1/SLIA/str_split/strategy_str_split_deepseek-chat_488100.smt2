; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; This scenario verifies segment counts and domain structure using str_split operations
(set-logic ALL)

; Declare variables for email address and its parts
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Email must contain exactly one '@' delimiter, splitting into local_part and domain
(assert (= (num_splits email "@") 2))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Constraint 2: Domain must contain at least one '.' delimiter, splitting into domain_name and tld
(assert (>= (num_splits domain ".") 2))
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Constraint 3: Local part must be non-empty and not contain '@' or '.'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part ".")))

; Constraint 4: Domain name must be non-empty and consist only of alphanumeric characters and hyphens
(assert (> (str.len domain_name) 0))
(assert (str.in_re domain_name (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))

; Constraint 5: TLD must be at least 2 characters long and consist only of letters
(assert (>= (str.len tld) 2))
(assert (str.in_re tld (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))) )))

; Constraint 6: Additional validation: domain must not start or end with a hyphen
(assert (not (str.prefixof "-" domain_name)))
(assert (not (str.suffixof "-" domain_name)))

; Constraint 7: Ensure the email is not a trivial case like "a@b.c" by requiring local_part length > 1
(assert (> (str.len local_part) 1))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
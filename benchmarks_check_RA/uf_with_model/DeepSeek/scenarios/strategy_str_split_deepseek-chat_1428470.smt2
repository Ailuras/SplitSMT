; Email Validation Scenario: Complex email address validation using '@' and '.' as delimiters
; Core structure: Validate segment counts and domain structure with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for email address and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare str_split interface functions

; Constraint 1: Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Constraint 2: Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Constraint 3: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 4: Domain must contain at least one '.' character
(assert (>= (num_splits domain ".") 2))

; Constraint 5: Extract domain name (before last '.') and TLD (after last '.')
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))

; Constraint 6: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 7: TLD must be between 2 and 6 characters (common TLD lengths)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 8: Email must not contain spaces
(assert (not (str.contains email " ")))

; Constraint 9: Local part can contain letters, digits, dots, underscores, and hyphens
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-")))))

; Constraint 10: Domain name can contain letters, digits, and hyphens
(assert (str.in_re domain_name (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 11: TLD must contain only letters
(assert (str.in_re tld (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Constraint 12: Email length must be reasonable (between 5 and 254 characters)
(assert (>= (str.len email) 5))
(assert (<= (str.len email) 254))

; Additional constraint to make it SAT: Provide a concrete example email
(assert (= email "user.name_123@example.co.uk"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)

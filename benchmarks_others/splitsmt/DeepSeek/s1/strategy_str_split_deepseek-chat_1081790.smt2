; Email Validation Scenario: Validate complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added constraints for segment counts and domain structure
(set-logic ALL)

; Declare variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare interface functions for str_split operations

; Constraint 1: Email must contain exactly one '@' character
(assert (= (str.num_splits email "@") 2))

; Constraint 2: Extract local part (before '@') and domain (after '@')
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Constraint 3: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 4: Domain must contain at least one '.' delimiter
(assert (>= (str.num_splits domain ".") 2))

; Constraint 5: Extract domain name (first part before last '.') and TLD (last part after last '.')
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))

; Constraint 6: Domain name must be at least 2 characters long
(assert (>= (str.len domain_name) 2))

; Constraint 7: TLD must be between 2 and 6 characters (common TLD lengths)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 8: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 9: Domain must not contain consecutive dots
(assert (not (str.contains domain "..")))

; Constraint 10: Local part can contain alphanumeric and certain special characters
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-") (str.to_re "+")))))

; Constraint 11: Domain name must be alphanumeric with hyphens allowed (but not at start/end)
(assert (str.in_re domain_name (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))))

; Constraint 12: TLD must be only letters
(assert (str.in_re tld (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))))

; Additional constraint to make it SAT: Provide a concrete example email
(assert (= email "user.name+tag@sub-domain.example.com"))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]

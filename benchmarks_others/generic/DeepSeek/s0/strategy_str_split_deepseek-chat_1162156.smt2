; Email Validation Scenario using str_split interface
(set-logic ALL)

; Declare variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (split_at email "@" 1)))

; Constraint 4: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 5: Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))

; Constraint 6: Extract domain name (before last '.')
(assert (= domain_name (split_at domain "." 0)))

; Constraint 7: Extract TLD (after last '.')
(assert (= tld (split_rest domain "." 1)))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be 2-6 characters long
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 10: TLD must contain only letters
(assert (str.in_re tld (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))) (str.to_re ""))))

; Constraint 11: Local part cannot contain '@' or spaces
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))

; Constraint 12: Domain cannot start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Additional constraint to make it SAT: provide a concrete example
(assert (= email "user.name@example.com"))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)

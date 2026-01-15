; Email Validation Scenario: Complex email address validation using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare email address and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts String)
(declare-const tld String)

; Declare str_split interface functions

; Constraint 1: Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))

; Constraint 5: Extract top-level domain (last part after last '.')
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Constraint 6: TLD must be 2-4 characters long
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 4)))

; Constraint 7: Local part must not be empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain must not be empty
(assert (> (str.len domain) 0))

; Constraint 9: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 10: Additional validation - email must match a basic pattern
(assert (str.in_re email (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))) (str.to_re "@") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-"))) (str.to_re ".") ((_ re.loop 2 4) (re.range "a" "z")))))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

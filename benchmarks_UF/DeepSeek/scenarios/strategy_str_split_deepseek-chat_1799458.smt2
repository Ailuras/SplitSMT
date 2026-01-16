; Email Validation Scenario: Complex email address validation using str_split operations
; Core structure: Validate email format with '@' and '.' delimiters, segment counts, and domain structure
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare email string variable
(declare-const email String)

; Declare str_split interface functions for email validation

; Constraint 1: Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Extract local part (before '@') and domain part (after '@')
(declare-const local_part String)
(declare-const domain_part String)
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_part (split_at email "@" 1)))

; Constraint 2: Local part must be non-empty and not too long
(assert (> (str.len local_part) 0))
(assert (<= (str.len local_part) 64))

; Constraint 3: Domain part must contain at least one '.' delimiter
(assert (>= (num_splits domain_part ".") 2))

; Extract top-level domain (last segment after '.')
(declare-const tld String)
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))

; Constraint 4: TLD must be 2-6 characters long and contain only letters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Constraint 5: Domain name (excluding TLD) must be non-empty
(declare-const domain_name String)
(assert (= domain_name (split_at domain_part "." 0)))
(assert (> (str.len domain_name) 0))

; Constraint 6: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 7: Additional validation - email must match standard pattern
(assert (str.in_re email (re.++ 
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") 
                   (str.to_re "!") (str.to_re "#") (str.to_re "$") (str.to_re "%") 
                   (str.to_re "&") (str.to_re "'") (str.to_re "*") (str.to_re "+") 
                   (str.to_re "-") (str.to_re "/") (str.to_re "=") (str.to_re "?") 
                   (str.to_re "^") (str.to_re "_") (str.to_re "`") (str.to_re "{") 
                   (str.to_re "|") (str.to_re "}") (str.to_re "~"))) 
    (str.to_re "@") 
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) 
    (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))))) 
    (str.to_re ".") 
    ((_ re.loop 2 6) (re.union (re.range "a" "z") (re.range "A" "Z"))) 
)))

; Constraint 8: Create UNSAT condition - email cannot contain consecutive dots in domain
(assert (not (str.contains domain_part "..")))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

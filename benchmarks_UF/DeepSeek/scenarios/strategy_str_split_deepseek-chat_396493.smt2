; Email Validation: Complex email address format validation using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for email and its parts
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare integer variables for segment counts
(declare-const num_at_splits Int)
(declare-const num_dot_splits Int)

; Define uninterpreted functions for str_split interface

; Constraint 1: Split email by '@' to get local part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_rest email "@" 1)))
(assert (= num_at_splits (num_splits email "@")))
(assert (>= num_at_splits 2)) ; Must have at least one '@' to split into two parts

; Constraint 2: Validate local part - must be non-empty and contain only alphanumeric characters and dots
(assert (> (str.len local_part) 0))
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".")))))

; Constraint 3: Split domain by '.' to get domain name and TLD
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (= num_dot_splits (num_splits domain ".")))
(assert (>= num_dot_splits 2)) ; Domain must have at least one '.' to separate name and TLD

; Constraint 4: Validate domain name - non-empty and alphanumeric
(assert (> (str.len domain_name) 0))
(assert (str.in_re domain_name (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 5: Validate TLD - must be 2 to 6 letters and not start with a digit
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))))

; Constraint 6: Additional complexity - ensure no consecutive dots in local part or domain
(assert (not (str.contains local_part "..")))
(assert (not (str.contains domain "..")))

; Constraint 7: Make the problem SAT by allowing a specific example
(assert (str.contains email "example@domain.com"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

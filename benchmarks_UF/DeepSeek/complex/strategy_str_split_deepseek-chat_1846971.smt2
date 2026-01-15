; Email Validation Scenario: Complex email address formats using '@' and '.' as delimiters
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for email address and its segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare uninterpreted functions for str_split interface

; Constraint 1: Split email by '@' to get local_part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_rest email "@" 1)))
(assert (>= (num_splits email "@") 2))

; Constraint 2: Split domain by '.' to get domain_name and tld
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (>= (num_splits domain ".") 2))

; Constraint 3: Ensure local_part is non-empty and contains only alphanumeric characters and dots
(assert (> (str.len local_part) 0))
(assert (str.in_re local_part (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "."))) )))

; Constraint 4: Ensure domain_name is non-empty and contains only alphanumeric characters and hyphens
(assert (> (str.len domain_name) 0))
(assert (str.in_re domain_name (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))

; Constraint 5: Ensure tld is non-empty and contains only letters
(assert (> (str.len tld) 0))
(assert (str.in_re tld (re.++ (re.* (re.range "a" "z")) )))

; Constraint 6: Additional complexity: email must not start or end with a dot
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 7: Make it SAT by allowing a specific valid email example
(assert (str.contains email "example@domain.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

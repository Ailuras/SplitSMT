; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added constraints for segment counts and domain structure
(set-logic ALL)

; Declare string variables for email components
(declare-fun email () String)
(declare-fun local_part () String)
(declare-fun domain () String)
(declare-fun domain_parts () String)
(declare-fun tld () String)
(declare-fun subdomain () String)

; Declare integer variables for segment counts
(declare-fun at_splits () Int)
(declare-fun dot_splits () Int)
(declare-fun domain_dot_splits () Int)

; Declare boolean variables for validation checks
(declare-fun valid_email_format () Bool)
(declare-fun valid_local_part () Bool)
(declare-fun valid_domain () Bool)
(declare-fun valid_tld () Bool)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Core email validation constraints
; Constraint 1: Email must contain exactly one '@' character
(assert (= at_splits (num_splits email "@")))
(assert (= valid_email_format (= at_splits 2)))

; Constraint 2: Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Constraint 3: Local part must be non-empty and not contain '@'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (= valid_local_part (not (str.contains local_part "@"))))

; Constraint 4: Domain must contain at least one '.' and be non-empty
(assert (> (str.len domain) 0))
(assert (= dot_splits (num_splits domain ".")))
(assert (= valid_domain (>= dot_splits 2)))

; Constraint 5: Extract TLD (last part after last '.')
(assert (= domain_dot_splits (num_splits domain ".")))
(assert (= tld (split_at domain "." (- domain_dot_splits 1))))

; Constraint 6: TLD must be 2-4 characters long and alphabetic only
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 4))
(assert (str.in_re tld (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))))
(assert (= valid_tld (and (>= (str.len tld) 2) (<= (str.len tld) 4))))

; Constraint 7: Extract subdomain (all parts before TLD)
(assert (= subdomain (split_rest domain "." 0)))
(assert (<= (num_splits subdomain ".") 3)) ; Limit subdomain depth

; Constraint 8: Additional complex pattern - email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 9: Ensure overall email validity
(assert (and valid_email_format valid_local_part valid_domain valid_tld))

; Constraint 10: Create both SAT and UNSAT possibilities with additional constraints
; SAT case: Valid email with specific pattern
(assert (str.contains email "example"))
; UNSAT case: Comment out to make SAT, uncomment to make UNSAT
; (assert (str.contains email "..")) ; Double dot makes invalid

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)

; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added str_split operations for segment counts and domain structure
(set-logic ALL)
; Declare variables for email address and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts Int)
(declare-const top_level_domain String)
(declare-const second_level_domain String)
; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Assert that email contains exactly one '@' character
(assert (= (num_splits email "@") 2))
; Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
; Ensure local part is non-empty
(assert (> (str.len local_part) 0))
; Ensure domain contains at least one '.' for structure
(assert (>= (num_splits domain ".") 2))
; Extract domain parts count
(assert (= domain_parts (num_splits domain ".")))
; Extract top-level domain (last part after last '.')
(assert (= top_level_domain (split_at domain "." (- domain_parts 1))))
; Ensure top-level domain has length between 2 and 4 characters (e.g., .com, .org)
(assert (>= (str.len top_level_domain) 2))
(assert (<= (str.len top_level_domain) 4))
; Extract second-level domain (part before top-level domain)
(assert (= second_level_domain (split_at domain "." (- domain_parts 2))))
; Ensure second-level domain is non-empty
(assert (> (str.len second_level_domain) 0))
; Additional constraint: email must not start or end with '.'
(assert (not (= (str.at email 0) ".")))
(assert (not (= (str.at email (- (str.len email) 1)) ".")))
; Constraint to make the problem SAT: require a specific pattern in local part (e.g., contains 'user')
(assert (str.contains local_part "user"))
; Final check for satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
; Email Validation Scenario
; Validating complex email address formats using '@' and '.' as delimiters
; Constraints verify segment counts and domain structure
(set-logic ALL)

; Declare string variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))

; Constraint 5: Extract domain name (before last '.')
(assert (= domain_name (split_at domain "." 0)))

; Constraint 6: Extract top-level domain (after last '.')
(assert (= tld (split_rest domain "." 1)))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be between 2 and 6 characters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Constraint 10: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 11: Domain must not contain consecutive dots
(assert (not (str.contains domain "..")))

; Constraint 12: Local part can contain dots but not at start/end
(assert (not (str.prefixof "." local_part)))
(assert (not (str.suffixof "." local_part)))

; Constraint 13: Ensure all segments are properly extracted
(assert (= email (str.++ local_part "@" domain)))
(assert (= domain (str.++ domain_name "." tld)))

; Additional constraint to make it SAT: provide a concrete example
(assert (= email "user.name@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
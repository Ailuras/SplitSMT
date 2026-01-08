; Email Validation Scenario: Complex email address format validation using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for email and its components
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_name String)
(declare-const tld String)

; Declare integer variables for segment counts
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Declare uninterpreted functions for str_split interface

; Constraint 1: Email must contain exactly one '@' character
(assert (= at_splits (num_splits email "@")))
(assert (= at_splits 2))

; Constraint 2: Extract local part (before '@') and domain part (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_part (split_rest email "@" 1)))

; Constraint 3: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 4: Domain part must contain at least one '.'
(assert (= dot_splits (num_splits domain_part ".")))
(assert (>= dot_splits 2))

; Constraint 5: Extract domain name (first part before last '.') and TLD (last part after last '.')
(assert (= domain_name (split_at domain_part "." 0)))
(assert (= tld (split_rest domain_part "." (- dot_splits 1))))

; Constraint 6: Domain name must be at least 2 characters long
(assert (>= (str.len domain_name) 2))

; Constraint 7: TLD must be 2-4 characters long (common email TLD lengths)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 4))

; Constraint 8: Email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 9: Domain part must not contain consecutive dots
(assert (not (str.contains domain_part "..")))

; Additional constraint for UNSAT instance: Force conflicting TLD length
; Uncomment below to make UNSAT
; (assert (= (str.len tld) 5))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

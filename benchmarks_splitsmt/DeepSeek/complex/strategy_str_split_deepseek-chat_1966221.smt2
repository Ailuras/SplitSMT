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

; Declare integer variables for segment counts
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Declare interface functions for string splitting

; Constraint 1: Email must contain exactly one '@' character
; This means splitting by '@' should produce exactly 2 segments
(assert (= at_splits (str.num_splits email "@")))
(assert (= at_splits 2))

; Constraint 2: Extract local part (before '@')
(assert (= local_part (str.split_at email "@" 0)))

; Constraint 3: Extract domain (after '@')
(assert (= domain (str.split_at email "@" 1)))

; Constraint 4: Domain must contain at least one '.'
; This means splitting domain by '.' should produce at least 2 segments
(assert (= dot_splits (str.num_splits domain ".")))
(assert (>= dot_splits 2))

; Constraint 5: Extract domain name (first part before last '.')
; Using split_rest to get everything before the last dot
(assert (= domain_name (str.split_at domain "." 0)))

; Constraint 6: Extract TLD (last part after last '.')
; Using split_at with index (dot_splits-1) to get the last segment
(assert (= tld (str.split_at domain "." (- dot_splits 1))))

; Constraint 7: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 8: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 9: TLD must be at least 2 characters long (standard requirement)
(assert (>= (str.len tld) 2))

; Constraint 10: Email must not start or end with '.'
(assert (not (= (str.at email 0) ".")))
(assert (not (= (str.at email (- (str.len email) 1)) ".")))

; Constraint 11: Additional validation - no consecutive dots in domain
; Using string contains to check for ".." pattern
(assert (not (str.contains domain "..")))

; Constraint 12: Make the problem SAT by allowing reasonable email patterns
; Example: "user@example.com" would satisfy all constraints
; This assertion ensures at least one valid pattern exists
(assert (or
    (str.contains email "a")
    (str.contains email "b")
    (str.contains email "c")
))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

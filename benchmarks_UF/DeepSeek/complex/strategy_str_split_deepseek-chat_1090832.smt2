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

; Declare functions for string split operations

; Constraint 1: Split email at '@' to get local_part (first segment) and domain (second segment)
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))

; Constraint 2: Domain must contain at least one '.' delimiter
(assert (>= (num_splits domain ".") 2))

; Constraint 3: Split domain at '.' to get domain_name (first segment) and tld (last segment)
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Constraint 4: Local part must be non-empty and not contain '@'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))

; Constraint 5: Domain name must be non-empty and not contain '.'
(assert (> (str.len domain_name) 0))
(assert (not (str.contains domain_name ".")))

; Constraint 6: TLD must be non-empty and have length between 2 and 4 characters
(assert (> (str.len tld) 0))
(assert (<= 2 (str.len tld)))
(assert (>= 4 (str.len tld)))

; Constraint 7: Email must not start or end with '.' or '@'
(assert (not (= (str.at email 0) ".")))
(assert (not (= (str.at email 0) "@")))
(assert (not (= (str.at email (- (str.len email) 1)) ".")))
(assert (not (= (str.at email (- (str.len email) 1)) "@")))

; Constraint 8: Additional check for valid domain structure using split_rest
(assert (str.contains (split_rest domain "." 1) "."))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

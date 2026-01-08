; Email Validation Scenario: Complex email address formats using '@' and '.' as delimiters
(set-logic ALL)

; Declare variables for email address and its segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare functions for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Split email at '@' to get local_part (segment 0) and domain (segment 1)
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))

; Constraint 2: Domain must contain at least one '.' delimiter
(assert (>= (num_splits domain ".") 2))

; Constraint 3: Split domain at '.' to get domain_name (segment 0) and tld (segment 1)
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Constraint 4: Local part must be non-empty
(assert (> (str.len local_part) 0))

; Constraint 5: Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; Constraint 6: TLD must be at least 2 characters long (common email standard)
(assert (>= (str.len tld) 2))

; Constraint 7: Ensure no extra '@' symbols in local part or domain (simplified check)
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain_name "@")))
(assert (not (str.contains tld "@")))

; Constraint 8: Domain must not start or end with '.' (basic validation)
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Constraint 9: Make the problem SAT by allowing a specific email pattern
(assert (str.contains email "example.com"))
(assert (str.contains email "@"))

(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]

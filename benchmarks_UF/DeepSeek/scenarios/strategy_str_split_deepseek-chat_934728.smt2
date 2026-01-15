; Email Validation Scenario: Complex email address validation using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare str_split interface functions

; Core email structure constraints
; Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))

; Extract domain name and TLD
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Additional constraints for realistic email validation
; Local part must be non-empty
(assert (> (str.len local_part) 0))

; Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; TLD must be at least 2 characters (common minimum)
(assert (>= (str.len tld) 2))

; Domain must not start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Email must not contain consecutive dots in local part
(assert (not (str.contains local_part "..")))

; Optional: Domain must be alphanumeric with hyphens allowed
(assert (str.in_re domain_name (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

; Email Validation Scenario: Complex email address validation using str_split operations
(set-logic ALL)

; Declare string variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare integer variables for segment counts
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Declare uninterpreted functions for str_split interface

; Core email structure constraints
; Email must contain exactly one '@' character
(assert (= at_splits (str.num_splits email "@")))
(assert (= at_splits 2))

; Extract local part (before '@') and domain (after '@')
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_rest email "@" 1)))

; Domain must contain at least one '.' character
(assert (= dot_splits (str.num_splits domain ".")))
(assert (>= dot_splits 2))

; Extract domain name (first part before last '.') and TLD (last part after last '.')
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." (- dot_splits 1))))

; Additional constraints for realistic email validation
; Local part must be non-empty
(assert (> (str.len local_part) 0))

; Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; TLD must be 2-6 characters long (common TLD lengths)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Local part cannot contain '@' characters
(assert (not (str.contains local_part "@")))

; Domain cannot contain consecutive dots
(assert (not (str.contains domain "..")))

; Local part must match a pattern: alphanumeric with allowed special characters
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "!") (str.to_re "#") (str.to_re "$") (str.to_re "%") (str.to_re "&") (str.to_re "'") (str.to_re "*") (str.to_re "+") (str.to_re "-") (str.to_re "/") (str.to_re "=") (str.to_re "?") (str.to_re "^") (str.to_re "_") (str.to_re "`") (str.to_re "{") (str.to_re "|") (str.to_re "}") (str.to_re "~")))))

; Domain name must be alphanumeric with hyphens allowed
(assert (str.in_re domain_name (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

; TLD must be alphabetic only
(assert (str.in_re tld (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

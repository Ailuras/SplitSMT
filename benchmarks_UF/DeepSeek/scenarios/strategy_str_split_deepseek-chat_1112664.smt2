; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added str_split constraints for segment validation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)
(declare-const subdomain String)

; Declare uninterpreted functions for str_split interface

; Core email structure constraints
; Email must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part must be non-empty
(assert (> (str.len local_part) 0))

; Domain must contain at least one '.' for TLD separation
(assert (>= (num_splits domain ".") 2))

; Extract domain name (first part before last '.') and TLD (last part after last '.')
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; TLD must be between 2 and 6 characters (common email TLD lengths)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Check for subdomain if domain has more than 2 parts
(assert (=> (> (num_splits domain ".") 2) 
    (and 
        (= subdomain (split_at domain "." 0))
        (> (str.len subdomain) 0)
    )
))

; Additional constraints for valid email format
; Local part cannot start or end with '.'
(assert (not (str.prefixof "." local_part)))
(assert (not (str.suffixof "." local_part)))

; Domain cannot start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Local part must contain only allowed characters (simplified)
(assert (str.in_re local_part 
    (re.+ 
        (re.union 
            (re.range "a" "z")
            (re.range "A" "Z")
            (re.range "0" "9")
            (str.to_re ".")
            (str.to_re "_")
            (str.to_re "%")
            (str.to_re "+")
            (str.to_re "-")
        )
    )
))

; Domain parts must contain only allowed characters
(assert (str.in_re domain_name 
    (re.+ 
        (re.union 
            (re.range "a" "z")
            (re.range "A" "Z")
            (re.range "0" "9")
            (str.to_re "-")
        )
    )
))

; TLD must contain only letters
(assert (str.in_re tld 
    (re.+ 
        (re.union 
            (re.range "a" "z")
            (re.range "A" "Z")
        )
    )
))

; Ensure email length is reasonable (typical email max length is 254 characters)
(assert (<= (str.len email) 254))
(assert (>= (str.len email) 3))  ; Minimum: a@b.c

; Create a SAT instance by providing a concrete example
; This makes the problem satisfiable
(assert (str.contains email "example@domain.com"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

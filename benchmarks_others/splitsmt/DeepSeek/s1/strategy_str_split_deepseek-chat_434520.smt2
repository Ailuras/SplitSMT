; Email validation scenario using str_split operations
; Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added constraints for segment counts and domain structure
(set-logic ALL)

; Declare string variables for email components
(declare-fun email () String)
(declare-fun local_part () String)
(declare-fun domain () String)
(declare-fun domain_name () String)
(declare-fun tld () String)

; Declare integer variables for validation
(declare-fun at_count () Int)
(declare-fun dot_count () Int)
(declare-fun local_len () Int)
(declare-fun domain_len () Int)

; Declare str_split interface functions

; Email must contain exactly one '@' character
(assert (= at_count (str.num_splits email "@")))
(assert (= at_count 2))  ; Exactly one '@' means 2 segments

; Extract local part (before '@') and domain (after '@')
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Local part must be non-empty and reasonable length
(assert (= local_len (str.len local_part)))
(assert (>= local_len 1))
(assert (<= local_len 64))

; Domain must contain at least one '.'
(assert (= dot_count (str.num_splits domain ".")))
(assert (>= dot_count 2))  ; At least one '.' means at least 2 segments

; Extract domain name and TLD
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))  ; Everything after first dot

; Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; TLD must be at least 2 characters
(assert (>= (str.len tld) 2))

; Additional constraints for valid email format
; Local part cannot start or end with '.'
(assert (not (str.prefixof "." local_part)))
(assert (not (str.suffixof "." local_part)))

; Domain cannot start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Domain must be reasonable length
(assert (= domain_len (str.len domain)))
(assert (>= domain_len 4))  ; Minimum: a.b
(assert (<= domain_len 255))

; Email must match typical pattern: local@domain.tld
; Using regex to ensure basic structure
(assert (str.in_re email (re.++
  (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") 
                  (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-")))
  (str.to_re "@")
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
    (re.++
      (str.to_re ".")
      (re.union
        (re.++ (re.range "a" "z") (re.range "a" "z"))
        (re.++ (re.range "a" "z") (re.range "a" "z") (re.range "a" "z"))
        (re.++ (re.range "a" "z") (re.range "a" "z") (re.range "a" "z") (re.range "a" "z"))
      )
    )
  )
)))

; Ensure the email is not too short overall
(assert (>= (str.len email) 6))

; Create both SAT and UNSAT possibilities by adding optional constraints
; Comment out one of the following to switch between SAT/UNSAT

; SAT version: valid email
(assert (str.contains email "example.com"))

; UNSAT version: invalid email (uncomment to use instead)
; (assert (str.contains email ".."))  ; Double dot in domain
; (assert (str.contains local_part "@"))  ; '@' in local part

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]

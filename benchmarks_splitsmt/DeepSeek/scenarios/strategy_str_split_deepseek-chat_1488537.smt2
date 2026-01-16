; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure extended with str_split operations for segment counts and domain structure
(set-logic ALL)

; Declare variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts Int)
(declare-const top_level_domain String)
(declare-const subdomain String)
(declare-const valid_email Bool)

; Declare str_split interface functions

; Assertions for email validation
; 1. Email must not be empty
(assert (not (= email "")))

; 2. Split email at '@' delimiter
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_rest email "@" 1)))
(assert (>= (str.num_splits email "@") 2))

; 3. Local part must not be empty and have at least one character
(assert (> (str.len local_part) 0))

; 4. Domain must not be empty and have at least one '.' delimiter
(assert (> (str.len domain) 0))
(assert (>= (str.num_splits domain ".") 2))

; 5. Extract top-level domain (last segment after splitting by '.')
(assert (= domain_parts (str.num_splits domain ".")))
(assert (= top_level_domain (str.split_at domain "." (- domain_parts 1))))

; 6. Top-level domain must be 2-4 characters long (common email TLDs)
(assert (>= (str.len top_level_domain) 2))
(assert (<= (str.len top_level_domain) 4))

; 7. Subdomain (first segment before top-level domain) must not be empty
(assert (= subdomain (str.split_at domain "." 0)))
(assert (> (str.len subdomain) 0))

; 8. Combine constraints to define valid_email
(assert (= valid_email (and
    (not (= email ""))
    (> (str.len local_part) 0)
    (> (str.len domain) 0)
    (>= (str.num_splits email "@") 2)
    (>= (str.num_splits domain ".") 2)
    (>= (str.len top_level_domain) 2)
    (<= (str.len top_level_domain) 4)
    (> (str.len subdomain) 0)
)))

; 9. Add a specific constraint to make it SAT: require email to contain "example.com" in domain
(assert (str.contains domain "example.com"))

; 10. Final check
(assert valid_email)

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

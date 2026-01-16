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

; Constraint 1: Split email at '@' to get local_part (segment 0) and domain (segment 1)
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (<= (num_splits email "@") 2)) ; Ensure exactly one '@' character

; Constraint 2: Split domain at '.' to get domain_name (segment 0) and tld (segment 1)
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))
(assert (>= (num_splits domain ".") 2))
(assert (<= (num_splits domain ".") 2)) ; Ensure exactly one '.' in domain for simplicity

; Constraint 3: Local part must be non-empty and contain only alphanumeric characters and dots
(assert (> (str.len local_part) 0))
(assert (str.in_re local_part (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "."))) )))

; Constraint 4: Domain name must be non-empty and contain only alphanumeric characters and hyphens
(assert (> (str.len domain_name) 0))
(assert (str.in_re domain_name (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))

; Constraint 5: TLD must be a common top-level domain (e.g., com, org, net) with length 2-4 characters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 4))
(assert (or (= tld "com") (= tld "org") (= tld "net") (= tld "edu") (= tld "gov")))

; Constraint 6: Ensure no leading or trailing dots in local part or domain name
(assert (not (str.prefixof "." local_part)))
(assert (not (str.suffixof "." local_part)))
(assert (not (str.prefixof "." domain_name)))
(assert (not (str.suffixof "." domain_name)))

; Constraint 7: Additional check for overall email length (reasonable bounds)
(assert (>= (str.len email) 6))
(assert (<= (str.len email) 254))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

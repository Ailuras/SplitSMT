; Email Validation Scenario: Complex email address formats using '@' and '.' as delimiters
(set-logic ALL)

; Declare variables for email address and its segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)

; Declare functions for string split operations

; Constraint 1: Email must contain exactly one '@' character, splitting into local_part and domain
(assert (= (str.num_splits email "@") 2))
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Constraint 2: Local part must be non-empty and not contain '@'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))

; Constraint 3: Domain must contain at least one '.' character, splitting into domain_name and tld
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_name (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))

; Constraint 4: Domain name must be non-empty and tld must be at least 2 characters long
(assert (> (str.len domain_name) 0))
(assert (>= (str.len tld) 2))

; Constraint 5: Ensure no extra '@' in domain and valid characters (simplified alphanumeric check)
(assert (not (str.contains domain "@")))
(assert (str.in_re domain (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-"))) (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))))))

; Constraint 6: Additional complexity: local part can contain '.' but not as first or last character
(assert (or (= (str.len local_part) 1) (and (not (= (str.at local_part 0) ".")) (not (= (str.at local_part (- (str.len local_part) 1)) ".")))))

; Check satisfiability
(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]

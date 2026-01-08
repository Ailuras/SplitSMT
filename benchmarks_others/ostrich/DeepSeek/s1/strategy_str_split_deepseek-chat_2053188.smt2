; Email Validation Scenario: Complex email address format validation using str_split operations
(set-logic ALL)

; Declare string variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts String)
(declare-const tld String)

; Declare integer variables for segment counts
(declare-const at_count Int)
(declare-const dot_count Int)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Core email structure constraints
; 1. Email must contain exactly one '@' character
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))

; 2. Split email at '@' to get local part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; 3. Domain must contain at least one '.' character
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))

; 4. Extract top-level domain (last segment after splitting by '.')
(assert (= tld (split_at domain "." (- dot_count 1))))

; 5. Local part constraints: must be non-empty and contain only allowed characters
(assert (> (str.len local_part) 0))
(assert (str.in_re local_part (re.++ 
    (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))
    (re.* (re.union 
        (re.range "a" "z") 
        (re.range "A" "Z") 
        (re.range "0" "9")
        (str.to_re "_")
        (str.to_re "-")
        (str.to_re ".")
    ))
)))

; 6. Domain constraints: each part between dots must be non-empty
(assert (forall ((i Int))
    (=> (and (>= i 0) (< i (- dot_count 1)))
        (> (str.len (split_at domain "." i)) 0)
    )
))

; 7. TLD constraints: must be 2-6 letters only
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ 
    (re.union (re.range "a" "z") (re.range "A" "Z"))
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))
)))

; 8. Additional constraint: email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; 9. Complex pattern: domain must have at least two parts before TLD
(assert (>= (- dot_count 1) 2))

; 10. Use split_rest to verify domain structure
(assert (= domain_parts (split_rest domain "." 0)))
(assert (= domain domain_parts))

; 11. SAT/UNSAT variation: uncomment to make UNSAT
; (assert (str.contains email ".."))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]

(set-logic ALL)

; Scenario: Email Validation using '@' and '.' delimiters

; String split interface (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const rest_domain String)

; Mutated remnants from seed (kept structure: regex membership + length coupling + disequality)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "b") (re.* (str.to_re "a"))))))
(assert (str.in_re y (str.to_re "a")))
(assert (= (str.len x) (str.len y)))
(assert (not (= x y)))
(assert (= 7 (str.len x)))

; Email split constraints
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= 2 (num_splits email "@")))

; Local-part constraints (non-empty, restricted charset, no leading/trailing dot)
(assert (>= (str.len local) 1))
(assert (str.in_re local (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re ".") (re.union (str.to_re "_") (str.to_re "-")))))))))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain constraints: at least one dot, labels structure
(assert (>= (num_splits domain ".") 2))
(assert (= first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (= rest_domain (split_rest domain "." 1)))

; First label: non-empty, alnum/hyphen, must start with a letter
(assert (>= (str.len first_label) 1))
(assert (str.in_re first_label (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "-")))))))
(assert (str.in_re (str.at first_label 0) (re.union (re.range "a" "z") (re.range "A" "Z"))))

; TLD: 2..6 letters only
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Cross-check: email must contain exactly one '@' and some '.' in domain
(assert (str.contains email "@"))
(assert (str.contains domain "."))

; SAT instance: provide a concrete satisfying email
(assert (= email "John_Doe-7@example.co"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

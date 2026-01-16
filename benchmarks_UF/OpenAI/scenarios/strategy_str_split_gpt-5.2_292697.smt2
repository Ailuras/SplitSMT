(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation via str_split: mix of SAT + UNSAT branches

; --- str_split interface (uninterpreted, per requirement)

; --- Variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)

(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)

; --- Basic parsing by '@'
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (split_rest email "@" 1) domain))

; --- Local-part constraints
(assert (= local_len (str.len local)))
(assert (>= local_len 1))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "..")))
; local cannot start or end with '.'
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- local_len 1)) ".")))

; --- Domain constraints
(assert (= domain_len (str.len domain)))
(assert (>= domain_len 3))
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "..")))

; Domain split by '.' must have at least two labels: something.tld
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- dot_count 1))))

; Labels must be non-empty, and not contain '.'
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len tld) 2))
(assert (not (str.contains domain_label0 ".")))
(assert (not (str.contains tld ".")))

; TLD structure: only lowercase letters, length 2..6
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ (re.+ (re.range "a" "z")) (re.* (str.to_re "")))))
; The above re.++ trick preserves String sort usage; constrain more precisely with a standard regex:
(assert (str.in_re tld (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))))

; Additional SAT-friendly domain label constraint: first label starts with a letter
(assert (str.in_re (str.at domain_label0 0) (re.range "a" "z")))

; --- SAT/UNSAT diversity through a disjunction
; SAT branch: typical email like "john.doe@example.com" (enforced abstractly)
; UNSAT branch: impossible requirement (tld length 1 but also >=2)
(assert
  (or
    (and
      ; domain must have exactly 3 labels: a.b.tld
      (= dot_count 3)
      (= domain_label1 (split_at domain "." 1))
      (>= (str.len domain_label1) 1)
      (not (str.contains domain_label1 "-"))
      ; forbid underscores in entire email
      (not (str.contains email "_"))
      ; require local contains a dot somewhere
      (str.contains local ".")
      ; ensure email contains the '@' delimiter implicitly (via split count), and a dot in domain
      (str.contains domain ".")
    )
    (and
      ; UNSAT: tld must be both length 1 and at least 2
      (= (str.len tld) 1)
      (>= (str.len tld) 2)
    )
  )
)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

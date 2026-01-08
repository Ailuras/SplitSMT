(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Email validation scenario
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const rest_labels String)
(declare-const second_label String)

; Core split structure: local@domain
(assert (>= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Reject multiple '@' (UNSAT drive with other constraints below)
(assert (= (num_splits email "@") 2))

; Local part constraints
(assert (>= (str.len local) 1))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain structure constraints using '.' delimiter
(assert (>= (num_splits domain ".") 2))
(assert (= first_label (split_at domain "." 0)))
(assert (= rest_labels (split_rest domain "." 1)))

; Ensure first domain label is non-empty and doesn't contain invalid chars
(assert (>= (str.len first_label) 1))
(assert (not (str.contains first_label "_")))
(assert (not (= (str.at first_label 0) "-")))
(assert (not (= (str.at first_label (- (str.len first_label) 1)) "-")))

; Compute TLD as last label via two-level split: rest_labels has at least one '.' or is just tld
(assert (>= (num_splits rest_labels ".") 1))
(assert (= tld (split_at rest_labels "." (- (num_splits rest_labels ".") 1))))

; TLD constraints: alphabetic only, length 2..6
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Additional domain label constraint: second label (if any) non-empty
(assert (>= (num_splits domain ".") 3))
(assert (= second_label (split_at domain "." 1)))
(assert (>= (str.len second_label) 1))

; Mutated from seed: contradicting constraint that email must be an IPv4-with-newline pattern
; This makes the instance UNSAT given the '@' and '.' email structure requirements.
(assert (not (str.in_re email
  (re.++
    (re.union
      (re.++ (str.to_re "25") (re.range "0" "5"))
      (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
      (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
      ((_ re.loop 1 2) (re.range "0" "9")))
    ((_ re.loop 3 3)
      (re.++ (str.to_re ".")
        (re.union
          (re.++ (str.to_re "25") (re.range "0" "5"))
          (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
          (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
          ((_ re.loop 1 2) (re.range "0" "9")))))
    (str.to_re "\u{a}")))))

; Force email to actually match that IPv4-with-newline regex too (direct contradiction with previous assert)
(assert (str.in_re email
  (re.++
    (re.union
      (re.++ (str.to_re "25") (re.range "0" "5"))
      (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
      (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
      ((_ re.loop 1 2) (re.range "0" "9")))
    ((_ re.loop 3 3)
      (re.++ (str.to_re ".")
        (re.union
          (re.++ (str.to_re "25") (re.range "0" "5"))
          (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
          (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
          ((_ re.loop 1 2) (re.range "0" "9")))))
    (str.to_re "\u{a}"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
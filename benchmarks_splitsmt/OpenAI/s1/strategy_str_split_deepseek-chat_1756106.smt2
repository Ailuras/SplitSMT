(set-logic ALL)

; Email Validation scenario using str_split and regex constraints

; Uninterpreted split interface

(declare-const X String) ; original seed variable, repurposed as the email string
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const after_first_dot String)
(declare-const at_count Int)
(declare-const dot_count Int)

; Core split structure: local@domain
(assert (= local (str.split_at X "@" 0)))
(assert (= domain (str.split_at X "@" 1)))
(assert (= at_count (str.num_splits X "@")))
(assert (= at_count 2))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; Domain must contain at least one dot and be split into at least 2 labels
(assert (= dot_count (str.num_splits domain ".")))
(assert (>= dot_count 2))

; Extract first domain label and rest
(assert (= first_label (str.split_at domain "." 0)))
(assert (= after_first_dot (str.split_rest domain "." 1)))
(assert (>= (str.len first_label) 1))
(assert (>= (str.len after_first_dot) 3))

; TLD is the last label when splitting by '.'
(assert (= tld (str.split_at domain "." (- dot_count 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Local part regex: starts/ends with alnum, may contain '.', '_', '+', '-' inside
(assert (str.in_re local
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9")))))

; Domain overall shape: labels separated by dots, labels are alnum or hyphen, no leading/trailing hyphen per label (approximated)
(assert (str.in_re domain
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.+
      (re.++
        (str.to_re ".")
        (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
        (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
        (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9")))))))

; TLD must be alphabetic only
(assert (str.in_re tld (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))) )))

; Disallow consecutive dots in local and domain (string-level approximations)
(assert (not (str.contains local "..")))
(assert (not (str.contains domain "..")))

; Ensure '@' and '.' are used as delimiters in the whole email
(assert (str.contains X "@"))
(assert (str.contains domain "."))

; UNSAT twist: simultaneously require local not to contain '+' but also require it to contain '+'
(assert (not (str.contains local "+")))
(assert (str.contains local "+"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

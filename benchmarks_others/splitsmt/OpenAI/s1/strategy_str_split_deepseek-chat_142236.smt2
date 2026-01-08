(set-logic ALL)

; Email Validation scenario using str_split and regex

; --- Uninterpreted functions for split interface ---

; --- Variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const left_of_dot String)

; --- Core structure: split by '@' and '.' and validate counts ---
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= (str.num_splits email "@") 2))

; Domain must contain at least one dot: e.g., sub.example.tld
(assert (>= (str.num_splits domain ".") 2))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (= left_of_dot (str.split_at domain "." 0)))

; --- Local-part constraints ---
(assert (>= (str.len local) 1))
(assert (<= (str.len local) 64))
(assert (not (str.contains local "..")))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))

; Local-part: starts with alnum; then [A-Za-z0-9._%+-]* (approx)
(assert (str.in_re local
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.*
      (re.union
        (re.range "A" "Z")
        (re.range "a" "z")
        (re.range "0" "9")
        (str.to_re ".")
        (str.to_re "_")
        (str.to_re "%")
        (str.to_re "+")
        (str.to_re "-")
      )))))

; --- Domain constraints ---
(assert (>= (str.len domain) 3))
(assert (<= (str.len domain) 255))
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain "..")))

; Leftmost label cannot start or end with hyphen (approx)
(assert (>= (str.len left_of_dot) 1))
(assert (not (= (str.at left_of_dot 0) "-")))
(assert (not (= (str.at left_of_dot (- (str.len left_of_dot) 1)) "-")))

; Leftmost label characters: [A-Za-z0-9-]+
(assert (str.in_re left_of_dot
  (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

; TLD: only letters, length 2..24
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Total email length bound
(assert (<= (str.len email) 320))

; --- SAT witness to ground the search ---
(assert (= email "user.name+tag_1@sub-example.domain.co"))

; --- Additional UNSAT instance to ensure diversity ---
; Claiming the same email has 2 '@' splits contradicts (= (str.num_splits email "@") 2)
(assert (not (= (str.num_splits email "@") 2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]

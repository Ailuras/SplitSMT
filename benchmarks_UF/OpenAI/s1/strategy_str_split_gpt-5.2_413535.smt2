(set-logic ALL)

; Email Validation scenario using str_split-style segment reasoning and regex sanity checks

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_tld String)
(declare-const domain_tld_extra String)
(declare-const rest_after_at String)
(declare-const rest_after_first_dot String)

; Core split structure: exactly one '@' -> two segments: local and domain
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= rest_after_at (split_rest email "@" 1)))
(assert (= rest_after_at domain))
(assert (= (num_splits email "@") 2))

; Local part constraints
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain structure: at least one '.' -> at least two labels (e.g., example.com)
(assert (>= (num_splits domain ".") 2))
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= domain_tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (= rest_after_first_dot (split_rest domain "." 1)))

; Domain label sanity
(assert (> (str.len domain_first_label) 0))
(assert (not (str.contains domain_first_label "_")))
(assert (not (= (str.at domain_first_label 0) "-")))
(assert (not (= (str.at domain_first_label (- (str.len domain_first_label) 1)) "-")))

; Domain must not contain consecutive dots or spaces, and must not start/end with dot
(assert (not (str.contains domain "..")))
(assert (not (str.contains domain " ")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; TLD constraints: length >= 2, only letters, and from a small allowed set
(assert (>= (str.len domain_tld) 2))
(assert (str.in_re domain_tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))
(assert (str.in_re domain_tld (re.union (str.to_re "com") (str.to_re "org") (str.to_re "net") (str.to_re "edu") (str.to_re "gov") (str.to_re "io") (str.to_re "co") (str.to_re "us") (str.to_re "uk"))))

; Entire email regex (lightweight, aligned with delimiter reasoning)
; local: letters/digits and ._%+- but not spaces; domain: labels with letters/digits/hyphen separated by dots
(assert (str.in_re email
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))
    (str.to_re "@")
    (re.++
      (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
      (re.+ (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
    )
  )
))

; Make file UNSAT by contradicting the exactly-one-'@' constraint with an explicit double-@ requirement
(assert (str.contains email "@@"))

; Additional constraint to stress split reasoning over dots
(assert (= domain_tld_extra (split_at domain "." 2)))
(assert (< (num_splits domain ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
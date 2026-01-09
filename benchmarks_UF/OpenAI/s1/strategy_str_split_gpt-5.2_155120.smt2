(set-logic ALL)

; Scenario: Email Validation using split operations and regex constraints

; Uninterpreted interface operations for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Primary input email
(declare-const x String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const domain_tld String)

; Core split structure: local@domain
(assert (= local (split_at x "@" 0)))
(assert (= domain (split_at x "@" 1)))
(assert (= domain (split_rest x "@" 1)))
(assert (= (num_splits x "@") 2))

; Domain structure: must contain at least one dot separating labels
(assert (>= (num_splits domain ".") 2))
(assert (= domain_first (split_at domain "." 0)))
(assert (= domain_tld (split_at domain "." (- (num_splits domain ".") 1))))

; Basic non-emptiness constraints
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (> (str.len domain_first) 0))
(assert (>= (str.len domain_tld) 2))

; Ensure '@' and '.' are not at boundaries in their respective scopes
(assert (not (= local "")))
(assert (not (= domain "")))
(assert (not (= domain_first "")))

; Local part should not contain '@'
(assert (= (num_splits local "@") 1))

; Domain should not contain '@'
(assert (= (num_splits domain "@") 1))

; Regex constraints: allowed characters in local and domain labels
; Allowed for local: letters/digits and these specials: . _ + -
(declare-const local_re RegLan)
(assert (= local_re
  (re.+
    (re.union
      (re.range "a" "z")
      (re.range "A" "Z")
      (re.range "0" "9")
      (str.to_re ".")
      (str.to_re "_")
      (str.to_re "+")
      (str.to_re "-")
    )
  )
))
(assert (str.in_re local local_re))

; Domain labels: letters/digits/hyphen only, must start with alnum by construction via regex
(declare-const label_re RegLan)
(assert (= label_re
  (re.++
    (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
  )
))
(assert (str.in_re domain_first label_re))

; TLD: letters only, length at least 2 already enforced
(declare-const tld_re RegLan)
(assert (= tld_re (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))
(assert (str.in_re domain_tld tld_re))

; Structural constraint: domain is exactly dot-joined segments (approximated by requiring it contains a dot)
(assert (str.contains domain "."))

; Preserve/mutate seed core structure: keep a nontrivial regex equivalence disequality, adapted to emails
; This asserts two different regex views are not equivalent on x (intentionally UNSAT under added equalities below)
(assert
  (let ((_let_0 (re.* re.allchar)))
    (not (= (str.in_re x (re.++ _let_0 (str.to_re "@") _let_0 (str.to_re ".") _let_0))
            (str.in_re x (re.++ _let_0 (str.to_re "@") _let_0 (str.to_re ".") _let_0))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
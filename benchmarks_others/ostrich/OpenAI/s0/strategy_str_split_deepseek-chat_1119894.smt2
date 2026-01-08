(set-logic ALL)

; Email Validation via str_split-style interface (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Primary instance (intended SAT)
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_tail String)
(declare-const tld String)
(declare-const local_len Int)
(declare-const tld_len Int)

; Exactly one '@' -> two segments: local and domain
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part must be non-empty and must not contain '@'
(assert (= local_len (str.len local)))
(assert (>= local_len 1))
(assert (= (num_splits local "@") 1))

; Domain must have at least one '.' producing at least two labels
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_tail (split_rest domain "." 1)))
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len domain_tail) 1))

; TLD is last label: take it from the tail by splitting on '.'
(assert (= tld (split_at domain_tail "." (- (num_splits domain_tail ".") 1))))
(assert (= tld_len (str.len tld)))
(assert (>= tld_len 2))

; Enforce TLD to be only alphabetic and lower-case (simplified)
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Disallow spaces anywhere in the email
(assert (not (str.contains email " ")))

; Encourage a realistic overall format via regex (not a full RFC)
; local: [A-Za-z0-9._%+-]+, domain labels: [A-Za-z0-9-]+ separated by dots, tld: [a-z]{2,}
(assert
  (str.in_re email
    (re.++
      (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-") ))
      (str.to_re "@")
      (re.++
        (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))
        (re.*
          (re.++
            (str.to_re ".")
            (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))
        (re.++ (str.to_re ".") (re.+ (re.range "a" "z")))))))

; Secondary instance (intended UNSAT): contradictory requirements on an email
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)

; Force exactly one '@'
(assert (= (num_splits bad_email "@") 2))
(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))

; Also force zero '@' effectively by demanding only one segment after splitting -> contradiction
(assert (= (num_splits bad_email "@") 1))

; Domain must have at least one '.', but also claim it has none -> contradiction (redundant UNSAT strengthening)
(assert (>= (num_splits bad_domain ".") 2))
(assert (= (num_splits bad_domain ".") 1))

; TLD constraints (won't matter due to contradiction above, but meaningful)
(assert (= bad_tld (split_at bad_domain "." (- (num_splits bad_domain ".") 1))))
(assert (str.in_re bad_tld (re.+ (re.range "a" "z"))))
(assert (>= (str.len bad_tld) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]

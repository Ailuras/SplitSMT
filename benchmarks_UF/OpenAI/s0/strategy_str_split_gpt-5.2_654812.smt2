(set-logic ALL)

; Email Validation using split constraints with '@' and '.' delimiters

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Primary email variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_tld String)
(declare-const domain_mid String)

; Indices for split operations (natural numbers)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)

(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))

; --- SAT instance: plausible complex email ---
; exactly one '@'
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; local-part constraints: non-empty, contains allowed basic structure (letters/digits + certain punctuations)
(assert (> (str.len local) 0))
(assert (str.in_re local (re.++
  (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))
  (re.* (re.++
    (re.union (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))
  ))
)))

; domain constraints: at least one '.' thus at least 2 labels
(assert (>= (num_splits domain ".") 2))
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= domain_tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (= domain_mid (split_rest domain "." 1)))

; first label and tld must be non-empty
(assert (> (str.len domain_first_label) 0))
(assert (> (str.len domain_tld) 0))

; labels basic regex (alnum and hyphen, must start/end alnum); apply to first label and tld
(define-fun label_re () RegLan
  (re.++
    (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
    (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))
  )
)
(assert (str.in_re domain_first_label label_re))

; TLD: letters only, length >= 2
(assert (>= (str.len domain_tld) 2))
(assert (str.in_re domain_tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Overall email should not contain spaces
(assert (not (str.contains email " ")))

; A concrete satisfying example (keeps file deterministically SAT for this block)
(assert (= email "alice.smith+tag_9@sub-domain.Example.com"))

; --- UNSAT instance: contradictory constraints for a second email ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)

; enforce exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; require domain has at least one '.'
(assert (>= (num_splits domain_bad ".") 2))

; contradiction: also require domain has no '.'
(assert (= (num_splits domain_bad ".") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
; Email Validation scenario: mutated/extended from seed while preserving core regex structure
(set-logic ALL)

; --- Uninterpreted interface functions for str_split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const X String) ; seed core string
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const domain_rest String)
(declare-const local_len Int)

; --- Seed constraints retained (core structure) ---
(assert (str.in_re X (re.++ (str.to_re "<img ") (re.* (re.++ (re.union (str.to_re "src") (str.to_re "height") (str.to_re "width") (str.to_re "border")) (str.to_re "=:q:W") (re.* (str.to_re "h")))) (str.to_re "/>\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "//{#") (re.+ (re.union (str.to_re "/") (str.to_re "{") (str.to_re "}"))) (str.to_re "}") (re.opt (str.to_re ".action")) (re.opt (str.to_re "/")) (str.to_re "/miU\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "//") ((_ re.loop 42 42) (re.union (re.range "0" "9") (re.range "A" "F"))) (str.to_re "/Um\u{a}")))))

; --- Email constraints using split_at/num_splits, '@' and '.' delimiters ---
; Split email at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (split_rest email "@" 2) ""))
(assert (= (num_splits email "@") 2))

; Local part should be non-empty and not contain '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))

; Domain must contain at least one dot, and should not start/end with dot
(assert (>= (num_splits domain ".") 2))
(assert (not (= (split_at domain "." 0) "")))
(assert (not (= (split_at domain "." (- (num_splits domain ".") 1)) "")))

; Bind first label and TLD (last label)
(assert (= subdomain (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (= domain_rest (split_rest domain "." 1)))

; Basic label sizes
(assert (>= (str.len subdomain) 1))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Local length tracked via an Int variable
(assert (= local_len (str.len local)))
(assert (<= local_len 64))

; Email should not contain spaces and should not contain consecutive dots
(assert (not (str.contains email " ")))
(assert (not (str.contains email "..")))

; --- Regex-based validation (complex patterns) ---
; local: [A-Za-z0-9_+.-]+ (but constrained further by no ".." above)
(define-fun local_atom_re () RegLan
  (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".")))
(assert (str.in_re local (re.+ local_atom_re)))

; domain labels: [A-Za-z0-9-]+, TLD: [A-Za-z]{2,6}
(define-fun label_char_re () RegLan
  (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
(define-fun tld_char_re () RegLan
  (re.union (re.range "a" "z") (re.range "A" "Z")))
(assert (str.in_re subdomain (re.+ label_char_re)))
(assert (str.in_re tld (re.++ ((_ re.loop 2 6) tld_char_re) (re.* (str.to_re "")))))

; Entire email must match local@domain (domain can have multiple labels)
(assert (str.in_re email
  (re.++ (re.+ local_atom_re)
         (str.to_re "@")
         (re.+ label_char_re)
         (re.* (re.++ (str.to_re ".") (re.+ label_char_re))))))

; --- UNSAT-driving constraint (for diversity): enforce an impossible domain without any dot ---
(assert (= (num_splits domain ".") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
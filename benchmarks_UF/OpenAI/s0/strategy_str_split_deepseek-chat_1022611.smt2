(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface operations for string split

; ------------------------
; SAT instance: complex-but-valid email validation constraints
; ------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const subdomain_sat String)
(declare-const domain_first_label_sat String)
(declare-const domain_rest_after_first_sat String)
(declare-const domain_last_label_sat String)
(declare-const i_sat Int)

; Basic non-emptiness and presence constraints
(assert (> (str.len email_sat) 5))
(assert (>= (num_splits email_sat "@") 2))
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; Local-part should not contain '@' and should include at least one '.' (to vary patterns)
(assert (= (num_splits local_sat "@") 1))
(assert (>= (num_splits local_sat ".") 2))

; Domain must have at least 2 labels separated by '.' (e.g., example.com)
(assert (>= (num_splits domain_sat ".") 2))

; Extract first label, rest, and last label of the domain
(assert (= domain_first_label_sat (split_at domain_sat "." 0)))
(assert (= domain_rest_after_first_sat (split_rest domain_sat "." 1)))
(assert (= domain_last_label_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (> (str.len domain_first_label_sat) 0))
(assert (> (str.len domain_rest_after_first_sat) 0))
(assert (> (str.len domain_last_label_sat) 0))

; TLD constraints: 2..6 chars, alphabetic-only (using regex)
(assert (= tld_sat domain_last_label_sat))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 6))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Optional additional structure: require a subdomain label of at least 2 chars
; (take the first label again as a "subdomain" placeholder)
(assert (= subdomain_sat domain_first_label_sat))
(assert (>= (str.len subdomain_sat) 2))

; Use a natural index constraint to exercise the interface's index discipline
(assert (>= i_sat 0))
(assert (< i_sat (num_splits domain_sat ".")))

; Construct a witness email string to ensure SAT
(assert (= email_sat "first.last@sub.example.com"))


; ------------------------
; UNSAT instance: contradictory domain/TLD requirements
; ------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const last_label_unsat String)

(assert (= email_unsat "user@corp.internal"))
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= last_label_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (= tld_unsat last_label_unsat))

; Contradiction: force TLD to be purely digits but also to be purely lowercase letters
(assert (str.in_re tld_unsat (re.+ (re.range "0" "9"))))
(assert (str.in_re tld_unsat (re.+ (re.range "a" "z"))))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

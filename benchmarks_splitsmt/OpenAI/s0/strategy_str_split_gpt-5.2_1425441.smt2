(set-logic ALL)

; Uninterpreted interface functions for string splitting

; =====================
; SAT instance: complex but valid-like email structure constraints
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_first_sat String)
(declare-const tld_sat String)
(declare-const after_at_sat String)
(declare-const subdomain_or_rest_sat String)
(declare-const dot_piece0_sat String)
(declare-const dot_piece1_sat String)
(declare-const dot_rest_after1_sat String)
(declare-const local0_sat String)
(declare-const local1_sat String)

; Basic email shape: exactly one '@' (two segments when split)
(assert (= (str.num_splits email_sat "@") 2))
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))
(assert (= after_at_sat (str.split_rest email_sat "@" 1)))
(assert (= after_at_sat domain_sat))

; Local part constraints: non-empty, no spaces, has at least one dot segment (but not leading/trailing dot)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat " ")))
(assert (>= (str.num_splits local_sat ".") 2))
(assert (= local0_sat (str.split_at local_sat "." 0)))
(assert (= local1_sat (str.split_at local_sat "." 1)))
(assert (>= (str.len local0_sat) 1))
(assert (>= (str.len local1_sat) 1))

; Domain constraints: must contain at least one dot (at least two segments), no spaces
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (not (str.contains domain_sat " ")))

; Domain structure: first label and last label (TLD) non-empty
(assert (= domain_first_sat (str.split_at domain_sat "." 0)))
(assert (>= (str.len domain_first_sat) 1))
(assert (= tld_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 1))))
(assert (>= (str.len tld_sat) 2))

; TLD must be all lowercase letters (simple regex) and length 2..10
(assert (<= (str.len tld_sat) 10))
(assert (str.in_re tld_sat (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z")))))

; Additional domain sanity: second label exists and non-empty
(assert (= dot_piece0_sat (str.split_at domain_sat "." 0)))
(assert (= dot_piece1_sat (str.split_at domain_sat "." 1)))
(assert (>= (str.len dot_piece1_sat) 1))
(assert (= dot_rest_after1_sat (str.split_rest domain_sat "." 1)))
(assert (>= (str.len dot_rest_after1_sat) 1))

; Concretize to ensure satisfiable while still matching constraints
(assert (= email_sat "john.doe@sub.example.co"))


; =====================
; UNSAT instance: contradictory email/domain structure constraints
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const dom_first_unsat String)

; Require exactly one '@'
(assert (= (str.num_splits email_unsat "@") 2))
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))

; Require domain to have at least one dot
(assert (>= (str.num_splits domain_unsat ".") 2))
(assert (= dom_first_unsat (str.split_at domain_unsat "." 0)))
(assert (>= (str.len dom_first_unsat) 1))

; TLD extraction and constraints
(assert (= tld_unsat (str.split_at domain_unsat "." (- (str.num_splits domain_unsat ".") 1))))
(assert (>= (str.len tld_unsat) 2))

; Contradiction: TLD must be digits only AND lowercase letters only
(assert (str.in_re tld_unsat (re.+ (re.range "0" "9"))))
(assert (str.in_re tld_unsat (re.+ (re.range "a" "z"))))

; Concretize to a typical-looking email (still unsat due to regex contradiction)
(assert (= email_unsat "alice@company.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

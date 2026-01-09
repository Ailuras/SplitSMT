(set-logic ALL)

; Uninterpreted str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== SAT instance: a consistent email validation scenario ==========
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_left_sat String)
(declare-const sub0_sat String)
(declare-const sub1_sat String)

(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; local-part constraints (not empty, no spaces, contains a dot separating two parts)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat " ")))
(assert (>= (num_splits local_sat ".") 2))
(assert (>= (str.len (split_at local_sat "." 0)) 1))
(assert (>= (str.len (split_at local_sat "." 1)) 1))

; domain constraints: at least one dot, tld is last segment, no spaces
(assert (not (str.contains domain_sat " ")))
(assert (>= (num_splits domain_sat ".") 2))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 6))

; domain left side is everything before final dot
(assert (= domain_left_sat (split_rest domain_sat "." 0)))
(assert (str.contains domain_left_sat "."))

; constrain the first two subdomain labels to be non-empty
(assert (= sub0_sat (split_at domain_sat "." 0)))
(assert (= sub1_sat (split_at domain_sat "." 1)))
(assert (>= (str.len sub0_sat) 1))
(assert (>= (str.len sub1_sat) 1))

; encourage a realistic shape by forcing domain to have exactly 3 segments: a.b.tld
(assert (= (num_splits domain_sat ".") 3))

; concrete witness-like structure (still SAT because split_* are uninterpreted)
(assert (= email_sat (str.++ local_sat "@" domain_sat)))
(assert (= local_sat "john.doe"))
(assert (= domain_sat "mail.example.com"))

(check-sat)

; ========== UNSAT instance: contradictory email validation constraints ==========
(push 1)

(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; require dot in domain
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))

; contradiction: force tld length simultaneously >= 2 and = 1
(assert (>= (str.len tld_unsat) 2))
(assert (= (str.len tld_unsat) 1))

(check-sat)

(pop 1)


; [GENERATION STATUS: SUCCESS]
(check-sat)
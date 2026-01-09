(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------
; SAT instance: plausible complex email
; ----------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const label0_sat String)
(declare-const label1_sat String)
(declare-const tld_sat String)
(declare-const rest_after_at_sat String)

; Basic structure: exactly one '@' => 2 segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= rest_after_at_sat (split_rest email_sat "@" 1)))
(assert (= rest_after_at_sat domain_sat))

; Local-part constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat "..")))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Domain constraints: at least three labels a.b.c (e.g., sub.example.com)
(assert (>= (num_splits domain_sat ".") 3))
(assert (= label0_sat (split_at domain_sat "." 0)))
(assert (= label1_sat (split_at domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))

; No empty labels at the front
(assert (>= (str.len label0_sat) 1))
(assert (>= (str.len label1_sat) 1))

; TLD constraints: at least 2 characters, only letters
(assert (>= (str.len tld_sat) 2))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Domain should not contain consecutive dots and not start/end with dot
(assert (not (str.contains domain_sat "..")))
(assert (not (= (str.at domain_sat 0) ".")))
(assert (not (= (str.at domain_sat (- (str.len domain_sat) 1)) ".")))

; Entire email should not contain spaces and must contain '@'
(assert (not (str.contains email_sat " ")))
(assert (str.contains email_sat "@"))

; Witness a concrete satisfying example
(assert (= email_sat "john.doe+tag@sub.example.com"))

; ----------------------
; UNSAT instance: conflicting requirements for email structure
; ----------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

; Claim exactly one '@' but also force three segments -> contradiction
(assert (= (num_splits email_unsat "@") 2))
(assert (= (num_splits email_unsat "@") 3))

; Additional (redundant) structural constraints
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (>= (str.len local_unsat) 1))
(assert (>= (str.len domain_unsat) 1))
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (>= (str.len tld_unsat) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
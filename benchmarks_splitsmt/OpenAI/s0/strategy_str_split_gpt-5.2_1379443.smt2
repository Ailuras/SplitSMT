(set-logic ALL)

; Uninterpreted split interface

; ======================
; SAT instance: valid-ish email structure
; ======================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_tail_sat String)
(declare-const label0_sat String)
(declare-const label1_sat String)
(declare-const label2_sat String)

; Exactly one '@' => two segments
(assert (= (str.num_splits email_sat "@") 2))
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))

; Local part constraints (non-empty, no spaces, no extra '@')
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (= (str.num_splits local_sat "@") 1))

; Domain constraints (at least 2 labels separated by '.')
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= label0_sat (str.split_at domain_sat "." 0)))
(assert (= label1_sat (str.split_at domain_sat "." 1)))
(assert (= domain_tail_sat (str.split_rest domain_sat "." 1)))
(assert (= tld_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 1))))

; Domain label constraints: non-empty, no spaces
(assert (> (str.len label0_sat) 0))
(assert (> (str.len label1_sat) 0))
(assert (not (str.contains domain_sat " ")))

; TLD constraints: length 2..24 and alphabetic lowercase only
(assert (and (>= (str.len tld_sat) 2) (<= (str.len tld_sat) 24)))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Additional realistic domain shape: allow multiple labels, but require last two labels exist
(assert (>= (str.num_splits domain_sat ".") 2))

; Concrete witness to ensure satisfiable
(assert (= email_sat "john.doe+tag@sub.example.co"))

; ======================
; UNSAT instance: contradictory segment-count / structure requirements
; ======================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const label0_unsat String)
(declare-const label1_unsat String)

; Force exactly one '@'
(assert (= (str.num_splits email_unsat "@") 2))
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))

; Also (contradiction): force zero '@' splits
(assert (= (str.num_splits email_unsat "@") 1))

; Domain wants at least two '.' labels
(assert (>= (str.num_splits domain_unsat ".") 2))
(assert (= label0_unsat (str.split_at domain_unsat "." 0)))
(assert (= label1_unsat (str.split_at domain_unsat "." 1)))
(assert (> (str.len label0_unsat) 0))
(assert (> (str.len label1_unsat) 0))

; TLD wants to be purely lowercase letters
(assert (= tld_unsat (str.split_at domain_unsat "." (- (str.num_splits domain_unsat ".") 1))))
(assert (str.in_re tld_unsat (re.+ (re.range "a" "z"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

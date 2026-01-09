(set-logic ALL)

; Uninterpreted interface operations for str_split

; =====================
; Scenario: Email Validation
; We encode two instances:
;   (1) A satisfiable set of constraints for a plausible complex email
;   (2) An unsatisfiable set of constraints to demonstrate rejection
; =====================

; ----------
; SAT instance variables
; ----------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const dom_prefix_sat String)
(declare-const label0_sat String)
(declare-const label1_sat String)
(declare-const label2_sat String)
(declare-const n_at_sat Int)
(declare-const n_dot_sat Int)
(declare-const local_len_sat Int)
(declare-const tld_len_sat Int)

; Basic splitting structure around '@'
(assert (= n_at_sat (str.num_splits email_sat "@")))
(assert (= n_at_sat 2))
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))

; Local part constraints: non-empty, no '@', no spaces, includes a '+' tag
(assert (= local_len_sat (str.len local_sat)))
(assert (>= local_len_sat 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (str.contains local_sat "+"))

; Domain constraints: at least 2 labels separated by '.', no spaces, no '@'
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))
(assert (= n_dot_sat (str.num_splits domain_sat ".")))
(assert (>= n_dot_sat 2))

; Constrain to exactly 3 labels for a complex domain: sub.example.co
(assert (= n_dot_sat 3))
(assert (= label0_sat (str.split_at domain_sat "." 0)))
(assert (= label1_sat (str.split_at domain_sat "." 1)))
(assert (= label2_sat (str.split_at domain_sat "." 2)))
(assert (>= (str.len label0_sat) 1))
(assert (>= (str.len label1_sat) 1))
(assert (>= (str.len label2_sat) 2))

; Reconstruct domain via split_rest and define TLD as last label
(assert (= dom_prefix_sat (str.split_rest domain_sat "." 0)))
(assert (= dom_prefix_sat domain_sat))
(assert (= tld_sat label2_sat))
(assert (= tld_len_sat (str.len tld_sat)))
(assert (and (>= tld_len_sat 2) (<= tld_len_sat 6)))

; Character-set style constraints using regex (approximate email validation)
; local part allowed: letters/digits and ._%+-
; domain labels allowed: letters/digits and -
(assert (str.in_re local_sat (re.+ (re.union (re.range "a" "z")
                                        (re.range "A" "Z")
                                        (re.range "0" "9")
                                        (str.to_re ".")
                                        (str.to_re "_")
                                        (str.to_re "%")
                                        (str.to_re "+")
                                        (str.to_re "-")))))
(assert (str.in_re label0_sat (re.+ (re.union (re.range "a" "z")
                                             (re.range "A" "Z")
                                             (re.range "0" "9")
                                             (str.to_re "-")))))
(assert (str.in_re label1_sat (re.+ (re.union (re.range "a" "z")
                                             (re.range "A" "Z")
                                             (re.range "0" "9")
                                             (str.to_re "-")))))
(assert (str.in_re label2_sat (re.+ (re.union (re.range "a" "z")
                                             (re.range "A" "Z")))))

; Provide a concrete satisfying witness (still allows solver freedom elsewhere)
(assert (= email_sat "john.doe+tag@sub.example.co"))

; ----------
; UNSAT instance variables
; ----------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const n_at_unsat Int)
(declare-const n_dot_unsat Int)
(declare-const tld_unsat String)
(declare-const label_last_unsat String)

; Split around '@'
(assert (= n_at_unsat (str.num_splits email_unsat "@")))
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))

; Force exactly one '@'
(assert (= n_at_unsat 2))

; Force domain to have at least two labels (contains a dot)
(assert (= n_dot_unsat (str.num_splits domain_unsat ".")))
(assert (>= n_dot_unsat 2))

; But also force domain to contain no dot -> contradiction with above when domain is concrete
(assert (not (str.contains domain_unsat ".")))

; Additionally pin the email to a concrete string with a dot in the domain
(assert (= email_unsat "alice@company.com"))

; Define last label (TLD) and require impossible length constraints
(assert (= label_last_unsat (str.split_at domain_unsat "." (- n_dot_unsat 1))))
(assert (= tld_unsat label_last_unsat))
(assert (< (str.len tld_unsat) 2))
(assert (> (str.len tld_unsat) 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

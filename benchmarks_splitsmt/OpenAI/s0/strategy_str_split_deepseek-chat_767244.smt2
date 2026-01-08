(set-logic ALL)

; Uninterpreted interface for string split

; ------------ SAT instance: plausible email validation -------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const host_sat String)
(declare-const domain_label0_sat String)
(declare-const domain_label1_sat String)
(declare-const local_len_sat Int)
(declare-const tld_len_sat Int)

; Basic split around '@'
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))
(assert (= (str.num_splits email_sat "@") 2))
(assert (= (str.split_rest email_sat "@" 1) domain_sat))

; Local-part constraints: non-empty, no spaces, no consecutive dots, basic allowed chars
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))
(assert (str.in_re local_sat (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-") (str.to_re "."))) (re.* (str.to_re "")))))

; Domain constraints: must contain at least one dot, no consecutive dots, no spaces
(assert (str.contains domain_sat "."))
(assert (not (str.contains domain_sat "..")))
(assert (not (str.contains domain_sat " ")))

; Split domain by '.' with at least two labels (host + tld)
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= domain_label0_sat (str.split_at domain_sat "." 0)))
(assert (= domain_label1_sat (str.split_at domain_sat "." 1)))
(assert (= tld_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 1))))
(assert (= host_sat (str.split_rest domain_sat "." 0)))

; Domain labels should be non-empty and avoid leading/trailing hyphen for first label
(assert (> (str.len domain_label0_sat) 0))
(assert (> (str.len domain_label1_sat) 0))
(assert (not (= (str.at domain_label0_sat 0) "-")))
(assert (not (= (str.at domain_label0_sat (- (str.len domain_label0_sat) 1)) "-")))

; TLD constraints: length 2..10 and alphabetic only
(assert (= tld_len_sat (str.len tld_sat)))
(assert (and (>= tld_len_sat 2) (<= tld_len_sat 10)))
(assert (str.in_re tld_sat (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Entire email basic structure must match local@domain syntactically
(assert (= email_sat (str.++ local_sat "@" domain_sat)))

; Add a concrete satisfying example to anchor SAT
(assert (= email_sat "alice.smith_01@example-domain.com"))

; ------------ UNSAT instance: contradictory requirements -------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))
(assert (= (str.num_splits email_unsat "@") 2))
(assert (= email_unsat (str.++ local_unsat "@" domain_unsat)))

; Force a concrete email with exactly one '.' in the domain (two labels)
(assert (= email_unsat "bob@host.com"))
(assert (= domain_unsat "host.com"))
(assert (= (str.num_splits domain_unsat ".") 2))
(assert (= tld_unsat (str.split_at domain_unsat "." 1)))

; Contradiction: require at least 3 labels in the domain (impossible with above)
(assert (>= (str.num_splits domain_unsat ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

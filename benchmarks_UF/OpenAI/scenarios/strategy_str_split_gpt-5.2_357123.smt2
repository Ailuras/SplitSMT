(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation scenario using str_split interface


; -------------------------
; SAT instance: valid-ish email with structured domain
; -------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_labels_sat Int)
(declare-const tld_sat String)

(assert (= email_sat "john.doe+tag@sub.example.co"))

; Exactly one '@' => two segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; Local part constraints (simple shape properties)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))

; Domain constraints: contains dots, at least 3 labels (sub + example + tld parts)
(assert (not (str.contains domain_sat "@")))
(assert (>= (str.len domain_sat) 3))
(assert (>= (num_splits domain_sat ".") 3))
(assert (= domain_labels_sat (num_splits domain_sat ".")))

; TLD is last label, length >= 2
(assert (= tld_sat (split_at domain_sat "." (- domain_labels_sat 1))))
(assert (>= (str.len tld_sat) 2))

; No empty labels: each of first three labels has length >= 1 (sufficient for this instance)
(assert (>= (str.len (split_at domain_sat "." 0)) 1))
(assert (>= (str.len (split_at domain_sat "." 1)) 1))
(assert (>= (str.len (split_at domain_sat "." 2)) 1))

; Domain begins with first label and a dot, i.e., first label is a prefix before '.'
(assert (str.prefixof (str.++ (split_at domain_sat "." 0) ".") domain_sat))

; -------------------------
; UNSAT instance: conflicting constraints about '@' placement and segment counts
; -------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)

(assert (= email_unsat "alice@@example.com"))

; Force exactly one '@' split (but the concrete email has two '@')
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Additionally require domain to be a normal dotted domain with at least 2 labels
(assert (>= (num_splits domain_unsat ".") 2))
(assert (>= (str.len (split_at domain_unsat "." 0)) 1))
(assert (>= (str.len (split_at domain_unsat "." 1)) 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

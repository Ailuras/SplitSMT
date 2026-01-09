(set-logic ALL)

; Uninterpreted string split interface

; =====================
; SAT instance: a valid-ish complex email structure
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const host_rest_sat String)
(declare-const domain_labels_sat Int)
(declare-const tld_len_sat Int)

; Basic split around '@'
(assert (>= (str.num_splits email_sat "@") 2))
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))

; No additional '@' in domain part (exactly two segments overall)
(assert (= (str.num_splits email_sat "@") 2))

; Non-empty local and domain
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; Ensure local part does not contain '@'
(assert (not (str.contains local_sat "@")))

; Domain structure using '.' splits: at least 2 labels (e.g., example.com)
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= domain_labels_sat (str.num_splits domain_sat ".")))

; TLD is last segment and has length >= 2
(assert (= tld_sat (str.split_at domain_sat "." (- domain_labels_sat 1))))
(assert (= tld_len_sat (str.len tld_sat)))
(assert (>= tld_len_sat 2))

; The rest from the last label is exactly the TLD
(assert (= host_rest_sat (str.split_rest domain_sat "." (- domain_labels_sat 1))))
(assert (= host_rest_sat tld_sat))

; Domain should not start or end with '.' (approximate via split constraints)
(assert (> (str.len (str.split_at domain_sat "." 0)) 0))
(assert (> (str.len (str.split_at domain_sat "." (- domain_labels_sat 1))) 0))

; Concretize a witness satisfying email form
(assert (= email_sat "john.doe+tag@sub.example.co.uk"))

; =====================
; UNSAT instance: conflicting domain constraints
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const labels_unsat Int)
(declare-const tld_unsat String)

; Basic split around '@'
(assert (>= (str.num_splits email_unsat "@") 2))
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))

; Exactly one '@'
(assert (= (str.num_splits email_unsat "@") 2))

; Require at least 2 labels in domain
(assert (= labels_unsat (str.num_splits domain_unsat ".")))
(assert (>= labels_unsat 2))

; Make the email concrete
(assert (= email_unsat "alice@company.com"))

; Contradiction: force domain to have exactly 1 label (no '.')
(assert (= labels_unsat 1))

; Extra constraints (still consistent with above, but unreachable due to contradiction)
(assert (= tld_unsat (str.split_at domain_unsat "." (- labels_unsat 1))))
(assert (>= (str.len local_unsat) 1))
(assert (>= (str.len tld_unsat) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

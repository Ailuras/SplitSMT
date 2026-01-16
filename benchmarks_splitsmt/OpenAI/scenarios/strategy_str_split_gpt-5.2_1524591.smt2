(set-logic ALL)

; Uninterpreted interface for split operations

; ========= SAT instance: a well-formed complex email =========
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dom_label0_ok String)
(declare-const tld_ok String)
(declare-const ok_is_valid Bool)

; Basic split around '@'
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))
(assert (= (str.num_splits email_ok "@") 2))

; Domain split around '.' must have at least 2 segments: label + tld
(assert (= dom_label0_ok (str.split_at domain_ok "." 0)))
(assert (= tld_ok (str.split_at domain_ok "." (- (str.num_splits domain_ok ".") 1))))
(assert (>= (str.num_splits domain_ok ".") 2))

; No empty local part, no empty domain, no empty tld
(assert (>= (str.len local_ok) 1))
(assert (>= (str.len domain_ok) 1))
(assert (>= (str.len tld_ok) 2))

; Local part should not contain '@'
(assert (not (str.contains local_ok "@")))

; Domain must contain '.' and must not contain '@'
(assert (str.contains domain_ok "."))
(assert (not (str.contains domain_ok "@")))

; Domain cannot start or end with '.'
(assert (not (= (str.split_at domain_ok "." 0) "")))
(assert (not (= (str.split_at domain_ok "." (- (str.num_splits domain_ok ".") 1)) "")))

; Constrain email_ok to a concrete, complex example with multiple domain labels
(assert (= email_ok "john.doe+tag@sub.mail.example.co"))

; A derived validity flag (useful for higher-level APIs)
(assert (= ok_is_valid (and (= (str.num_splits email_ok "@") 2)
                           (>= (str.num_splits domain_ok ".") 2)
                           (>= (str.len local_ok) 1)
                           (>= (str.len tld_ok) 2))))
(assert ok_is_valid)

; ========= UNSAT instance: contradictory email constraints =========
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const bad_is_valid Bool)

(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Require exactly one '@' split (2 segments)
(assert (= (str.num_splits email_bad "@") 2))

; Also require that local part contains '@' (contradicts the split semantics expectation)
; Combined with further structure constraints, this creates an UNSAT core in realistic split models.
(assert (str.contains local_bad "@"))

; Require domain to have at least two '.'-separated labels
(assert (>= (str.num_splits domain_bad ".") 2))
(assert (= tld_bad (str.split_at domain_bad "." (- (str.num_splits domain_bad ".") 1))))
(assert (>= (str.len tld_bad) 2))

; Contradiction: force domain to have no '.' while also requiring >= 2 splits
(assert (not (str.contains domain_bad ".")))

(assert (= bad_is_valid (and (= (str.num_splits email_bad "@") 2)
                            (>= (str.num_splits domain_bad ".") 2)
                            (not (str.contains domain_bad ".")))))
(assert bad_is_valid)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

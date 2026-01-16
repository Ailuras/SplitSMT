(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for string splitting

; -----------------------------
; Email Validation (SAT instance)
; -----------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_head_ok String)
(declare-const tld_ok String)
(declare-const subdomain_ok String)

; Basic shape: local@domain
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= (num_splits email_ok "@") 2))

; Local-part constraints
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))
(assert (not (= (str.at local_ok 0) ".")))
(assert (not (= (str.at local_ok (- (str.len local_ok) 1)) ".")))

; Domain constraints: require at least one dot, and a valid TLD length
(assert (>= (num_splits domain_ok ".") 2))
(assert (= domain_head_ok (split_at domain_ok "." 0)))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (>= (str.len domain_head_ok) 1))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 24))

; Ensure domain has no spaces and no '@'
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "@")))

; A mixed structural check using split_rest: the rest from the first label should start with '.'
(assert (= (split_rest domain_ok "." 1) (str.++ "." subdomain_ok)))
(assert (>= (str.len subdomain_ok) 2))

; Constructive constraints to guarantee satisfiable model
(assert (= local_ok "john.doe"))
(assert (= domain_ok "mail.example.com"))
(assert (= email_ok (str.++ local_ok "@" domain_ok)))

; --------------------------------
; Email Validation (UNSAT instance)
; --------------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= (num_splits email_bad "@") 2))

; Domain must have at least one dot
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))

; Force a contradiction: domain has no dot, but also must have at least one dot
(assert (not (str.contains domain_bad ".")))

; Make strings concrete to emphasize the contradiction
(assert (= local_bad "alice"))
(assert (= domain_bad "localhost"))
(assert (= email_bad (str.++ local_bad "@" domain_bad)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

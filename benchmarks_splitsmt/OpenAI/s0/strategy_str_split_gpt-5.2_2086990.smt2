(set-logic ALL)

; Uninterpreted interface functions for string splitting

; Email inputs
(declare-const email_sat String)
(declare-const email_unsat String)

; Common derived parts for SAT email
(declare-const sat_local String)
(declare-const sat_domain String)
(declare-const sat_first_label String)
(declare-const sat_tld String)
(declare-const sat_domain_rest String)

; Common derived parts for UNSAT email
(declare-const unsat_local String)
(declare-const unsat_domain String)
(declare-const unsat_first_label String)
(declare-const unsat_tld String)

; -------------------------
; SAT instance: should be satisfiable
; Enforce shape: local@label.tld  (at least 2 labels in domain)
; -------------------------
(assert (= email_sat "alice.smith+tag@example.co"))

; Split by '@' must give exactly 2 parts
(assert (= (str.num_splits email_sat "@") 2))
(assert (= sat_local (str.split_at email_sat "@" 0)))
(assert (= sat_domain (str.split_at email_sat "@" 1)))
(assert (= (str.split_rest email_sat "@" 1) sat_domain))

; Local-part sanity: non-empty, no '@', does not start/end with '.'
(assert (> (str.len sat_local) 0))
(assert (not (str.contains sat_local "@")))
(assert (not (= (str.at sat_local 0) ".")))
(assert (not (= (str.at sat_local (- (str.len sat_local) 1)) ".")))

; Domain sanity: contains at least one '.', no '@', non-empty
(assert (> (str.len sat_domain) 0))
(assert (not (str.contains sat_domain "@")))
(assert (>= (str.num_splits sat_domain ".") 2))

; Extract first label and last label (TLD) using split operations
(assert (= sat_first_label (str.split_at sat_domain "." 0)))
(assert (= sat_domain_rest (str.split_rest sat_domain "." 1)))

; Constrain TLD to be the last segment by making domain_rest exactly "co"
; (This enforces exactly two labels: example.co)
(assert (= sat_domain_rest "co"))
(assert (= sat_tld (str.split_at sat_domain "." 1)))

; Label constraints: non-empty labels, no empty segments around '.'
(assert (> (str.len sat_first_label) 0))
(assert (> (str.len sat_tld) 0))

; TLD constraints: length at least 2
(assert (>= (str.len sat_tld) 2))

; -------------------------
; UNSAT instance: should be unsatisfiable
; Intend to force both "exactly one '@'" and also "no '@'", conflicting
; Additionally enforce domain has at least 2 '.' labels, while fixing to a single-label domain
; -------------------------
(assert (= email_unsat "bob@localhost"))

; Split by '@' must give exactly 2 parts
(assert (= (str.num_splits email_unsat "@") 2))
(assert (= unsat_local (str.split_at email_unsat "@" 0)))
(assert (= unsat_domain (str.split_at email_unsat "@" 1)))

; Contradiction: email must not contain '@'
(assert (not (str.contains email_unsat "@")))

; Domain structure requirements: must have at least two labels (contain '.')
(assert (>= (str.num_splits unsat_domain ".") 2))
(assert (= unsat_first_label (str.split_at unsat_domain "." 0)))
(assert (= unsat_tld (str.split_at unsat_domain "." 1)))

; Fix domain to single-label "localhost" (contradicts the '.' split requirement)
(assert (= unsat_domain "localhost"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

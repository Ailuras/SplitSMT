(set-logic ALL)

; Uninterpreted split interface

; Primary email candidate (intended SAT)
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_tld String)
(declare-const domain_rest_from1 String)

; Auxiliary email candidate (intended UNSAT)
(declare-const email_bad String)
(declare-const bad_local String)
(declare-const bad_domain String)

; -------------------------------
; SAT instance: enforce a reasonably complex valid email structure
; Must have exactly one '@' => exactly 2 segments when split by '@'
(assert (= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Basic non-emptiness and length bounds
(assert (>= (str.len local) 1))
(assert (<= (str.len local) 64))
(assert (>= (str.len domain) 3))
(assert (<= (str.len domain) 255))

; Disallow spaces in local/domain (simple sanity)
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))

; Local part should not contain '@'
(assert (not (str.contains local "@")))

; Domain must contain at least one '.' and have at least 2 labels
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_first_label (str.split_at domain "." 0)))
(assert (= domain_rest_from1 (str.split_rest domain "." 1)))

; The last label (TLD) must have length >= 2
(assert (= domain_tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (>= (str.len domain_tld) 2))

; Domain first label and TLD should be non-empty
(assert (>= (str.len domain_first_label) 1))
(assert (>= (str.len domain_tld) 1))

; Domain should not start or end with '.'
(assert (not (= domain_first_label "")))
(assert (not (= domain_tld "")))

; Enforce that domain has no empty labels anywhere by requiring no ".."
(assert (not (str.contains domain "..")))

; Add a structured constraint: domain_rest_from1 must contain at least one '.' iff domain has >=3 labels
(assert (= (>= (str.num_splits domain ".") 3) (str.contains domain_rest_from1 ".")))

; Make the instance more concrete but still satisfiable
(assert (str.contains local "."))
(assert (not (str.contains local "..")))
(assert (str.contains domain "example"))
(assert (str.contains domain_tld "com"))

; Ensure overall email matches the split recomposition expectation (sanity)
(assert (= email (str.++ local "@" domain)))

; -------------------------------
; UNSAT instance: contradictory email structure requirements
; Force exactly one '@' split but also force local to contain '@'
(assert (= (str.num_splits email_bad "@") 2))
(assert (= bad_local (str.split_at email_bad "@" 0)))
(assert (= bad_domain (str.split_at email_bad "@" 1)))
(assert (>= (str.len bad_local) 1))
(assert (>= (str.len bad_domain) 1))
(assert (not (str.contains bad_local "@")))
(assert (str.contains bad_local "@"))

; Also add a domain contradiction: require at least 2 labels but forbid '.' entirely
(assert (>= (str.num_splits bad_domain ".") 2))
(assert (not (str.contains bad_domain ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

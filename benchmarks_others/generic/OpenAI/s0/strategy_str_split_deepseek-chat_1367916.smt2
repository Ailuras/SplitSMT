(set-logic ALL)

; Uninterpreted string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: plausible complex email validation
; -------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const second_level_sat String)
(declare-const subdomain_sat String)
(declare-const domain_rest_sat String)
(declare-const local_plus_parts_sat Int)
(declare-const local_dot_parts_sat Int)
(declare-const domain_dot_parts_sat Int)

; Split at '@' into local and domain
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Local part constraints: length bounds and no embedded '@'
(assert (>= (str.len local_sat) 1))
(assert (<= (str.len local_sat) 64))
(assert (not (str.contains local_sat "@")))

; Allow complex local: require at least one '.' or '+' segmenting (via split counts)
(assert (= local_plus_parts_sat (num_splits local_sat "+")))
(assert (= local_dot_parts_sat (num_splits local_sat ".")))
(assert (or (>= local_plus_parts_sat 2) (>= local_dot_parts_sat 2)))

; Domain constraints: overall length and at least one '.'
(assert (>= (str.len domain_sat) 3))
(assert (<= (str.len domain_sat) 255))
(assert (= domain_dot_parts_sat (num_splits domain_sat ".")))
(assert (>= domain_dot_parts_sat 2))

; Extract domain labels: subdomain, second-level, and TLD
(assert (= subdomain_sat (split_at domain_sat "." 0)))
(assert (= domain_rest_sat (split_rest domain_sat "." 1)))
(assert (= second_level_sat (split_at domain_sat "." (- domain_dot_parts_sat 2))))
(assert (= tld_sat (split_at domain_sat "." (- domain_dot_parts_sat 1))))

; Index sanity (natural indices)
(assert (>= (- domain_dot_parts_sat 2) 0))
(assert (>= (- domain_dot_parts_sat 1) 0))

; Label non-emptiness
(assert (>= (str.len subdomain_sat) 1))
(assert (>= (str.len second_level_sat) 1))
(assert (>= (str.len tld_sat) 2))

; Simple structural restrictions: no empty labels and no '@' in domain
(assert (not (str.contains domain_sat "@")))

; Require alphabetic TLD: [a-zA-Z]{2,6}
(assert (str.in_re tld_sat (re.++ (re.union (re.range "a" "z") (re.range "A" "Z"))
                                 (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))))))
(assert (<= (str.len tld_sat) 6))

; Disallow leading/trailing dot in domain by requiring first and last labels non-empty
(assert (>= (str.len (split_at domain_sat "." 0)) 1))
(assert (>= (str.len (split_at domain_sat "." (- domain_dot_parts_sat 1))) 1))

; Ensure email has no spaces
(assert (not (str.contains email_sat " ")))

(check-sat)

; -------------------------
; UNSAT instance: contradictory email constraints
; -------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const domain_dot_parts_unsat Int)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Domain must have at least one '.'
(assert (= domain_dot_parts_unsat (num_splits domain_unsat ".")))
(assert (>= domain_dot_parts_unsat 2))
(assert (= tld_unsat (split_at domain_unsat "." (- domain_dot_parts_unsat 1))))
(assert (>= (- domain_dot_parts_unsat 1) 0))

; Contradiction: force TLD to be length >= 2, but also exactly "c" (length 1)
(assert (>= (str.len tld_unsat) 2))
(assert (= tld_unsat "c"))

(check-sat)



; [GENERATION STATUS: SUCCESS]

(set-logic ALL)

; Uninterpreted interface: str_split

; ------------------------------
; SAT instance: complex but consistent email validation constraints
; ------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_main_sat String)
(declare-const tld_sat String)
(declare-const sub1_sat String)
(declare-const sub2_sat String)
(declare-const tld2_sat String)
(declare-const recon_domain_sat String)
(declare-const recon_email_sat String)
(declare-const plus_tag_sat String)
(declare-const plus_left_sat String)
(declare-const plus_right_sat String)
(declare-const start_local_char_sat String)

; Split at '@' into local and domain, enforce exactly one '@' (2 segments)
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))
(assert (= (str.num_splits email_sat "@") 2))

; Basic non-emptiness and structure
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains domain_sat " ")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Local part: allow optional '+' tag (must not be empty on either side if '+' appears)
(assert (>= (str.num_splits local_sat "+") 1))
(assert (<= (str.num_splits local_sat "+") 2))
(assert (= plus_left_sat (str.split_at local_sat "+" 0)))
(assert (= plus_right_sat (str.split_at local_sat "+" 1)))
(assert (=> (= (str.num_splits local_sat "+") 2)
            (and (> (str.len plus_left_sat) 0)
                 (> (str.len plus_right_sat) 0))))
(assert (=> (= (str.num_splits local_sat "+") 2)
            (= plus_tag_sat plus_right_sat)))
(assert (=> (= (str.num_splits local_sat "+") 1)
            (= plus_tag_sat "")))

; Local part should not start with '.' and must not contain ".."
(assert (= start_local_char_sat (str.at local_sat 0)))
(assert (not (= start_local_char_sat ".")))
(assert (not (str.contains local_sat "..")))

; Domain structure: must have at least one dot, i.e., >=2 segments when split by '.'
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= domain_main_sat (str.split_at domain_sat "." 0)))
(assert (= tld_sat (str.split_at domain_sat "." 1)))
(assert (> (str.len domain_main_sat) 0))
(assert (> (str.len tld_sat) 0))

; Also require at least 3 dot-separated segments (subdomain + domain + tld)
(assert (>= (str.num_splits domain_sat ".") 3))
(assert (= sub1_sat (str.split_at domain_sat "." 0)))
(assert (= sub2_sat (str.split_at domain_sat "." 1)))
(assert (= tld2_sat (str.split_at domain_sat "." 2)))
(assert (> (str.len sub1_sat) 0))
(assert (> (str.len sub2_sat) 0))
(assert (> (str.len tld2_sat) 0))

; Domain parts must not be empty (implies no leading/trailing dot and no ".." in domain)
(assert (not (str.contains domain_sat "..")))
(assert (not (str.contains domain_sat ".-")))
(assert (not (str.contains domain_sat "-.")))

; Reconstruct domain/email using split_rest and concatenation to tie components together
(assert (= recon_domain_sat (str.++ (str.split_at domain_sat "." 0) "." (str.split_rest domain_sat "." 1))))
(assert (= recon_domain_sat domain_sat))
(assert (= recon_email_sat (str.++ local_sat "@" domain_sat)))
(assert (= recon_email_sat email_sat))

; Provide a concrete satisfying witness
(assert (= email_sat "john.doe+tag@sub.example.com"))

; ------------------------------
; UNSAT instance: conflicting requirements about dots in the domain
; ------------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const domain_first_unsat String)

(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))
(assert (= (str.num_splits email_unsat "@") 2))
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))

; Require at least one '.' in domain
(assert (>= (str.num_splits domain_unsat ".") 2))
(assert (= domain_first_unsat (str.split_at domain_unsat "." 0)))
(assert (> (str.len domain_first_unsat) 0))

; Contradiction: also require that domain contains no '.'
(assert (not (str.contains domain_unsat ".")))

; Tie to a plausible email shape (still contradictory due to dot constraints)
(assert (= email_unsat "alice@domain"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

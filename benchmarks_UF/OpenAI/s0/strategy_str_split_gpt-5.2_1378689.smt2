(set-logic ALL)

; Email Validation via str_split: mix of SAT and UNSAT constraint groups

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Shared helper uninterpreted predicates (non-primitive checks) ---
(declare-fun is_nonempty (String) Bool)
(declare-fun all_lower_alnum_underscore (String) Bool)
(declare-fun all_lower_alnum_hyphen (String) Bool)
(declare-fun all_lower_alpha (String) Bool)

; --- SAT instance variables ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const sld_sat String)
(declare-const sub_sat String)
(declare-const recon_domain_sat String)
(declare-const recon_email_sat String)

; Basic split around '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (<= (num_splits email_sat "@") 2))

; Ensure local and domain are nonempty and do not contain '@'
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Domain split around '.' : require at least one dot and at least 2 segments
(assert (>= (num_splits domain_sat ".") 2))

; Enforce a plausible structure: [subdomain '.'] sld '.' tld
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (= sld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 2))))
(assert (= sub_sat (split_rest domain_sat "." 0)))

; Nonempty SLD and TLD
(assert (> (str.len sld_sat) 0))
(assert (> (str.len tld_sat) 0))

; Simple content policies (uninterpreted, but constrained to be true)
(assert (is_nonempty local_sat))
(assert (is_nonempty domain_sat))
(assert (all_lower_alnum_underscore local_sat))
(assert (all_lower_alnum_hyphen sld_sat))
(assert (all_lower_alpha tld_sat))

; Length constraints: local part 1..64, whole email <= 254, TLD 2..24
(assert (<= (str.len local_sat) 64))
(assert (<= (str.len email_sat) 254))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))

; Reconstruct to connect the split functions with concrete string structure
(assert (= recon_domain_sat (str.++ sld_sat "." tld_sat)))
(assert (= recon_email_sat (str.++ local_sat "@" recon_domain_sat)))
(assert (= email_sat recon_email_sat))

; Exclude trivial bad patterns in SAT instance
(assert (not (str.contains email_sat "..")))
(assert (not (str.contains email_sat "@.")))
(assert (not (str.contains email_sat ".@")))

; Provide a concrete satisfying email (keeps constraints grounded)
(assert (= local_sat "user_name1"))
(assert (= sld_sat "example-domain"))
(assert (= tld_sat "com"))


; --- UNSAT instance variables (contradictory constraints) ---
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const part0_unsat String)
(declare-const part1_unsat String)
(declare-const recon_email_unsat String)

; Force exactly one '@'
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Contradiction: require local contains '@' but also no extra '@' possible in local
(assert (not (str.contains local_unsat "@")))
(assert (str.contains local_unsat "@"))

; Additional domain structure constraints (won't matter due to contradiction)
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= part0_unsat (split_at domain_unsat "." 0)))
(assert (= part1_unsat (split_at domain_unsat "." 1)))
(assert (> (str.len part0_unsat) 0))
(assert (> (str.len part1_unsat) 0))

; Reconstruct email shape
(assert (= recon_email_unsat (str.++ local_unsat "@" domain_unsat)))
(assert (= email_unsat recon_email_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
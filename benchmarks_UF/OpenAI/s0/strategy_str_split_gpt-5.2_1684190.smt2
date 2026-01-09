(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- SAT instance: plausible complex email ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domlabel0_sat String)
(declare-const domlabel1_sat String)
(declare-const tld_sat String)
(declare-const domain_tail_sat String)
(declare-const local_first_sat String)
(declare-const local_rest_sat String)

; Split at '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= domain_sat (split_rest email_sat "@" 1)))
(assert (= 2 (num_splits email_sat "@")))

; Non-empty local and domain
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; Local part: contains at least one '.' and segments are non-empty
(assert (>= (num_splits local_sat ".") 2))
(assert (= local_first_sat (split_at local_sat "." 0)))
(assert (= local_rest_sat (split_rest local_sat "." 1)))
(assert (> (str.len local_first_sat) 0))
(assert (> (str.len (split_at local_sat "." 1)) 0))

; No spaces in full email
(assert (not (str.contains email_sat " ")))

; Domain structure: at least three labels separated by '.' (e.g., sub.example.com)
(assert (>= (num_splits domain_sat ".") 3))
(assert (= domlabel0_sat (split_at domain_sat "." 0)))
(assert (= domlabel1_sat (split_at domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (= domain_tail_sat (split_rest domain_sat "." 1)))

; Labels must be non-empty and cannot contain '@'
(assert (> (str.len domlabel0_sat) 0))
(assert (> (str.len domlabel1_sat) 0))
(assert (> (str.len tld_sat) 0))
(assert (not (str.contains domlabel0_sat "@")))
(assert (not (str.contains domlabel1_sat "@")))
(assert (not (str.contains tld_sat "@")))

; Domain must not start or end with '.' (approximated via first/last labels non-empty)
(assert (not (= domlabel0_sat "")))
(assert (not (= tld_sat "")))

; TLD constraints: length at least 2 and only letters (approx via regex)
(assert (>= (str.len tld_sat) 2))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Example concrete email to ensure satisfiable
(assert (= email_sat "john.doe@sub.example.com"))

(check-sat)

; --- UNSAT instance: contradictory constraints for email splitting/domain ---
(push)
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const first_label_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Claim exactly one '@'
(assert (= 2 (num_splits email_unsat "@")))

; But also claim there are no '@' splits (contradiction)
(assert (= 1 (num_splits email_unsat "@")))

; Additional domain requirements (never reached, but meaningful)
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= first_label_unsat (split_at domain_unsat "." 0)))
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (> (str.len first_label_unsat) 0))
(assert (> (str.len tld_unsat) 0))
(assert (>= (str.len tld_unsat) 2))

(check-sat)
(pop)



; [GENERATION STATUS: SUCCESS]
(check-sat)
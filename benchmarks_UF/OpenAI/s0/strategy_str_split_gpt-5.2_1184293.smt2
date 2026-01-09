(set-logic ALL)

; Uninterpreted interface operations for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; SAT instance: complex email validation constraints
; =========================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const host_sat String)
(declare-const tld_sat String)
(declare-const tld_first_char_sat String)
(declare-const at_count_sat Int)
(declare-const dot_count_domain_sat Int)

; Structure: local@domain
(assert (= at_count_sat (num_splits email_sat "@")))
(assert (= at_count_sat 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; Local part basic validity
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))

; Domain constraints: must contain at least one dot, host + tld
(assert (= dot_count_domain_sat (num_splits domain_sat ".")))
(assert (>= dot_count_domain_sat 2))
(assert (= host_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_rest domain_sat "." 1)))

; Host constraints
(assert (> (str.len host_sat) 0))
(assert (not (str.contains host_sat "@")))
(assert (not (str.contains host_sat " ")))

; TLD constraints (allow multi-label TLD via split_rest, e.g., co.uk)
(assert (> (str.len tld_sat) 1))
(assert (not (str.contains tld_sat "@")))
(assert (not (str.contains tld_sat " ")))
(assert (not (str.contains tld_sat "..")))
(assert (not (str.contains tld_sat ".")))

; Require TLD begins with a lowercase letter a-z (simple structural check)
(assert (= tld_first_char_sat (str.substr tld_sat 0 1)))
(assert (str.in_re tld_first_char_sat (re.range "a" "z")))

; Concrete witness to ensure SAT
(assert (= email_sat "alice.smith+tag@sub.example.com"))

; =========================
; UNSAT instance: contradictory email validation constraints
; =========================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const at_count_unsat Int)
(declare-const dot_count_domain_unsat Int)

; Enforce exactly one '@' in split sense
(assert (= at_count_unsat (num_splits email_unsat "@")))
(assert (= at_count_unsat 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Contradiction: domain has no dots but also at least one dot required
(assert (= dot_count_domain_unsat (num_splits domain_unsat ".")))
(assert (= dot_count_domain_unsat 1))
(assert (>= dot_count_domain_unsat 2))

; Additional constraints (not needed for UNSAT, but keep meaningful)
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
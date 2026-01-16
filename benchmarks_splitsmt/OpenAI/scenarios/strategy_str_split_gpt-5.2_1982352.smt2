(set-logic ALL)

; Email Validation with split-based reasoning

; --- str_split interface (uninterpreted) ---

; --- Shared helper constants ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; ------------------------------------------------------------
; SAT instance: a plausible, structured email
; local@sub.domain.tld with additional constraints
; ------------------------------------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const dom_last_sat String)
(declare-const dom_before_last_sat String)

; Exactly one '@' => 2 segments when splitting by '@'
(assert (= (str.num_splits email_sat at_delim) 2))
(assert (= local_sat (str.split_at email_sat at_delim 0)))
(assert (= domain_sat (str.split_at email_sat at_delim 1)))

; Local-part constraints (simple structural checks)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat at_delim)))
(assert (not (str.contains local_sat " ")))
(assert (not (= (str.at local_sat 0) ".")))

; Domain constraints: at least sub.domain.tld => >= 3 segments by '.'
(assert (>= (str.num_splits domain_sat dot_delim) 3))

; Extract last two segments via split_rest nesting
(assert (= dom_last_sat (str.split_at domain_sat dot_delim (- (str.num_splits domain_sat dot_delim) 1))))
(assert (= dom_before_last_sat (str.split_at domain_sat dot_delim (- (str.num_splits domain_sat dot_delim) 2))))
(assert (= tld_sat dom_last_sat))

; TLD constraints: length >= 2 and only lowercase letters a-z
(assert (>= (str.len tld_sat) 2))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Second-level domain constraints: non-empty and lowercase letters/digits/hyphen (no empty segment)
(assert (>= (str.len dom_before_last_sat) 1))
(assert (str.in_re dom_before_last_sat (re.+ (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

; Domain must not contain '@' or spaces
(assert (not (str.contains domain_sat at_delim)))
(assert (not (str.contains domain_sat " ")))

; Enforce a concrete satisfying example (still consistent with above constraints)
(assert (= email_sat "alice-1@sub.example.co"))

; ------------------------------------------------------------
; UNSAT instance: contradictory delimiter/segment constraints
; ------------------------------------------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

; Claim exactly one '@'
(assert (= (str.num_splits email_unsat at_delim) 2))
(assert (= local_unsat (str.split_at email_unsat at_delim 0)))
(assert (= domain_unsat (str.split_at email_unsat at_delim 1)))

; Also (incorrectly) require that the whole email contains no '@' at all => contradiction with num_splits = 2
(assert (not (str.contains email_unsat at_delim)))

; Additional domain structure requirements (won't matter due to contradiction above)
(assert (>= (str.num_splits domain_unsat dot_delim) 2))
(assert (= tld_unsat (str.split_at domain_unsat dot_delim (- (str.num_splits domain_unsat dot_delim) 1))))
(assert (>= (str.len tld_unsat) 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

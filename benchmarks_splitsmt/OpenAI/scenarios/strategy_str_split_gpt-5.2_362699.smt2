(set-logic ALL)

; Email Validation via str_split using '@' and '.' delimiters

; Uninterpreted split interface

; Shared helper strings
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; =========================
; SAT instance: well-formed email
; =========================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_label0_ok String)
(declare-const domain_label1_ok String)

; Basic split around '@'
(assert (= local_ok (str.split_at email_ok at_delim 0)))
(assert (= domain_ok (str.split_at email_ok at_delim 1)))
(assert (= (str.num_splits email_ok at_delim) 2))

; Local-part constraints (non-empty, no spaces, no '@', no consecutive dots)
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok "..")))
(assert (not (str.contains local_ok ".@")))
(assert (not (str.contains local_ok "@.")))

; Domain constraints (must contain at least one '.', no spaces)
(assert (not (str.contains domain_ok " ")))
(assert (>= (str.num_splits domain_ok dot_delim) 2))
(assert (= domain_label0_ok (str.split_at domain_ok dot_delim 0)))
(assert (= domain_label1_ok (str.split_at domain_ok dot_delim 1)))
(assert (> (str.len domain_label0_ok) 0))
(assert (> (str.len domain_label1_ok) 0))

; TLD is last segment: use split_rest to obtain suffix from index 1, then take its last label via another split
(assert (= tld_ok (str.split_at (str.split_rest domain_ok dot_delim 1) dot_delim (- (str.num_splits (str.split_rest domain_ok dot_delim 1) dot_delim) 1))))

; TLD structure constraints: length 2..24, alphabetic-only (lowercase for simplicity)
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 24))
(assert (str.in_re tld_ok (re.+ (re.range "a" "z"))))

; Domain label constraints: simple DNS-like restrictions (no empty label, no leading/trailing '-')
(assert (not (= domain_label0_ok "-")))
(assert (not (= domain_label1_ok "-")))
(assert (not (= (str.at domain_label0_ok 0) "-")))
(assert (not (= (str.at domain_label1_ok 0) "-")))
(assert (not (= (str.at domain_label0_ok (- (str.len domain_label0_ok) 1)) "-")))
(assert (not (= (str.at domain_label1_ok (- (str.len domain_label1_ok) 1)) "-")))

; Witness email for SAT
(assert (= email_ok "alice.smith@sub.example"))

; =========================
; UNSAT instance: contradictory email requirements
; =========================
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Force exactly one '@'
(assert (= (str.num_splits email_bad at_delim) 2))
(assert (= local_bad (str.split_at email_bad at_delim 0)))
(assert (= domain_bad (str.split_at email_bad at_delim 1)))

; Require domain to have at least one '.', and also require it to have no '.' (contradiction)
(assert (>= (str.num_splits domain_bad dot_delim) 2))
(assert (not (str.contains domain_bad ".")))

; Additional constraints that would otherwise look reasonable
(assert (> (str.len local_bad) 0))
(assert (not (str.contains local_bad " ")))
(assert (not (str.contains local_bad "@")))

; Define tld_bad from domain_bad if it were splittable (still consistent with the interface, but overall UNSAT due to contradiction above)
(assert (= tld_bad (str.split_at (str.split_rest domain_bad dot_delim 1) dot_delim (- (str.num_splits (str.split_rest domain_bad dot_delim 1) dot_delim) 1))))
(assert (>= (str.len tld_bad) 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

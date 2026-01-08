(set-logic ALL)

; Email Validation via str_split abstraction

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Shared helpers / constants ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; =====================
; SAT instance: plausible valid email
; =====================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const host_ok String)
(declare-const tld_ok String)
(declare-const tld_label_ok String)

; Basic split at '@'
(assert (= local_ok (split_at email_ok at_delim 0)))
(assert (= domain_ok (split_rest email_ok at_delim 1)))
(assert (= (num_splits email_ok at_delim) 2))

; Non-empty local/domain
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))

; Local constraints: no '@', no spaces, at least 3 chars, simple regex
(assert (not (str.contains local_ok at_delim)))
(assert (not (str.contains local_ok " ")))
(assert (>= (str.len local_ok) 3))
(assert (str.in_re local_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))

; Domain constraints: must have at least one '.', no spaces
(assert (not (str.contains domain_ok " ")))
(assert (>= (num_splits domain_ok dot_delim) 2))

; Split domain into host and tld (rest)
(assert (= host_ok (split_at domain_ok dot_delim 0)))
(assert (= tld_ok (split_rest domain_ok dot_delim 1)))
(assert (> (str.len host_ok) 0))
(assert (> (str.len tld_ok) 0))

; Host label constraints: alnum/hyphen only, cannot start/end with '-'
(assert (str.in_re host_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (= (str.at host_ok 0) "-")))
(assert (not (= (str.at host_ok (- (str.len host_ok) 1)) "-")))

; TLD constraints: one or more labels separated by '.', final label length >= 2
(assert (>= (num_splits tld_ok dot_delim) 1))
(assert (= tld_label_ok (split_at tld_ok dot_delim (- (num_splits tld_ok dot_delim) 1))))
(assert (>= (str.len tld_label_ok) 2))
(assert (str.in_re tld_label_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Concrete witness to ensure SAT
(assert (= email_ok "alice.smith+tag@example.co.uk"))

; =====================
; UNSAT instance: contradictory email requirements
; =====================
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const host_bad String)
(declare-const tld_bad String)

; Requires exactly one '@'
(assert (= local_bad (split_at email_bad at_delim 0)))
(assert (= domain_bad (split_rest email_bad at_delim 1)))
(assert (= (num_splits email_bad at_delim) 2))
(assert (> (str.len local_bad) 0))
(assert (> (str.len domain_bad) 0))

; Domain split and structure constraints
(assert (= host_bad (split_at domain_bad dot_delim 0)))
(assert (= tld_bad (split_rest domain_bad dot_delim 1)))
(assert (>= (num_splits domain_bad dot_delim) 2))
(assert (> (str.len host_bad) 0))
(assert (> (str.len tld_bad) 0))

; Contradiction 1: local part must both contain '@' and not contain '@'
(assert (str.contains local_bad at_delim))
(assert (not (str.contains local_bad at_delim)))

; Contradiction 2: domain must have at least one dot but also forced to have none
(assert (>= (num_splits domain_bad dot_delim) 2))
(assert (= (num_splits domain_bad dot_delim) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]

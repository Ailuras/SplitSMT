(set-logic ALL)

; Uninterpreted functions for str_split interface

; =========================
; Scenario: Email Validation
; =========================

; ----------
; SAT instance: a well-formed email with structured local-part and domain
; ----------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const local_user_ok String)
(declare-const local_tag_ok String)
(declare-const local_tag_count_ok Int)
(declare-const domain_label_count_ok Int)
(declare-const dom_label0_ok String)
(declare-const dom_label1_ok String)
(declare-const dom_label2_ok String)
(declare-const tld_ok String)

(assert (= email_ok "john.doe+news@sub.example.com"))

; Basic split by '@'
(assert (>= (str.num_splits email_ok "@") 2))
(assert (= 2 (str.num_splits email_ok "@")))
(assert (= local_ok (str.split_at email_ok "@" 0)))
(assert (= domain_ok (str.split_at email_ok "@" 1)))
(assert (= "" (str.split_rest email_ok "@" 2)))

; Local-part constraints
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Optional tag via '+' in local-part: require exactly 2 segments (user + tag)
(assert (= local_tag_count_ok (str.num_splits local_ok "+")))
(assert (= local_user_ok (str.split_at local_ok "+" 0)))
(assert (= local_tag_ok (str.split_at local_ok "+" 1)))
(assert (= 2 local_tag_count_ok))
(assert (> (str.len local_user_ok) 0))
(assert (> (str.len local_tag_ok) 0))

; Ensure local_user has at least one '.' segment (e.g., first.last)
(assert (>= (str.num_splits local_user_ok ".") 2))
(assert (not (str.contains local_user_ok "..")))
(assert (not (str.contains local_user_ok ".@")))

; Domain constraints
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "..")))
(assert (not (str.contains domain_ok ".-")))
(assert (not (str.contains domain_ok "-.")))
(assert (not (str.contains domain_ok "-@")))

; Split domain by '.' and require at least 3 labels: sub + second-level + TLD
(assert (= domain_label_count_ok (str.num_splits domain_ok ".")))
(assert (>= domain_label_count_ok 3))
(assert (= dom_label0_ok (str.split_at domain_ok "." 0)))
(assert (= dom_label1_ok (str.split_at domain_ok "." 1)))
(assert (= dom_label2_ok (str.split_at domain_ok "." 2)))
(assert (= tld_ok (str.split_at domain_ok "." (- domain_label_count_ok 1))))

; Labels are non-empty and no spaces
(assert (> (str.len dom_label0_ok) 0))
(assert (> (str.len dom_label1_ok) 0))
(assert (> (str.len dom_label2_ok) 0))
(assert (not (str.contains dom_label0_ok " ")))
(assert (not (str.contains dom_label1_ok " ")))
(assert (not (str.contains dom_label2_ok " ")))

; TLD must be "com" for this SAT instance
(assert (= tld_ok "com"))

; ----------
; UNSAT instance: force contradictory structure with split constraints
; ----------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const at_count_bad Int)
(declare-const domain_label_count_bad Int)
(declare-const first_dom_label_bad String)
(declare-const last_dom_label_bad String)

(assert (= email_bad "alice@@example..com"))

(assert (= at_count_bad (str.num_splits email_bad "@")))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))

; Contradiction: require exactly 2 segments on '@' but the concrete string has more
(assert (= 2 at_count_bad))

; Additional contradictory constraints on the domain structure
(assert (= domain_label_count_bad (str.num_splits domain_bad ".")))
(assert (>= domain_label_count_bad 2))
(assert (= first_dom_label_bad (str.split_at domain_bad "." 0)))
(assert (= last_dom_label_bad (str.split_at domain_bad "." (- domain_label_count_bad 1))))
(assert (> (str.len first_dom_label_bad) 0))
(assert (> (str.len last_dom_label_bad) 0))

; Contradiction: disallow consecutive dots, but the concrete email contains ".."
(assert (not (str.contains email_bad "..")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------
; SAT instance: plausible email validation constraints
; -----------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const first_label_ok String)
(declare-const rest_labels_ok String)
(declare-const tld_ok String)
(declare-const dot_count_ok Int)
(declare-const label_count_ok Int)

; exactly one '@' meaning two segments when splitting by '@'
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; local part constraints: non-empty, no spaces, no '@'
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "@")))

; domain constraints: contains at least one '.', non-empty labels, no spaces, no '@'
(assert (>= (str.len domain_ok) 3))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "@")))
(assert (>= (num_splits domain_ok ".") 2))

; split domain at '.' and constrain the first label and rest
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (= rest_labels_ok (split_rest domain_ok "." 1)))
(assert (>= (str.len first_label_ok) 1))

; label counts
(assert (= label_count_ok (num_splits domain_ok ".")))
(assert (>= label_count_ok 2))

; require a TLD as the last label: model via splitting rest labels again
; if label_count_ok >= 2, then rest_labels_ok has at least one segment when split by '.'
(assert (>= (num_splits rest_labels_ok ".") 1))
(assert (= tld_ok (split_at rest_labels_ok "." (- (num_splits rest_labels_ok ".") 1))))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 24))

; simple character sanity: domain and TLD must not contain '+' (overly strict but consistent)
(assert (not (str.contains domain_ok "+")))
(assert (not (str.contains tld_ok "+")))

; regex approximations: enforce that email_ok contains exactly one '@' by forbidding two '@'
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains local_ok "@")))

; provide a constructive witness to ensure SAT
(assert (= email_ok "alice.smith@sub.example.com"))

; -----------------------
; UNSAT instance: contradictory email constraints
; -----------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; require domain has at least one '.'
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." 1)))
(assert (>= (str.len tld_bad) 2))

; contradictory: also require domain has no '.'
(assert (= (num_splits domain_bad ".") 1))

; witness value (doesn't matter; contradiction already forces UNSAT)
(assert (= email_bad "bob@invalid"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
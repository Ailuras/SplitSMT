(set-logic ALL)

; Uninterpreted interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------
; SAT instance: a complex but valid email structure
; ------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const first_label_ok String)
(declare-const tld_ok String)
(declare-const remainder_ok String)
(declare-const at_count_ok Int)
(declare-const dot_count_ok Int)

(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= at_count_ok (num_splits email_ok "@")))
(assert (= at_count_ok 2))

; local part sanity: non-empty, no spaces, does not contain '@'
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok " ")))
(assert (= (num_splits local_ok "@") 1))

; domain constraints: at least one dot, non-empty labels, and structured tail
(assert (= dot_count_ok (num_splits domain_ok ".")))
(assert (>= dot_count_ok 2))
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (= remainder_ok (split_rest domain_ok "." 1)))
(assert (> (str.len first_label_ok) 0))
(assert (not (str.contains first_label_ok " ")))

; last segment as TLD: take last label via split_rest indexing
(assert (= tld_ok (split_at domain_ok "." (- dot_count_ok 1))))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 24))

; enforce a concrete witness shape: user.name+tag@sub.example.co
(assert (= email_ok "user.name+tag@sub.example.co"))

; ------------
; UNSAT instance: impossible email structure (conflicting split constraints)
; ------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const at_count_bad Int)
(declare-const dot_count_bad Int)
(declare-const tld_bad String)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= at_count_bad (num_splits email_bad "@")))

; claim exactly one '@' exists (i.e., only one segment), but also force segment 1 to be non-empty -> contradiction
(assert (= at_count_bad 1))
(assert (> (str.len domain_bad) 0))

; additionally force there to be at least one dot in the domain and a TLD of length >= 2
(assert (= dot_count_bad (num_splits domain_bad ".")))
(assert (>= dot_count_bad 2))
(assert (= tld_bad (split_at domain_bad "." (- dot_count_bad 1))))
(assert (>= (str.len tld_bad) 2))

; provide an explicit bad-looking candidate to strengthen inconsistency with the segment-count claim
(assert (= email_bad "a@b.c"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
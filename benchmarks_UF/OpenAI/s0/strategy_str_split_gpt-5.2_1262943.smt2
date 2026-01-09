(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------------
; Scenario: Email Validation
; ----------------------------

; A satisfiable instance: an email that meets constraints
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const host_ok String)
(declare-const d0_ok String)
(declare-const d1_ok String)
(declare-const d2_ok String)
(declare-const rest1_ok String)

; Split at '@' must yield exactly 2 segments: local and domain
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local-part constraints (non-empty, no '@', no spaces)
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Domain constraints: contains at least one '.' (=> >=2 segments)
(assert (>= (num_splits domain_ok ".") 2))
(assert (= d0_ok (split_at domain_ok "." 0)))
(assert (= d1_ok (split_at domain_ok "." 1)))
(assert (= rest1_ok (split_rest domain_ok "." 1)))

; Enforce at least 3 domain labels to model complex domains: host.sub.tld
(assert (>= (num_splits domain_ok ".") 3))
(assert (= d2_ok (split_at domain_ok "." 2)))

; Basic label constraints: each non-empty and no spaces
(assert (> (str.len d0_ok) 0))
(assert (> (str.len d1_ok) 0))
(assert (> (str.len d2_ok) 0))
(assert (not (str.contains d0_ok " ")))
(assert (not (str.contains d1_ok " ")))
(assert (not (str.contains d2_ok " ")))

; Domain reconstruction sanity: d0 '.' rest1
(assert (= domain_ok (str.++ d0_ok "." rest1_ok)))

; Host and TLD references
(assert (= host_ok d0_ok))
(assert (= tld_ok d2_ok))

; TLD constraints: length in [2, 6]
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 6))

; Provide one concrete satisfying witness
(assert (= email_ok "john.doe@sub.example.com"))

; ----------------------------
; An unsatisfiable instance: contradictory email constraints
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Must split into exactly 2 segments at '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Domain requires at least 2 labels at '.'
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))

; Contradiction: force TLD to be both length 2 and length 1
(assert (= (str.len tld_bad) 2))
(assert (= (str.len tld_bad) 1))

; Another contradiction: local-part must be non-empty but also empty
(assert (> (str.len local_bad) 0))
(assert (= local_bad ""))

; Concrete email that would otherwise be fine, but contradictions remain
(assert (= email_bad "a@b.co"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
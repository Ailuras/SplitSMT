(set-logic ALL)

; Email Validation via str_split interface
; We model parsing using '@' and '.' delimiters and constrain segment counts and structure.

; --- Uninterpreted split operations ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- Primary email variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const dom_head String)
(declare-const tld String)
(declare-const tld2 String)
(declare-const reconstructed String)

; --- Additional variables for diversity ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const another_email String)
(declare-const another_domain String)
(declare-const another_tld String)

; -----------------------------
; SAT instance: plausible complex email
; -----------------------------
; Split at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (= (num_splits email "@") 2))

; Local part constraints (non-empty, no extra '@')
(assert (> (str.len local) 0))
(assert (= (num_splits local "@") 1))

; Domain constraints: must contain at least one '.' and have a TLD
(assert (>= (num_splits domain ".") 2))
(assert (= dom_head (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))
(assert (> (str.len dom_head) 0))
(assert (> (str.len tld) 0))

; Disallow empty labels by ensuring no leading/trailing '.' and no consecutive '..' (approximate)
(assert (not (= (split_at domain "." 0) "")))
(assert (not (= (split_at domain "." (- (num_splits domain ".") 1)) "")))
(assert (not (str.contains domain "..")))

; TLD alphabetic-ish approximation: no digits and length in [2, 6]
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (not (str.contains tld "0")))
(assert (not (str.contains tld "1")))
(assert (not (str.contains tld "2")))
(assert (not (str.contains tld "3")))
(assert (not (str.contains tld "4")))
(assert (not (str.contains tld "5")))
(assert (not (str.contains tld "6")))
(assert (not (str.contains tld "7")))
(assert (not (str.contains tld "8")))
(assert (not (str.contains tld "9")))

; Reconstruct a specific complex but valid address shape
(assert (= reconstructed (str.++ local "@" domain)))
(assert (= email reconstructed))

; Give a concrete satisfying witness pattern
(assert (= local "first.last+tag"))
(assert (= domain "sub.example"))

; -----------------------------
; UNSAT instance: impossible constraints for an email (contradicting '@' splits)
; -----------------------------
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= (num_splits email_bad "@") 2))
; Contradiction: force local_bad to contain '@' while also requiring it has exactly 1 segment under '@'
(assert (str.contains local_bad "@"))
(assert (= (num_splits local_bad "@") 1))

; -----------------------------
; Additional mixed constraints: another email with multi-dot domain
; -----------------------------
(assert (= another_domain (split_at another_email "@" 1)))
(assert (>= (num_splits another_email "@") 2))
(assert (= (num_splits another_email "@") 2))

; Domain must have at least three labels (e.g., a.b.c)
(assert (>= (num_splits another_domain ".") 3))
(assert (= another_tld (split_at another_domain "." (- (num_splits another_domain ".") 1))))
(assert (>= (str.len another_tld) 2))
(assert (<= (str.len another_tld) 10))

; Constrain another_email to equal some structured string while leaving room for solver choices
(assert (not (str.contains another_domain "..")))
(assert (not (= (split_at another_domain "." 0) "")))

; Make another_email concrete but consistent
(assert (= another_email "user@a.b.co"))

; Extra: ensure tld2 matches the last label of domain for the primary email
(assert (= tld2 (split_at domain "." (- (num_splits domain ".") 1))))
(assert (= tld2 tld))

(check-sat)


; [GENERATION STATUS: SUCCESS]

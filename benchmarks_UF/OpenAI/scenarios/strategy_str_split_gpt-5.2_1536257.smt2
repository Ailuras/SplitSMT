(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split operations

; -------------------------
; SAT instance: plausible complex email validation
; -------------------------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const local_first String)
(declare-const local_last String)
(declare-const domain_head String)
(declare-const tld String)
(declare-const tld_first String)
(declare-const tld_second String)
(declare-const local_dot_count Int)
(declare-const dom_dot_count Int)

; Split email at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_rest email "@" 2)))
(assert (= (num_splits email "@") 2))

; Non-empty local and domain
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Ensure exactly one '@' by enforcing no '@' inside local or domain
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; Local-part rules: allow dots but not at ends, and no consecutive dots
; Enforce at least 2 segments if dots exist; constrain segments and reconstruct
(assert (>= (num_splits local ".") 1))
(assert (= local_dot_count (num_splits local ".")))
(assert (= local_first (split_at local "." 0)))
(assert (= local_last (split_at local "." (- local_dot_count 1))))
(assert (> (str.len local_first) 0))
(assert (> (str.len local_last) 0))
(assert (not (str.contains local "..")))

; Domain rules: must have at least one dot (e.g., example.com), and no empty labels
(assert (>= (num_splits domain ".") 2))
(assert (= dom_dot_count (num_splits domain ".")))
(assert (= domain_head (split_at domain "." 0)))
(assert (> (str.len domain_head) 0))
(assert (not (str.contains domain "..")))

; TLD: last label, length at least 2, and purely alphabetic (lowercase here)
(assert (= tld (split_at domain "." (- dom_dot_count 1))))
(assert (>= (str.len tld) 2))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Additionally require the TLD to have at least two dot-separated segments overall in domain
; and constrain the last two labels to be alphabetic to model multi-part TLDs (e.g., co.uk)
(assert (>= dom_dot_count 3))
(assert (= tld_first (split_at domain "." (- dom_dot_count 2))))
(assert (= tld_second (split_at domain "." (- dom_dot_count 1))))
(assert (>= (str.len tld_first) 2))
(assert (>= (str.len tld_second) 2))
(assert (str.in_re tld_first (re.+ (re.range "a" "z"))))
(assert (str.in_re tld_second (re.+ (re.range "a" "z"))))

; Tie together with a concrete example to keep this instance SAT
(assert (= email "first.last@example.co.uk"))

; -------------------------
; UNSAT instance: inconsistent email requirements
; -------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const domain_bad_head String)
(declare-const domain_bad_tld String)
(declare-const dom_bad_dot_count Int)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= (num_splits email_bad "@") 2))
(assert (> (str.len local_bad) 0))
(assert (> (str.len domain_bad) 0))

; Require a domain with at least one dot
(assert (>= (num_splits domain_bad ".") 2))
(assert (= dom_bad_dot_count (num_splits domain_bad ".")))
(assert (= domain_bad_head (split_at domain_bad "." 0)))
(assert (= domain_bad_tld (split_at domain_bad "." (- dom_bad_dot_count 1))))
(assert (> (str.len domain_bad_head) 0))
(assert (> (str.len domain_bad_tld) 0))

; Contradiction: also demand the domain contains no '.'
(assert (not (str.contains domain_bad ".")))

; Pin to a concrete email containing a dot to strengthen the conflict
(assert (= email_bad "a@b.com"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

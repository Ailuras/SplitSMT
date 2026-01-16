(set-logic ALL)

; Email Validation scenario using str_split interface with '@' and '.' delimiters


(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const second_level String)
(declare-const rest_after_at String)
(declare-const first_dot_seg String)
(declare-const remainder_from_dot String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)

; Core split structure
(assert (= local (str.split_at email "@" 0)))
(assert (= rest_after_at (str.split_rest email "@" 1)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= at_count (str.num_splits email "@")))

; Exactly one '@' => two segments
(assert (= at_count 2))

; Domain split by '.'
(assert (= first_dot_seg (str.split_at domain "." 0)))
(assert (= remainder_from_dot (str.split_rest domain "." 1)))
(assert (= second_level (str.split_at domain "." 0)))
(assert (= tld (str.split_at domain "." 1)))
(assert (= dot_count (str.num_splits domain ".")))

; Require at least one '.' in domain => at least two segments
(assert (>= dot_count 2))

; Basic non-emptiness
(assert (> (str.len email) 5))
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (= tld_len (str.len tld)))
(assert (>= local_len 1))
(assert (>= domain_len 3))
(assert (>= tld_len 2))

; No spaces in local or domain (approximate by forbidding contains)
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))

; Local part should not start or end with '.'
(assert (or (= local "") (not (= (str.at local 0) "."))))
(assert (or (= local "") (not (= (str.at local (- (str.len local) 1)) "."))))

; Domain should not start or end with '.'
(assert (or (= domain "") (not (= (str.at domain 0) "."))))
(assert (or (= domain "") (not (= (str.at domain (- (str.len domain) 1)) "."))))

; Disallow consecutive dots in domain by forbidding ".." occurrence
(assert (not (str.contains domain "..")))

; Constrain email by a loose regex: must contain '@' somewhere and at least one '.' after it
; This does not fully validate RFC rules; it enforces presence/ordering.
(assert (str.in_re email (re.++ (re.* re.allchar)
                               (str.to_re "@")
                               (re.* re.allchar)
                               (str.to_re ".")
                               (re.* re.allchar))))

; Negative examples (preserve seed-like exclusions but adapted to email context)
(assert (not (= email "")))
(assert (not (= email "a@b")))
(assert (not (= email "@example.com")))
(assert (not (= email "user@.com")))
(assert (not (= email "user@example..com")))
(assert (not (= email "user@@example.com")))
(assert (not (= email "user example@example.com")))

; SAT branch: enforce a concrete valid-ish structure while leaving content flexible
(assert (= tld "com"))
(assert (>= (str.len second_level) 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

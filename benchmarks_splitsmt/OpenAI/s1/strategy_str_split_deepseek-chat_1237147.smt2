(set-logic ALL)

; --- Uninterpreted interface for string splitting ---

; --- Seed booleans preserved and repurposed ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; --- Email validation variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const first_label String)
(declare-const tld String)
(declare-const dot_tail String)

; --- Seed structure mutated to relate to email instead of literal "-" ---
(assert (= T_1 (= "-" email)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" email)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- Core email split constraints using '@' ---
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= (str.num_splits email "@") 2))

; local and domain must be non-empty
(assert (not (= local "")))
(assert (not (= domain "")))

; local part should not contain '@'
(assert (not (str.contains local "@")))

; --- Domain structure using '.' delimiter ---
; Require at least one dot in the domain: e.g., "example.com" or "mail.example.co"
(assert (>= (str.num_splits domain ".") 2))

; Define first label and TLD as first and last segments
(assert (= first_label (str.split_at domain "." 0)))
(assert (not (= first_label "")))

; dot_tail is everything after the first label
(assert (= dot_tail (str.split_rest domain "." 1)))
(assert (not (= dot_tail "")))

; Ensure dot_tail itself has at least one segment (always true if non-empty, but keeps structure explicit)
(assert (>= (str.num_splits dot_tail ".") 1))

; Constrain TLD via taking the last segment indirectly:
; If dot_tail has exactly 1 segment, that segment is the TLD.
(assert (=> (= (str.num_splits domain ".") 2)
            (= tld (str.split_at domain "." 1))))

; If dot_tail has at least 2 segments, the last segment is split_at dot_tail "." (str.num_splits dot_tail "." - 1)
(assert (=> (>= (str.num_splits domain ".") 3)
            (= tld (str.split_at dot_tail "." (- (str.num_splits dot_tail ".") 1)))))

; TLD non-empty and length constraints (2..24)
(assert (not (= tld "")))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; --- Additional consistency constraints ---
; Email must contain '@' as a delimiter and not start/end with it (approximated by non-empty parts already)
(assert (str.contains email "@"))

; Disallow domain starting with '.' (approximated by first_label non-empty) and disallow consecutive dots in domain
(assert (not (str.contains domain "..")))

; Disallow local starting or ending with '.' (approximated by not having '.' at edges using substr/at)
(assert (=> (>= (str.len local) 1)
            (and (not (= (str.at local 0) "."))
                 (not (= (str.at local (- (str.len local) 1)) ".")))))

; --- Include an UNSAT branch as a separate instance inside the same file via a contradiction trigger ---
; If email equals "a@b.c" then require TLD length >= 5, contradicting "c".
(assert (=> (= email "a@b.c") (>= (str.len tld) 5)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

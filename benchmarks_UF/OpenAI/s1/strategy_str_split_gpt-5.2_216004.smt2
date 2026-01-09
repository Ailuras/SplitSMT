(set-logic ALL)

; Uninterpreted interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables (preserved) and additional variables for email validation
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_127821 () String)

(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const domain_head String)
(declare-const dot_count Int)
(declare-const at_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)

; Preserve the seed's core structure
(assert (= T_1 (not (= "file:" var_0xINPUT_127821))))
(assert T_1)

; Tie the input to the email under validation
(assert (= email var_0xINPUT_127821))

; Email must contain exactly one '@' -> two segments when splitting by '@'
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Basic non-emptiness constraints
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 0))

; Disallow forbidden prefixes (keep from seed intent, and add another common prohibition)
(assert (not (str.prefixof "file:" email)))
(assert (not (str.prefixof "mailto:" email)))

; Domain must have at least one '.' -> at least two segments
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))

; Top-level domain is last segment after splitting by '.'
(assert (= tld (split_at domain "." (- dot_count 1))))
(assert (= tld_len (str.len tld)))
(assert (>= tld_len 2))

; Domain head must be non-empty (segment 0)
(assert (= domain_head (split_at domain "." 0)))
(assert (> (str.len domain_head) 0))

; Structural sanity: local and domain should not themselves contain delimiter repetitions at ends
(assert (not (str.prefixof "@" email)))
(assert (not (str.suffixof "@" email)))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; --- UNSAT side condition (intentionally contradicts valid email structure) ---
; If there are at least two domain segments, TLD length must be >=2 above,
; but we additionally force it to be length 1, making the instance UNSAT.
(assert (= tld_len 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(set-logic ALL)

; Uninterpreted interface operations for str_split

; Seed-derived symbols (mutated/extended)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_23905 () String)

; Email-specific variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const pre_tld String)
(declare-const dot_count Int)
(declare-const at_count Int)

; Preserve core structure but repurpose away from the trivial "-" equality
(assert (= email var_0xINPUT_23905))
(assert (= T_1 (and (not (= email "-")) (>= (str.len email) 3))))
(assert T_1)

; Split at '@' to validate basic email structure
(assert (= at_count (str.num_splits email "@")))
(assert (= T_2 (= at_count 2)))
(assert T_2)

(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; Forbid '@' in local or domain parts (ensures single '@')
(assert (= (str.num_splits local "@") 1))
(assert (= (str.num_splits domain "@") 1))

; Domain must contain at least one '.' and have non-empty segments
(assert (= dot_count (str.num_splits domain ".")))
(assert (>= dot_count 2))

; Require a non-empty top-level domain and non-empty pre-tld
(assert (= tld (str.split_at domain "." (- dot_count 1))))
(assert (= pre_tld (str.split_at domain "." 0)))
(assert (>= (str.len tld) 2))
(assert (>= (str.len pre_tld) 1))

; Domain must not start or end with '.'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; UNSAT branch: contradictory constraint forcing domain to be empty while also requiring dot_count>=2
(assert (= T_3 (= domain "")))
(assert T_3)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

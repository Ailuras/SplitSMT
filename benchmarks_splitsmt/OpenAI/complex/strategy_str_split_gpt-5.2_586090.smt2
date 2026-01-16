(set-logic ALL)

; --- Uninterpreted interface operations for str_split ---

; --- Booleans preserved from seed core structure ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; --- Inputs / derived segments ---
(declare-const var_0xINPUT_323918 String)
(declare-const local_part String)
(declare-const domain String)
(declare-const first_label String)
(declare-const second_label String)
(declare-const tld String)

; Seed structure: T_1 means non-empty
(assert (= T_1 (not (= "" var_0xINPUT_323918))))

; Basic email split around '@'
(assert (= local_part (str.split_at var_0xINPUT_323918 "@" 0)))
(assert (= domain (str.split_at var_0xINPUT_323918 "@" 1)))

; Exactly one '@' => two segments
(assert (= (str.num_splits var_0xINPUT_323918 "@") 2))

; Local part constraints
(assert (not (= "" local_part)))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))
(assert (not (= (str.at local_part 0) ".")))

; Domain split around '.' and structure constraints
(assert (>= (str.num_splits domain ".") 3))
(assert (= first_label (str.split_at domain "." 0)))
(assert (= second_label (str.split_at domain "." 1)))
(assert (= tld (str.split_at domain "." 2)))

(assert (not (= "" domain)))
(assert (not (= "" first_label)))
(assert (not (= "" second_label)))
(assert (not (= "" tld)))

; Ensure there is at least one '.' in domain by requiring that domain differs from its first label
(assert (not (= domain first_label)))

; TLD constraints: length between 2 and 6
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Make domain tail consistent with split_rest interface usage
(assert (= (str.split_rest domain "." 2) tld))

; T_2 flips T_1, then we also require a valid email structure above.
; This combination makes the instance UNSAT while preserving seed's contradiction core.
(assert (= T_2 (not T_1)))
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

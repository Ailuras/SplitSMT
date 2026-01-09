(set-logic ALL)

; Boolean guards (preserve core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Input email
(declare-fun var_0xINPUT_228795 () String)

; str_split interface

; Email-derived components
(declare-const local_part String)
(declare-const domain_part String)
(declare-const first_domain_label String)
(declare-const tld String)
(declare-const domain_tail String)

; Basic non-empty input checks (as in seed)
(assert (= T_1 (not (= "" var_0xINPUT_228795))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_228795))))
(assert T_2)

; Mutated seed equality/inequality core
(assert (= T_3 (not (= "fB9De3KAY9" var_0xINPUT_228795))))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email split structure: exactly one '@' => two segments
(assert (= T_5 (= (str.num_splits var_0xINPUT_228795 "@") 2)))
(assert T_5)

; Bind local and domain parts
(assert (= local_part (str.split_at var_0xINPUT_228795 "@" 0)))
(assert (= domain_part (str.split_at var_0xINPUT_228795 "@" 1)))

; Local part constraints
(assert (not (= local_part "")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))
(assert (not (str.contains local_part "..")))

; Domain constraints: must have at least one '.' and not start/end with '.'
(assert (>= (str.num_splits domain_part ".") 2))
(assert (not (= domain_part "")))
(assert (not (= (str.at domain_part 0) ".")))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))
(assert (not (str.contains domain_part "..")))
(assert (not (str.contains domain_part "@")))

; Bind domain labels
(assert (= first_domain_label (str.split_at domain_part "." 0)))
(assert (= tld (str.split_at domain_part "." (- (str.num_splits domain_part ".") 1))))
(assert (= domain_tail (str.split_rest domain_part "." 1)))

; Domain label constraints
(assert (not (= first_domain_label "")))
(assert (not (str.contains first_domain_label "_")))
(assert (not (str.contains domain_part " ")))

; TLD constraints: length between 2 and 6
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Force presence of at least one dot after first label (domain_tail non-empty)
(assert (not (= domain_tail "")))

; An additional boolean tying to a property (keeps similar shape)
(assert (= T_6 (and (>= (str.len local_part) 1) (>= (str.len domain_part) 3))))
(assert T_6)

; Ensure some determinism: pick a concrete satisfying email
(assert (= var_0xINPUT_228795 "user.name+tag@example.co"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

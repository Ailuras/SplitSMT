(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-style Boolean structure (preserved but extended)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; Email input and derived parts
(declare-fun var_0xINPUT_54124 () String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const rest_after_tld String)

; Core split structure: local@domain
(assert (= local_part (split_at var_0xINPUT_54124 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_54124 "@" 1)))

; Basic non-emptiness checks
(assert (= T_1 (not (= "" var_0xINPUT_54124))))
(assert (= T_3 (and (not (= "" local_part)) (not (= "" domain_part)))))

; Exactly one '@' => two segments
(assert (= T_4 (= (num_splits var_0xINPUT_54124 "@") 2)))

; Domain must have at least two dot-separated labels
(assert (>= (num_splits domain_part ".") 2))

; Extract first two domain labels and the last (TLD)
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))
(assert (= rest_after_tld (split_rest domain_part "." (- (num_splits domain_part ".") 1))))

; Domain label non-emptiness and simple structure constraints
(assert (not (= "" domain_label0)))
(assert (not (= "" domain_label1)))
(assert (not (= "" tld)))

; No empty segments caused by consecutive dots: forbid ".." in domain
(assert (not (str.contains domain_part "..")))

; '.' must appear in domain (redundant with num_splits>=2, but explicit)
(assert (str.contains domain_part "."))

; Local part constraints: must not contain '@', and must not start/end with '.'
(assert (not (str.contains local_part "@")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; TLD length constraints (2..24)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Consistency: splitting at '.' at the last segment should yield exactly the TLD as rest
(assert (= rest_after_tld tld))

; UNSAT core-style toggle preserved from seed, but now tied to email validity
(assert (= T_2 (not (and T_1 T_3 T_4))))
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

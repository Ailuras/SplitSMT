(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-style variables retained (and repurposed)
(declare-fun I0_5 () Int)
(declare-fun I0_8 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun T0_5 () String)
(declare-fun T0_8 () String)
(declare-fun T1_5 () String)
(declare-fun T1_8 () String)
(declare-fun T2_5 () String)
(declare-fun T2_8 () String)
(declare-fun T3_5 () String)
(declare-fun T3_8 () String)
(declare-fun T4_5 () String)
(declare-fun T4_8 () String)
(declare-fun T5_5 () String)
(declare-fun T5_8 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun var_0xINPUT_100767 () String)

; Additional email-validation specific variables
(declare-const localpart String)
(declare-const domain String)
(declare-const tld String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const forbidden_dotdot Bool)
(declare-const forbidden_atat Bool)
(declare-const has_at Bool)

; Core email structure via split
(assert (= localpart (split_at var_0xINPUT_100767 "@" 0)))
(assert (= domain (split_at var_0xINPUT_100767 "@" 1)))
(assert (>= (num_splits var_0xINPUT_100767 "@") 2))
(assert (= (num_splits var_0xINPUT_100767 "@") 2))
(assert (>= (str.len localpart) 1))
(assert (>= (str.len domain) 1))

; Domain must contain dots and end with a TLD
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))

; Forbid pathological patterns
(assert (= forbidden_dotdot (str.contains var_0xINPUT_100767 "..")))
(assert (not forbidden_dotdot))
(assert (= forbidden_atat (str.contains var_0xINPUT_100767 "@@")))
(assert (not forbidden_atat))
(assert (not (str.contains localpart " ")))
(assert (not (str.contains domain " ")))

; Seed-like boolean scaffolding, mutated to be meaningful for email
(assert (= T_1 (= "-" var_0xINPUT_100767)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_100767)))
(assert (not T_3))

; Repurpose PCTEMP_LHS_1/PCTEMP_LHS_2 as indices derived from lengths and enforce sane ranges
(assert (= PCTEMP_LHS_1 (str.len localpart)))
(assert (= PCTEMP_LHS_2 (str.len domain)))
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert T_5)

; Additional seed-style ite blocks, now tied to '@' and '.' structure (still purely constraints)
(assert (= T_SELECT_1 (not (= I0_5 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= I0_5 (str.len T4_5))
    (= var_0xINPUT_100767 (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (= T1_5 (str.++ T2_5 T3_5))
    (= T2_5 (str.++ T4_5 T5_5))
    (= T5_5 "@")
    ; localpart must not contain '@'
    (not (str.contains T4_5 "@"))
    ; localpart must match the extracted one
    (= T4_5 localpart))
  (and
    (= I0_5 (- 1))
    (= var_0xINPUT_100767 (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (not (str.contains T1_5 "@"))
  )))

(assert (= T_SELECT_2 (not (= I0_8 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= I0_8 (str.len T4_8))
    (= domain (str.++ T0_8 T1_8))
    (= 0 (str.len T0_8))
    (= T1_8 (str.++ T2_8 T3_8))
    (= T2_8 (str.++ T4_8 T5_8))
    (= T5_8 ".")
    ; domain_label0 is first label before dot
    (= T4_8 domain_label0)
    (>= (str.len domain_label0) 1)
    (not (str.contains domain_label0 "-"))
  )
  (and
    (= I0_8 (- 1))
    (= domain (str.++ T0_8 T1_8))
    (= 0 (str.len T0_8))
    (not (str.contains T1_8 "."))
  )))

; UNSAT twist: require domain to have at least one dot (already asserted),
; but also enforce that it contains no dot via split_rest constraint.
; This makes the instance UNSAT while preserving the email-validation core structure.
(assert (= (split_rest domain "." 0) domain))
(assert (not (str.contains (split_rest domain "." 0) ".")))

; Reuse T_7 as a final contradictory check, in seed style but tied to domain length
(assert (= T_7 (< PCTEMP_LHS_2 0)))
(assert T_7)

(check-sat)


; [GENERATION STATUS: SUCCESS]
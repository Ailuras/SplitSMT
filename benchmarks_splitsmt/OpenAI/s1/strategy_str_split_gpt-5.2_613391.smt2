(set-logic ALL)

; Email Validation scenario using str_split interface

(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () Bool)
(declare-fun T_12 () Bool)
(declare-fun T_13 () Bool)

(declare-fun var_0xINPUT_114521 () String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const tld String)
(declare-const sld String)
(declare-const domain_rest_after_sld String)
(declare-const first_domain_label String)
(declare-const second_domain_label String)

; Preserve core structure: non-empty input checks
(assert (= T_1 (not (= "" var_0xINPUT_114521))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_114521))))
(assert T_2)

; Mutate seed: keep the "Example:" exclusion pattern
(assert (= T_3 (= var_0xINPUT_114521 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)

; Switch to email-centric forbidden constant and force it (mirrors seed's T_5/T_6 structure)
(assert (= T_5 (not (= var_0xINPUT_114521 "o7E1eVAEe3"))))
(assert (= T_6 (not T_5)))
(assert T_6)

; Email split around '@'
(assert (= local_part (str.split_at var_0xINPUT_114521 "@" 0)))
(assert (= domain_part (str.split_at var_0xINPUT_114521 "@" 1)))
(assert (>= (str.num_splits var_0xINPUT_114521 "@") 2))
(assert (<= (str.num_splits var_0xINPUT_114521 "@") 2))

; Basic sanity constraints on local/domain
(assert (not (= local_part "")))
(assert (not (= domain_part "")))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain_part " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain_part "@")))

; Domain must contain at least one '.' producing at least two labels
(assert (>= (str.num_splits domain_part ".") 2))

; Extract first two domain labels and rest
(assert (= first_domain_label (str.split_at domain_part "." 0)))
(assert (= second_domain_label (str.split_at domain_part "." 1)))
(assert (= domain_rest_after_sld (str.split_rest domain_part "." 1)))

; Non-empty labels
(assert (not (= first_domain_label "")))
(assert (not (= second_domain_label "")))

; Forbid leading dot and consecutive dot implicitly by requiring first two labels non-empty
; and by constraining the rest to not start with '.'
(assert (= T_7 (str.contains domain_rest_after_sld "..")))
(assert (= T_8 (not T_7)))
(assert T_8)

; TLD extraction: last segment after splitting domain_rest_after_sld by '.'
; Here we approximate: require that the second label is the TLD when only two labels exist
(assert (= T_9 (= (str.num_splits domain_part ".") 2)))
(assert (= T_10 (=> T_9 (= tld second_domain_label))))
(assert T_10)

; When there are 3+ labels, require TLD to be the second label of split_rest at index (str.num_splits-2)
; We relax by constraining: if 3+ labels, second label is not the TLD (i.e., must have another '.')
(assert (= T_11 (>= (str.num_splits domain_part ".") 3)))
(assert (= T_12 (=> T_11 (str.contains domain_rest_after_sld "."))))
(assert T_12)

; TLD length constraints and character exclusions (relaxed)
(assert (>= (str.len second_domain_label) 2))
(assert (<= (str.len second_domain_label) 15))
(assert (not (str.contains second_domain_label "-")))

; Local part constraints: no consecutive dots and not starting/ending with dot
(assert (= T_13 (str.contains local_part "..")))
(assert (not T_13))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Force a concrete email to create a definite (and intentionally UNSAT) instance via conflict with TLD rule above
; Since we forced var_0xINPUT_114521 = "o7E1eVAEe3" already, it cannot be a valid email containing '@'
; This makes the instance UNSAT while still exercising the email validation structure.
(assert (str.contains var_0xINPUT_114521 "@"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

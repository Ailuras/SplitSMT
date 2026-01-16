(set-logic ALL)

; Uninterpreted split interface for email validation

; Seed-style boolean structure retained and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)

(declare-fun U_1 () Bool)
(declare-fun U_2 () Bool)
(declare-fun U_3 () Bool)
(declare-fun U_4 () Bool)
(declare-fun U_5 () Bool)

; Input email string
(declare-fun var_0xINPUT_109105 () String)

; Segment variables for readability
(declare-const local_part String)
(declare-const domain_full String)
(declare-const domain_label0 String)
(declare-const tld String)
(declare-const domain_rest_from1 String)

; Basic non-triviality constraints (mutated from seed)
(assert (= T_1 (= "-" var_0xINPUT_109105)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_109105)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email must contain exactly one '@' -> num_splits with '@' equals 2 segments
(assert (= T_5 (= (str.num_splits var_0xINPUT_109105 "@") 2)))
(assert T_5)

; Bind local and domain using split_at
(assert (= local_part (str.split_at var_0xINPUT_109105 "@" 0)))
(assert (= domain_full (str.split_at var_0xINPUT_109105 "@" 1)))

; Local and domain must be non-empty
(assert (= T_6 (and (> (str.len local_part) 0) (> (str.len domain_full) 0))))
(assert T_6)

; Local part must not contain '@'
(assert (= T_7 (not (str.contains local_part "@"))))
(assert T_7)

; Domain must not contain '@'
(assert (= T_8 (not (str.contains domain_full "@"))))
(assert T_8)

; Domain structure: at least one '.' (e.g., example.com)
(assert (= U_1 (>= (str.num_splits domain_full ".") 2)))
(assert U_1)

; Extract first domain label and the last segment (tld) via split interface
(assert (= domain_label0 (str.split_at domain_full "." 0)))
(assert (= domain_rest_from1 (str.split_rest domain_full "." 1)))

; Ensure first label non-empty and does not contain '.'
(assert (= U_2 (and (> (str.len domain_label0) 0) (not (str.contains domain_label0 ".")))))
(assert U_2)

; Enforce that the "rest from 1" is the remaining domain; must contain at least one segment
(assert (= U_3 (> (str.len domain_rest_from1) 0)))
(assert U_3)

; Define tld as the last split element by constraining it to be a suffix after the final '.'
; (We don't have direct last-index access, so we conservatively constrain via split_at at index 1 when exactly two segments)
(assert (= U_4 (=> (= (str.num_splits domain_full ".") 2)
                  (= tld (str.split_at domain_full "." 1)))))
(assert U_4)

; TLD constraints: length between 2 and 10 when defined in the 2-segment domain case
(assert (= U_5 (=> (= (str.num_splits domain_full ".") 2)
                  (and (>= (str.len tld) 2) (<= (str.len tld) 10)))))
(assert U_5)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

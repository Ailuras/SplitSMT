(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted str_split interface

; Seed-shaped declarations preserved
(declare-fun I0_2 () Int)
(declare-fun I0_4 () Int)
(declare-fun I0_6 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun PCTEMP_LHS_3 () Int)
(declare-fun T0_2 () String)
(declare-fun T0_4 () String)
(declare-fun T0_6 () String)
(declare-fun T1_2 () String)
(declare-fun T1_4 () String)
(declare-fun T1_6 () String)
(declare-fun T2_2 () String)
(declare-fun T2_4 () String)
(declare-fun T2_6 () String)
(declare-fun T3_2 () String)
(declare-fun T3_4 () String)
(declare-fun T3_6 () String)
(declare-fun T4_2 () String)
(declare-fun T4_4 () String)
(declare-fun T4_6 () String)
(declare-fun T5_2 () String)
(declare-fun T5_4 () String)
(declare-fun T5_6 () String)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun T_SELECT_3 () Bool)
(declare-fun var_0xINPUT_40206 () String)

; Additional variables for email validation scenario
(declare-const local String)
(declare-const domain String)
(declare-const d0 String)
(declare-const d1 String)
(declare-const d2 String)
(declare-const d3 String)
(declare-const recon_domain String)
(declare-const recon_email String)
(declare-const has_plus Bool)
(declare-const has_underscore Bool)
(declare-const unsat_branch Bool)

; Preserve core "T_SELECT" structure but mutate to email patterns
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_2 0))
    (= var_0xINPUT_40206 (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    (= I0_2 (str.len T4_2))
    (= T1_2 (str.++ T2_2 T3_2))
    (= T2_2 (str.++ T4_2 T5_2))
    (= T5_2 "@")
    ; local part must not contain '@'
    (not (str.contains T4_2 "@"))
    ; local part must not start with '.'
    (not (= (str.at T4_2 0) "."))
    (>= (str.len T4_2) 1))
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= var_0xINPUT_40206 (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    ; fallback still forbids '@@'
    (not (str.contains T1_2 "@@")))))

(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= PCTEMP_LHS_2 (+ I0_4 0))
    (= var_0xINPUT_40206 (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
    (= I0_4 (str.len T4_4))
    (= T1_4 (str.++ T2_4 T3_4))
    (= T2_4 (str.++ T4_4 T5_4))
    (= T5_4 "")
    ; domain must contain at least one '.'
    (str.contains T4_4 ".")
    ; domain must not end with '.'
    (not (= (str.at T4_4 (- (str.len T4_4) 1)) "."))
    (>= (str.len T4_4) 3))
  (and
    (= PCTEMP_LHS_2 (- 1))
    (= var_0xINPUT_40206 (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
    (not (str.contains T1_4 "..")))))

(assert (= T_SELECT_3 (not (= PCTEMP_LHS_3 (- 1)))))
(assert (ite T_SELECT_3
  (and
    (= PCTEMP_LHS_3 (+ I0_6 0))
    (= var_0xINPUT_40206 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (= I0_6 (str.len T4_6))
    (= T1_6 (str.++ T2_6 T3_6))
    (= T2_6 (str.++ T4_6 T5_6))
    (= T5_6 "")
    ; whole email must contain exactly one '@' modeled via split counts
    (= (num_splits var_0xINPUT_40206 "@") 2)
    ; forbid spaces
    (not (str.contains var_0xINPUT_40206 " "))
    (>= (str.len var_0xINPUT_40206) 3))
  (and
    (= PCTEMP_LHS_3 (- 1))
    (= var_0xINPUT_40206 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (not (str.contains T1_6 "@")))))

; Tie scenario variables to split constraints
(assert (= local (split_at var_0xINPUT_40206 "@" 0)))
(assert (= domain (split_at var_0xINPUT_40206 "@" 1)))
(assert (>= (num_splits var_0xINPUT_40206 "@") 2))
(assert (<= (num_splits var_0xINPUT_40206 "@") 2))

; Domain split by '.' must have at least 2 labels (e.g., example.com) and at most 4 (e.g., a.b.c.d)
(assert (>= (num_splits domain ".") 2))
(assert (<= (num_splits domain ".") 4))

; Extract up to four labels
(assert (= d0 (split_at domain "." 0)))
(assert (= d1 (split_at domain "." 1)))
(assert (= d2 (split_at domain "." 2)))
(assert (= d3 (split_at domain "." 3)))

; Basic label constraints
(assert (>= (str.len d0) 1))
(assert (>= (str.len d1) 2))
(assert (not (= d1 "")))
(assert (not (str.contains d0 "@")))
(assert (not (str.contains domain "@")))

; Enforce TLD: only letters and length 2..6 for d1 if there are exactly 2 labels
; If 3+ labels, enforce last label (d2 or d3) similarly
(declare-const tld String)
(assert (ite (= (num_splits domain ".") 2)
  (= tld d1)
  (ite (= (num_splits domain ".") 3)
    (= tld d2)
    (= tld d3))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Local-part sanity: no leading/trailing dot and no consecutive dots
(assert (>= (str.len local) 1))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))
(assert (not (str.contains local "@")))

; Optional plus-tag and underscore flags (diverse constraints)
(assert (= has_plus (str.contains local "+")))
(assert (= has_underscore (str.contains local "_")))
(assert (=> has_plus (>= (str.len local) 3)))
(assert (=> has_underscore (>= (str.len local) 2)))

; Reconstruct email using split_rest for consistency
(assert (= recon_domain (split_rest domain "." 0)))
(assert (= recon_email (str.++ local "@" recon_domain)))
(assert (= recon_email var_0xINPUT_40206))

; Mutated terminal checks: not "-" and not empty
(assert (= T_4 (= "-" var_0xINPUT_40206)))
(assert (= T_5 (not T_4)))
(assert T_5)
(assert (= T_6 (= "" var_0xINPUT_40206)))
(assert (not T_6))

; Include an UNSAT branch (disabled by default) for diversity
(assert (= unsat_branch false))
(assert (=> unsat_branch (and (= (num_splits var_0xINPUT_40206 "@") 1) (= (num_splits var_0xINPUT_40206 "@") 2))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)

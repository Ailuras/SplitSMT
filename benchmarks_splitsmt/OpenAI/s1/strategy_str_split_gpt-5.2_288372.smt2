(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field count checks, and empty-field detection

; Non-primitive interface operations (str_split)

; Seed-style declarations preserved
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_35390 () String)

; New CSV-focused variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const empty_field_detected Bool)
(declare-const has_extra_fields Bool)

; Core structure retained but repurposed: keep the "not '-'" guard and the "is empty" marker style
(assert (= T_1 (= "-" var_0xINPUT_35390)))
(assert (= T_2 (not T_1)))
(assert T_2)

; For CSV, interpret input as the CSV string; keep T_3 equality but on csv
(assert (= csv var_0xINPUT_35390))
(assert (= T_3 (= "" csv)))

; Delimiter is comma
(assert (= delim ","))

; Split into fields
(assert (= f0 (str.split_at csv delim 0)))
(assert (= f1 (str.split_at csv delim 1)))
(assert (= f2 (str.split_at csv delim 2)))
(assert (= rest2 (str.split_rest csv delim 2)))

; Derived booleans about CSV structure
(assert (= empty_field_detected (or (= f0 "") (= f1 "") (= f2 ""))))
(assert (= has_extra_fields (> (str.num_splits csv delim) 3)))

; Mutated PCTEMP_LHS_1 selection structure:
; - If selection holds, enforce a 3-field CSV with an empty middle field: "alpha,,gamma"
; - Else, create a contradictory requirement (UNSAT branch) by forcing exactly 2 fields while also needing 3
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert
 (ite T_SELECT_1
      (and
        ; SAT branch: concrete CSV with an empty field
        (= T0_5 "alpha")
        (= T1_5 (str.++ "," (str.++ "" (str.++ "," "gamma"))))
        (= csv (str.++ T0_5 T1_5))
        (= (str.num_splits csv delim) 3)
        (= f0 "alpha")
        (= f1 "")
        (= f2 "gamma")
        (= empty_field_detected true)
        (= has_extra_fields false)

        ; Keep some seed-like arithmetic linkage
        (= I0_5 (str.len f0))
        (= PCTEMP_LHS_1 (+ I0_5 0))

        ; Keep a seed-inspired regex avoidance: forbid a tracking-token-like substring in the whole CSV
        (not (str.in_re csv
                        (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "a") (str.to_re "=")
                              (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4")))))
      (and
        ; UNSAT branch: impossible combination (forces 2 splits and also references 3rd field as non-empty)
        (= PCTEMP_LHS_1 (- 1))
        (= csv (str.++ "x" (str.++ "," "y")))
        (= (str.num_splits csv delim) 2)
        (= f0 "x")
        (= f1 "y")
        (not (= f2 ""))
        (= (str.num_splits csv delim) 3))))

; Keep seed tail constraints form
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_6 (not T_5)))
(assert T_6)

; Force SAT by requiring we are in the non-(-1) branch
(assert (not (= PCTEMP_LHS_1 (- 1))))

; Also ensure CSV is not empty (contrasts with T_3 assignment possibility)
(assert (not T_3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

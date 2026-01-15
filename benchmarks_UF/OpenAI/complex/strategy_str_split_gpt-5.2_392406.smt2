(set-logic ALL)

; Uninterpreted interface for CSV splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-style declarations (kept core structure)
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
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun T_SELECT_3 () Bool)
(declare-fun var_0xINPUT_107890 () String)

; CSV-focused extra variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const has_empty_field Bool)
(declare-const bad_field_count Bool)

(assert (= delim ","))

; Tie the old input to the CSV line to preserve core structure while changing scenario
(assert (= var_0xINPUT_107890 csv_line))

; Keep seed-style select structure but repurpose with CSV delimiters
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_2 0))
    (= csv_line (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    (= T1_2 (str.++ T2_2 T3_2))
    (= T2_2 (str.++ T4_2 T5_2))
    (= T5_2 ",")
    (= I0_2 (str.len T4_2))
    (not (= T4_2 ""))
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= csv_line (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
  )))

(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= PCTEMP_LHS_2 (+ I0_4 0))
    (= csv_line (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
    (= T1_4 (str.++ T2_4 T3_4))
    (= T2_4 (str.++ T4_4 T5_4))
    (= T5_4 ",")
    (= I0_4 (str.len T4_4))
  )
  (and
    (= PCTEMP_LHS_2 (- 1))
    (= csv_line (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
  )))

(assert (= T_SELECT_3 (not (= PCTEMP_LHS_3 (- 1)))))
(assert (ite T_SELECT_3
  (and
    (= PCTEMP_LHS_3 (+ I0_6 0))
    (= csv_line (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (= T1_6 (str.++ T2_6 T3_6))
    (= T2_6 (str.++ T4_6 T5_6))
    (= T5_6 ",")
    (= I0_6 (str.len T4_6))
  )
  (and
    (= PCTEMP_LHS_3 (- 1))
    (= csv_line (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
  )))

; CSV processing constraints using the str_split interface
(assert (>= (num_splits csv_line delim) 1))
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Ensure we are really dealing with comma-separated format
(assert (str.contains csv_line delim))

; Detect empty fields
(assert (= has_empty_field (or (= field0 "") (= field1 "") (= field2 ""))))

; Field count checks: exactly 3 fields expected
(assert (= bad_field_count (not (= (num_splits csv_line delim) 3))))

; Constrain indices and lengths (natural bounds)
(assert (>= (num_splits csv_line delim) 3))
(assert (>= (str.len field0) 0))
(assert (>= (str.len field1) 0))
(assert (>= (str.len field2) 0))

; Build a concrete CSV line pattern and then create a contradiction for UNSAT
(assert (= csv_line (str.++ "id" "," "" "," "name")))

; Seed-style final checks, mutated for CSV (ban trivial/sentinel lines)
(assert (= T_4 (= "-" csv_line)))
(assert (= T_5 (not T_4)))
(assert T_5)
(assert (= T_6 (= "" csv_line)))
(assert (= T_7 (not T_6)))
(assert T_7)

; Force a contradictory combination: no empty fields, but the middle field is empty
(assert (not has_empty_field))

; Additionally keep a seed-like contradictory arithmetic guard
(assert (= T_8 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_9 (not T_8)))
(assert T_9)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

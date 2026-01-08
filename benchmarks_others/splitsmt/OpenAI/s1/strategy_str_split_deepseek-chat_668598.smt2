(set-logic ALL)

; --- Uninterpreted interface for str_split (CSV fields)

; --- Seed variables (kept core structure)
(declare-fun T_SELECT_1 () Bool)
(declare-fun I0_2 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_2 () String)
(declare-fun T1_2 () String)
(declare-fun T2_2 () String)
(declare-fun T3_2 () String)
(declare-fun T4_2 () String)
(declare-fun T5_2 () String)
(declare-fun var_0xINPUT_18338 () String)

; --- Additional CSV-processing variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_after_2 String)
(declare-const has_empty_field Bool)
(declare-const total_fields Int)

; --- Preserve the seed concatenation core
(assert (= var_0xINPUT_18338 (str.++ T0_2 T1_2)))
(assert (= T1_2 (str.++ T2_2 T3_2)))
(assert (= T2_2 (str.++ T4_2 T5_2)))

; --- CSV scenario binding: build a CSV line using the seed core
(assert (= delim ","))
; require empty prefix for the line (consistent with seed len constraint)
(assert (= 0 (str.len T0_2)))
(assert (= csv_line var_0xINPUT_18338))

; Interpret T4_2 and T3_2 as CSV fragments: "a," then "b," ; T5_2 as last field
(assert (= T4_2 "a,"))
(assert (= T3_2 "b,"))
(assert (= T5_2 "c"))

; --- Ensure we detect empty fields and enforce correct field count
(assert (= total_fields (str.num_splits csv_line delim)))
(assert (>= total_fields 1))

; Access first three fields via split_at
(assert (= field0 (str.split_at csv_line delim 0)))
(assert (= field1 (str.split_at csv_line delim 1)))
(assert (= field2 (str.split_at csv_line delim 2)))
(assert (= rest_after_2 (str.split_rest csv_line delim 2)))

; Expect exactly 3 fields for this CSV line
(assert (= total_fields 3))

; No empty fields allowed in this instance
(assert (= has_empty_field (or (= field0 "") (= field1 "") (= field2 ""))))
(assert (not has_empty_field))

; Field sanity: disallow commas inside individual fields
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))

; Keep arithmetic core from seed but adapted to CSV length checks
(assert (= I0_2 (str.len T4_2)))
(assert (= PCTEMP_LHS_1 (+ I0_2 0)))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert T_SELECT_1)

; Additional length constraints: "a," length = 2, and overall structure implies some bounds
(assert (= I0_2 2))
(assert (>= (str.len csv_line) 5))

; Remove unrelated utma-regex constraint; replace with CSV-specific constraint
(assert (not (str.contains csv_line "__utma=")))

(check-sat)


; [GENERATION STATUS: SUCCESS]

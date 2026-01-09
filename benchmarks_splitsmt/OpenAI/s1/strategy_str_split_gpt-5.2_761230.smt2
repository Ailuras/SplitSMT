(set-logic ALL)

; --- Uninterpreted interface for string split ---

; --- Seed-style declarations preserved ---
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
(declare-fun var_0xINPUT_42055 () String)

; --- New variables for "Log Analysis" scenario ---
(declare-const ts String)
(declare-const level String)
(declare-const host String)
(declare-const msg String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const timepart String)
(declare-const datepart String)
(declare-const isoSep String)
(declare-const levelWithColon String)
(declare-const lvlRaw String)
(declare-const lvlColon String)
(declare-const okLevel Bool)
(declare-const okTs Bool)

; --- Core structure retained: 3 guarded parsing branches ---
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_2 0))
    (= var_0xINPUT_42055 (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    (= T1_2 (str.++ T2_2 T3_2))
    (= T2_2 (str.++ T4_2 T5_2))
    (= I0_2 (str.len T4_2))

    ; Log format: "<timestamp> <LEVEL>: <message>"
    (= ts (str.split_at var_0xINPUT_42055 " " 0))
    (= levelWithColon (str.split_at var_0xINPUT_42055 " " 1))
    (= msg (str.split_rest var_0xINPUT_42055 " " 2))
    (>= (str.num_splits var_0xINPUT_42055 " ") 3)

    ; validate that second token is LEVEL:
    (= lvlRaw (str.split_at levelWithColon ":" 0))
    (= lvlColon (str.split_at levelWithColon ":" 1))
    (= lvlColon "")
    (= level lvlRaw)
    (= okLevel (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))
    okLevel

    ; timestamp validation (shape only): YYYY-MM-DDThh:mm:ssZ
    (= isoSep (str.split_at ts "T" 1))
    (>= (str.num_splits ts "T") 2)
    (= datepart (str.split_at ts "T" 0))
    (= timepart (str.split_at ts "T" 1))
    (= (str.at ts 4) "-")
    (= (str.at ts 7) "-")
    (= (str.at ts 10) "T")
    (= (str.at ts 13) ":")
    (= (str.at ts 16) ":")
    (= (str.at ts 19) "Z")
    (= (str.len ts) 20)
    (= okTs true)

    ; Use seed suffix slots as concrete markers (mutated from cookie tags)
    (= T5_2 "HOST=")
    (= host (str.split_at msg " " 0))
    (str.contains msg "request")
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= var_0xINPUT_42055 (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    (= okTs false)
  )
))

(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= PCTEMP_LHS_2 (+ I0_4 0))
    (= var_0xINPUT_42055 (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
    (= T1_4 (str.++ T2_4 T3_4))
    (= T2_4 (str.++ T4_4 T5_4))
    (= I0_4 (str.len T4_4))

    ; Alternative delimiter check: ensure we can split by spaces into at least 3 segments
    (>= (str.num_splits var_0xINPUT_42055 " ") 3)
    (= ts (str.split_at var_0xINPUT_42055 " " 0))
    (= levelWithColon (str.split_at var_0xINPUT_42055 " " 1))

    ; Stricter check on time fields using substrings
    (= hh (str.substr ts 11 2))
    (= mm (str.substr ts 14 2))
    (= ss (str.substr ts 17 2))
    (str.in_re hh (re.++ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2")) (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))
    (str.in_re mm (re.++ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5")) (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))
    (str.in_re ss (re.++ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5")) (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))

    ; Mutated seed marker
    (= T5_4 "APP=")
    (str.contains (str.split_rest var_0xINPUT_42055 " " 2) "status")
  )
  (and
    (= PCTEMP_LHS_2 (- 1))
    (= var_0xINPUT_42055 (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
  )
))

(assert (= T_SELECT_3 (not (= PCTEMP_LHS_3 (- 1)))))
(assert (ite T_SELECT_3
  (and
    (= PCTEMP_LHS_3 (+ I0_6 0))
    (= var_0xINPUT_42055 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (= T1_6 (str.++ T2_6 T3_6))
    (= T2_6 (str.++ T4_6 T5_6))
    (= I0_6 (str.len T4_6))

    ; Parse loglevel from token 1 and constrain it
    (= levelWithColon (str.split_at var_0xINPUT_42055 " " 1))
    (= level (str.split_at levelWithColon ":" 0))
    (str.contains levelWithColon ":")

    ; Mutated marker
    (= T5_6 "PID=")

    ; In this branch, force an impossible timestamp length to create inconsistency when selected
    (= ts (str.split_at var_0xINPUT_42055 " " 0))
    (= (str.len ts) 19)
  )
  (and
    (= PCTEMP_LHS_3 (- 1))
    (= var_0xINPUT_42055 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
  )
))

; --- Global log-analysis constraints ---
; Input must look like a log entry (not empty)
(assert (>= (str.len var_0xINPUT_42055) 1))

; Ensure at least one parsing branch is active
(assert (or T_SELECT_1 T_SELECT_2 T_SELECT_3))

; Keep seed-style boolean chain but mutate meaning: input must not be "-" and must be non-empty
(assert (= T_4 (= "-" var_0xINPUT_42055)))
(assert (= T_5 (not T_4)))
(assert T_5)
(assert (= T_6 (= "" var_0xINPUT_42055)))
(assert (not T_6))

; Force the input to be a concrete well-formed log entry that satisfies branch 1 and 2 timestamp checks
(assert (= var_0xINPUT_42055 "2025-01-31T23:59:58Z INFO: HOST=web01 request status=200"))

; Make branch 3 selected as well, causing UNSAT due to timestamp length mismatch in that branch
(assert T_SELECT_3)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

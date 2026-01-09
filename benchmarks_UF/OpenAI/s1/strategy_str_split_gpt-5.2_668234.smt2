(set-logic ALL)

; Uninterpreted interface for split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables preserved
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
(declare-fun T_a () Bool)
(declare-fun T_b () Bool)
(declare-fun var_0xINPUT_95026 () String)

; New variables for log analysis scenario
(declare-const ts String)
(declare-const level String)
(declare-const module String)
(declare-const message String)
(declare-const day String)
(declare-const time String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const rest_after_level String)
(declare-const rest_after_module String)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)
(declare-const is_info Bool)
(declare-const is_error Bool)
(declare-const sat_branch Bool)
(declare-const unsat_branch Bool)

; Core structure preserved but mutated: now checks log entry components rather than utm cookies
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_2 0))
    (= var_0xINPUT_95026 (str.++ T0_2 T1_2))
    (= I0_2 (str.len T4_2))
    (= 0 (str.len T0_2))
    (= T1_2 (str.++ T2_2 T3_2))
    (= T2_2 (str.++ T4_2 T5_2))
    (= T5_2 " ")
    ; T4_2 is the timestamp token, ensure it contains ':'
    (str.contains T4_2 ":")
    ; and is NOT a pure digit sequence (requires at least one non-digit like '-' or ':')
    (not (str.in_re T4_2 (re.+ (re.range "0" "9"))))
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= var_0xINPUT_95026 (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    (not (str.contains T1_2 ":"))
  )
))

(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= PCTEMP_LHS_2 (+ I0_4 0))
    (= var_0xINPUT_95026 (str.++ T0_4 T1_4))
    (= I0_4 (str.len T4_4))
    (= 0 (str.len T0_4))
    (= T1_4 (str.++ T2_4 T3_4))
    (= T2_4 (str.++ T4_4 T5_4))
    (= T5_4 ":")
    ; T4_4 is log level candidate; avoid whitespace and enforce uppercase word
    (not (str.contains T4_4 " "))
    (str.in_re T4_4 (re.+ (re.range "A" "Z")))
  )
  (and
    (= PCTEMP_LHS_2 (- 1))
    (= var_0xINPUT_95026 (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
    (not (str.contains T1_4 ":"))
  )
))

(assert (= T_SELECT_3 (not (= PCTEMP_LHS_3 (- 1)))))
(assert (ite T_SELECT_3
  (and
    (= PCTEMP_LHS_3 (+ I0_6 0))
    (= var_0xINPUT_95026 (str.++ T0_6 T1_6))
    (= I0_6 (str.len T4_6))
    (= 0 (str.len T0_6))
    (= T1_6 (str.++ T2_6 T3_6))
    (= T2_6 (str.++ T4_6 T5_6))
    (= T5_6 " ")
    ; T4_6 is module name candidate: enforce alphabetic and dot/underscore allowed
    (str.in_re T4_6 (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (str.to_re ".") (str.to_re "_"))))
  )
  (and
    (= PCTEMP_LHS_3 (- 1))
    (= var_0xINPUT_95026 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (= T1_6 "")
  )
))

; Keep seed-style global checks but adapt slightly
(assert (= T_4 (= "-" var_0xINPUT_95026)))
(assert (= T_5 (not T_4)))
(assert T_5)
(assert (= T_6 (= "" var_0xINPUT_95026)))
(assert (= T_7 (not T_6)))
(assert T_7)

; Mutate satisfiability conditions: require PCTEMP_LHS_1 and PCTEMP_LHS_3 valid, but allow PCTEMP_LHS_2 to be -1 (unknown level) in one branch
(assert (= T_8 (< (- 1) PCTEMP_LHS_1)))
(assert T_8)
(assert (= T_9 (< (- 1) PCTEMP_LHS_2)))
(assert (= T_a (not T_9)))
; T_a asserted as in seed (forces PCTEMP_LHS_2 = -1)
(assert T_a)
(assert (= T_b (< (- 1) PCTEMP_LHS_3)))
(assert T_b)

; --- Log Analysis modeling with str_split interface ---
; Expected log shape: "YYYY-MM-DD HH:MM:SS LEVEL: module message..."

; At least 4 space-separated segments: date, time, level:, rest
(assert (>= (num_splits var_0xINPUT_95026 " ") 4))
(assert (= day (split_at var_0xINPUT_95026 " " 0)))
(assert (= time (split_at var_0xINPUT_95026 " " 1)))
(assert (= level (split_at var_0xINPUT_95026 " " 2)))
(assert (= rest_after_level (split_rest var_0xINPUT_95026 " " 3)))

; Timestamp format checks
(assert (str.in_re day (re.++ (re.loop (re.range "0" "9") 4 4) (str.to_re "-") (re.loop (re.range "0" "9") 2 2) (str.to_re "-") (re.loop (re.range "0" "9") 2 2))))
(assert (str.in_re time (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re ":") (re.loop (re.range "0" "9") 2 2) (str.to_re ":") (re.loop (re.range "0" "9") 2 2))))

; Split time by ':' using interface
(assert (>= (num_splits time ":") 3))
(assert (= hour (split_at time ":" 0)))
(assert (= minute (split_at time ":" 1)))
(assert (= second (split_at time ":" 2)))
(assert (str.in_re hour (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re minute (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re second (re.loop (re.range "0" "9") 2 2)))

; Require level token ends with ':' and extract module/message by splitting rest_after_level
(assert (str.in_re level (re.++ (re.+ (re.range "A" "Z")) (str.to_re ":"))))
(assert (>= (num_splits rest_after_level " ") 2))
(assert (= module (split_at rest_after_level " " 0)))
(assert (= message (split_rest rest_after_level " " 1)))
(assert (> (str.len message) 0))

; Level extraction consistency with mutated seed: since PCTEMP_LHS_2 = -1, force level not to be INFO: or ERROR:
(assert (= is_info (= level "INFO:")))
(assert (= is_error (= level "ERROR:")))
(assert (not is_info))
(assert (not is_error))

; Introduce both SAT and UNSAT instances via branch flags
(assert (= sat_branch true))
(assert (= unsat_branch false))

; SAT branch: consistent constraints (e.g., module non-empty, message contains keyword)
(assert (=> sat_branch (and (> (str.len module) 0) (str.contains message "request"))))

; UNSAT branch (disabled): would force impossible timestamp and level simultaneously
(assert (=> unsat_branch (and (= time "99:99:99") (= level "INFO:"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
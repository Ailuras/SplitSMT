(set-logic ALL)

; Uninterpreted split interface for log parsing

; Seed variables preserved
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_193661 () String)

; Additional booleans for log-analysis checks
(declare-const T_ts_ok Bool)
(declare-const T_level_ok Bool)
(declare-const T_nonempty Bool)

; Parsed fields
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const level String)
(declare-const msg String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Basic non-empty input (core structure mutated but preserved)
(assert (= T_1 (= var_0xINPUT_193661 "")))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_nonempty T_2))

; Expect at least: "DATE TIME LEVEL: MESSAGE" separated by spaces and a colon after level
(assert (>= (str.num_splits var_0xINPUT_193661 " ") 4))

; Extract tokens
(assert (= ts_date (str.split_at var_0xINPUT_193661 " " 0)))
(assert (= ts_time (str.split_at var_0xINPUT_193661 " " 1)))
(assert (= level (str.split_at var_0xINPUT_193661 " " 2)))
(assert (= msg (str.split_rest var_0xINPUT_193661 " " 3)))

; LEVEL token should be like "INFO:" or "ERROR:" etc.
(assert (= T_level_ok (and (str.contains level ":") (= (str.len (str.split_at level ":" 0)) (- (str.len level) 1)))))

; Timestamp format validation (intentionally inconsistent to create UNSAT)
; Date must be exactly 10 chars: YYYY-MM-DD
(assert (= (str.len ts_date) 10))
(assert (= (str.at ts_date 4) "-"))
(assert (= (str.at ts_date 7) "-"))

; Time must be exactly 8 chars: HH:MM:SS
(assert (= (str.len ts_time) 8))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))

; Split time into components
(assert (= hour (str.split_at ts_time ":" 0)))
(assert (= minute (str.split_at ts_time ":" 1)))
(assert (= second (str.split_at ts_time ":" 2)))
(assert (= (str.num_splits ts_time ":") 3))

; Component lengths
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Contradictory constraints on hour to force UNSAT
(assert (= hour "12"))
(assert (not (= hour "12")))

; Timestamp ok flag (kept for structure, but irrelevant due to contradiction)
(assert (= T_ts_ok (and (= (str.len ts_date) 10) (= (str.len ts_time) 8))))

; Additional sanity: message non-empty
(assert (> (str.len msg) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

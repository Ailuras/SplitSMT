(set-logic ALL)

; Mutated/extended scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Preserve core structure booleans and the input string
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-const var_0xINPUT_124328 String)

; Additional booleans for log-specific checks
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)

; str_split interface (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core seed constraints (mutated: keep T_1/T_2 structure, but no longer force empty string)
(assert (= T_1 (= "-" var_0xINPUT_124328)))
(assert (= T_2 (not T_1)))
(assert T_2)

; In seed, T_3 forced empty input; mutate to "non-empty input" to enable log parsing
(assert (= T_3 (= "" var_0xINPUT_124328)))
(assert (not T_3))

; Log entry shape: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by spaces into at least 3 segments
(assert (>= (num_splits var_0xINPUT_124328 " ") 3))

(declare-const ts_date String)
(declare-const ts_time String)
(declare-const level_colon String)
(declare-const level String)
(declare-const msg_rest String)

(assert (= ts_date (split_at var_0xINPUT_124328 " " 0)))
(assert (= ts_time (split_at var_0xINPUT_124328 " " 1)))
(assert (= level_colon (split_at var_0xINPUT_124328 " " 2)))
(assert (= msg_rest (split_rest var_0xINPUT_124328 " " 3)))

; Timestamp format validation (approximate but concrete):
; Date must match 4 digits '-' 2 digits '-' 2 digits and length 10
(assert (= T_4 (= (str.len ts_date) 10)))
(assert T_4)
(assert (= T_5 (str.in_re ts_date (re.++ (re.loop (re.range "0" "9") 4 4)
                                           (str.to_re "-")
                                           (re.loop (re.range "0" "9") 2 2)
                                           (str.to_re "-")
                                           (re.loop (re.range "0" "9") 2 2)))))
(assert T_5)

; Time must match 2 digits ':' 2 digits ':' 2 digits and length 8
(assert (= T_6 (= (str.len ts_time) 8)))
(assert T_6)
(assert (= T_7 (str.in_re ts_time (re.++ (re.loop (re.range "0" "9") 2 2)
                                           (str.to_re ":")
                                           (re.loop (re.range "0" "9") 2 2)
                                           (str.to_re ":")
                                           (re.loop (re.range "0" "9") 2 2)))))
(assert T_7)

; Log level extraction: level_colon is like "INFO:"; split at ':' gives level in segment 0
(assert (>= (num_splits level_colon ":") 2))
(assert (= level (split_at level_colon ":" 0)))

; Level must be one of a known set
(assert (= T_8 (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))))
(assert T_8)

; Message should be non-empty and should not contain newline
(assert (= T_9 (and (> (str.len msg_rest) 0) (not (str.contains msg_rest "\n")))))
(assert T_9)

; Ensure input contains expected separators
(assert (str.contains var_0xINPUT_124328 " "))
(assert (str.contains var_0xINPUT_124328 ":"))

; Concrete satisfiable instance guidance (still symbolic, but pins a realistic shape)
(assert (str.prefixof (str.++ ts_date " " ts_time " ") var_0xINPUT_124328))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

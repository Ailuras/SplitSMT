(set-logic ALL)

; Uninterpreted interface for string split operations

; -----------------------------
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by space: [0]=date [1]=time [2]=LEVEL: [3..]=message parts
; Split by colon in the LEVEL field to extract level.
; -----------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_field String)
(declare-const message_tail String)
(declare-const level_str String)
(declare-const date_ok Bool)
(declare-const time_ok Bool)

; Basic segmentation by spaces
(assert (= date_str (str.split_at log_line " " 0)))
(assert (= time_str (str.split_at log_line " " 1)))
(assert (= level_field (str.split_at log_line " " 2)))
(assert (= message_tail (str.split_rest log_line " " 3)))
(assert (>= (str.num_splits log_line " ") 4))

; Level extraction: "LEVEL:"
(assert (= level_str (str.split_at level_field ":" 0)))
(assert (>= (str.num_splits level_field ":") 2))

; Timestamp format checks via regex
(assert (= date_ok (str.in_re date_str (re.++ (re.range "0" "9")
                                            (re.++ (re.range "0" "9")
                                                   (re.++ (re.range "0" "9")
                                                          (re.++ (re.range "0" "9")
                                                                 (re.++ (str.to_re "-")
                                                                        (re.++ (re.range "0" "9")
                                                                               (re.++ (re.range "0" "9")
                                                                                      (re.++ (str.to_re "-")
                                                                                             (re.++ (re.range "0" "9")
                                                                                                    (re.range "0" "9")))))))))))))

(assert (= time_ok (str.in_re time_str (re.++ (re.range "0" "9")
                                            (re.++ (re.range "0" "9")
                                                   (re.++ (str.to_re ":")
                                                          (re.++ (re.range "0" "9")
                                                                 (re.++ (re.range "0" "9")
                                                                        (re.++ (str.to_re ":")
                                                                               (re.++ (re.range "0" "9")
                                                                                      (re.range "0" "9")))))))))))

(assert date_ok)
(assert time_ok)

; Ensure log level is one of common levels
(assert (or (= level_str "INFO")
            (= level_str "WARN")
            (= level_str "ERROR")
            (= level_str "DEBUG")))

; Require message tail to be non-empty and contain a keyword
(assert (> (str.len message_tail) 0))
(assert (str.contains message_tail "request"))

; Concretize a satisfiable example
(assert (= log_line "2025-01-06 09:14:33 INFO: request completed"))

; -----------------------------
; Scenario: Log Analysis (UNSAT instance)
; Contradiction: same line but forced to have invalid date regex while also asserting it matches.
; -----------------------------
(declare-const log_line_bad String)
(declare-const date_bad String)
(declare-const time_bad String)
(declare-const level_field_bad String)
(declare-const level_bad String)

(assert (= date_bad (str.split_at log_line_bad " " 0)))
(assert (= time_bad (str.split_at log_line_bad " " 1)))
(assert (= level_field_bad (str.split_at log_line_bad " " 2)))
(assert (= level_bad (str.split_at level_field_bad ":" 0)))
(assert (>= (str.num_splits log_line_bad " ") 3))
(assert (>= (str.num_splits level_field_bad ":") 2))

; Force a specific bad log line
(assert (= log_line_bad "2025-13-99 25:61:61 ERROR: impossible timestamp"))

; Still (incorrectly) require strict timestamp shape AND also require a conflicting constraint on characters.
; This creates UNSAT by forcing date to match YYYY-MM-DD but also forcing a non-digit inside.
(assert (str.in_re date_bad (re.++ (re.range "0" "9")
                                 (re.++ (re.range "0" "9")
                                        (re.++ (re.range "0" "9")
                                               (re.++ (re.range "0" "9")
                                                      (re.++ (str.to_re "-")
                                                             (re.++ (re.range "0" "9")
                                                                    (re.++ (re.range "0" "9")
                                                                           (re.++ (str.to_re "-")
                                                                                  (re.++ (re.range "0" "9")
                                                                                         (re.range "0" "9"))))))))))))

; Contradiction: 5th character of date must be '-' due to regex, but we also force it to be 'X'
(assert (= (str.at date_bad 4) "X"))

; Also require a specific level, to keep it realistic
(assert (= level_bad "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

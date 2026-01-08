; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure preserved with added timestamp validation and log level extraction
(set-logic ALL)

; Original variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_80364 () String)

; New variables for log analysis
(declare-fun log_entry () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)
(declare-fun colon_count () Int)
(declare-fun space_count () Int)

; Interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Original constraints (modified for log context)
(assert (= T_1 (not (= "4PH2ujcENG" var_0xINPUT_80364))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_80364))))
(assert T_2)
(assert (= T_3 (= var_0xINPUT_80364 "[INFO] 2023-10-05T14:30:00: User login successful")))
(assert T_3)

; Log entry parsing constraints
(assert (= log_entry var_0xINPUT_80364))

; Extract log level (first segment before space)
(assert (= log_level (split_at log_entry " " 0)))
(assert (str.contains log_level "]"))
(assert (or (str.contains log_level "[INFO]") (str.contains log_level "[ERROR]") (str.contains log_level "[WARN]")))

; Extract timestamp (second segment before colon)
(assert (= timestamp (split_at (split_rest log_entry " " 1) ":" 0)))
(assert (= (str.len timestamp) 19)) ; ISO format length
(assert (str.contains timestamp "T"))
(assert (str.contains timestamp "-"))
(assert (str.contains timestamp ":"))

; Extract message (rest after timestamp)
(assert (= message (split_rest (split_rest log_entry " " 1) ":" 1)))
(assert (>= (str.len message) 5))

; Structural validation using split operations
(assert (= colon_count (num_splits log_entry ":")))
(assert (= space_count (num_splits log_entry " ")))
(assert (>= colon_count 3)) ; At least timestamp colons and message separator
(assert (>= space_count 2)) ; At least level-timestamp and timestamp-message separators

; Additional constraint: timestamp must start with year 2023 or 2024
(assert (or (str.prefixof "2023-" timestamp) (str.prefixof "2024-" timestamp)))

; Final consistency check
(assert (= log_entry (str.++ log_level " " timestamp ":" message)))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)

(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; Scenario: Log Analysis
; =====================

; A single structured server log entry, fields separated by spaces:
;   "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(declare-const log_line String)

; Space-separated fields
(declare-const field0 String) ; date
(declare-const field1 String) ; time
(declare-const field2 String) ; level_with_colon
(declare-const message_rest String)

; Colon-separated extraction from the LEVEL: prefix
(declare-const level String)
(declare-const after_level String)

; Additional checks / diversity variables
(declare-const another_line String)
(declare-const another_level_with_colon String)
(declare-const another_level String)

; =====================
; Split structure constraints
; =====================

; Indices are natural
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

; Require at least 4 space-separated segments: date, time, level:, message...
(assert (>= (num_splits log_line " ") 4))
(assert (= field0 (split_at log_line " " 0)))
(assert (= field1 (split_at log_line " " 1)))
(assert (= field2 (split_at log_line " " 2)))
(assert (= message_rest (split_rest log_line " " 3)))

; LEVEL parsing: split "LEVEL:" by ":" -> level and remainder
(assert (>= (num_splits field2 ":") 2))
(assert (= level (split_at field2 ":" 0)))
(assert (= after_level (split_rest field2 ":" 1)))

; after_level should be empty (i.e., field2 is exactly "LEVEL:")
(assert (= after_level ""))

; =====================
; Timestamp format validation via regex
; =====================

; Date: YYYY-MM-DD
(assert (str.in_re field0 (re.++ (re.loop (str.to_re "0") 4 4) (str.to_re "-") (re.loop (str.to_re "0") 2 2) (str.to_re "-") (re.loop (str.to_re "0") 2 2))))
; The above is a relaxed pattern using only '0'. Add stronger digit class using union.
(declare-const digit_re RegLan)
(assert (= digit_re (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9"))))))))))))
(assert (str.in_re field0 (re.++ (re.loop digit_re 4 4) (str.to_re "-") (re.loop digit_re 2 2) (str.to_re "-") (re.loop digit_re 2 2))))

; Time: HH:MM:SS (basic digit-based validation)
(assert (str.in_re field1 (re.++ (re.loop digit_re 2 2) (str.to_re ":") (re.loop digit_re 2 2) (str.to_re ":") (re.loop digit_re 2 2))))

; =====================
; Log level extraction and validation
; =====================

; Level must be one of a known set
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message should be non-empty and should not contain a newline
(assert (> (str.len message_rest) 0))
(assert (not (str.contains message_rest "\n")))

; The original line should contain the separator between date and time
(assert (str.contains log_line " "))

; =====================
; SAT instance (consistent constraints)
; =====================

; Force a concrete satisfying shape for log_line while still using split interface
(assert (= field0 "2025-01-09"))
(assert (= field1 "12:34:56"))
(assert (= level "INFO"))
(assert (= field2 "INFO:"))
(assert (= message_rest "service started"))

; =====================
; UNSAT instance (intentional contradiction)
; =====================

; Another line: require it to be parseable and level extracted similarly
(assert (>= (num_splits another_line " ") 3))
(assert (= another_level_with_colon (split_at another_line " " 2)))
(assert (>= (num_splits another_level_with_colon ":") 2))
(assert (= another_level (split_at another_level_with_colon ":" 0)))

; Contradiction: level must be ERROR and INFO at the same time
(assert (= another_level "ERROR"))
(assert (= another_level "INFO"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_segments Int)
(declare-const space_segments Int)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Log entry must contain at least 3 colon-separated segments (timestamp:level:message...)
(assert (>= (num_splits log_entry ":") 3))

; Constraint 2: Extract timestamp as first colon-separated segment
(assert (= timestamp (split_at log_entry ":" 0)))

; Constraint 3: Timestamp must match format HH:MM:SS (8 characters with colons)
(assert (= (str.len timestamp) 8))
(assert (str.in_re timestamp (re.++ (re.range "0" "2") (re.range "0" "9") (str.to_re ":") (re.range "0" "5") (re.range "0" "9") (str.to_re ":") (re.range "0" "5") (re.range "0" "9"))))

; Constraint 4: Extract log level as second colon-separated segment
(assert (= log_level (split_at log_entry ":" 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 6: Extract message as everything after the second colon
(assert (= message (split_rest log_entry ":" 2)))

; Constraint 7: Message must contain at least 2 space-separated words
(assert (>= (num_splits message " ") 2))

; Constraint 8: First word of message must be alphabetic only
(assert (str.in_re (split_at message " " 0) (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Constraint 9: Log entry length constraints
(assert (>= (str.len log_entry) 20))
(assert (<= (str.len log_entry) 200))

; Constraint 10: Additional consistency check - timestamp hour must be valid (00-23)
(assert (<= (str.to_int (str.substr timestamp 0 2)) 23))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)

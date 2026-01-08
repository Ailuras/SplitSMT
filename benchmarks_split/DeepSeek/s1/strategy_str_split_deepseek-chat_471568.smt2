; Log Analysis: Parsing structured server log entries with spaces and colons, validating timestamp format and extracting log level.
; Using str_split interface for segmentation.
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const delimiter String)

; Define str_split interface functions as per the methodology
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Set delimiter to space for splitting log entry into parts
(assert (= delimiter " "))

; Constraint 1: Log entry must have at least 3 parts (timestamp, log_level, message)
(assert (>= (num_splits log_entry delimiter) 3))

; Constraint 2: Extract timestamp as the first segment
(assert (= timestamp (split_at log_entry delimiter 0)))

; Constraint 3: Extract log_level as the second segment
(assert (= log_level (split_at log_entry delimiter 1)))

; Constraint 4: Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (split_rest log_entry delimiter 2)))

; Constraint 5: Timestamp format validation: must be of length 19 and contain colons and hyphens in specific positions
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Constraint 6: Log level must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 7: Message must not be empty
(assert (> (str.len message) 0))

; Constraint 8: Additional check to ensure log entry has exactly 3 parts for simplicity (can be SAT or UNSAT based on instance)
; This makes the instance UNSAT if log entry has more than 3 parts, but we keep it as a potential constraint for diversity.
; Commenting out to allow SAT instances; uncomment for UNSAT.
; (assert (= (num_splits log_entry delimiter) 3))

; Constraint 9: Ensure timestamp characters are digits or separators as per format
; For example, positions 0-3, 5-6, 8-9, 11-12, 14-15, 17-18 must be digits
; Using regex-like constraints with str.contains and str.at for simplicity
(assert (and
  (>= (str.to_int (str.at timestamp 0)) 48) (<= (str.to_int (str.at timestamp 0)) 57)
  (>= (str.to_int (str.at timestamp 1)) 48) (<= (str.to_int (str.at timestamp 1)) 57)
  (>= (str.to_int (str.at timestamp 2)) 48) (<= (str.to_int (str.at timestamp 2)) 57)
  (>= (str.to_int (str.at timestamp 3)) 48) (<= (str.to_int (str.at timestamp 3)) 57)
  (>= (str.to_int (str.at timestamp 5)) 48) (<= (str.to_int (str.at timestamp 5)) 57)
  (>= (str.to_int (str.at timestamp 6)) 48) (<= (str.to_int (str.at timestamp 6)) 57)
  (>= (str.to_int (str.at timestamp 8)) 48) (<= (str.to_int (str.at timestamp 8)) 57)
  (>= (str.to_int (str.at timestamp 9)) 48) (<= (str.to_int (str.at timestamp 9)) 57)
  (>= (str.to_int (str.at timestamp 11)) 48) (<= (str.to_int (str.at timestamp 11)) 57)
  (>= (str.to_int (str.at timestamp 12)) 48) (<= (str.to_int (str.at timestamp 12)) 57)
  (>= (str.to_int (str.at timestamp 14)) 48) (<= (str.to_int (str.at timestamp 14)) 57)
  (>= (str.to_int (str.at timestamp 15)) 48) (<= (str.to_int (str.at timestamp 15)) 57)
  (>= (str.to_int (str.at timestamp 17)) 48) (<= (str.to_int (str.at timestamp 17)) 57)
  (>= (str.to_int (str.at timestamp 18)) 48) (<= (str.to_int (str.at timestamp 18)) 57)
))

; Check satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message))

; [GENERATION STATUS: SUCCESS]
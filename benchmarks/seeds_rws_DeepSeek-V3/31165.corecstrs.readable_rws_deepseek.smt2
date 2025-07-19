; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
(set-logic QF_S)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.contains (String String) Bool)
(declare-fun str.prefixof (String String) Bool)
(declare-fun str.suffixof (String String) Bool)
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; ; Example log format: [2023-01-15 14:30:45] INFO: User login successful | ip=192.168.1.1
(declare-const log_entry String)
(assert (= log_entry "[2023-01-15 14:30:45] INFO: User login successful | ip=192.168.1.1"))

; ; 1. Timestamp extraction and validation
(declare-const timestamp String)
(assert (= timestamp (str.split_at (str.split_at log_entry "[" 1) "]" 0)))

; ; Validate timestamp format YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.split_at timestamp "-" 0) "2023"))
(assert (= (str.split_at (str.split_at timestamp "-" 1) "-" 0) "01"))
(assert (= (str.split_at (str.split_at timestamp "-" 1) "-" 1) "15 14:30:45"))
(assert (= (str.split_at (str.split_at timestamp " " 1) ":" 0) "14"))
(assert (= (str.split_at (str.split_at timestamp " " 1) ":" 1) "30:45"))

; 2. Log level validation (must be one of: DEBUG, INFO, WARN, ERROR)
(declare-const log_level String)
(assert (= log_level (str.split_at (str.split_at log_entry "]" 1) ":" 0)))
(assert (or (= log_level " DEBUG")
 (= log_level " INFO")
 (= log_level " WARN")
 (= log_level " ERROR")))

; ; 3. Message extraction (everything after log level)
(declare-const message String)
(assert (= message (str.split_rest (str.split_at log_entry "]" 1) ":" 1)))

; Additional constraints for message content
(assert (str.contains message "successful"))
(assert (str.contains message "ip="))
(assert (not (str.contains message "failure")))

; Negative test case (should be unsat)
(push)
(assert (str.contains log_level " CRITICAL"))
(check-sat)
(pop)

; Positive test case (should be sat)
(assert (str.contains log_level " INFO"))
(check-sat)
(get-model)
(exit)
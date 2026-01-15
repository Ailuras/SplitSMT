; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure: Validate timestamp format and extract log level using str_split operations
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_count Int)
(declare-const space_count Int)

; Define str_split interface operations for splitting by delimiter

; Constraint 1: Log entry must contain at least one colon and one space
(assert (str.contains log_entry ":"))
(assert (str.contains log_entry " "))

; Constraint 2: Extract timestamp as first segment when splitting by space
; Timestamp is assumed to be at the beginning of the log entry
(assert (= timestamp (split_at log_entry " " 0)))

; Constraint 3: Timestamp must have format HH:MM:SS (8 characters with colons)
(assert (= (str.len timestamp) 8))
(assert (str.contains timestamp ":"))
; Ensure exactly two colons in timestamp
(assert (= (num_splits timestamp ":") 3))
; Validate colon positions at indices 2 and 5 (0-based)
(assert (= (str.at timestamp 2) ":"))
(assert (= (str.at timestamp 5) ":"))
; Ensure other characters are digits (simplified check: not colons)
(assert (not (= (str.at timestamp 0) ":")))
(assert (not (= (str.at timestamp 1) ":")))
(assert (not (= (str.at timestamp 3) ":")))
(assert (not (= (str.at timestamp 4) ":")))
(assert (not (= (str.at timestamp 6) ":")))
(assert (not (= (str.at timestamp 7) ":")))

; Constraint 4: Extract log level as second segment when splitting by space
; Log level is after timestamp, separated by a space
(assert (= log_level (split_at log_entry " " 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 6: Message is the rest of the log after the first two segments (timestamp and log level)
(assert (= message (split_rest log_entry " " 2)))

; Constraint 7: Message must not be empty and should contain at least one colon for key-value pairs
(assert (not (= message "")))
(assert (str.contains message ":"))

; Constraint 8: Count colons and spaces in the entire log entry for additional validation
(assert (= colon_count (num_splits log_entry ":")))
(assert (= space_count (num_splits log_entry " ")))
; Ensure at least 3 colons (two in timestamp, one in message) and at least 2 spaces
(assert (>= colon_count 3))
(assert (>= space_count 2))

; Constraint 9: Specific example to create a SAT instance
; This forces a particular valid log entry structure
(assert (str.contains log_entry "12:34:56 INFO user:login"))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

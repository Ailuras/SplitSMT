; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
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

; Declare string variables for log components
(declare-fun log_entry () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)
(declare-fun source () String)
(declare-fun pid () String)

; Declare integer variables for validation
(declare-fun timestamp_len () Int)
(declare-fun colon_count () Int)
(declare-fun space_count () Int)

; Declare boolean variables for constraints
(declare-fun valid_timestamp_format () Bool)
(declare-fun valid_log_level () Bool)
(declare-fun has_pid () Bool)

; Core log parsing using str_split operations
(assert (= timestamp (split_at log_entry " " 0))) ; First segment is timestamp
(assert (= log_level (split_at log_entry " " 1))) ; Second segment is log level
(assert (= source (split_at log_entry " " 2))) ; Third segment is source
(assert (= message (split_rest log_entry " " 3))) ; Remaining segments form message

; Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= timestamp_len (str.len timestamp)))
(assert (>= timestamp_len 19)) ; Minimum length for full timestamp
(assert (str.contains timestamp "-")) ; Must contain hyphens for date
(assert (str.contains timestamp ":")) ; Must contain colons for time
(assert (= (str.at timestamp 4) "-")) ; Position 4 should be hyphen
(assert (= (str.at timestamp 7) "-")) ; Position 7 should be hyphen
(assert (= (str.at timestamp 13) ":")) ; Position 13 should be colon
(assert (= (str.at timestamp 16) ":")) ; Position 16 should be colon

; Count colons in timestamp for validation
(assert (= colon_count (+ (ite (str.contains timestamp ":") 1 0) (ite (str.contains (str.substr timestamp 14 5) ":") 1 0))))
(assert (>= colon_count 2)) ; At least two colons in time portion

; Validate log level (must be one of standard levels)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG") (= log_level "FATAL")))

; Check if message contains PID information
(assert (str.contains message "PID:"))
(assert (= pid (split_at message ":" 1))) ; Extract PID after "PID:"
(assert (>= (str.len pid) 1)) ; PID must have at least one character

; Additional constraints for realistic log analysis
(assert (>= (num_splits log_entry " ") 4)) ; Must have at least 4 space-separated segments
(assert (>= (str.len message) 10)) ; Message must be meaningful length
(assert (not (str.contains timestamp ".."))) ; No double dots in timestamp
(assert (not (str.contains log_level " "))) ; Log level cannot contain spaces

; Create both SAT and UNSAT possibilities with branching condition
(declare-fun test_case () Bool)
(assert (or test_case (not test_case))) ; This is always true, but allows branching

; SAT case: Valid log entry
(assert (=> test_case
    (and
        (= log_entry "2023-10-15 14:30:45 INFO server.main PID:12345 User login successful")
        (= (num_splits log_entry " ") 7)
        (= (str.len timestamp) 19)
        (= log_level "INFO")
        (str.contains message "login")
    )
))

; UNSAT case: Invalid timestamp format
(assert (=> (not test_case)
    (and
        (= log_entry "2023/10/15 14:30:45 WARN auth.service PID:67890 Invalid credentials")
        (= (str.at timestamp 4) "/") ; Wrong separator, should be hyphen
        (= log_level "WARN")
        (str.contains message "credentials")
    )
))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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
; Log Analysis: Parsing structured server log entries with spaces and colons, focusing on timestamp format and log level extraction.
; Declare variables for log entry and its components.
(declare-fun log_entry () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)
; Declare interface functions for string splitting.
; Assert that the log entry contains at least three segments when split by spaces.
(assert (>= (num_splits log_entry " ") 3))
; Extract timestamp as the first segment after splitting by space.
(assert (= timestamp (split_at log_entry " " 0)))
; Extract log level as the second segment after splitting by space.
(assert (= log_level (split_at log_entry " " 1)))
; Extract message as the concatenation of all segments from index 2 onwards.
(assert (= message (split_rest log_entry " " 2)))
; Validate timestamp format: should be of the form "HH:MM:SS" with exactly two colons.
(assert (= (num_splits timestamp ":") 3))
(assert (= (str.len (split_at timestamp ":" 0)) 2))
(assert (= (str.len (split_at timestamp ":" 1)) 2))
(assert (= (str.len (split_at timestamp ":" 2)) 2))
; Validate log level: must be one of "INFO", "WARN", "ERROR", or "DEBUG".
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))
; Additional constraint: message must not be empty.
(assert (not (= (str.len message) 0)))
; Ensure the log entry does not contain invalid characters like commas or semicolons in the timestamp.
(assert (not (str.contains timestamp ",")))
(assert (not (str.contains timestamp ";")))
; Check for a specific pattern in the message: it should contain at least one word separated by spaces.
(assert (>= (num_splits message " ") 1))
; Final check: the entire log entry must be non-empty.
(assert (not (= (str.len log_entry) 0)))

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

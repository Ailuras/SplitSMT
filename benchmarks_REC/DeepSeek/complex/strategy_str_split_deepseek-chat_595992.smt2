; Log Analysis Scenario: Parsing structured server log entries
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

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare uninterpreted functions for str_split interface

; Assert that log entry has at least 4 space-separated segments (timestamp, level, source, message)
(assert (>= (num_splits log_entry " ") 4))

; Extract timestamp as first segment (index 0) when splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log level as second segment (index 1) when splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Extract source as third segment (index 2) when splitting by space
(assert (= source (split_at log_entry " " 2)))

; Extract message as the rest starting from index 3 when splitting by space
(assert (= message (split_rest log_entry " " 3)))

; Validate timestamp format: should contain colon ':' and have at least 2 colon-separated parts (e.g., HH:MM:SS)
(assert (>= (num_splits timestamp ":") 2))

; Additional constraint: timestamp must have exactly 3 colon-separated segments for HH:MM:SS format
(assert (= (num_splits timestamp ":") 3))

; Validate log level: must be one of "INFO", "WARN", "ERROR", or "DEBUG"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Complex pattern: Ensure message does not contain the word "FAILURE" if log level is "INFO"
(assert (=> (= log_level "INFO") (not (str.contains message "FAILURE"))))

; Another constraint: Source must contain at least one dot '.' (e.g., "server.api")
(assert (str.contains source "."))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

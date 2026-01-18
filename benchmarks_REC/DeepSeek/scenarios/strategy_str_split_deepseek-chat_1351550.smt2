; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
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

; Declare string variables for log entries and components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)
(declare-const raw_log String)

; Declare split functions for parsing

; Core constraint: Parse log entry with format "TIMESTAMP LEVEL: MESSAGE [SOURCE]"
; First split by space to separate timestamp and rest
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= (split_rest log_entry " " 0) (str.++ log_level ":" message " [" source "]")))

; Validate timestamp format: YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Extract log level by splitting the rest after timestamp by colon
(assert (= log_level (split_at (split_rest log_entry " " 1) ":" 0)))

; Validate log level is one of standard values
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Extract message by taking segment after log level colon
(assert (= message (split_at (split_rest (split_rest log_entry " " 1) ":" 1) " [" 0)))

; Extract source from brackets
(assert (= source (split_at (split_rest (split_rest log_entry " " 1) ":" 1) " [" 1)))
(assert (str.contains source "]"))
(assert (= (str.at source (- (str.len source) 1)) "]"))

; Additional constraint: Ensure log entry has proper structure with at least 3 space-separated parts
(assert (>= (num_splits log_entry " ") 3))

; Example log entry for SAT instance
(assert (= log_entry "2023-10-05 14:30:22 ERROR: Database connection failed [server-db-01]"))

; Additional constraints for complexity
; Constraint 1: Message must not be empty
(assert (> (str.len message) 0))

; Constraint 2: Source must contain hyphen
(assert (str.contains source "-"))

; Constraint 3: Timestamp year must be reasonable (2000-2099)
(assert (str.prefixof "20" (str.substr timestamp 0 2)))

; Constraint 4: Log level extraction consistency check
(assert (= (num_splits (str.++ log_level ":" message " [" source "]") ":") 2))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

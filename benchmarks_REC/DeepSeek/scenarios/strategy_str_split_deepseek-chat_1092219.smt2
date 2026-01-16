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
(declare-fun delimiter_space () String)
(declare-fun delimiter_colon () String)

; Declare integer variables for validation
(declare-fun year () Int)
(declare-fun month () Int)
(declare-fun day () Int)
(declare-fun hour () Int)
(declare-fun minute () Int)
(declare-fun second () Int)

; Declare boolean variables for checks
(declare-fun valid_timestamp_format () Bool)
(declare-fun valid_log_level () Bool)
(declare-fun overall_valid () Bool)

; Define delimiters
(assert (= delimiter_space " "))
(assert (= delimiter_colon ":"))

; Define split operations for log parsing

; Core log parsing constraints
(assert (= timestamp (split_at log_entry delimiter_space 0)))
(assert (= log_level (split_at log_entry delimiter_space 1)))
(assert (= message (split_rest log_entry delimiter_space 2)))
(assert (>= (num_splits log_entry delimiter_space) 3))

; Timestamp format validation: YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Extract timestamp components
(assert (= year (str.to_int (str.substr timestamp 0 4))))
(assert (= month (str.to_int (str.substr timestamp 5 2))))
(assert (= day (str.to_int (str.substr timestamp 8 2))))
(assert (= hour (str.to_int (str.substr timestamp 11 2))))
(assert (= minute (str.to_int (str.substr timestamp 14 2))))
(assert (= second (str.to_int (str.substr timestamp 17 2))))

; Validate timestamp ranges
(assert (and (>= year 2000) (<= year 2100)))
(assert (and (>= month 1) (<= month 12)))
(assert (and (>= day 1) (<= day 31)))
(assert (and (>= hour 0) (<= hour 23)))
(assert (and (>= minute 0) (<= minute 59)))
(assert (and (>= second 0) (<= second 59)))

; Combine timestamp validations
(assert (= valid_timestamp_format
    (and
        (= (str.len timestamp) 19)
        (= (str.at timestamp 4) "-")
        (= (str.at timestamp 7) "-")
        (= (str.at timestamp 10) " ")
        (= (str.at timestamp 13) ":")
        (= (str.at timestamp 16) ":")
        (>= year 2000) (<= year 2100)
        (>= month 1) (<= month 12)
        (>= day 1) (<= day 31)
        (>= hour 0) (<= hour 23)
        (>= minute 0) (<= minute 59)
        (>= second 0) (<= second 59)
    )
))

; Log level validation: Must be one of INFO, WARN, ERROR, DEBUG
(assert (= valid_log_level
    (or
        (= log_level "INFO")
        (= log_level "WARN")
        (= log_level "ERROR")
        (= log_level "DEBUG")
    )
))

; Message must not be empty
(assert (not (= message "")))

; Overall validation
(assert (= overall_valid (and valid_timestamp_format valid_log_level)))

; Create a SAT instance with specific constraints
(assert (= log_entry "2023-12-25 14:30:45 INFO User login successful"))
(assert overall_valid)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

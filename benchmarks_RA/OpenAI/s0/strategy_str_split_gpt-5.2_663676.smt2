(set-logic ALL)

; Uninterpreted interface functions for str_split
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

; -----------------------
; Log Analysis scenario
; Parsing structured server log entries separated by spaces and colons.
; Expected shape (typical): "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -----------------------

; Main (intended SAT) instance
(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_and_rest String)
(declare-const level_token String)
(declare-const message String)

; Auxiliary pieces
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const mi String)
(declare-const ss String)

; Split by spaces: [0]=date [1]=time [2]=LEVEL: [3..]=rest
(assert (>= (num_splits log_line " ") 4))
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= level_and_rest (split_rest log_line " " 2)))

; level_and_rest begins with token ending in ':' and then a space and message
(assert (>= (num_splits level_and_rest " ") 2))
(assert (= level_token (split_at level_and_rest " " 0)))
(assert (= message (split_rest level_and_rest " " 1)))

; Split log level token by ':' => [0]=LEVEL [1]=empty suffix or extra
(assert (>= (num_splits level_token ":") 2))
(assert (= (split_at level_token ":" 0) (split_at level_token ":" 0)))
(assert (= "" (split_at level_token ":" 1)))

; Level must be one of typical levels
(assert (or (= (split_at level_token ":" 0) "INFO")
            (= (split_at level_token ":" 0) "WARN")
            (= (split_at level_token ":" 0) "ERROR")
            (= (split_at level_token ":" 0) "DEBUG")))

; Timestamp format validation
; Date: YYYY-MM-DD
(assert (>= (num_splits date_part "-") 3))
(assert (= yyyy (split_at date_part "-" 0)))
(assert (= mm   (split_at date_part "-" 1)))
(assert (= dd   (split_at date_part "-" 2)))
(assert (= (str.len yyyy) 4))
(assert (= (str.len mm) 2))
(assert (= (str.len dd) 2))
(assert (str.in_re yyyy (re.+ (re.range "0" "9"))))
(assert (str.in_re mm   (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re dd   (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Time: HH:MM:SS
(assert (>= (num_splits time_part ":") 3))
(assert (= hh (split_at time_part ":" 0)))
(assert (= mi (split_at time_part ":" 1)))
(assert (= ss (split_at time_part ":" 2)))
(assert (= (str.len hh) 2))
(assert (= (str.len mi) 2))
(assert (= (str.len ss) 2))
(assert (str.in_re hh (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re mi (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Message should be non-empty and contain a colon-separated key:value somewhere (common in structured logs)
(assert (> (str.len message) 0))
(assert (str.contains message ":"))

; Provide a concrete witness (helps SAT and keeps constraints meaningful)
(assert (= log_line "2025-07-19 14:05:33 INFO: user_id:42 action:login"))

; -----------------------
; Additional (intended UNSAT) instance to ensure diversity
; Contradictory requirements on extracted level and timestamp parts.
; -----------------------

(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_and_rest String)
(declare-const bad_level_token String)
(declare-const bad_level String)
(declare-const bad_yyyy String)

(assert (>= (num_splits bad_log_line " ") 3))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_level_and_rest (split_rest bad_log_line " " 2)))
(assert (= bad_level_token (split_at bad_level_and_rest " " 0)))
(assert (>= (num_splits bad_level_token ":") 2))
(assert (= bad_level (split_at bad_level_token ":" 0)))

; Force the log line to be a specific one with INFO
(assert (= bad_log_line "2025-01-01 00:00:00 INFO: x:y"))

; Contradiction: extracted level must be both INFO and ERROR
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Extra timestamp contradiction: year must be 4 digits, but also explicitly set to length 3
(assert (>= (num_splits bad_date "-") 3))
(assert (= bad_yyyy (split_at bad_date "-" 0)))
(assert (= (str.len bad_yyyy) 4))
(assert (= (str.len bad_yyyy) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

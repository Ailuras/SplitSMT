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

; Uninterpreted interface operations for string splitting

; Scenario: Log Analysis
; Expected rough structure (space-separated):
;   "YYYY-MM-DD HH:MM:SS:ms LEVEL: message..."
; Where LEVEL is one of INFO|WARN|ERROR and is followed by ':'

; ----------------------
; SAT instance variables
; ----------------------
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time_ms String)
(declare-const level_colon String)
(declare-const level String)
(declare-const message String)

; Basic tokenization by spaces
(assert (>= (num_splits log_line " ") 4))
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time_ms (split_at log_line " " 1)))
(assert (= level_colon (split_at log_line " " 2)))
(assert (= message (split_rest log_line " " 3)))

; Timestamp date format: YYYY-MM-DD
(assert (str.in_re ts_date (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "-")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "-")
                                 (re.range "0" "9") (re.range "0" "9"))))

; Time+ms format: HH:MM:SS:ms (ms exactly 3 digits)
(assert (str.in_re ts_time_ms (re.++ (re.range "0" "9") (re.range "0" "9")
                                    (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9")
                                    (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9")
                                    (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9") (re.range "0" "9"))))

; Extract LEVEL by splitting token "LEVEL:" on ':'
(assert (>= (num_splits level_colon ":") 2))
(assert (= level (split_at level_colon ":" 0)))

; Constrain log level values
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR")))

; Message sanity checks
(assert (>= (str.len message) 1))
(assert (not (str.contains message "\n")))

; Ensure the separator between level and message is a space in the original
; i.e., token 2 is level_colon and token 3 begins message; already enforced by split_rest

; Add a concrete satisfying example to ground the SAT portion
(assert (= log_line "2025-12-31 23:59:59:123 ERROR: disk full on /dev/sda1"))

; ------------------------
; UNSAT instance variables
; ------------------------
; Separate set of variables to create a clearly contradictory log constraint set
(declare-const bad_log_line String)
(declare-const bad_ts_date String)
(declare-const bad_ts_time_ms String)
(declare-const bad_level_colon String)
(declare-const bad_level String)

; Tokenization
(assert (>= (num_splits bad_log_line " ") 3))
(assert (= bad_ts_date (split_at bad_log_line " " 0)))
(assert (= bad_ts_time_ms (split_at bad_log_line " " 1)))
(assert (= bad_level_colon (split_at bad_log_line " " 2)))

; Bad timestamp constraints: require both correct date format and an impossible length
(assert (str.in_re bad_ts_date (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")
                                     (str.to_re "-")
                                     (re.range "0" "9") (re.range "0" "9")
                                     (str.to_re "-")
                                     (re.range "0" "9") (re.range "0" "9"))))
(assert (= (str.len bad_ts_date) 9))

; Level extraction, then contradictory constraints on the extracted level
(assert (>= (num_splits bad_level_colon ":") 2))
(assert (= bad_level (split_at bad_level_colon ":" 0)))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Ground the bad log line as well (still UNSAT due to contradictions above)
(assert (= bad_log_line "2026-01-01 00:00:00:000 INFO: boot"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted interface for string split operations
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

; ------------------------
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by spaces to get timestamp date/time and the LEVEL:token
; Then split by ':' to extract LEVEL
; ------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_token String)
(declare-const level_str String)
(declare-const msg_str String)

; Basic splitting structure
(assert (>= (num_splits log_line " ") 4))
(assert (= date_str (split_at log_line " " 0)))
(assert (= time_str (split_at log_line " " 1)))
(assert (= level_token (split_at log_line " " 2)))
(assert (= msg_str (split_rest log_line " " 3)))

; Timestamp validation via regex
(assert (str.in_re date_str (str.to_re "2026-01-09")))
(assert (str.in_re time_str (str.to_re "12:34:56")))

; Level extraction and validation
(assert (>= (num_splits level_token ":") 2))
(assert (= level_str (split_at level_token ":" 0)))
(assert (str.in_re level_str (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (str.to_re "ERROR")))))

; Message sanity checks
(assert (>= (str.len msg_str) 1))
(assert (str.contains msg_str "request"))

; Constrain the full line to match intended structure using concatenation
(assert (= log_line (str.++ date_str " " time_str " " level_token " " msg_str)))

; Additional simple consistency checks
(assert (not (str.contains level_str " ")))
(assert (not (str.contains date_str " ")))
(assert (not (str.contains time_str " ")))

; ------------------------
; Scenario: Log Analysis (UNSAT instance)
; Same general structure, but contradictory timestamp and level constraints.
; ------------------------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_token String)
(declare-const bad_level String)

(assert (>= (num_splits bad_log_line " ") 3))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_level_token (split_at bad_log_line " " 2)))

; Require a strict date pattern (fixed here) but also contradict it
(assert (str.in_re bad_date (str.to_re "2026-01-09")))
(assert (str.in_re bad_date (str.to_re "2026-02-30")))

; Require time to be two different fixed values simultaneously
(assert (str.in_re bad_time (str.to_re "00:00:00")))
(assert (str.in_re bad_time (str.to_re "23:59:59")))

; Level token must split and yield a known level, but also contradict it
(assert (>= (num_splits bad_level_token ":") 2))
(assert (= bad_level (split_at bad_level_token ":" 0)))
(assert (str.in_re bad_level (re.union (str.to_re "INFO") (str.to_re "ERROR"))))
(assert (str.in_re bad_level (str.to_re "DEBUG")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

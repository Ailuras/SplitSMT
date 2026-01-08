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

; Uninterpreted interface for split operations

; -----------------------------
; SAT instance: well-formed log line
; Format target (informal): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; -----------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_colon String)
(declare-const level_str String)
(declare-const msg_str String)
(declare-const year_str String)
(declare-const mon_str String)
(declare-const day_str String)
(declare-const hour_str String)
(declare-const min_str String)
(declare-const sec_str String)

; Space-separated tokens: date, time, level:, rest-of-message
(assert (>= (num_splits log_line " ") 4))
(assert (= date_str (split_at log_line " " 0)))
(assert (= time_str (split_at log_line " " 1)))
(assert (= level_colon (split_at log_line " " 2)))
(assert (= msg_str (split_rest log_line " " 3)))

; Timestamp date format checks: YYYY-MM-DD
(assert (= 10 (str.len date_str)))
(assert (= year_str (str.substr date_str 0 4)))
(assert (= "-" (str.substr date_str 4 1)))
(assert (= mon_str (str.substr date_str 5 2)))
(assert (= "-" (str.substr date_str 7 1)))
(assert (= day_str (str.substr date_str 8 2)))
(assert (str.in_re year_str (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon_str (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_str (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Timestamp time format checks: HH:MM:SS
(assert (= 8 (str.len time_str)))
(assert (= hour_str (str.substr time_str 0 2)))
(assert (= ":" (str.substr time_str 2 1)))
(assert (= min_str (str.substr time_str 3 2)))
(assert (= ":" (str.substr time_str 5 1)))
(assert (= sec_str (str.substr time_str 6 2)))
(assert (str.in_re hour_str (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_str (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_str (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Extract log level from the token like "INFO:" or "ERROR:" etc.
(assert (>= (num_splits level_colon ":") 2))
(assert (= level_str (split_at level_colon ":" 0)))
(assert (or (= level_str "INFO") (= level_str "WARN") (= level_str "ERROR") (= level_str "DEBUG")))

; Message checks
(assert (>= (str.len msg_str) 1))
(assert (not (str.contains msg_str "\n")))

; Concrete satisfiable witness-like constraints (keep still flexible)
(assert (str.prefixof "202" year_str))
(assert (str.prefixof "0" mon_str))
(assert (str.prefixof "0" day_str))
(assert (str.prefixof "1" hour_str))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory constraints on a second log line
; Intended contradiction: enforce both correct time separator ':' at pos 2
; and also '-' at pos 2.
; -----------------------------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_colon String)
(declare-const bad_level String)
(declare-const bad_msg String)

(assert (>= (num_splits bad_log_line " ") 4))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_level_colon (split_at bad_log_line " " 2)))
(assert (= bad_msg (split_rest bad_log_line " " 3)))

(assert (= 8 (str.len bad_time)))
(assert (= ":" (str.substr bad_time 2 1)))
(assert (= "-" (str.substr bad_time 2 1)))

; Also constrain level extraction to look realistic (doesn't fix contradiction)
(assert (>= (num_splits bad_level_colon ":") 2))
(assert (= bad_level (split_at bad_level_colon ":" 0)))
(assert (or (= bad_level "INFO") (= bad_level "WARN") (= bad_level "ERROR") (= bad_level "DEBUG")))
(assert (>= (str.len bad_msg) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

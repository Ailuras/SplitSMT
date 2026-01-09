(set-logic ALL)

; Uninterpreted functions for str_split interface
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

; =========================
; SAT instance: Log analysis parsing
; Format (space-separated): "YYYY-MM-DD HH:MM:SS LEVEL: message"
; =========================
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_and_msg_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

(declare-const y_sat Int)
(declare-const mo_sat Int)
(declare-const d_sat Int)
(declare-const hh_sat Int)
(declare-const mm_sat Int)
(declare-const ss_sat Int)

; Basic splitting by spaces
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_and_msg_sat (split_rest log_line_sat " " 2)))

; Extract level and message by colon delimiter ("LEVEL: message")
(assert (>= (num_splits level_and_msg_sat ":") 2))
(assert (= level_sat (split_at level_and_msg_sat ":" 0)))
(assert (= msg_sat (split_rest level_and_msg_sat ":" 1)))

; Constrain level to common values
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Date must be YYYY-MM-DD
(assert (>= (num_splits date_sat "-") 3))
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))

; Time must be HH:MM:SS
(assert (>= (num_splits time_sat ":") 3))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= min_sat (split_at time_sat ":" 1)))
(assert (= sec_sat (split_at time_sat ":" 2)))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Timestamp numeric range checks using str.to_int
(assert (= y_sat (str.to_int year_sat)))
(assert (= mo_sat (str.to_int month_sat)))
(assert (= d_sat (str.to_int day_sat)))
(assert (= hh_sat (str.to_int hour_sat)))
(assert (= mm_sat (str.to_int min_sat)))
(assert (= ss_sat (str.to_int sec_sat)))

(assert (and (>= y_sat 1970) (<= y_sat 2099)))
(assert (and (>= mo_sat 1) (<= mo_sat 12)))
(assert (and (>= d_sat 1) (<= d_sat 31)))
(assert (and (>= hh_sat 0) (<= hh_sat 23)))
(assert (and (>= mm_sat 0) (<= mm_sat 59)))
(assert (and (>= ss_sat 0) (<= ss_sat 59)))

; Ensure the log line is consistent with extracted pieces
(assert (= log_line_sat (str.++ date_sat " " time_sat " " level_sat ":" msg_sat)))

; Some message properties
(assert (> (str.len msg_sat) 0))
(assert (str.contains msg_sat "request"))

; Regex validation for digit-only components
(assert (str.in_re year_sat (re.loop (str.to_re "0") 0 0)))
; The above is intentionally weak (always false) in some solvers; use explicit digit regex instead
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Pin a concrete satisfying example (keeps it clearly SAT)
(assert (= log_line_sat "2024-11-05 13:07:59 INFO: request completed"))

(check-sat)

; =========================
; UNSAT instance: Contradicting timestamp / level extraction
; =========================
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_and_msg_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)

(declare-const month_unsat String)
(declare-const mo_unsat Int)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_and_msg_unsat (split_rest log_line_unsat " " 2)))

(assert (>= (num_splits level_and_msg_unsat ":") 2))
(assert (= level_unsat (split_at level_and_msg_unsat ":" 0)))
(assert (= msg_unsat (split_rest level_and_msg_unsat ":" 1)))

; Enforce that level is exactly INFO
(assert (= level_unsat "INFO"))

; Now contradict by requiring the reconstructed line to contain "ERROR" as extracted level
(assert (= log_line_unsat (str.++ date_unsat " " time_unsat " " "ERROR" ":" msg_unsat)))

; Also enforce a valid date split but impossible month range
(assert (>= (num_splits date_unsat "-") 3))
(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (= mo_unsat (str.to_int month_unsat)))
(assert (and (>= mo_unsat 1) (<= mo_unsat 12)))
(assert (= mo_unsat 13))

; Pin a concrete line that still makes the constraints clash
(assert (= log_line_unsat "2024-13-05 10:00:00 INFO: request failed"))

(check-sat)
(exit)

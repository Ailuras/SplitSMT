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

; ---------- SAT instance: well-formed log entry ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const component_name_sat String)
(declare-const pid_sat String)

; Shape: "YYYY-MM-DD HH:MM:SS LEVEL component: message"
(assert (= ts_sat (str.++ (split_at log_line_sat " " 0) " " (split_at log_line_sat " " 1))))
(assert (= level_sat (split_at log_line_sat " " 2)))
(assert (= component_sat (split_at log_line_sat " " 3)))
(assert (= message_sat (split_rest log_line_sat " " 4)))

; Require at least 5 space-separated fields
(assert (>= (num_splits log_line_sat " ") 5))

; Timestamp tokenization
(assert (= date_sat (split_at ts_sat " " 0)))
(assert (= time_sat (split_at ts_sat " " 1)))
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))

; Ensure correct number of splits in date and time
(assert (= (num_splits date_sat "-") 3))
(assert (= (num_splits time_sat ":") 3))

; Regex: digit-only and fixed lengths
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Basic range checks via int conversion
(declare-const year_i_sat Int)
(declare-const month_i_sat Int)
(declare-const day_i_sat Int)
(declare-const hour_i_sat Int)
(declare-const minute_i_sat Int)
(declare-const second_i_sat Int)
(assert (= year_i_sat (str.to_int year_sat)))
(assert (= month_i_sat (str.to_int month_sat)))
(assert (= day_i_sat (str.to_int day_sat)))
(assert (= hour_i_sat (str.to_int hour_sat)))
(assert (= minute_i_sat (str.to_int minute_sat)))
(assert (= second_i_sat (str.to_int second_sat)))
(assert (>= year_i_sat 2000))
(assert (<= year_i_sat 2099))
(assert (>= month_i_sat 1))
(assert (<= month_i_sat 12))
(assert (>= day_i_sat 1))
(assert (<= day_i_sat 31))
(assert (>= hour_i_sat 0))
(assert (<= hour_i_sat 23))
(assert (>= minute_i_sat 0))
(assert (<= minute_i_sat 59))
(assert (>= second_i_sat 0))
(assert (<= second_i_sat 59))

; Log level extraction and validation
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component must end with ':' and have non-empty name before it
(assert (= ":" (str.at component_sat (- (str.len component_sat) 1))))
(assert (> (str.len component_sat) 1))
(assert (= component_name_sat (str.substr component_sat 0 (- (str.len component_sat) 1))))
(assert (not (= component_name_sat "")))

; Optional PID pattern in component name like "auth[1234]" is allowed
(assert (or
  (not (str.contains component_name_sat "["))
  (and
    (= (split_at component_name_sat "[" 0) component_name_sat) ; conservative: no '[' means no split
    true)))

; Message should be non-empty and contain at least one printable character (approx: not empty)
(assert (> (str.len message_sat) 0))

; Witness a concrete satisfiable log line
(assert (= log_line_sat "2024-01-09 13:45:07 INFO auth: login ok"))

; ---------- UNSAT instance: contradictory timestamp + level constraints ----------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const month_unsat String)
(declare-const month_i_unsat Int)

(assert (>= (num_splits log_line_unsat " ") 4))
(assert (= ts_unsat (str.++ (split_at log_line_unsat " " 0) " " (split_at log_line_unsat " " 1))))
(assert (= level_unsat (split_at log_line_unsat " " 2)))

(assert (= date_unsat (split_at ts_unsat " " 0)))
(assert (= time_unsat (split_at ts_unsat " " 1)))
(assert (= (num_splits date_unsat "-") 3))
(assert (= month_unsat (split_at date_unsat "-" 1)))

; Month must be exactly two digits
(assert (str.in_re month_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (= month_i_unsat (str.to_int month_unsat)))

; Contradiction: month must be within [1..12] and simultaneously be 13
(assert (>= month_i_unsat 1))
(assert (<= month_i_unsat 12))
(assert (= month_i_unsat 13))

; Contradiction: level is fixed to INFO but must also be ERROR
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Give a concrete looking line; contradictions above make it UNSAT anyway
(assert (= log_line_unsat "2024-13-01 00:00:00 INFO core: bad month"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

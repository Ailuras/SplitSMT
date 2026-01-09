(set-logic ALL)

; Uninterpreted interface for split operations
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

; Scenario: Log Analysis (Parsing structured server log entries)
; Expected style: "YYYY-MM-DD HH:MM:SS LEVEL: message..."

; ------------ SAT instance ------------
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const ts_year_sat String)
(declare-const ts_month_sat String)
(declare-const ts_day_sat String)
(declare-const ts_hour_sat String)
(declare-const ts_min_sat String)
(declare-const ts_sec_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

; Split by spaces: [0]=date, [1]=time, [2]=LEVEL:, rest=message
(assert (>= (num_splits log_line_sat " ") 4))
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= msg_sat (split_rest log_line_sat " " 3)))

; Date format: YYYY-MM-DD
(assert (= 10 (str.len ts_date_sat)))
(assert (= "-" (str.at ts_date_sat 4)))
(assert (= "-" (str.at ts_date_sat 7)))
(assert (= ts_year_sat (str.substr ts_date_sat 0 4)))
(assert (= ts_month_sat (str.substr ts_date_sat 5 2)))
(assert (= ts_day_sat (str.substr ts_date_sat 8 2)))
(assert (str.in_re ts_year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re ts_month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ts_day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Time format: HH:MM:SS
(assert (= 8 (str.len ts_time_sat)))
(assert (= ":" (str.at ts_time_sat 2)))
(assert (= ":" (str.at ts_time_sat 5)))
(assert (= ts_hour_sat (str.substr ts_time_sat 0 2)))
(assert (= ts_min_sat (str.substr ts_time_sat 3 2)))
(assert (= ts_sec_sat (str.substr ts_time_sat 6 2)))
(assert (str.in_re ts_hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ts_min_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ts_sec_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Range checks via integer conversion
(declare-const hour_i_sat Int)
(declare-const min_i_sat Int)
(declare-const sec_i_sat Int)
(assert (= hour_i_sat (str.to_int ts_hour_sat)))
(assert (= min_i_sat (str.to_int ts_min_sat)))
(assert (= sec_i_sat (str.to_int ts_sec_sat)))
(assert (and (<= 0 hour_i_sat) (<= hour_i_sat 23)))
(assert (and (<= 0 min_i_sat) (<= min_i_sat 59)))
(assert (and (<= 0 sec_i_sat) (<= sec_i_sat 59)))

; Extract log level by splitting token 2 on colon: "LEVEL:" -> [0]=LEVEL
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= level_sat (split_at level_colon_sat ":" 0)))

; Allowed levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message checks
(assert (>= (str.len msg_sat) 1))
(assert (not (str.contains msg_sat "\n")))

; Provide one concrete satisfying example to keep this part SAT
(assert (= log_line_sat "2024-11-05 09:13:07 INFO: service_started"))

; ------------ UNSAT instance ------------
; Another log line variable with contradictory requirements
(declare-const log_line_unsat String)
(declare-const ts_time_unsat String)
(declare-const hour_i_unsat Int)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))

; Require correct time shape and also an impossible hour range simultaneously
(assert (= 8 (str.len ts_time_unsat)))
(assert (= ":" (str.at ts_time_unsat 2)))
(assert (= ":" (str.at ts_time_unsat 5)))
(assert (str.in_re (str.substr ts_time_unsat 0 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (= hour_i_unsat (str.to_int (str.substr ts_time_unsat 0 2))))
(assert (and (<= 0 hour_i_unsat) (<= hour_i_unsat 23)))
(assert (and (>= hour_i_unsat 24) (<= hour_i_unsat 30)))

; Also force level to be both INFO and ERROR (contradiction)
(assert (>= (num_splits level_colon_unsat ":") 2))
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Fix log line to a plausible concrete string to ensure the contradiction is not avoided by undefined split behavior
(assert (= log_line_unsat "2024-11-05 12:00:00 INFO: ok"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

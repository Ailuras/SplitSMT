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

; Uninterpreted split interface (methodology: Solving String Split Constraints via Relaxation)

; ========= SAT instance: well-formed log analysis =========
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const host_sat String)
(declare-const service_sat String)
(declare-const pid_sat String)
(declare-const remainder_sat String)

(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= remainder_sat (split_rest log_line_sat " " 2)))
(assert (= msg_sat remainder_sat))

; Require at least: <timestamp> <level> <host> <service>:<pid> <message...>
(assert (>= (num_splits log_line_sat " ") 5))

; Timestamp must look like YYYY-MM-DDTHH:MM:SS
(assert (= date_sat (split_at ts_sat "T" 0)))
(assert (= time_sat (split_at ts_sat "T" 1)))
(assert (= (num_splits ts_sat "T") 2))

(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (num_splits date_sat "-") 3))

(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))

(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Use regex to constrain digits and allowed levels
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction: must be one of common levels
(assert (str.in_re level_sat (re.union (str.to_re "INFO")
                                      (re.union (str.to_re "WARN")
                                                (re.union (str.to_re "ERROR")
                                                          (str.to_re "DEBUG"))))))

; Host field and service:pid field
(assert (= host_sat (split_at log_line_sat " " 2)))
(assert (= service_sat (split_at (split_at log_line_sat " " 3) ":" 0)))
(assert (= pid_sat (split_at (split_at log_line_sat " " 3) ":" 1)))
(assert (= (num_splits (split_at log_line_sat " " 3) ":") 2))

; pid must be digits and non-empty
(assert (>= (str.len pid_sat) 1))
(assert (str.in_re pid_sat (re.+ (re.range "0" "9"))))

; Message should contain a colon-separated key:value somewhere (typical structured logs)
(assert (str.contains msg_sat ":"))

; Provide a concrete satisfying example (anchors the SAT instance)
(assert (= log_line_sat "2025-01-09T13:05:44 INFO web-01 auth:1234 user=alice action=login result=ok"))


; ========= UNSAT instance: contradictory timestamp/level constraints =========
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const year_unsat String)
(declare-const month_unsat String)
(declare-const day_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (>= (num_splits log_line_unsat " ") 2))

; Force a concrete log line that violates the extracted constraints below
(assert (= log_line_unsat "2025-1-09T13:05:44 TRACE anything"))

; Constrain timestamp to have two-digit month/day, but the concrete line has month "1"
(assert (= date_unsat (split_at ts_unsat "T" 0)))
(assert (= time_unsat (split_at ts_unsat "T" 1)))
(assert (= (num_splits ts_unsat "T") 2))

(assert (= year_unsat (split_at date_unsat "-" 0)))
(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (= day_unsat (split_at date_unsat "-" 2)))
(assert (= (num_splits date_unsat "-") 3))

(assert (= (str.len year_unsat) 4))
(assert (= (str.len month_unsat) 2))
(assert (= (str.len day_unsat) 2))

; Additionally require allowed levels, but the concrete line uses TRACE
(assert (str.in_re level_unsat (re.union (str.to_re "INFO")
                                        (re.union (str.to_re "WARN")
                                                  (re.union (str.to_re "ERROR")
                                                            (str.to_re "DEBUG"))))))

(check-sat)
(exit)

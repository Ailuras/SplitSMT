(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; -------- SAT instance: well-formed log analysis --------
(declare-const log_line_sat String)
(declare-const ts_token_sat String)
(declare-const time_part_sat String)
(declare-const level_token_sat String)
(declare-const msg_rest_sat String)
(declare-const ts_date_sat String)
(declare-const ts_clock_sat String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts_token_sat (split_at log_line_sat " " 0)))
(assert (= time_part_sat (split_at log_line_sat " " 1)))
(assert (= level_token_sat (split_at log_line_sat " " 2)))
(assert (= msg_rest_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Timestamp format validation (basic): date token has two '-' and time token has two ':'
(assert (= (num_splits ts_token_sat "-") 3))
(assert (= (num_splits time_part_sat ":") 3))

; Enforce fixed lengths: "YYYY-MM-DD" length 10, "HH:MM:SS" length 8
(assert (= (str.len ts_token_sat) 10))
(assert (= (str.len time_part_sat) 8))

; Split timestamp pieces to constrain digit-only fields
(assert (= ts_date_sat ts_token_sat))
(assert (= ts_clock_sat time_part_sat))

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

(assert (= year_sat (split_at ts_date_sat "-" 0)))
(assert (= month_sat (split_at ts_date_sat "-" 1)))
(assert (= day_sat (split_at ts_date_sat "-" 2)))
(assert (= hour_sat (split_at ts_clock_sat ":" 0)))
(assert (= min_sat (split_at ts_clock_sat ":" 1)))
(assert (= sec_sat (split_at ts_clock_sat ":" 2)))

(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Digit-only checks using regex
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re month_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re day_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re min_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.+ (re.range "0" "9"))))

; Extract log level from token of form "LEVEL:" (colon terminated)
(declare-const level_name_sat String)
(assert (= level_name_sat (split_at level_token_sat ":" 0)))
(assert (= (split_at level_token_sat ":" 1) ""))
(assert (>= (num_splits level_token_sat ":") 2))

; Restrict log level to a known set
(assert (or (= level_name_sat "INFO") (= level_name_sat "WARN") (= level_name_sat "ERROR") (= level_name_sat "DEBUG")))

; Message must be non-empty and contain at least one alphabetic character
(assert (> (str.len msg_rest_sat) 0))
(assert (str.in_re msg_rest_sat (re.++ (re.* re.allchar) (re.range "A" "Z") (re.* re.allchar))))

; Provide a concrete satisfiable example
(assert (= log_line_sat "2025-01-09 13:45:59 INFO: Service started"))

; -------- UNSAT instance: contradictory constraints on another log line --------
(declare-const log_line_unsat String)
(declare-const ts_token_unsat String)
(declare-const time_part_unsat String)
(declare-const level_token_unsat String)
(declare-const msg_rest_unsat String)

(assert (= ts_token_unsat (split_at log_line_unsat " " 0)))
(assert (= time_part_unsat (split_at log_line_unsat " " 1)))
(assert (= level_token_unsat (split_at log_line_unsat " " 2)))
(assert (= msg_rest_unsat (split_rest log_line_unsat " " 3)))
(assert (>= (num_splits log_line_unsat " ") 4))

; Contradiction: require exactly 3 ':' splits in time token, but force length 7 (cannot match HH:MM:SS which needs 8)
(assert (= (num_splits time_part_unsat ":") 3))
(assert (= (str.len time_part_unsat) 7))

; Also force a concrete time token length 8 via equality => direct conflict with length 7
(assert (= time_part_unsat "12:34:56"))

; Another mild structure constraint to mimic parsing
(assert (= (num_splits ts_token_unsat "-") 3))
(assert (= (str.len ts_token_unsat) 10))

; Concrete line (doesn't matter due to contradictions above)
(assert (= log_line_unsat "2025-01-09 12:34:56 ERROR: Something failed"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

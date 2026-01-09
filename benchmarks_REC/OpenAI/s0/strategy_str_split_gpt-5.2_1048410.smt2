(set-logic ALL)

; Uninterpreted split interface
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

; ========= SAT instance: well-formed log parsing =========
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

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))
(assert (>= (num_splits log_line_sat " ") 3))

; Timestamp expected to contain date and time separated by a space encoded as date+"T"+time or pure space? Here: enforce "YYYY-MM-DD" in ts_sat and validate via split_at by '-'
(assert (= date_sat (split_at ts_sat "T" 0)))
(assert (= time_sat (split_at ts_sat "T" 1)))
(assert (>= (num_splits ts_sat "T") 2))

(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= 3 (num_splits date_sat "-")))

(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))
(assert (= 3 (num_splits time_sat ":")))

; Regex validation for timestamp components (digits and fixed widths)
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Additional semantic checks: fixed lengths and limited ranges using integer conversion
(declare-const year_i_sat Int)
(declare-const month_i_sat Int)
(declare-const day_i_sat Int)
(declare-const hour_i_sat Int)
(declare-const minute_i_sat Int)
(declare-const second_i_sat Int)

(assert (= 4 (str.len year_sat)))
(assert (= 2 (str.len month_sat)))
(assert (= 2 (str.len day_sat)))
(assert (= 2 (str.len hour_sat)))
(assert (= 2 (str.len minute_sat)))
(assert (= 2 (str.len second_sat)))

(assert (= year_i_sat (str.to_int year_sat)))
(assert (= month_i_sat (str.to_int month_sat)))
(assert (= day_i_sat (str.to_int day_sat)))
(assert (= hour_i_sat (str.to_int hour_sat)))
(assert (= minute_i_sat (str.to_int minute_sat)))
(assert (= second_i_sat (str.to_int second_sat)))

(assert (and (>= year_i_sat 1970) (<= year_i_sat 2099)))
(assert (and (>= month_i_sat 1) (<= month_i_sat 12)))
(assert (and (>= day_i_sat 1) (<= day_i_sat 31)))
(assert (and (>= hour_i_sat 0) (<= hour_i_sat 23)))
(assert (and (>= minute_i_sat 0) (<= minute_i_sat 59)))
(assert (and (>= second_i_sat 0) (<= second_i_sat 59)))

; Log level extraction: enforce it is one of known tokens
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message and level formatting hints
(assert (not (str.contains level_sat ":")))
(assert (str.contains msg_sat ":"))

; Provide a concrete satisfiable example shape
(assert (= log_line_sat (str.++ "2025-01-09T13:45:07" (str.++ " " (str.++ "INFO" (str.++ " " "auth: user=alice result=ok"))))))

; ========= UNSAT instance: conflicting timestamp and level constraints =========
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const month_unsat String)
(declare-const second_unsat String)
(declare-const month_i_unsat Int)
(declare-const second_i_unsat Int)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (>= (num_splits log_line_unsat " ") 3))

(assert (= date_unsat (split_at ts_unsat "T" 0)))
(assert (= time_unsat (split_at ts_unsat "T" 1)))
(assert (>= (num_splits ts_unsat "T") 2))

(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (= 3 (num_splits date_unsat "-")))
(assert (= second_unsat (split_at time_unsat ":" 2)))
(assert (= 3 (num_splits time_unsat ":")))

; Enforce numeric two-digit regex
(assert (str.in_re month_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))

(assert (= month_i_unsat (str.to_int month_unsat)))
(assert (= second_i_unsat (str.to_int second_unsat)))

; Contradiction: month must be both 12 and in range 1..11
(assert (= month_i_unsat 12))
(assert (and (>= month_i_unsat 1) (<= month_i_unsat 11)))

; Contradiction: seconds forced to 60 but restricted to 0..59
(assert (= second_i_unsat 60))
(assert (and (>= second_i_unsat 0) (<= second_i_unsat 59)))

; Contradiction on level: must be INFO and ERROR simultaneously
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Provide concrete line form (still cannot satisfy due to above contradictions)
(assert (= log_line_unsat (str.++ "2025-12-01T10:20:60" (str.++ " " (str.++ "INFO" (str.++ " " "x: y"))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

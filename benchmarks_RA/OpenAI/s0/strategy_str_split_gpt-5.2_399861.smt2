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

; --- SAT instance: plausible structured log entry ---
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

; Tokenization by space: "<timestamp> <level>: <message>"
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))
(assert (>= (num_splits log_line_sat " ") 3))

; Timestamp token is "YYYY-MM-DDTHH:MM:SS" (no timezone here)
(assert (= date_sat (split_at ts_sat "T" 0)))
(assert (= time_sat (split_at ts_sat "T" 1)))
(assert (= (num_splits ts_sat "T") 2))

; Date checks: YYYY-MM-DD with digit groups and basic ranges
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (= (str.len month_sat) 2))
(assert (str.in_re month_sat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (= (str.len day_sat) 2))
(assert (str.in_re day_sat (re.++ (re.range "0" "3") (re.range "0" "9"))))
(assert (let ((m (str.to_int month_sat))) (and (>= m 1) (<= m 12))))
(assert (let ((d (str.to_int day_sat))) (and (>= d 1) (<= d 31))))

; Time checks: HH:MM:SS with digit groups and ranges
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))
(assert (= (str.len hour_sat) 2))
(assert (str.in_re hour_sat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (= (str.len minute_sat) 2))
(assert (str.in_re minute_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (= (str.len second_sat) 2))
(assert (str.in_re second_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (let ((h (str.to_int hour_sat))) (and (>= h 0) (<= h 23))))
(assert (let ((mi (str.to_int minute_sat))) (and (>= mi 0) (<= mi 59))))
(assert (let ((s (str.to_int second_sat))) (and (>= s 0) (<= s 59))))

; Log level extraction: token like "INFO:" or "ERROR:" etc.
(assert (str.in_re level_sat (re.++ (re.union (str.to_re "INFO:") (str.to_re "WARN:") (str.to_re "ERROR:") (str.to_re "DEBUG:")) (re.* (str.to_re "")))))
; Ensure it ends with ':' and has at least 5 chars (e.g., "INFO:")
(assert (>= (str.len level_sat) 5))
(assert (= (str.at level_sat (- (str.len level_sat) 1)) ":"))

; Message constraints: non-empty and does not contain newline
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Provide a concrete satisfying witness shape
(assert (str.in_re log_line_sat
  (re.++
    (re.++
      (re.++
        (re.++
          (re.++
            (re.++ (re.+ (re.range "0" "9")) (str.to_re "-"))
            (re.+ (re.range "0" "9")))
          (str.to_re "T"))
        (re.+ (re.range "0" "9")))
      (str.to_re " "))
    (re.++ (re.union (str.to_re "INFO:") (str.to_re "WARN:") (str.to_re "ERROR:") (str.to_re "DEBUG:"))
           (re.++ (str.to_re " ") (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "_") (str.to_re "-") (str.to_re ".") (str.to_re "/"))))))))


; --- UNSAT instance: contradictory timestamp and level constraints ---
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const month_unsat String)
(declare-const hour_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (= msg_unsat (split_rest log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 3))

; Require a 'T' split
(assert (= date_unsat (split_at ts_unsat "T" 0)))
(assert (= time_unsat (split_at ts_unsat "T" 1)))
(assert (= (num_splits ts_unsat "T") 2))

; Month extracted but forced out of range (UNSAT when combined with range constraints)
(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (= (str.len month_unsat) 2))
(assert (str.in_re month_unsat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (let ((m (str.to_int month_unsat))) (and (>= m 1) (<= m 12))))
(assert (= month_unsat "13"))

; Log level must be both INFO: and ERROR: simultaneously (UNSAT)
(assert (str.contains level_unsat "INFO:"))
(assert (str.contains level_unsat "ERROR:"))
(assert (= level_unsat "INFO:"))

; Hour extracted but forced invalid while also constrained valid
(assert (= hour_unsat (split_at time_unsat ":" 0)))
(assert (= (str.len hour_unsat) 2))
(assert (str.in_re hour_unsat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (let ((h (str.to_int hour_unsat))) (and (>= h 0) (<= h 23))))
(assert (= hour_unsat "24"))

; Keep message non-empty to avoid trivial contradictions elsewhere
(assert (> (str.len msg_unsat) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted split interface (space/colon-based parsing)
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

; ========= SAT instance: well-formed log parsing =========
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Concrete example to make the instance robustly SAT
(assert (= log_line_sat "2026-01-09 13:05:59 INFO auth: User login ok"))

; Space-separated fields: <timestamp> <level> <component:> <message...>
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= component_sat (split_at log_line_sat " " 2)))
(assert (= msg_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Timestamp is further split by space: <date> <time>
(assert (= date_sat (split_at ts_sat " " 0)))
(assert (= time_sat (split_at ts_sat " " 1)))
(assert (>= (num_splits ts_sat " ") 2))

; Date format YYYY-MM-DD
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= mon_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (= (str.len mon_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re mon_sat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Time format HH:MM:SS
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= min_sat (split_at time_sat ":" 1)))
(assert (= sec_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))
(assert (str.in_re hour_sat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re min_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction/validation
(assert (or (= level_sat "DEBUG") (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR")))

; Component field must end with ':' and have a non-empty name prefix
(assert (str.in_re component_sat (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9")))) (str.to_re ":"))))

; Message sanity check
(assert (> (str.len msg_sat) 0))
(assert (str.contains msg_sat "login"))

; ========= UNSAT instance: contradictory log checks =========
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const time_unsat String)
(declare-const hour_unsat String)
(declare-const sec_unsat String)
(declare-const component_unsat String)

; Concrete log line, but with contradictions below
(assert (= log_line_unsat "2026-01-09 13:05:59 INFO auth: test"))

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (= component_unsat (split_at log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 4))

; Enforce level is INFO and also ERROR (contradiction)
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Enforce timestamp has a time part, then contradict its colon split count
(assert (= time_unsat (split_at ts_unsat " " 1)))
(assert (>= (num_splits ts_unsat " ") 2))
(assert (= (num_splits time_unsat ":") 3))
(assert (= (num_splits time_unsat ":") 2))

; Additional contradiction: hour must be two chars and also empty
(assert (= hour_unsat (split_at time_unsat ":" 0)))
(assert (= (str.len hour_unsat) 2))
(assert (= hour_unsat ""))

; Component must end with ':' but also must not contain ':'
(assert (str.in_re component_unsat (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9")))) (str.to_re ":"))))
(assert (not (str.contains component_unsat ":")))

; A further inconsistent constraint tying seconds
(assert (= sec_unsat (split_at time_unsat ":" 2)))
(assert (= sec_unsat "59"))
(assert (= sec_unsat "00"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

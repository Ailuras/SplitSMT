(set-logic ALL)

; Uninterpreted interface: str_split
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

; =========================
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Validating timestamp format and extracting log level.
; Include both SAT and UNSAT instances.
; =========================

; ---------- Shared declarations ----------
(declare-const log_line_sat String)
(declare-const log_line_unsat String)

(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_unsat String)
(declare-const component_unsat String)
(declare-const message_unsat String)

(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

(declare-const hour_unsat String)
(declare-const min_unsat String)
(declare-const sec_unsat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)

(declare-const year_unsat String)
(declare-const month_unsat String)
(declare-const day_unsat String)

; Helper regexes
(declare-const re_digit RegLan)
(declare-const re_2digit RegLan)
(declare-const re_4digit RegLan)
(declare-const re_level RegLan)

(assert (= re_digit (re.range "0" "9")))
(assert (= re_2digit (re.++ re_digit re_digit)))
(assert (= re_4digit (re.++ re_digit re_digit re_digit re_digit)))
(assert (= re_level (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; =====================================================
; SAT instance: a well-formed log line
; Format: YYYY-MM-DD HH:MM:SS LEVEL Component: message
; =====================================================

; Basic splitting by spaces
(assert (>= (num_splits log_line_sat " ") 4))
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= level_sat (split_at log_line_sat " " 2)))
(assert (= component_sat (split_at log_line_sat " " 3)))
(assert (= message_sat (split_rest log_line_sat " " 4)))

; Timestamp date: YYYY-MM-DD using splits on '-'
(assert (= year_sat (split_at ts_date_sat "-" 0)))
(assert (= month_sat (split_at ts_date_sat "-" 1)))
(assert (= day_sat (split_at ts_date_sat "-" 2)))
(assert (= (num_splits ts_date_sat "-") 3))
(assert (str.in_re year_sat re_4digit))
(assert (str.in_re month_sat re_2digit))
(assert (str.in_re day_sat re_2digit))

; Timestamp time: HH:MM:SS using splits on ':'
(assert (= hour_sat (split_at ts_time_sat ":" 0)))
(assert (= min_sat (split_at ts_time_sat ":" 1)))
(assert (= sec_sat (split_at ts_time_sat ":" 2)))
(assert (= (num_splits ts_time_sat ":") 3))
(assert (str.in_re hour_sat re_2digit))
(assert (str.in_re min_sat re_2digit))
(assert (str.in_re sec_sat re_2digit))

; Log level extraction constraint
(assert (str.in_re level_sat re_level))

; Component has a trailing ':' (e.g., "Auth:")
(assert (str.suffixof ":" component_sat))
(assert (>= (str.len component_sat) 2))

; Message is non-empty and does not contain newline
(assert (> (str.len message_sat) 0))
(assert (not (str.contains message_sat "\n")))

; Concretize a consistent SAT example
(assert (= log_line_sat "2025-01-09 13:45:07 INFO Auth: user login ok"))

; =====================================================
; UNSAT instance: conflicting requirements
; Format intended same, but constraints contradict.
; =====================================================

; Split by spaces
(assert (>= (num_splits log_line_unsat " ") 4))
(assert (= ts_date_unsat (split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_unsat (split_at log_line_unsat " " 2)))
(assert (= component_unsat (split_at log_line_unsat " " 3)))
(assert (= message_unsat (split_rest log_line_unsat " " 4)))

; Require exactly the same general timestamp structure
(assert (= (num_splits ts_date_unsat "-") 3))
(assert (= year_unsat (split_at ts_date_unsat "-" 0)))
(assert (= month_unsat (split_at ts_date_unsat "-" 1)))
(assert (= day_unsat (split_at ts_date_unsat "-" 2)))
(assert (str.in_re year_unsat re_4digit))
(assert (str.in_re month_unsat re_2digit))
(assert (str.in_re day_unsat re_2digit))

(assert (= (num_splits ts_time_unsat ":") 3))
(assert (= hour_unsat (split_at ts_time_unsat ":" 0)))
(assert (= min_unsat (split_at ts_time_unsat ":" 1)))
(assert (= sec_unsat (split_at ts_time_unsat ":" 2)))
(assert (str.in_re hour_unsat re_2digit))
(assert (str.in_re min_unsat re_2digit))
(assert (str.in_re sec_unsat re_2digit))

; Log level must be valid per regex, but also constrained to an invalid value
(assert (str.in_re level_unsat re_level))
(assert (= level_unsat "TRACE"))

; Component must end with ':', but also forced to not contain ':'
(assert (str.suffixof ":" component_unsat))
(assert (not (str.contains component_unsat ":")))

; Fix a candidate line to show the intended structure (still UNSAT due to contradictions above)
(assert (= log_line_unsat "2025-01-09 13:45:07 TRACE Core: should be impossible"))

; Combined query: SAT and UNSAT constraints together => UNSAT overall.
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

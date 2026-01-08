(set-logic ALL)
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

; Uninterpreted split interface

; -------- SAT instance: plausible log line --------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ss_sat String)
(declare-const rest_after_ts_sat String)
(declare-const rest_after_lvl_sat String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= rest_after_ts_sat (split_rest log_line_sat " " 1)))
(assert (= lvl_sat (split_at rest_after_ts_sat " " 0)))
(assert (= rest_after_lvl_sat (split_rest rest_after_ts_sat " " 1)))

; Level/message delimiter via ':' in the remainder after LEVEL
(assert (>= (num_splits rest_after_lvl_sat ":") 2))
(assert (= msg_sat (split_rest rest_after_lvl_sat ":" 1)))

; Timestamp format validation: length and character classes
(assert (= (str.len ts_sat) 19))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) " "))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))

; Split date/time by space
(assert (= date_sat (split_at ts_sat " " 0)))
(assert (= time_sat (split_at ts_sat " " 1)))
(assert (>= (num_splits ts_sat " ") 2))

; Date components: YYYY-MM-DD
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= mon_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= (num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (= (str.len mon_sat) 2))
(assert (= (str.len day_sat) 2))

; Time components: HH:MM:SS
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mm_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))
(assert (= (num_splits time_sat ":") 3))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Digit regex
(define-fun DIGIT () RegLan (re.range "0" "9"))
(define-fun TWO_DIGITS () RegLan (re.++ DIGIT DIGIT))
(define-fun FOUR_DIGITS () RegLan (re.++ DIGIT (re.++ DIGIT (re.++ DIGIT DIGIT))))

; Enforce digits in components
(assert (str.in_re year_sat FOUR_DIGITS))
(assert (str.in_re mon_sat TWO_DIGITS))
(assert (str.in_re day_sat TWO_DIGITS))
(assert (str.in_re hh_sat TWO_DIGITS))
(assert (str.in_re mm_sat TWO_DIGITS))
(assert (str.in_re ss_sat TWO_DIGITS))

; Acceptable levels (mix of common ones)
(assert (or (= lvl_sat "INFO") (= lvl_sat "WARN") (= lvl_sat "ERROR") (= lvl_sat "DEBUG")))

; Message must be non-empty after ':' (allow leading space but require some content)
(assert (>= (str.len msg_sat) 1))

; Provide a concrete satisfying example to anchor SAT instance
(assert (= log_line_sat "2025-12-31 23:59:58 INFO: rotation completed"))

; -------- UNSAT instance: contradictory requirements --------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const year_unsat String)
(declare-const mon_unsat String)
(declare-const day_unsat String)
(declare-const hh_unsat String)
(declare-const mm_unsat String)
(declare-const ss_unsat String)
(declare-const rest_after_ts_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= rest_after_ts_unsat (split_rest log_line_unsat " " 1)))
(assert (= lvl_unsat (split_at rest_after_ts_unsat " " 0)))

; Same timestamp structure constraints
(assert (= (str.len ts_unsat) 19))
(assert (= (str.at ts_unsat 4) "-"))
(assert (= (str.at ts_unsat 7) "-"))
(assert (= (str.at ts_unsat 10) " "))
(assert (= (str.at ts_unsat 13) ":"))
(assert (= (str.at ts_unsat 16) ":"))

; Split date/time and enforce digit shapes
(assert (= date_unsat (split_at ts_unsat " " 0)))
(assert (= time_unsat (split_at ts_unsat " " 1)))
(assert (= (num_splits ts_unsat " ") 2))

(assert (= year_unsat (split_at date_unsat "-" 0)))
(assert (= mon_unsat (split_at date_unsat "-" 1)))
(assert (= day_unsat (split_at date_unsat "-" 2)))
(assert (= (num_splits date_unsat "-") 3))
(assert (= (str.len year_unsat) 4))
(assert (= (str.len mon_unsat) 2))
(assert (= (str.len day_unsat) 2))
(assert (str.in_re year_unsat FOUR_DIGITS))
(assert (str.in_re mon_unsat TWO_DIGITS))
(assert (str.in_re day_unsat TWO_DIGITS))

(assert (= hh_unsat (split_at time_unsat ":" 0)))
(assert (= mm_unsat (split_at time_unsat ":" 1)))
(assert (= ss_unsat (split_at time_unsat ":" 2)))
(assert (= (num_splits time_unsat ":") 3))
(assert (str.in_re hh_unsat TWO_DIGITS))
(assert (str.in_re mm_unsat TWO_DIGITS))
(assert (str.in_re ss_unsat TWO_DIGITS))

; Contradiction: require level to be both INFO and ERROR
(assert (= lvl_unsat "INFO"))
(assert (= lvl_unsat "ERROR"))

; Anchor with a plausible line (still unsat due to level contradiction)
(assert (= log_line_unsat "2026-01-01 00:00:00 INFO: happy new year"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

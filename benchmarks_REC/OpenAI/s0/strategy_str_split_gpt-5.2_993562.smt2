(set-logic ALL)

; Uninterpreted interface functions for split operations
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

; -----------------------------
; SAT instance: well-formed log parsing
; -----------------------------
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)
(declare-const date_re String)
(declare-const time_re String)
(declare-const level_re String)
(declare-const comp_re String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL Component: message..."
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= level_sat   (split_at log_line_sat " " 2)))
(assert (= component_sat (split_at log_line_sat " " 3)))
(assert (= message_sat (split_rest log_line_sat " " 4)))
(assert (>= (num_splits log_line_sat " ") 5))

; Component ends with ':'
(assert (str.suffixof ":" component_sat))
(assert (>= (str.len component_sat) 2))

; Timestamp regex: date and time format checks
(assert (= date_re "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]"))
(assert (= time_re "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"))
(assert (str.in_re ts_date_sat (str.to_re date_re)))
(assert (str.in_re ts_time_sat (str.to_re time_re)))

; Further extraction of time parts
(assert (= hour_sat (split_at ts_time_sat ":" 0)))
(assert (= min_sat  (split_at ts_time_sat ":" 1)))
(assert (= sec_sat  (split_at ts_time_sat ":" 2)))
(assert (>= (num_splits ts_time_sat ":") 3))

; Log level is one of: INFO, WARN, ERROR, DEBUG
(assert (= level_re "(INFO|WARN|ERROR|DEBUG)"))
(assert (str.in_re level_sat (str.to_re level_re)))

; Component name pattern: letters/digits/underscore ending with ':'
(assert (= comp_re "[A-Za-z_][A-Za-z0-9_]*:"))
(assert (str.in_re component_sat (str.to_re comp_re)))

; Message basic sanity
(assert (>= (str.len message_sat) 1))
(assert (not (str.contains message_sat "\n")))

; Make the SAT instance concrete
(assert (= log_line_sat "2025-01-09 13:05:44 INFO AuthService: login ok"))

; -----------------------------
; UNSAT instance: contradictory parsing requirements
; -----------------------------
(declare-const log_line_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_unsat String)
(declare-const component_unsat String)
(declare-const message_unsat String)
(declare-const level_re2 String)
(declare-const time_re2 String)

(assert (= ts_date_unsat (split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_unsat   (split_at log_line_unsat " " 2)))
(assert (= component_unsat (split_at log_line_unsat " " 3)))
(assert (= message_unsat (split_rest log_line_unsat " " 4)))
(assert (>= (num_splits log_line_unsat " ") 5))

; Force a fixed (inconsistent) line
(assert (= log_line_unsat "2025-01-09 13:05:44 INFO AuthService: login ok"))

; Contradiction 1: time must match HH:MM:SS but also must not contain ':'
(assert (= time_re2 "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"))
(assert (str.in_re ts_time_unsat (str.to_re time_re2)))
(assert (not (str.contains ts_time_unsat ":")))

; Contradiction 2: level must be INFO but also must be ERROR
(assert (= level_re2 "INFO"))
(assert (str.in_re level_unsat (str.to_re level_re2)))
(assert (= level_unsat "ERROR"))

; Component must end with ':' but also must not contain ':'
(assert (str.suffixof ":" component_unsat))
(assert (not (str.contains component_unsat ":")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

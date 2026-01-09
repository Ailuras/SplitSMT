(set-logic ALL)

; Uninterpreted functions for string split interface
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

; =====================
; SAT instance: log analysis parsing and validation
; =====================

(declare-const log_line_sat String)
(declare-const ts_part_sat String)
(declare-const rest_after_ts_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Split by single spaces: "<timestamp> <level>: <message>"
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_part_sat (split_at log_line_sat " " 0)))
(assert (= rest_after_ts_sat (split_rest log_line_sat " " 1)))
(assert (= level_sat (split_at rest_after_ts_sat " " 0)))
(assert (= msg_sat (split_rest rest_after_ts_sat " " 1)))

; Level should be "INFO:" | "WARN:" | "ERROR:" | "DEBUG:"
(assert (or (= level_sat "INFO:") (= level_sat "WARN:") (= level_sat "ERROR:") (= level_sat "DEBUG:")))

; Message must be non-empty and must not itself contain a newline
(assert (>= (str.len msg_sat) 1))
(assert (not (str.contains msg_sat "\n")))

; Timestamp format: YYYY-MM-DD:HH:MM:SS (split by colon)
(assert (>= (num_splits ts_part_sat ":") 4))
(assert (= date_sat (split_at ts_part_sat ":" 0)))
(assert (= hour_sat (split_at ts_part_sat ":" 1)))
(assert (= min_sat (split_at ts_part_sat ":" 2)))
(assert (= sec_sat (split_at ts_part_sat ":" 3)))
(assert (= time_sat (str.++ hour_sat ":" min_sat ":" sec_sat)))

; Validate date via regex: \d{4}-\d{2}-\d{2}
(assert (str.in_re date_sat (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")))))

; Validate time fields are exactly two digits
(assert (str.in_re hour_sat (re.++ ((_ re.loop 2 2) (re.range "0" "9")))))
(assert (str.in_re min_sat (re.++ ((_ re.loop 2 2) (re.range "0" "9")))))
(assert (str.in_re sec_sat (re.++ ((_ re.loop 2 2) (re.range "0" "9")))))

; Extra structural check: log line starts with the timestamp and a space
(assert (= log_line_sat (str.++ ts_part_sat " " rest_after_ts_sat)))

; Provide one concrete satisfiable witness to ensure SAT
(assert (= log_line_sat "2025-01-09:13:07:59 INFO: service started"))

; =====================
; UNSAT instance: conflicting constraints for log parsing
; =====================

(declare-const log_line_unsat String)
(declare-const ts_part_unsat String)
(declare-const rest_after_ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const hour_unsat String)
(declare-const min_unsat String)
(declare-const sec_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_part_unsat (split_at log_line_unsat " " 0)))
(assert (= rest_after_ts_unsat (split_rest log_line_unsat " " 1)))
(assert (= level_unsat (split_at rest_after_ts_unsat " " 0)))

; Force a particular log line
(assert (= log_line_unsat "2025-01-09:13:07:59 INFO: bad"))

; Parse timestamp pieces
(assert (>= (num_splits ts_part_unsat ":") 4))
(assert (= date_unsat (split_at ts_part_unsat ":" 0)))
(assert (= hour_unsat (split_at ts_part_unsat ":" 1)))
(assert (= min_unsat (split_at ts_part_unsat ":" 2)))
(assert (= sec_unsat (split_at ts_part_unsat ":" 3)))

; Require level to be ERROR: but the concrete line has INFO:
(assert (= level_unsat "ERROR:"))

; Also require an impossible date shape (must contain a slash), contradicting the concrete date
(assert (str.contains date_unsat "/"))

; Additionally require hour to be 3 digits, contradicting the concrete time (and typical validation)
(assert (str.in_re hour_unsat (re.++ ((_ re.loop 3 3) (re.range "0" "9")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

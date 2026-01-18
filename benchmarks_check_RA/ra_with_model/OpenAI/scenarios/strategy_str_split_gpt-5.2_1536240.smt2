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

; Uninterpreted interface functions for string splitting

; -----------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Expected shape (example):
;   "2026-01-09 12:34:56 INFO: user=jdoe action=login"
; -----------------------------

; SAT instance: consistent log entry
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const yyyy_sat String)
(declare-const mm_sat String)
(declare-const dd_sat String)
(declare-const hh_sat String)
(declare-const mi_sat String)
(declare-const ss_sat String)

; Split by spaces: timestamp, level+colon, message
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_colon_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))

; Timestamp split by space into date and time
(assert (>= (num_splits ts_sat " ") 2))
(assert (= date_sat (split_at ts_sat " " 0)))
(assert (= time_sat (split_at ts_sat " " 1)))

; Date split by '-' into YYYY-MM-DD
(assert (>= (num_splits date_sat "-") 3))
(assert (= yyyy_sat (split_at date_sat "-" 0)))
(assert (= mm_sat (split_at date_sat "-" 1)))
(assert (= dd_sat (split_at date_sat "-" 2)))

; Time split by ':' into HH:MM:SS
(assert (>= (num_splits time_sat ":") 3))
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mi_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))

; Log level extraction: "INFO:" => level "INFO"
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= level_sat (split_at level_colon_sat ":" 0)))

; Concrete structure constraints for a satisfiable example
(assert (= yyyy_sat "2026"))
(assert (= mm_sat "01"))
(assert (= dd_sat "09"))
(assert (= hh_sat "12"))
(assert (= mi_sat "34"))
(assert (= ss_sat "56"))
(assert (= level_sat "INFO"))
(assert (str.contains msg_sat "user="))
(assert (str.contains msg_sat "action="))

; Bind a concrete full log line to guarantee satisfiable parsing
(assert (= log_line_sat "2026-01-09 12:34:56 INFO: user=jdoe action=login"))

; -----------------------------
; UNSAT instance: conflicting timestamp format expectations
; Here we force a 'T' separator but still try to parse by space into date/time.
; -----------------------------

(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 1)))

; Force ISO-8601-like timestamp with 'T' and no spaces inside timestamp
(assert (= ts_unsat "2026-01-09T12:34:56"))

; But also require that timestamp splits by space into two segments (date and time)
(assert (>= (num_splits ts_unsat " ") 2))
(assert (= date_unsat (split_at ts_unsat " " 0)))
(assert (= time_unsat (split_at ts_unsat " " 1)))

; Concrete log line consistent with ts_unsat as first token
(assert (= log_line_unsat "2026-01-09T12:34:56 INFO: something"))

; -----------------------------
; Global check: include both SAT and UNSAT constraints together.
; This makes the overall file UNSAT (by design) to provide diversity.
; -----------------------------



; [GENERATION STATUS: SUCCESS]
(assert (= time_sat "6"))
(assert (= time_unsat "2"))
(assert (= ts_unsat "2026-01-09T12:34:56"))
(assert (= msg_sat "user=Jaction="))
(assert (= date_unsat "2"))
(assert (= date_sat "0"))
(assert (= yyyy_sat "2026"))
(assert (= ts_sat "2"))
(assert (= level_colon_sat "-"))
(assert (= hh_sat "12"))
(assert (= log_line_unsat "2026-01-09T12:34:56 INFO: something"))
(assert (= level_colon_unsat "2"))
(assert (= level_sat "INFO"))
(assert (= log_line_sat "2026-01-09 12:34:56 INFO: user=jdoe action=login"))
(assert (= mm_sat "01"))
(assert (= ss_sat "56"))
(assert (= mi_sat "34"))
(assert (= dd_sat "09"))
(check-sat)
(exit)

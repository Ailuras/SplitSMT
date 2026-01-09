(set-logic ALL)

; Uninterpreted interface operations for splitting
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

; Uninterpreted helpers for this scenario (non-primitive parsing/validation)
(declare-fun is_valid_timestamp (String) Bool)
(declare-fun is_valid_ip (String) Bool)
(declare-fun is_known_level (String) Bool)

; =========================
; SAT instance: consistent structured log entry
; Format (one possible):
;   "YYYY-MM-DD HH:MM:SS LEVEL component: message"
; Split by spaces to isolate timestamp date, time, level, etc.
; Split by ':' to isolate component and message
; =========================

(declare-const log_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const rest_after_level_sat String)
(declare-const comp_sat String)
(declare-const msg_sat String)
(declare-const comp_msg_sat String)

; Ensure at least 4 space-separated segments: date, time, level, and remainder
(assert (>= (num_splits log_sat " ") 4))
(assert (>= (num_splits log_sat ":") 2))

(assert (= date_sat (split_at log_sat " " 0)))
(assert (= time_sat (split_at log_sat " " 1)))
(assert (= level_sat (split_at log_sat " " 2)))
(assert (= rest_after_level_sat (split_rest log_sat " " 3)))

(assert (= ts_sat (str.++ date_sat " " time_sat)))

; Timestamp format validation via regex plus a semantic predicate
(assert (str.in_re date_sat (str.to_re (str.++ ""))))
(assert (str.in_re date_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re time_sat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))
(assert (is_valid_timestamp ts_sat))

; Level extraction checks
(assert (is_known_level level_sat))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Parse component/message around the first colon
(assert (= comp_sat (split_at rest_after_level_sat ":" 0)))
(assert (= msg_sat (split_rest rest_after_level_sat ":" 1)))
(assert (= comp_msg_sat (str.++ comp_sat ":" msg_sat)))
(assert (str.contains rest_after_level_sat ":"))

; Component constraints: non-empty and alphanumeric-ish with underscores/dashes
(assert (> (str.len comp_sat) 0))
(assert (str.in_re comp_sat (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "-"))))))))

; Message constraints: must mention status code pattern or keyword
(assert (or (str.contains msg_sat "status=") (str.contains msg_sat "timeout") (str.contains msg_sat "user=")))

; Provide concrete witness-like restrictions to keep it SAT
(assert (= date_sat "2025-01-09"))
(assert (= time_sat "13:05:07"))
(assert (= level_sat "INFO"))
(assert (= comp_sat "auth"))
(assert (= msg_sat " user=bob status=200"))
(assert (= log_sat (str.++ date_sat " " time_sat " " level_sat " " comp_sat ":" msg_sat)))

; =========================
; UNSAT instance: conflicting requirements on extracted log level
; =========================

(declare-const log_unsat String)
(declare-const level_unsat String)

(assert (>= (num_splits log_unsat " ") 3))
(assert (= level_unsat (split_at log_unsat " " 2)))

; Force two distinct levels simultaneously -> UNSAT
(assert (= level_unsat "ERROR"))
(assert (= level_unsat "INFO"))

; Also demand it be a known level (doesn't repair unsat, but adds realism)
(assert (is_known_level level_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

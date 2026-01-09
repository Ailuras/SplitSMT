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

; -----------------------------
; SAT instance: structured server log
; Format target (space-separated):
;   YYYY-MM-DDTHH:MM:SSZ <LEVEL>: <message>
; Example: 2025-01-09T13:05:59Z INFO: Service started
; -----------------------------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

(declare-const y_sat String)
(declare-const mo_sat String)
(declare-const d_sat String)
(declare-const hh_sat String)
(declare-const mi_sat String)
(declare-const ssZ_sat String)
(declare-const ss_sat String)

(assert (= log_line_sat "2025-01-09T13:05:59Z INFO: Service started"))

; Split by spaces: [timestamp, "INFO:", "Service", ...]
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_colon_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))

; Level extraction by splitting token like "INFO:" using ":"
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Timestamp structure checks
; ts = "YYYY-MM-DDTHH:MM:SSZ"
(assert (= (str.len ts_sat) 20))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) "T"))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))
(assert (= (str.at ts_sat 19) "Z"))

; Extract date/time components via split_at
(assert (>= (num_splits ts_sat "T") 2))
(assert (>= (num_splits ts_sat "-") 3))
(assert (= y_sat (split_at ts_sat "-" 0)))
(assert (= mo_sat (split_at ts_sat "-" 1)))
(assert (= d_sat (split_at (split_at ts_sat "T" 0) "-" 2)))
(assert (= hh_sat (split_at (split_at ts_sat "T" 1) ":" 0)))
(assert (= mi_sat (split_at (split_at ts_sat "T" 1) ":" 1)))
(assert (= ssZ_sat (split_at (split_at ts_sat "T" 1) ":" 2)))

(assert (>= (num_splits ssZ_sat "Z") 2))
(assert (= ss_sat (split_at ssZ_sat "Z" 0)))

; Length constraints for components
(assert (= (str.len y_sat) 4))
(assert (= (str.len mo_sat) 2))
(assert (= (str.len d_sat) 2))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mi_sat) 2))
(assert (= (str.len ss_sat) 2))

; Digit-only constraints for each component using regex
(assert (str.in_re y_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mo_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re d_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mi_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Numeric range checks using str.to_int (requires digit-only, satisfied above)
(declare-const y_i_sat Int)
(declare-const mo_i_sat Int)
(declare-const d_i_sat Int)
(declare-const hh_i_sat Int)
(declare-const mi_i_sat Int)
(declare-const ss_i_sat Int)
(assert (= y_i_sat (str.to_int y_sat)))
(assert (= mo_i_sat (str.to_int mo_sat)))
(assert (= d_i_sat (str.to_int d_sat)))
(assert (= hh_i_sat (str.to_int hh_sat)))
(assert (= mi_i_sat (str.to_int mi_sat)))
(assert (= ss_i_sat (str.to_int ss_sat)))
(assert (and (>= mo_i_sat 1) (<= mo_i_sat 12)))
(assert (and (>= d_i_sat 1) (<= d_i_sat 31)))
(assert (and (>= hh_i_sat 0) (<= hh_i_sat 23)))
(assert (and (>= mi_i_sat 0) (<= mi_i_sat 59)))
(assert (and (>= ss_i_sat 0) (<= ss_i_sat 59)))

; Message constraints
(assert (>= (str.len msg_sat) 1))
(assert (str.contains msg_sat "Service"))

(check-sat)

; -----------------------------
; UNSAT instance: conflicting checks on a malformed line
; Intentionally mismatched timestamp/level token constraints
; -----------------------------

(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_token_unsat String)
(declare-const level_unsat String)
(declare-const y_unsat String)
(declare-const mo_unsat String)
(declare-const d_unsat String)
(declare-const hh_unsat String)
(declare-const mi_unsat String)
(declare-const ssZ_unsat String)
(declare-const ss_unsat String)
(declare-const y_i_unsat Int)
(declare-const mo_i_unsat Int)
(declare-const d_i_unsat Int)
(declare-const hh_i_unsat Int)
(declare-const mi_i_unsat Int)
(declare-const ss_i_unsat Int)

; Malformed timestamp: uses space instead of 'T' and ends without 'Z'
(assert (= log_line_unsat "2025-01-09 13:05:59 INFO: Broken"))

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_token_unsat (split_at log_line_unsat " " 2)))

; Require level token to be exactly "ERROR:" while the line has "INFO:" at position 2
(assert (= level_token_unsat "ERROR:"))
(assert (>= (num_splits level_token_unsat ":") 2))
(assert (= level_unsat (split_at level_token_unsat ":" 0)))
(assert (= level_unsat "ERROR"))

; Timestamp constraints that cannot hold for "2025-01-09" (length 10)
(assert (= (str.len ts_unsat) 20))
(assert (= (str.at ts_unsat 10) "T"))
(assert (= (str.at ts_unsat 19) "Z"))

; Attempt to parse components anyway and enforce strict ranges
(assert (>= (num_splits ts_unsat "T") 2))
(assert (>= (num_splits ts_unsat "-") 3))
(assert (= y_unsat (split_at ts_unsat "-" 0)))
(assert (= mo_unsat (split_at ts_unsat "-" 1)))
(assert (= d_unsat (split_at (split_at ts_unsat "T" 0) "-" 2)))
(assert (= hh_unsat (split_at (split_at ts_unsat "T" 1) ":" 0)))
(assert (= mi_unsat (split_at (split_at ts_unsat "T" 1) ":" 1)))
(assert (= ssZ_unsat (split_at (split_at ts_unsat "T" 1) ":" 2)))
(assert (>= (num_splits ssZ_unsat "Z") 2))
(assert (= ss_unsat (split_at ssZ_unsat "Z" 0)))

(assert (= y_i_unsat (str.to_int y_unsat)))
(assert (= mo_i_unsat (str.to_int mo_unsat)))
(assert (= d_i_unsat (str.to_int d_unsat)))
(assert (= hh_i_unsat (str.to_int hh_unsat)))
(assert (= mi_i_unsat (str.to_int mi_unsat)))
(assert (= ss_i_unsat (str.to_int ss_unsat)))

; Additional contradiction: force impossible month range
(assert (and (>= mo_i_unsat 13) (<= mo_i_unsat 12)))

(check-sat)
(exit)

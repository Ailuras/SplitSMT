(set-logic ALL)

; Uninterpreted string-split interface
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
; SAT instance: well-formed log parsing
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; =========================
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const message_sat String)

(declare-const y_sat String)
(declare-const m_sat String)
(declare-const d_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ss_sat String)

(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= message_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Level extraction: "LEVEL:" then message begins after space
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= (split_at level_colon_sat ":" 1) ""))

; Timestamp validation via splitting
(assert (= y_sat (split_at date_sat "-" 0)))
(assert (= m_sat (split_at date_sat "-" 1)))
(assert (= d_sat (split_at date_sat "-" 2)))
(assert (= hh_sat (split_at time_sat ":" 0)))
(assert (= mm_sat (split_at time_sat ":" 1)))
(assert (= ss_sat (split_at time_sat ":" 2)))
(assert (= (num_splits date_sat "-") 3))
(assert (= (num_splits time_sat ":") 3))

; Length checks for fixed-width timestamp fields
(assert (= (str.len y_sat) 4))
(assert (= (str.len m_sat) 2))
(assert (= (str.len d_sat) 2))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Digit-only constraints using regex
(assert (str.in_re y_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re m_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re d_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Constrain numeric ranges (loose but meaningful)
(declare-const yi_sat Int)
(declare-const mi_sat Int)
(declare-const di_sat Int)
(declare-const hhi_sat Int)
(declare-const mmi_sat Int)
(declare-const ssi_sat Int)

(assert (= yi_sat (str.to_int y_sat)))
(assert (= mi_sat (str.to_int m_sat)))
(assert (= di_sat (str.to_int d_sat)))
(assert (= hhi_sat (str.to_int hh_sat)))
(assert (= mmi_sat (str.to_int mm_sat)))
(assert (= ssi_sat (str.to_int ss_sat)))

(assert (and (>= yi_sat 1970) (<= yi_sat 2099)))
(assert (and (>= mi_sat 1) (<= mi_sat 12)))
(assert (and (>= di_sat 1) (<= di_sat 31)))
(assert (and (>= hhi_sat 0) (<= hhi_sat 23)))
(assert (and (>= mmi_sat 0) (<= mmi_sat 59)))
(assert (and (>= ssi_sat 0) (<= ssi_sat 59)))

; Log level validation and message sanity
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))
(assert (>= (str.len message_sat) 1))
(assert (not (str.contains message_sat "\n")))

; Fix a concrete satisfying example
(assert (= log_line_sat "2025-01-09 07:05:30 INFO: service started"))

; =========================
; UNSAT instance: conflicting requirements for the same parsing constraints
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message..." but forced contradictions
; =========================
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)
(declare-const message_unsat String)

(declare-const y_unsat String)
(declare-const m_unsat String)
(declare-const d_unsat String)
(declare-const hh_unsat String)
(declare-const mm_unsat String)
(declare-const ss_unsat String)

(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (= message_unsat (split_rest log_line_unsat " " 3)))
(assert (>= (num_splits log_line_unsat " ") 4))

(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (>= (num_splits level_colon_unsat ":") 2))
(assert (= (split_at level_colon_unsat ":" 1) ""))

(assert (= y_unsat (split_at date_unsat "-" 0)))
(assert (= m_unsat (split_at date_unsat "-" 1)))
(assert (= d_unsat (split_at date_unsat "-" 2)))
(assert (= hh_unsat (split_at time_unsat ":" 0)))
(assert (= mm_unsat (split_at time_unsat ":" 1)))
(assert (= ss_unsat (split_at time_unsat ":" 2)))
(assert (= (num_splits date_unsat "-") 3))
(assert (= (num_splits time_unsat ":") 3))

; Contradiction 1: y_unsat must be 4 digits but also equal to "20A5"
(assert (= (str.len y_unsat) 4))
(assert (str.in_re y_unsat (re.+ (re.range "0" "9"))))
(assert (= y_unsat "20A5"))

; Contradiction 2: level must be one of known set, but fixed to "TRACE"
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))
(assert (= level_unsat "TRACE"))

; Provide a concrete line (still should be inconsistent with constraints above)
(assert (= log_line_unsat "20A5-13-40 25:99:99 TRACE: impossible"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

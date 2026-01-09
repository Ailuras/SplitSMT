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

; =========================
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Example intended shape:
;   "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; =========================

; ---------- SAT instance: a well-formed log line ----------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_with_colon_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

; Basic splitting by spaces: [date, time, level:, rest...]
(assert (>= (num_splits log_line_sat " ") 4))
(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_with_colon_sat (split_at log_line_sat " " 2)))
(assert (= (split_rest log_line_sat " " 3) (str.++ component_sat " " message_sat)))

; Timestamp format checks (date)
(assert (= (str.len date_sat) 10))
(assert (= (str.at date_sat 4) "-"))
(assert (= (str.at date_sat 7) "-"))
(assert (str.in_re (str.substr date_sat 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_sat 5 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr date_sat 8 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Timestamp format checks (time)
(assert (= (str.len time_sat) 8))
(assert (= (str.at time_sat 2) ":"))
(assert (= (str.at time_sat 5) ":"))
(assert (str.in_re (str.substr time_sat 0 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr time_sat 3 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr time_sat 6 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Extract log level from "LEVEL:" via split on ":"
(assert (>= (num_splits level_with_colon_sat ":") 2))
(assert (= level_sat (split_at level_with_colon_sat ":" 0)))
(assert (= "" (split_at level_with_colon_sat ":" 1)))

; Allow common levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component should end with ':' in the original rest-of-line format "component: message"
(assert (>= (num_splits component_sat ":") 2))
(assert (= (split_at component_sat ":" 1) ""))
(assert (>= (str.len message_sat) 1))

; Concretize one satisfying log line
(assert (= log_line_sat "2026-01-09 12:34:56 INFO: auth: login ok"))

; ---------- UNSAT instance: conflicting timestamp/level requirements ----------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_with_colon_unsat String)
(declare-const level_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_with_colon_unsat (split_at log_line_unsat " " 2)))

; Demand strict time punctuation
(assert (= (str.len time_unsat) 8))
(assert (= (str.at time_unsat 2) ":"))
(assert (= (str.at time_unsat 5) ":"))

; But also force a contradictory time where position 2 is not ':'
(assert (= time_unsat "12-34-56"))

; Extract level and contradict it
(assert (>= (num_splits level_with_colon_unsat ":") 2))
(assert (= level_unsat (split_at level_with_colon_unsat ":" 0)))
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Provide a plausible log line anyway (still unsat due to contradictions)
(assert (= log_line_unsat "2026-01-09 12-34-56 INFO: core: msg"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

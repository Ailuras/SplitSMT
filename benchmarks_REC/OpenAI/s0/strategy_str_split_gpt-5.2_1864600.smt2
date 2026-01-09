(set-logic ALL)

; Uninterpreted interface operations for string splitting
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

; =====================
; SAT instance: well-formed log line
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; =====================
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const levelcol_sat String)
(declare-const level_sat String)
(declare-const componentcol_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

; Split by spaces into at least 4 segments: date, time, LEVEL:, rest...
(assert (>= (num_splits log_line_sat " ") 4))
(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= levelcol_sat (split_at log_line_sat " " 2)))
(assert (= message_sat (split_rest log_line_sat " " 3)))

; Validate date format YYYY-MM-DD with digits
(assert (str.in_re date_sat (re.++ (re.loop (re.range "0" "9") 4 4)
                                  (str.to_re "-")
                                  (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re "-")
                                  (re.loop (re.range "0" "9") 2 2))))

; Validate time format HH:MM:SS with digits
(assert (str.in_re time_sat (re.++ (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re ":")
                                  (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re ":")
                                  (re.loop (re.range "0" "9") 2 2))))

; Extract level from "LEVEL:" and validate against known levels
(assert (str.suffixof ":" levelcol_sat))
(assert (= level_sat (str.substr levelcol_sat 0 (- (str.len levelcol_sat) 1))))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message part contains "component:" as first token, and component has no spaces
(assert (= componentcol_sat (split_at message_sat " " 0)))
(assert (str.suffixof ":" componentcol_sat))
(assert (= component_sat (str.substr componentcol_sat 0 (- (str.len componentcol_sat) 1))))
(assert (not (str.contains component_sat " ")))

; Constrain an explicit concrete satisfying example
(assert (= log_line_sat "2025-01-09 13:45:07 INFO: auth: login ok"))

; =====================
; UNSAT instance: contradictory timestamp validation
; =====================
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)

(assert (>= (num_splits log_line_unsat " ") 2))
(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))

; Require time to be both correct HH:MM:SS and also contain no ':' -> contradiction
(assert (str.in_re time_unsat (re.++ (re.loop (re.range "0" "9") 2 2)
                                    (str.to_re ":")
                                    (re.loop (re.range "0" "9") 2 2)
                                    (str.to_re ":")
                                    (re.loop (re.range "0" "9") 2 2))))
(assert (not (str.contains time_unsat ":")))

; Fix a concrete log line to ensure the contradiction is about constraints, not freedom
(assert (= log_line_unsat "2025-01-09 12:00:00 ERROR: core: bad"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

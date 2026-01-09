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
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks: timestamp format validation and log level extraction.
; -----------------------------

; Common variables
(declare-const delim_space String)
(declare-const delim_colon String)
(assert (= delim_space " "))
(assert (= delim_colon ":"))

; =========
; SAT instance: well-formed log line
; Format (by spaces):
;   0: date "YYYY-MM-DD"
;   1: time "HH:MM:SS"
;   2: level (e.g., INFO)
;   3: component (e.g., auth)
;   4: message tail
; =========
(declare-const log_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const msg_sat String)

(assert (>= (num_splits log_sat delim_space) 5))
(assert (= date_sat (split_at log_sat delim_space 0)))
(assert (= time_sat (split_at log_sat delim_space 1)))
(assert (= level_sat (split_at log_sat delim_space 2)))
(assert (= component_sat (split_at log_sat delim_space 3)))
(assert (= msg_sat (split_rest log_sat delim_space 4)))

; Timestamp format checks (structural):
; date must be exactly 10 chars: YYYY-MM-DD with dashes at positions 4 and 7
(assert (= (str.len date_sat) 10))
(assert (= (str.at date_sat 4) "-"))
(assert (= (str.at date_sat 7) "-"))

; time must be exactly 8 chars: HH:MM:SS with colons at positions 2 and 5
(assert (= (str.len time_sat) 8))
(assert (= (str.at time_sat 2) ":"))
(assert (= (str.at time_sat 5) ":"))

; Decompose time by colons and require 3 segments
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)
(assert (>= (num_splits time_sat delim_colon) 3))
(assert (= hour_sat (split_at time_sat delim_colon 0)))
(assert (= min_sat (split_at time_sat delim_colon 1)))
(assert (= sec_sat (split_at time_sat delim_colon 2)))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Log level extraction: constrain to common levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Additional structural checks: component non-empty, message contains a colon-separated key-value somewhere
(assert (> (str.len component_sat) 0))
(assert (str.contains msg_sat ":"))

; Provide a concrete satisfiable example
(assert (= log_sat "2026-01-09 12:34:56 INFO auth user_id:42 login ok"))

(check-sat)

; =========
; UNSAT instance: contradictory timestamp constraints for a log line
; =========
(declare-const log_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_unsat String)

(assert (>= (num_splits log_unsat delim_space) 3))
(assert (= date_unsat (split_at log_unsat delim_space 0)))
(assert (= time_unsat (split_at log_unsat delim_space 1)))
(assert (= level_unsat (split_at log_unsat delim_space 2)))

; Intend date to be YYYY-MM-DD (len 10), but also force it to equal an 8-char string -> contradiction
(assert (= (str.len date_unsat) 10))
(assert (= date_unsat "20260109"))

; Intend time to be HH:MM:SS, but force wrong colon placement simultaneously
(assert (= (str.len time_unsat) 8))
(assert (= (str.at time_unsat 2) ":"))
(assert (= (str.at time_unsat 2) "-"))

; Any level, but constrain it anyway
(assert (or (= level_unsat "INFO") (= level_unsat "ERROR")))

; Give a plausible-looking log to ensure only constraints cause UNSAT
(assert (= log_unsat "20260109 12-34-56 INFO something"))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)

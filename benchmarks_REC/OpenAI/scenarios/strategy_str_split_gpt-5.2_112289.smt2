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

; Uninterpreted functions for string split interface

; =====================
; Scenario: Log Analysis (SAT instance)
; Parsing structured server log entries separated by spaces and colons.
; Example shape: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; =====================

(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_full String)
(declare-const level_token String)
(declare-const level String)
(declare-const msg String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Split by spaces: [0]=date, [1]=time, [2]="LEVEL:", rest is message
(assert (>= (num_splits log_line " ") 4))
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level_token (split_at log_line " " 2)))
(assert (= msg (split_rest log_line " " 3)))
(assert (= ts_full (str.++ ts_date (str.++ " " ts_time))))

; Timestamp date validation: YYYY-MM-DD
(assert (>= (num_splits ts_date "-") 3))
(assert (= year (split_at ts_date "-" 0)))
(assert (= month (split_at ts_date "-" 1)))
(assert (= day (split_at ts_date "-" 2)))
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))

; Timestamp time validation: HH:MM:SS
(assert (>= (num_splits ts_time ":") 3))
(assert (= hour (split_at ts_time ":" 0)))
(assert (= minute (split_at ts_time ":" 1)))
(assert (= second (split_at ts_time ":" 2)))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level extraction: "LEVEL:" -> level
(assert (>= (num_splits level_token ":") 2))
(assert (= level (split_at level_token ":" 0)))

; Allowed log levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message constraints for realism
(assert (>= (str.len msg) 1))
(assert (not (str.contains msg "\n")))

; One concrete witness consistent with constraints
(assert (= log_line "2025-01-09 12:34:56 INFO: startup complete"))

; =====================
; Additional checks (still SAT): extract the first word of message and ensure it's alphabetic-ish
; =====================
(declare-const msg_first_word String)
(assert (>= (num_splits msg " ") 1))
(assert (= msg_first_word (split_at msg " " 0)))
(assert (>= (str.len msg_first_word) 3))

; =====================
; Independent UNSAT instance: conflicting timestamp format constraints
; =====================
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)

(assert (>= (num_splits bad_log_line " ") 2))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))

; Require date to look like YYYY-MM-DD but also force it to have only 2 segments when split by '-'
(assert (= (str.len (split_at bad_date "-" 0)) 4))
(assert (= (str.len (split_at bad_date "-" 1)) 2))
(assert (= (str.len (split_at bad_date "-" 2)) 2))
(assert (= (num_splits bad_date "-") 2))

; Pin a plausible bad_log_line (doesn't matter; constraints already inconsistent)
(assert (= bad_log_line "2025-01-09 12:34:56 ERROR: boom"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

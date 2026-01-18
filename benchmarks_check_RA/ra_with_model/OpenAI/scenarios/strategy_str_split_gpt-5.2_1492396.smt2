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

; ========== SAT instance: structured log parsing ========== 
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts String)
(declare-const level_and_rest String)
(declare-const level_token String)
(declare-const msg String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Split log entry by spaces: "<date> <time> <LEVEL>: <message>"
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level_and_rest (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 3))

; Timestamp format validation: date and time shapes
(assert (str.in_re ts_date (str.to_re "2026-01-09")))
(assert (str.in_re ts_time (re.++ (re.range "0" "2") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9"))))
(assert (= ts (str.++ ts_date " " ts_time)))

; Further split time by ':' into hh:mm:ss
(assert (= hh (split_at ts_time ":" 0)))
(assert (= mm (split_at ts_time ":" 1)))
(assert (= ss (split_at ts_time ":" 2)))
(assert (= 3 (num_splits ts_time ":")))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Extract log level token from "LEVEL: ..." by splitting on ':'
(assert (= level_token (split_at level_and_rest ":" 0)))
(assert (>= (num_splits level_and_rest ":") 2))
(assert (str.in_re level_token (re.union (str.to_re "INFO")
                                         (re.union (str.to_re "WARN")
                                                   (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message is remainder after ':' (could start with a space)
(assert (= msg (split_rest level_and_rest ":" 1)))
(assert (>= (str.len msg) 1))

; Constrain a plausible concrete example to ensure SAT
(assert (= log_line "2026-01-09 12:34:56 INFO: disk check ok"))


; ========== UNSAT instance: contradictory timestamp/level checks ========== 
(declare-const bad_log String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_and_rest String)
(declare-const bad_level String)

(assert (= bad_date (split_at bad_log " " 0)))
(assert (= bad_time (split_at bad_log " " 1)))
(assert (= bad_level_and_rest (split_rest bad_log " " 2)))
(assert (>= (num_splits bad_log " ") 3))

; Force a concrete bad log line
(assert (= bad_log "2026-13-40 99:99:99 TRACE: impossible"))

; Require a strict time regex that 99:99:99 cannot satisfy, plus require it equals the bad_time
(assert (str.in_re bad_time (re.++ (re.range "0" "2") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9"))))

; Extract level; TRACE is not in the allowed set, but also require it equals extracted token
(assert (= bad_level (split_at bad_level_and_rest ":" 0)))
(assert (str.in_re bad_level (re.union (str.to_re "INFO")
                                       (re.union (str.to_re "WARN")
                                                 (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))



; [GENERATION STATUS: SUCCESS]
(assert (= bad_date "2026-01-09"))
(assert (= bad_log "2026-13-40 99:99:99 TRACE: impossible"))
(assert (= ts "2026-01-09 10:00:00"))
(assert (= msg "H"))
(assert (= log_line "2026-01-09 12:34:56 INFO: disk check ok"))
(assert (= ts_date "2026-01-09"))
(assert (= level_and_rest "2"))
(assert (= ts_time "10:00:00"))
(assert (= mm "ML"))
(assert (= ss "QP"))
(assert (= bad_level "WARN"))
(assert (= level_token "DEBUG"))
(assert (= hh "KJ"))
(assert (= bad_time "10:00:08"))
(assert (= bad_level_and_rest "6"))
(check-sat)
(exit)

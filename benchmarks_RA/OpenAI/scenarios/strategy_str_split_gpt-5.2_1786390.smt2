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

; Uninterpreted string split interface

; -----------------------------
; Scenario: Log Analysis
; Structured log format (informal):
;   YYYY-MM-DD HH:MM:SS:LEVEL: message...
; Delimiters: space separates date/time from the rest, colons separate time fields and level.
; -----------------------------

; === SAT instance: a plausible well-formed log entry ===
(declare-const log_line_sat String)
(declare-const sat_part0 String)
(declare-const sat_part1plus String)
(declare-const sat_date String)
(declare-const sat_time_and_level_and_msg String)
(declare-const sat_time_h String)
(declare-const sat_time_m String)
(declare-const sat_time_s String)
(declare-const sat_level String)
(declare-const sat_msg String)

; Split by single space: date and the remainder
(assert (>= (num_splits log_line_sat " ") 2))
(assert (= sat_part0 (split_at log_line_sat " " 0)))
(assert (= sat_part1plus (split_rest log_line_sat " " 1)))
(assert (= sat_date sat_part0))
(assert (= sat_time_and_level_and_msg sat_part1plus))

; Date format: YYYY-MM-DD
(assert (str.in_re sat_date (str.to_re "2026-01-09")))

; Time+level+msg split by ':' => HH : MM : SS : LEVEL : <rest>
(assert (>= (num_splits sat_time_and_level_and_msg ":") 5))
(assert (= sat_time_h (split_at sat_time_and_level_and_msg ":" 0)))
(assert (= sat_time_m (split_at sat_time_and_level_and_msg ":" 1)))
(assert (= sat_time_s (split_at sat_time_and_level_and_msg ":" 2)))
(assert (= sat_level  (split_at sat_time_and_level_and_msg ":" 3)))
(assert (= sat_msg    (split_rest sat_time_and_level_and_msg ":" 4)))

; Basic timestamp component checks
(assert (str.in_re sat_time_h (re.union (str.to_re "00") (str.to_re "23"))))
(assert (str.in_re sat_time_m (re.union (str.to_re "00") (str.to_re "59"))))
(assert (str.in_re sat_time_s (re.union (str.to_re "00") (str.to_re "59"))))

; Log level extraction: must be one of common levels
(assert (str.in_re sat_level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message should be non-empty and can contain spaces/colons (modeled loosely)
(assert (>= (str.len sat_msg) 1))

; Also tie log_line_sat to a concrete exemplar to guarantee SAT
(assert (= log_line_sat "2026-01-09 23:59:59:INFO: service started"))

; === UNSAT instance: contradictory constraints about level and timestamp ===
(declare-const log_line_unsat String)
(declare-const uns_part0 String)
(declare-const uns_part1plus String)
(declare-const uns_date String)
(declare-const uns_time_and_level_and_msg String)
(declare-const uns_time_h String)
(declare-const uns_time_m String)
(declare-const uns_time_s String)
(declare-const uns_level String)
(declare-const uns_msg String)

(assert (>= (num_splits log_line_unsat " ") 2))
(assert (= uns_part0 (split_at log_line_unsat " " 0)))
(assert (= uns_part1plus (split_rest log_line_unsat " " 1)))
(assert (= uns_date uns_part0))
(assert (= uns_time_and_level_and_msg uns_part1plus))

; Set a concrete log line
(assert (= log_line_unsat "2026-01-09 12:34:56:INFO: hello"))

; Parse time/level/msg
(assert (>= (num_splits uns_time_and_level_and_msg ":") 5))
(assert (= uns_time_h (split_at uns_time_and_level_and_msg ":" 0)))
(assert (= uns_time_m (split_at uns_time_and_level_and_msg ":" 1)))
(assert (= uns_time_s (split_at uns_time_and_level_and_msg ":" 2)))
(assert (= uns_level  (split_at uns_time_and_level_and_msg ":" 3)))
(assert (= uns_msg    (split_rest uns_time_and_level_and_msg ":" 4)))

; Contradiction 1: extracted level must be ERROR, but concrete line has INFO
(assert (= uns_level "ERROR"))

; Contradiction 2: force impossible time second value given concrete line has 56
(assert (= uns_time_s "00"))

; Ensure message is non-empty (irrelevant, but adds diversity)
(assert (>= (str.len uns_msg) 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

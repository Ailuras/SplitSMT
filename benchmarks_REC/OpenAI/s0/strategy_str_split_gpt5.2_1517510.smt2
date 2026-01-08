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
; Parsing structured server log entries separated by spaces and colons.
; Target structure (informal):
;   <timestamp> <level>: <message>
; Example:
;   2026-01-07T12:34:56Z INFO: something happened
; -----------------------------

; Primary log entry (intended SAT)
(declare-const log_line String)
(declare-const ts String)
(declare-const level_colon String)
(declare-const level String)
(declare-const message_rest String)

; Secondary log entry (intended UNSAT via contradictory requirements)
(declare-const bad_log_line String)
(declare-const bad_ts String)
(declare-const bad_level_colon String)
(declare-const bad_level String)

; Regex for strict timestamp: YYYY-MM-DDTHH:MM:SSZ
(declare-const re_digit RegLan)
(declare-const re_2d RegLan)
(declare-const re_4d RegLan)
(declare-const re_ts RegLan)

(assert (= re_digit (re.range "0" "9")))
(assert (= re_2d (re.++ re_digit re_digit)))
(assert (= re_4d (re.++ re_2d re_2d)))
(assert (= re_ts
  (re.++
    re_4d (str.to_re "-") re_2d (str.to_re "-") re_2d
    (str.to_re "T")
    re_2d (str.to_re ":") re_2d (str.to_re ":") re_2d
    (str.to_re "Z"))))

; -----------------------------
; SAT instance constraints
; -----------------------------

; Must have at least 3 space-separated segments: ts, level_colon, and message...
(assert (>= (num_splits log_line " ") 3))

; Extract fields by splitting on spaces
(assert (= ts (split_at log_line " " 0)))
(assert (= level_colon (split_at log_line " " 1)))
(assert (= message_rest (split_rest log_line " " 2)))

; Timestamp must match strict format
(assert (str.in_re ts re_ts))

; The second token must contain ':' (e.g., "INFO:")
(assert (str.contains level_colon ":"))

; Extract level by splitting token on ':'
(assert (= level (split_at level_colon ":" 0)))

; Level must be one of common values
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Ensure level_colon is exactly <level> + ':' (no extra colons)
(assert (= (num_splits level_colon ":") 2))
(assert (= level_colon (str.++ level ":")))

; Message must be non-empty and not start with ':'
(assert (> (str.len message_rest) 0))
(assert (not (= (str.at message_rest 0) ":")))

; Concrete anchor to keep the instance grounded but still symbolic
(assert (str.contains message_rest "request"))

; -----------------------------
; UNSAT instance constraints (separate log line)
; -----------------------------

; Same intended structure, but with contradictory checks
(assert (>= (num_splits bad_log_line " ") 2))
(assert (= bad_ts (split_at bad_log_line " " 0)))
(assert (= bad_level_colon (split_at bad_log_line " " 1)))
(assert (= bad_level (split_at bad_level_colon ":" 0)))

; Contradiction: timestamp must match strict regex AND be too short
(assert (str.in_re bad_ts re_ts))
(assert (< (str.len bad_ts) 10))

; Additional plausible constraints (do not affect the core contradiction)
(assert (= (num_splits bad_level_colon ":") 2))
(assert (or (= bad_level "INFO") (= bad_level "ERROR")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

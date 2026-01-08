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

; Uninterpreted string-split interface

; -----------------------------
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by space to isolate date, time, and remainder.
; Split by ':' to isolate level and message.
; -----------------------------

(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const remainder_part String)
(declare-const level_field String)
(declare-const msg_field String)

; Space-based parsing
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= remainder_part (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 3))

; The remainder begins with something like "LEVEL: ..."
(assert (= level_field (split_at remainder_part ":" 0)))
(assert (= msg_field (split_rest remainder_part ":" 1)))
(assert (>= (num_splits remainder_part ":") 2))

; Date format validation: YYYY-MM-DD
(assert (= (str.len date_part) 10))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (str.in_re (str.substr date_part 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 5 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 8 2) (re.+ (re.range "0" "9"))))

; Time format validation: HH:MM:SS
(assert (= (str.len time_part) 8))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (str.in_re (str.substr time_part 0 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr time_part 3 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr time_part 6 2) (re.+ (re.range "0" "9"))))

; Log level extraction and validation
(assert (or (= level_field "INFO") (= level_field "WARN") (= level_field "ERROR") (= level_field "DEBUG")))

; Message sanity checks
(assert (>= (str.len msg_field) 1))
(assert (not (str.contains msg_field "\n")))

; -----------------------------
; Additional SAT constraints to pin an example-like shape (still satisfiable)
; Ensure log_line contains a colon after the level somewhere.
; -----------------------------

(assert (str.contains remainder_part ":"))

; -----------------------------
; Scenario: Log Analysis (UNSAT instance)
; Another log line forced to satisfy conflicting timestamp rules.
; -----------------------------

(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_remainder String)

(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_remainder (split_rest bad_log_line " " 2)))
(assert (>= (num_splits bad_log_line " ") 3))

; Conflicting constraints on bad_time: must be length 8 but also must contain no ':'
(assert (= (str.len bad_time) 8))
(assert (not (str.contains bad_time ":")))
; Yet also enforce the usual time separators at positions 2 and 5
(assert (= (str.at bad_time 2) ":"))
(assert (= (str.at bad_time 5) ":"))

; Conflicting constraints on bad_date: require '-' at pos 4 and 7, but also forbid '-'
(assert (= (str.len bad_date) 10))
(assert (= (str.at bad_date 4) "-"))
(assert (= (str.at bad_date 7) "-"))
(assert (not (str.contains bad_date "-")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

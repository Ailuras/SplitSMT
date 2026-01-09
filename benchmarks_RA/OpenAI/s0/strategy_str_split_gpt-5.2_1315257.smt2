(set-logic ALL)

; Uninterpreted interface functions for string split
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

; ============================
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Parsing structured server log entries separated by spaces and colons.
; ============================

(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_and_msg String)
(declare-const level_str String)
(declare-const msg_str String)

(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Split on spaces: expect at least 3 segments: date, time, and rest
(assert (>= (num_splits log_line " ") 3))
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= level_and_msg (split_rest log_line " " 2)))

; Split date on '-' into Y,M,D
(assert (>= (num_splits date_part "-") 3))
(assert (= year  (split_at date_part "-" 0)))
(assert (= month (split_at date_part "-" 1)))
(assert (= day   (split_at date_part "-" 2)))

; Timestamp basic shape checks
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))

(assert (str.in_re year (re.+ (re.range "0" "9"))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Split time on ':' into HH,MM,SS
(assert (>= (num_splits time_part ":") 3))
(assert (= hour   (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))

(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

(assert (str.in_re hour   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Range checks for time fields
(assert (and (>= (str.to_int hour) 0) (<= (str.to_int hour) 23)))
(assert (and (>= (str.to_int minute) 0) (<= (str.to_int minute) 59)))
(assert (and (>= (str.to_int second) 0) (<= (str.to_int second) 59)))

; Extract log level by splitting on ':' (first colon separates LEVEL from message)
(assert (>= (num_splits level_and_msg ":") 2))
(assert (= level_str (split_at level_and_msg ":" 0)))
(assert (= msg_str (split_rest level_and_msg ":" 1)))

; Allowable levels
(assert (or (= level_str "INFO") (= level_str "WARN") (= level_str "ERROR") (= level_str "DEBUG")))

; Message constraints (must exist, basic sanity)
(assert (>= (str.len msg_str) 1))
(assert (not (str.contains msg_str "\n")))

; A concrete example witness for satisfiable parsing
(assert (= log_line "2026-01-09 07:15:42 INFO: service started"))

(check-sat)

; ============================
; Scenario: Log Analysis (UNSAT instance)
; Conflicting requirements: force second=60 while also constraining seconds <=59
; ============================

(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_rest String)
(declare-const bad_second String)

(assert (>= (num_splits bad_log_line " ") 3))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_rest (split_rest bad_log_line " " 2)))

(assert (>= (num_splits bad_time ":") 3))
(assert (= bad_second (split_at bad_time ":" 2)))
(assert (= (str.len bad_second) 2))
(assert (str.in_re bad_second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Range constraint says seconds <= 59
(assert (and (>= (str.to_int bad_second) 0) (<= (str.to_int bad_second) 59)))

; Force seconds to be "60" which contradicts the range
(assert (= bad_log_line "2026-01-09 12:00:60 ERROR: impossible second"))
(assert (= bad_second "60"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

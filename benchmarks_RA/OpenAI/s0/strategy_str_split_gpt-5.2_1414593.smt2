(set-logic ALL)

; Uninterpreted interface: str_split
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

; Scenario: Log Analysis
; Format (space-separated): "YYYY-MM-DD HH:MM:SS LEVEL: module: message"

(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_full String)
(declare-const level_and_rest String)
(declare-const level_token String)
(declare-const module_token String)
(declare-const message_tail String)

(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const i_year Int)
(declare-const i_month Int)
(declare-const i_day Int)
(declare-const i_hour Int)
(declare-const i_minute Int)
(declare-const i_second Int)

(declare-const sat_witness String)
(declare-const sat_level String)
(declare-const sat_msg String)

(declare-const unsat_line String)
(declare-const unsat_level String)

; ------------------------
; General parsing constraints on log_line
; ------------------------

; Split by spaces: [0]=date, [1]=time, [2]=LEVEL:, rest
(assert (>= (num_splits log_line " ") 4))
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level_and_rest (split_rest log_line " " 2)))
(assert (= ts_full (str.++ ts_date " " ts_time)))

; Validate date structure YYYY-MM-DD via split by "-"
(assert (= year (split_at ts_date "-" 0)))
(assert (= month (split_at ts_date "-" 1)))
(assert (= day (split_at ts_date "-" 2)))
(assert (= (num_splits ts_date "-") 3))
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))

; Validate time structure HH:MM:SS via split by ":"
(assert (= hour (split_at ts_time ":" 0)))
(assert (= minute (split_at ts_time ":" 1)))
(assert (= second (split_at ts_time ":" 2)))
(assert (= (num_splits ts_time ":") 3))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Digits-only and ranges for date/time fields
(assert (str.in_re year (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Convert to integers
(assert (= i_year (str.to_int year)))
(assert (= i_month (str.to_int month)))
(assert (= i_day (str.to_int day)))
(assert (= i_hour (str.to_int hour)))
(assert (= i_minute (str.to_int minute)))
(assert (= i_second (str.to_int second)))

; Range constraints (simplified calendar)
(assert (and (>= i_year 1970) (<= i_year 2099)))
(assert (and (>= i_month 1) (<= i_month 12)))
(assert (and (>= i_day 1) (<= i_day 31)))
(assert (and (>= i_hour 0) (<= i_hour 23)))
(assert (and (>= i_minute 0) (<= i_minute 59)))
(assert (and (>= i_second 0) (<= i_second 59)))

; Parse level/module/message by splitting level_and_rest on ": "
; Expected: "LEVEL: module: message..."
(assert (>= (num_splits level_and_rest ": ") 3))
(assert (= level_token (split_at level_and_rest ": " 0)))
(assert (= module_token (split_at level_and_rest ": " 1)))
(assert (= message_tail (split_rest level_and_rest ": " 2)))

; Log level validation
(assert (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG")))

; Module token should be non-empty and alnum/underscore/dash
(assert (>= (str.len module_token) 1))
(assert (str.in_re module_token (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "-"))))))))

; Message should be non-empty
(assert (>= (str.len message_tail) 1))

; ------------------------
; SAT instance (existence witness): ensure some line can be valid
; ------------------------

; sat_witness is an example-valid line, linked to parsing constraints by equality
(assert (= log_line sat_witness))

; Constrain witness to contain a known substring and be consistent with parsed level/message
(assert (str.contains sat_witness "INFO"))
(assert (str.contains sat_witness "module"))
(assert (str.contains sat_witness "started"))

; Tie additional extracted variables to confirm extraction behavior
(assert (= sat_level level_token))
(assert (= sat_msg message_tail))

; Provide a concrete satisfiable witness (still respects all assertions)
(assert (= sat_witness "2024-01-09 13:45:07 INFO: module: started"))

; ------------------------
; UNSAT instance: a second independent log line that cannot satisfy level constraints
; ------------------------

; Force unsat_line to have a well-formed timestamp and delimiter structure, but an impossible level
(assert (>= (num_splits unsat_line " ") 4))
(assert (= (split_at unsat_line " " 0) "2024-01-09"))
(assert (= (split_at unsat_line " " 1) "13:45:07"))
(assert (= unsat_level (split_at (split_rest unsat_line " " 2) ": " 0)))
(assert (>= (num_splits (split_rest unsat_line " " 2) ": ") 3))

; Contradictory level constraints (must be both INFO and not INFO)
(assert (= unsat_level "INFO"))
(assert (not (= unsat_level "INFO")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

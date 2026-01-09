(set-logic ALL)

; Uninterpreted str_split interface
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

; --- SAT instance: parse and validate a structured log entry ---
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const log_level String)
(declare-const component String)
(declare-const message String)
(declare-const ts_hour String)
(declare-const ts_min String)
(declare-const ts_sec String)
(declare-const ts_year String)
(declare-const ts_month String)
(declare-const ts_day String)

; Basic shape: "YYYY-MM-DD HH:MM:SS LEVEL component: message"
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= log_level (split_at log_line " " 2)))
(assert (= component (split_at log_line " " 3)))
(assert (= message (split_rest log_line " " 4)))
(assert (>= (num_splits log_line " ") 5))

; Timestamp date validation: YYYY-MM-DD
(assert (= ts_year (split_at ts_date "-" 0)))
(assert (= ts_month (split_at ts_date "-" 1)))
(assert (= ts_day (split_at ts_date "-" 2)))
(assert (= (num_splits ts_date "-") 3))
(assert (= (str.len ts_year) 4))
(assert (= (str.len ts_month) 2))
(assert (= (str.len ts_day) 2))
(assert (str.in_re ts_year (re.+ (re.range "0" "9"))))
(assert (str.in_re ts_month (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re ts_day (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Timestamp time validation: HH:MM:SS
(assert (= ts_hour (split_at ts_time ":" 0)))
(assert (= ts_min (split_at ts_time ":" 1)))
(assert (= ts_sec (split_at ts_time ":" 2)))
(assert (= (num_splits ts_time ":") 3))
(assert (= (str.len ts_hour) 2))
(assert (= (str.len ts_min) 2))
(assert (= (str.len ts_sec) 2))
(assert (str.in_re ts_hour (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re ts_min (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re ts_sec (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction check
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Component token ends with ':' and message is non-empty
(assert (str.suffixof ":" component))
(assert (> (str.len message) 0))

; Concrete example to ensure SAT with consistent parsing
(assert (= log_line "2026-01-09 13:45:22 INFO auth: user=alice action=login"))

; --- UNSAT instance: contradictory checks for another log line ---
(declare-const bad_line String)
(declare-const bad_level String)
(declare-const bad_ts_time String)
(declare-const bad_hour String)
(declare-const bad_min String)
(declare-const bad_sec String)

(assert (= bad_ts_time (split_at bad_line " " 1)))
(assert (= bad_level (split_at bad_line " " 2)))
(assert (>= (num_splits bad_line " ") 4))

; Force the level to be INFO but also not INFO (contradiction)
(assert (= bad_level "INFO"))
(assert (not (= bad_level "INFO")))

; Additionally constrain time to have 3 parts, then contradict it by requiring 2
(assert (= bad_hour (split_at bad_ts_time ":" 0)))
(assert (= bad_min (split_at bad_ts_time ":" 1)))
(assert (= bad_sec (split_at bad_ts_time ":" 2)))
(assert (= (num_splits bad_ts_time ":") 3))
(assert (= (num_splits bad_ts_time ":") 2))

; Concrete bad line (still irrelevant due to above contradictions)
(assert (= bad_line "2026-01-09 25:61:61 INFO core: impossible"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

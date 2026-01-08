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

; Uninterpreted interface for string splitting

; -------------------------
; SAT instance: well-formed log line
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -------------------------
(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_colon_part String)
(declare-const level String)
(declare-const message String)

(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const y Int)
(declare-const mon Int)
(declare-const d Int)
(declare-const h Int)
(declare-const mi Int)
(declare-const s Int)

; Split by spaces into: [date, time, rest...]
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= level_colon_part (split_at log_line " " 2)))
(assert (= message (split_rest log_line " " 3)))
(assert (>= (num_splits log_line " ") 4))

; Extract level from "LEVEL:" by splitting on ":"
(assert (= level (split_at level_colon_part ":" 0)))
(assert (>= (num_splits level_colon_part ":") 2))

; Timestamp structure checks using splitting
(assert (= year (split_at date_part "-" 0)))
(assert (= month (split_at date_part "-" 1)))
(assert (= day (split_at date_part "-" 2)))
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))
(assert (= (num_splits date_part "-") 3))
(assert (= (num_splits time_part ":") 3))

; Length constraints for timestamp components
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Digits-only regex for each component
(assert (str.in_re year (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Numeric range constraints via str.to_int
(assert (= y (str.to_int year)))
(assert (= mon (str.to_int month)))
(assert (= d (str.to_int day)))
(assert (= h (str.to_int hour)))
(assert (= mi (str.to_int minute)))
(assert (= s (str.to_int second)))
(assert (and (<= 1970 y) (<= y 2099)))
(assert (and (<= 1 mon) (<= mon 12)))
(assert (and (<= 1 d) (<= d 31)))
(assert (and (<= 0 h) (<= h 23)))
(assert (and (<= 0 mi) (<= mi 59)))
(assert (and (<= 0 s) (<= s 59)))

; Log level allowed set
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Sanity: ensure message exists and does not contain newline
(assert (>= (str.len message) 1))
(assert (not (str.contains message "\n")))

; Build a concrete satisfying example to anchor SAT instance
(assert (= log_line "2024-11-05 19:07:03 ERROR: disk full"))

; -------------------------
; UNSAT instance: contradicting constraints on a second log line
; -------------------------
(declare-const bad_log String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_colon String)
(declare-const bad_level String)
(declare-const bad_year String)
(declare-const bad_month String)
(declare-const bad_day String)
(declare-const bad_mon_int Int)

(assert (= bad_date (split_at bad_log " " 0)))
(assert (= bad_time (split_at bad_log " " 1)))
(assert (= bad_level_colon (split_at bad_log " " 2)))
(assert (>= (num_splits bad_log " ") 3))

(assert (= bad_level (split_at bad_level_colon ":" 0)))
(assert (>= (num_splits bad_level_colon ":") 2))

(assert (= bad_year (split_at bad_date "-" 0)))
(assert (= bad_month (split_at bad_date "-" 1)))
(assert (= bad_day (split_at bad_date "-" 2)))
(assert (= (num_splits bad_date "-") 3))

; Force a concrete bad log
(assert (= bad_log "2023-13-01 00:00:00 INFO: ok"))

; Also require the month to be within range (1..12) but simultaneously equal to 13 -> UNSAT
(assert (= (str.len bad_month) 2))
(assert (str.in_re bad_month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (= bad_mon_int (str.to_int bad_month)))
(assert (and (<= 1 bad_mon_int) (<= bad_mon_int 12)))
(assert (= bad_mon_int 13))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

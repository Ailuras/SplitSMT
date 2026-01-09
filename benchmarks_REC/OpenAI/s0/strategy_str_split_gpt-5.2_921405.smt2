(set-logic ALL)

; Uninterpreted interface for string split operations
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

; ------------ SAT instance: valid-ish log parsing ------------
(declare-const log1 String)
(declare-const date1 String)
(declare-const time1 String)
(declare-const level1 String)
(declare-const message1 String)
(declare-const hh1 String)
(declare-const mm1 String)
(declare-const ss1 String)

; Overall structure: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (= date1 (split_at log1 " " 0)))
(assert (= time1 (split_at log1 " " 1)))
(assert (= level1 (split_at log1 " " 2)))
(assert (= message1 (split_rest log1 " " 3)))
(assert (>= (num_splits log1 " ") 4))

; date format: 4-2-2 digits with '-' separators
(assert (str.in_re date1 (re.++ (re.loop (re.range "0" "9") 4 4)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2))))

; time format: HH:MM:SS (2 digits each) using ':'
(assert (str.in_re time1 (re.++ (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2))))

; extract HH, MM, SS via split on ':'
(assert (= hh1 (split_at time1 ":" 0)))
(assert (= mm1 (split_at time1 ":" 1)))
(assert (= ss1 (split_at time1 ":" 2)))
(assert (>= (num_splits time1 ":") 3))

; constrain numeric ranges using string-to-int
(assert (str.in_re hh1 (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re mm1 (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re ss1 (re.loop (re.range "0" "9") 2 2)))
(assert (and (<= 0 (str.to_int hh1)) (<= (str.to_int hh1) 23)))
(assert (and (<= 0 (str.to_int mm1)) (<= (str.to_int mm1) 59)))
(assert (and (<= 0 (str.to_int ss1)) (<= (str.to_int ss1) 59)))

; log level token should end with ':' and contain only uppercase letters before ':'
(assert (str.in_re level1 (re.++ (re.+ (re.range "A" "Z")) (str.to_re ":"))))

; message exists and does not start with a space (basic sanity)
(assert (>= (str.len message1) 1))
(assert (not (= (str.at message1 0) " ")))

; Provide a concrete satisfying example (keeps this block SAT)
(assert (= log1 "2026-01-09 13:05:44 INFO: user=alice action=login ok"))

; ------------ UNSAT instance: contradictory checks for another log ------------
(declare-const log2 String)
(declare-const time2 String)
(declare-const hh2 String)

; Parse second token as time
(assert (= time2 (split_at log2 " " 1)))
(assert (>= (num_splits log2 " ") 2))

; Require HH:MM:SS shape, then force an impossible hour (>= 24) while also bounding to <= 23
(assert (str.in_re time2 (re.++ (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2))))
(assert (= hh2 (split_at time2 ":" 0)))
(assert (>= (num_splits time2 ":") 3))
(assert (str.in_re hh2 (re.loop (re.range "0" "9") 2 2)))
(assert (<= (str.to_int hh2) 23))
(assert (>= (str.to_int hh2) 24))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

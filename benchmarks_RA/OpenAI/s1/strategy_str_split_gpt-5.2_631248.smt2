(set-logic ALL)

; Uninterpreted split interface for log parsing
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

; Seed variables preserved
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_193661 () String)

; Additional booleans for log-analysis checks
(declare-const T_ts_ok Bool)
(declare-const T_level_ok Bool)
(declare-const T_nonempty Bool)

; Parsed fields
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const level String)
(declare-const msg String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Basic non-empty input (core structure mutated but preserved)
(assert (= T_1 (= var_0xINPUT_193661 "")))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_nonempty T_2))

; Expect at least: "DATE TIME LEVEL: MESSAGE" separated by spaces and a colon after level
(assert (>= (num_splits var_0xINPUT_193661 " ") 4))

; Extract tokens
(assert (= ts_date (split_at var_0xINPUT_193661 " " 0)))
(assert (= ts_time (split_at var_0xINPUT_193661 " " 1)))
(assert (= level (split_at var_0xINPUT_193661 " " 2)))
(assert (= msg (split_rest var_0xINPUT_193661 " " 3)))

; LEVEL token should be like "INFO:" or "ERROR:" etc.
(assert (= T_level_ok (and (str.contains level ":") (= (str.len (split_at level ":" 0)) (- (str.len level) 1)))))

; Timestamp format validation (intentionally inconsistent to create UNSAT)
; Date must be exactly 10 chars: YYYY-MM-DD
(assert (= (str.len ts_date) 10))
(assert (= (str.at ts_date 4) "-"))
(assert (= (str.at ts_date 7) "-"))

; Time must be exactly 8 chars: HH:MM:SS
(assert (= (str.len ts_time) 8))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))

; Split time into components
(assert (= hour (split_at ts_time ":" 0)))
(assert (= minute (split_at ts_time ":" 1)))
(assert (= second (split_at ts_time ":" 2)))
(assert (= (num_splits ts_time ":") 3))

; Component lengths
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Contradictory constraints on hour to force UNSAT
(assert (= hour "12"))
(assert (not (= hour "12")))

; Timestamp ok flag (kept for structure, but irrelevant due to contradiction)
(assert (= T_ts_ok (and (= (str.len ts_date) 10) (= (str.len ts_time) 8))))

; Additional sanity: message non-empty
(assert (> (str.len msg) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

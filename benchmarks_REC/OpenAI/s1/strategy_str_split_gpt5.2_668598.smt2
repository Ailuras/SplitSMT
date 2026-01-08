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

; --- Uninterpreted interface for str_split (CSV fields)

; --- Seed variables (kept core structure)
(declare-fun T_SELECT_1 () Bool)
(declare-fun I0_2 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_2 () String)
(declare-fun T1_2 () String)
(declare-fun T2_2 () String)
(declare-fun T3_2 () String)
(declare-fun T4_2 () String)
(declare-fun T5_2 () String)
(declare-fun var_0xINPUT_18338 () String)

; --- Additional CSV-processing variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_after_2 String)
(declare-const has_empty_field Bool)
(declare-const total_fields Int)

; --- Preserve the seed concatenation core
(assert (= var_0xINPUT_18338 (str.++ T0_2 T1_2)))
(assert (= T1_2 (str.++ T2_2 T3_2)))
(assert (= T2_2 (str.++ T4_2 T5_2)))

; --- CSV scenario binding: build a CSV line using the seed core
(assert (= delim ","))
; require empty prefix for the line (consistent with seed len constraint)
(assert (= 0 (str.len T0_2)))
(assert (= csv_line var_0xINPUT_18338))

; Interpret T4_2 and T3_2 as CSV fragments: "a," then "b," ; T5_2 as last field
(assert (= T4_2 "a,"))
(assert (= T3_2 "b,"))
(assert (= T5_2 "c"))

; --- Ensure we detect empty fields and enforce correct field count
(assert (= total_fields (num_splits csv_line delim)))
(assert (>= total_fields 1))

; Access first three fields via split_at
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest_after_2 (split_rest csv_line delim 2)))

; Expect exactly 3 fields for this CSV line
(assert (= total_fields 3))

; No empty fields allowed in this instance
(assert (= has_empty_field (or (= field0 "") (= field1 "") (= field2 ""))))
(assert (not has_empty_field))

; Field sanity: disallow commas inside individual fields
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))

; Keep arithmetic core from seed but adapted to CSV length checks
(assert (= I0_2 (str.len T4_2)))
(assert (= PCTEMP_LHS_1 (+ I0_2 0)))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert T_SELECT_1)

; Additional length constraints: "a," length = 2, and overall structure implies some bounds
(assert (= I0_2 2))
(assert (>= (str.len csv_line) 5))

; Remove unrelated utma-regex constraint; replace with CSV-specific constraint
(assert (not (str.contains csv_line "__utma=")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

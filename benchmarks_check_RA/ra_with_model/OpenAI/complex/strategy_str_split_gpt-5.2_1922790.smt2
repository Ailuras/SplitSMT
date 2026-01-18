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
; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure correct field counts, detect empty fields.

; Uninterpreted interface functions for split

; Boolean guards (preserve core seed structure with T_*)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)

; Additional booleans for CSV-specific checks
(declare-fun T_9 () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () Bool)
(declare-fun T_12 () Bool)

; Input CSV line
(declare-fun var_0xINPUT_239267 () String)

; Derived fields
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)

; Seed-like basic sanity constraints (mutated)
(assert (= T_1 (not (= "AA1ND6MEXd" var_0xINPUT_239267))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_239267))))
(assert T_2)
(assert (= T_3 (>= (str.len var_0xINPUT_239267) 3)))
(assert T_3)
(assert (= T_4 (not (= var_0xINPUT_239267 ""))))
(assert T_4)
(assert (= T_5 (= var_0xINPUT_239267 "")))
(assert (= T_6 (not T_5)))
(assert T_6)
(assert (= T_7 (str.contains var_0xINPUT_239267 ",")))
(assert T_7)

; Mutate T_8 to tie to CSV header prefix rather than exact equality
(assert (= T_8 (str.prefixof "Example:" var_0xINPUT_239267)))
(assert T_8)

; CSV splitting constraints
(assert (>= (num_splits var_0xINPUT_239267 ",") 4))
(assert (= field0 (split_at var_0xINPUT_239267 "," 0)))
(assert (= field1 (split_at var_0xINPUT_239267 "," 1)))
(assert (= field2 (split_at var_0xINPUT_239267 "," 2)))
(assert (= field3 (split_at var_0xINPUT_239267 "," 3)))

; Detect empty fields: require field1 empty (empty middle field)
(assert (= T_9 (= field1 "")))
(assert T_9)

; Also require no trailing empty after the 3rd comma: field3 is non-empty
(assert (= T_10 (not (= field3 ""))))
(assert T_10)

; Ensure there is at least one non-empty among field0 and field2
(assert (= T_11 (or (not (= field0 "")) (not (= field2 "")))))
(assert T_11)

; UNSAT-inducing consistency check: forbid consecutive commas while also requiring an empty field1
; If field1 is empty, there must be a ",," pattern between field0 and field2.
(assert (= T_12 (not (str.contains var_0xINPUT_239267 ",,"))))
(assert T_12)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

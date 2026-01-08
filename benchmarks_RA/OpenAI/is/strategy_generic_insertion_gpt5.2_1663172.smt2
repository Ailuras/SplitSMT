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
(declare-fun I0_11 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_11 () String)
(declare-fun T1_10 () String)
(declare-fun T1_11 () String)
(declare-fun T1_16 () String)
(declare-fun T1_4 () String)
(declare-fun T1_7 () String)
(declare-fun T2_10 () String)
(declare-fun T2_11 () String)
(declare-fun T2_16 () String)
(declare-fun T2_4 () String)
(declare-fun T2_7 () String)
(declare-fun T3_11 () String)
(declare-fun T4_11 () String)
(declare-fun T5_11 () String)
(declare-fun T_1 () String)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () String)
(declare-fun T_5 () Bool)
(declare-fun T_6 () String)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_a () String)
(declare-fun T_b () Bool)
(declare-fun var_0xINPUT_49773 () String)
(assert (= T_1 (str.++ T1_4 T2_4)))
(assert (= T2_4 var_0xINPUT_49773))
(assert (= T1_4 ""))
(assert (= T_2 (= "-" T_1)))
(assert (= T_3 (not T_2)))
(assert T_3)
(assert (= T_4 (str.++ T1_7 T2_7)))
(assert (= T2_7 var_0xINPUT_49773))
(assert (= T1_7 ""))
(assert (= T_5 (= "" T_4)))
(assert T_5)
(assert (= T_6 (str.++ T1_10 T2_10)))
(assert (= T2_10 var_0xINPUT_49773))
(assert (= T1_10 ""))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_1 (+ I0_11 0)) (= T_6 (str.++ T0_11 T1_11)) (= I0_11 (str.len T4_11)) (= 0 (str.len T0_11)) (= T1_11 (str.++ T2_11 T3_11)) (= T2_11 (str.++ T4_11 T5_11)) (= T5_11 "utm_id=") (not (str.in_re T4_11 (re.++ (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "_") (str.to_re "i") (str.to_re "d") (str.to_re "="))))) (and (= PCTEMP_LHS_1 (- 1)) (= T_6 (str.++ T0_11 T1_11)) (= 0 (str.len T0_11)) (not (str.in_re T1_11 (re.++ (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "_") (str.to_re "i") (str.to_re "d") (str.to_re "=")))))))
(assert (= T_8 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_9 (not T_8)))
(assert T_9)
(assert (= T_a (str.++ T1_16 T2_16)))
(assert (= T2_16 var_0xINPUT_49773))
(assert (= T1_16 ""))
(assert (= T_b (= "-" T_a)))
(assert T_b)

; --- START CONSTRAINT ---
; str_split interface declarations

; new helper variables
(declare-fun ss_n_qmark () Int)
(declare-fun ss_first_seg () String)
(declare-fun ss_rest_after_first () String)
(declare-fun ss_second_seg () String)

; relate the input to a split around '?' and extract segments
(assert (= ss_n_qmark (num_splits var_0xINPUT_49773 "?")))
(assert (>= ss_n_qmark 1))
(assert (= ss_first_seg (split_at var_0xINPUT_49773 "?" 0)))
(assert (= ss_rest_after_first (split_rest var_0xINPUT_49773 "?" 1)))

; if there is a query part, it is the second segment; otherwise empty
(assert (ite (>= ss_n_qmark 2)
            (= ss_second_seg (split_at var_0xINPUT_49773 "?" 1))
            (= ss_second_seg "")))

; connect with existing constraint that the whole input is "-" (from T_b/T_a)
(assert (= ss_first_seg "-"))

; if a query part exists, it must be non-empty and not start with "utm_id="
(assert (ite (>= ss_n_qmark 2)
            (and (> (str.len ss_second_seg) 0)
                 (not (str.in_re ss_second_seg (re.++ (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "_") (str.to_re "i") (str.to_re "d") (str.to_re "=") (re.* re.allchar)))))
            true))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

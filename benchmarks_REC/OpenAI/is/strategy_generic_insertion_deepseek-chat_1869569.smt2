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
(declare-fun I0_14 () Int)
(declare-fun I0_5 () Int)
(declare-fun I0_8 () Int)
(declare-fun I1_14 () Int)
(declare-fun I2_14 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun PCTEMP_LHS_3 () String)
(declare-fun T0_5 () String)
(declare-fun T0_8 () String)
(declare-fun T1_14 () String)
(declare-fun T1_5 () String)
(declare-fun T1_8 () String)
(declare-fun T2_14 () String)
(declare-fun T2_5 () String)
(declare-fun T2_8 () String)
(declare-fun T3_14 () String)
(declare-fun T3_5 () String)
(declare-fun T3_8 () String)
(declare-fun T4_5 () String)
(declare-fun T4_8 () String)
(declare-fun T5_5 () String)
(declare-fun T5_8 () String)
(declare-fun T_1 () Bool)
(declare-fun T_10 () String)
(declare-fun T_11 () Bool)
(declare-fun T_12 () String)
(declare-fun T_13 () Bool)
(declare-fun T_14 () String)
(declare-fun T_15 () Bool)
(declare-fun T_16 () String)
(declare-fun T_17 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Int)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun T_a () Int)
(declare-fun T_c () String)
(declare-fun T_d () Bool)
(declare-fun T_e () String)
(declare-fun T_f () Bool)
(declare-fun var_0xINPUT_47712 () String)
(assert (= T_1 (= "-" var_0xINPUT_47712)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_47712)))
(assert T_3)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_1 (+ I0_5 0)) (= var_0xINPUT_47712 (str.++ T0_5 T1_5)) (= I0_5 (str.len T4_5)) (= 0 (str.len T0_5)) (= T1_5 (str.++ T2_5 T3_5)) (= T2_5 (str.++ T4_5 T5_5)) (= T5_5 "__utmz=218069774.") (not (str.in_re T4_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "z") (str.to_re "=") (str.to_re "2") (str.to_re "1") (str.to_re "8") (str.to_re "0") (str.to_re "6") (str.to_re "9") (str.to_re "7") (str.to_re "7") (str.to_re "4") (str.to_re "."))))) (and (= PCTEMP_LHS_1 (- 1)) (= var_0xINPUT_47712 (str.++ T0_5 T1_5)) (= 0 (str.len T0_5)) (not (str.in_re T1_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "z") (str.to_re "=") (str.to_re "2") (str.to_re "1") (str.to_re "8") (str.to_re "0") (str.to_re "6") (str.to_re "9") (str.to_re "7") (str.to_re "7") (str.to_re "4") (str.to_re ".")))))))
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert T_5)
(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_2 (and (= PCTEMP_LHS_2 (+ I0_8 PCTEMP_LHS_1)) (= var_0xINPUT_47712 (str.++ T0_8 T1_8)) (= I0_8 (str.len T4_8)) (= PCTEMP_LHS_1 (str.len T0_8)) (= T1_8 (str.++ T2_8 T3_8)) (= T2_8 (str.++ T4_8 T5_8)) (= T5_8 ";") (not (str.in_re T4_8 (str.to_re ";")))) (and (= PCTEMP_LHS_2 (- 1)) (= var_0xINPUT_47712 (str.++ T0_8 T1_8)) (= PCTEMP_LHS_1 (str.len T0_8)) (not (str.in_re T1_8 (str.to_re ";"))))))
(assert (= T_7 (< PCTEMP_LHS_2 0)))
(assert (= T_8 (not T_7)))
(assert T_8)
(assert (= T_9 (+ PCTEMP_LHS_1 6)))
(assert (= T_a (+ T_9 1)))
(assert (= I0_14 (- PCTEMP_LHS_2 T_a)))
(assert (>= T_a 0))
(assert (>= PCTEMP_LHS_2 T_a))
(assert (<= PCTEMP_LHS_2 I1_14))
(assert (= I2_14 I1_14))
(assert (= I0_14 (str.len PCTEMP_LHS_3)))
(assert (= var_0xINPUT_47712 (str.++ T1_14 T2_14)))
(assert (= T2_14 (str.++ PCTEMP_LHS_3 T3_14)))
(assert (= T_a (str.len T1_14)))
(assert (= I1_14 (str.len var_0xINPUT_47712)))
(assert (= T_d (= "-" T_c)))
(assert T_d)
(assert (= T_f (= "-" T_e)))
(assert T_f)
(assert (= T_11 (= "-" T_10)))
(assert T_11)
(assert (= T_13 (= "-" T_12)))
(assert T_13)
(assert (= T_15 (= "-" T_14)))
(assert T_15)
(assert (= T_17 (= "-" T_16)))
(assert T_17)

; --- START CONSTRAINT ---

(declare-fun utmz_payload () String)

(assert (>= (num_splits var_0xINPUT_47712 "__utmz=218069774.") 2))
(assert (= utmz_payload (split_rest var_0xINPUT_47712 "__utmz=218069774." 1)))
(assert (>= (num_splits utmz_payload ";") 1))
(assert (= PCTEMP_LHS_3 (split_at utmz_payload ";" 0)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

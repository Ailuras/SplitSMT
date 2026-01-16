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
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun T_1 () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () String)
(declare-fun T_12 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () String)
(declare-fun T_8 () Bool)
(declare-fun T_9 () String)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_a () Bool)
(declare-fun T_b () String)
(declare-fun T_c () Bool)
(declare-fun T_d () String)
(declare-fun T_e () Bool)
(declare-fun T_f () String)
(declare-fun var_0xINPUT_96349 () String)
(assert (= T_1 (= "-" var_0xINPUT_96349)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_96349)))
(assert T_3)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_1 (+ I0_5 0)) (= var_0xINPUT_96349 (str.++ T0_5 T1_5)) (= I0_5 (str.len T4_5)) (= 0 (str.len T0_5)) (= T1_5 (str.++ T2_5 T3_5)) (= T2_5 (str.++ T4_5 T5_5)) (= T5_5 "__utmz=16886264.") (not (str.in_re T4_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "z") (str.to_re "=") (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4") (str.to_re "."))))) (and (= PCTEMP_LHS_1 (- 1)) (= var_0xINPUT_96349 (str.++ T0_5 T1_5)) (= 0 (str.len T0_5)) (not (str.in_re T1_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "z") (str.to_re "=") (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4") (str.to_re ".")))))))
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_6 (not T_5)))
(assert T_6)
(assert (= T_8 (= "-" T_7)))
(assert T_8)
(assert (= T_a (= "-" T_9)))
(assert T_a)
(assert (= T_c (= "-" T_b)))
(assert T_c)
(assert (= T_e (= "-" T_d)))
(assert T_e)
(assert (= T_10 (= "-" T_f)))
(assert T_10)
(assert (= T_12 (= "-" T_11)))
(assert T_12)

; --- START CONSTRAINT ---
; str_split interface function signatures

; New helper variables
(declare-fun delim_utmz () String)
(declare-fun seg0_utmz () String)
(declare-fun seg1_utmz () String)
(declare-fun rest1_utmz () String)

; Split-based constraints over the existing input
(assert (= delim_utmz "__utmz=16886264."))
(assert (>= (num_splits var_0xINPUT_96349 delim_utmz) 1))
(assert (= seg0_utmz (split_at var_0xINPUT_96349 delim_utmz 0)))
(assert (= seg1_utmz (split_at var_0xINPUT_96349 delim_utmz 1)))
(assert (= rest1_utmz (split_rest var_0xINPUT_96349 delim_utmz 1)))
(assert (= var_0xINPUT_96349 (str.++ seg0_utmz rest1_utmz)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

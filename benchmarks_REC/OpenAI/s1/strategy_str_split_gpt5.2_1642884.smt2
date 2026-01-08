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

; Uninterpreted interface functions for string splitting

; Seed-style variables retained (and repurposed)
(declare-fun I0_5 () Int)
(declare-fun I0_8 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun T0_5 () String)
(declare-fun T0_8 () String)
(declare-fun T1_5 () String)
(declare-fun T1_8 () String)
(declare-fun T2_5 () String)
(declare-fun T2_8 () String)
(declare-fun T3_5 () String)
(declare-fun T3_8 () String)
(declare-fun T4_5 () String)
(declare-fun T4_8 () String)
(declare-fun T5_5 () String)
(declare-fun T5_8 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun var_0xINPUT_100767 () String)

; Additional email-validation specific variables
(declare-const localpart String)
(declare-const domain String)
(declare-const tld String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const forbidden_dotdot Bool)
(declare-const forbidden_atat Bool)
(declare-const has_at Bool)

; Core email structure via split
(assert (= localpart (split_at var_0xINPUT_100767 "@" 0)))
(assert (= domain (split_at var_0xINPUT_100767 "@" 1)))
(assert (>= (num_splits var_0xINPUT_100767 "@") 2))
(assert (= (num_splits var_0xINPUT_100767 "@") 2))
(assert (>= (str.len localpart) 1))
(assert (>= (str.len domain) 1))

; Domain must contain dots and end with a TLD
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))

; Forbid pathological patterns
(assert (= forbidden_dotdot (str.contains var_0xINPUT_100767 "..")))
(assert (not forbidden_dotdot))
(assert (= forbidden_atat (str.contains var_0xINPUT_100767 "@@")))
(assert (not forbidden_atat))
(assert (not (str.contains localpart " ")))
(assert (not (str.contains domain " ")))

; Seed-like boolean scaffolding, mutated to be meaningful for email
(assert (= T_1 (= "-" var_0xINPUT_100767)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_100767)))
(assert (not T_3))

; Repurpose PCTEMP_LHS_1/PCTEMP_LHS_2 as indices derived from lengths and enforce sane ranges
(assert (= PCTEMP_LHS_1 (str.len localpart)))
(assert (= PCTEMP_LHS_2 (str.len domain)))
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert T_5)

; Additional seed-style ite blocks, now tied to '@' and '.' structure (still purely constraints)
(assert (= T_SELECT_1 (not (= I0_5 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= I0_5 (str.len T4_5))
    (= var_0xINPUT_100767 (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (= T1_5 (str.++ T2_5 T3_5))
    (= T2_5 (str.++ T4_5 T5_5))
    (= T5_5 "@")
    ; localpart must not contain '@'
    (not (str.contains T4_5 "@"))
    ; localpart must match the extracted one
    (= T4_5 localpart))
  (and
    (= I0_5 (- 1))
    (= var_0xINPUT_100767 (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (not (str.contains T1_5 "@"))
  )))

(assert (= T_SELECT_2 (not (= I0_8 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= I0_8 (str.len T4_8))
    (= domain (str.++ T0_8 T1_8))
    (= 0 (str.len T0_8))
    (= T1_8 (str.++ T2_8 T3_8))
    (= T2_8 (str.++ T4_8 T5_8))
    (= T5_8 ".")
    ; domain_label0 is first label before dot
    (= T4_8 domain_label0)
    (>= (str.len domain_label0) 1)
    (not (str.contains domain_label0 "-"))
  )
  (and
    (= I0_8 (- 1))
    (= domain (str.++ T0_8 T1_8))
    (= 0 (str.len T0_8))
    (not (str.contains T1_8 "."))
  )))

; UNSAT twist: require domain to have at least one dot (already asserted),
; but also enforce that it contains no dot via split_rest constraint.
; This makes the instance UNSAT while preserving the email-validation core structure.
(assert (= (split_rest domain "." 0) domain))
(assert (not (str.contains (split_rest domain "." 0) ".")))

; Reuse T_7 as a final contradictory check, in seed style but tied to domain length
(assert (= T_7 (< PCTEMP_LHS_2 0)))
(assert T_7)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

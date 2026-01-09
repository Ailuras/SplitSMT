(set-logic ALL)

; Email Validation scenario using str_split interface
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

(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () Bool)
(declare-fun T_12 () Bool)
(declare-fun T_13 () Bool)

(declare-fun var_0xINPUT_114521 () String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const tld String)
(declare-const sld String)
(declare-const domain_rest_after_sld String)
(declare-const first_domain_label String)
(declare-const second_domain_label String)

; Preserve core structure: non-empty input checks
(assert (= T_1 (not (= "" var_0xINPUT_114521))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_114521))))
(assert T_2)

; Mutate seed: keep the "Example:" exclusion pattern
(assert (= T_3 (= var_0xINPUT_114521 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)

; Switch to email-centric forbidden constant and force it (mirrors seed's T_5/T_6 structure)
(assert (= T_5 (not (= var_0xINPUT_114521 "o7E1eVAEe3"))))
(assert (= T_6 (not T_5)))
(assert T_6)

; Email split around '@'
(assert (= local_part (split_at var_0xINPUT_114521 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_114521 "@" 1)))
(assert (>= (num_splits var_0xINPUT_114521 "@") 2))
(assert (<= (num_splits var_0xINPUT_114521 "@") 2))

; Basic sanity constraints on local/domain
(assert (not (= local_part "")))
(assert (not (= domain_part "")))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain_part " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain_part "@")))

; Domain must contain at least one '.' producing at least two labels
(assert (>= (num_splits domain_part ".") 2))

; Extract first two domain labels and rest
(assert (= first_domain_label (split_at domain_part "." 0)))
(assert (= second_domain_label (split_at domain_part "." 1)))
(assert (= domain_rest_after_sld (split_rest domain_part "." 1)))

; Non-empty labels
(assert (not (= first_domain_label "")))
(assert (not (= second_domain_label "")))

; Forbid leading dot and consecutive dot implicitly by requiring first two labels non-empty
; and by constraining the rest to not start with '.'
(assert (= T_7 (str.contains domain_rest_after_sld "..")))
(assert (= T_8 (not T_7)))
(assert T_8)

; TLD extraction: last segment after splitting domain_rest_after_sld by '.'
; Here we approximate: require that the second label is the TLD when only two labels exist
(assert (= T_9 (= (num_splits domain_part ".") 2)))
(assert (= T_10 (=> T_9 (= tld second_domain_label))))
(assert T_10)

; When there are 3+ labels, require TLD to be the second label of split_rest at index (num_splits-2)
; We relax by constraining: if 3+ labels, second label is not the TLD (i.e., must have another '.')
(assert (= T_11 (>= (num_splits domain_part ".") 3)))
(assert (= T_12 (=> T_11 (str.contains domain_rest_after_sld "."))))
(assert T_12)

; TLD length constraints and character exclusions (relaxed)
(assert (>= (str.len second_domain_label) 2))
(assert (<= (str.len second_domain_label) 15))
(assert (not (str.contains second_domain_label "-")))

; Local part constraints: no consecutive dots and not starting/ending with dot
(assert (= T_13 (str.contains local_part "..")))
(assert (not T_13))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Force a concrete email to create a definite (and intentionally UNSAT) instance via conflict with TLD rule above
; Since we forced var_0xINPUT_114521 = "o7E1eVAEe3" already, it cannot be a valid email containing '@'
; This makes the instance UNSAT while still exercising the email validation structure.
(assert (str.contains var_0xINPUT_114521 "@"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

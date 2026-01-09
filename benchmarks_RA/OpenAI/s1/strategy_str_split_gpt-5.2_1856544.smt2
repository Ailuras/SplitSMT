(set-logic ALL)

; Uninterpreted split interface for email validation
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

; Seed-style boolean structure retained and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)

(declare-fun U_1 () Bool)
(declare-fun U_2 () Bool)
(declare-fun U_3 () Bool)
(declare-fun U_4 () Bool)
(declare-fun U_5 () Bool)

; Input email string
(declare-fun var_0xINPUT_109105 () String)

; Segment variables for readability
(declare-const local_part String)
(declare-const domain_full String)
(declare-const domain_label0 String)
(declare-const tld String)
(declare-const domain_rest_from1 String)

; Basic non-triviality constraints (mutated from seed)
(assert (= T_1 (= "-" var_0xINPUT_109105)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_109105)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email must contain exactly one '@' -> num_splits with '@' equals 2 segments
(assert (= T_5 (= (num_splits var_0xINPUT_109105 "@") 2)))
(assert T_5)

; Bind local and domain using split_at
(assert (= local_part (split_at var_0xINPUT_109105 "@" 0)))
(assert (= domain_full (split_at var_0xINPUT_109105 "@" 1)))

; Local and domain must be non-empty
(assert (= T_6 (and (> (str.len local_part) 0) (> (str.len domain_full) 0))))
(assert T_6)

; Local part must not contain '@'
(assert (= T_7 (not (str.contains local_part "@"))))
(assert T_7)

; Domain must not contain '@'
(assert (= T_8 (not (str.contains domain_full "@"))))
(assert T_8)

; Domain structure: at least one '.' (e.g., example.com)
(assert (= U_1 (>= (num_splits domain_full ".") 2)))
(assert U_1)

; Extract first domain label and the last segment (tld) via split interface
(assert (= domain_label0 (split_at domain_full "." 0)))
(assert (= domain_rest_from1 (split_rest domain_full "." 1)))

; Ensure first label non-empty and does not contain '.'
(assert (= U_2 (and (> (str.len domain_label0) 0) (not (str.contains domain_label0 ".")))))
(assert U_2)

; Enforce that the "rest from 1" is the remaining domain; must contain at least one segment
(assert (= U_3 (> (str.len domain_rest_from1) 0)))
(assert U_3)

; Define tld as the last split element by constraining it to be a suffix after the final '.'
; (We don't have direct last-index access, so we conservatively constrain via split_at at index 1 when exactly two segments)
(assert (= U_4 (=> (= (num_splits domain_full ".") 2)
                  (= tld (split_at domain_full "." 1)))))
(assert U_4)

; TLD constraints: length between 2 and 10 when defined in the 2-segment domain case
(assert (= U_5 (=> (= (num_splits domain_full ".") 2)
                  (and (>= (str.len tld) 2) (<= (str.len tld) 10)))))
(assert U_5)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

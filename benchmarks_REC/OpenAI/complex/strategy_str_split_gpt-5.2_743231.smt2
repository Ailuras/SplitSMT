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

; Uninterpreted functions for str_split interface

; Seed-style boolean guards
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Input email
(declare-fun var_0xINPUT_161005 () String)

; Basic non-triviality constraints (mutated from seed)
(assert (= T_1 (= "-" var_0xINPUT_161005)))
(assert (= T_2 (not T_1)))
(assert T_2)

(assert (= T_3 (= "" var_0xINPUT_161005)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email must contain exactly one '@' -> 2 segments when splitting by '@'
(assert (= T_5 (= (num_splits var_0xINPUT_161005 "@") 2)))
(assert T_5)

; Split into local and domain parts
(declare-const local_part String)
(declare-const domain_part String)
(assert (= local_part (split_at var_0xINPUT_161005 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_161005 "@" 1)))

; Local part constraints
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "..")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Domain part: must contain at least one '.' => at least 2 segments
(assert (>= (num_splits domain_part ".") 2))

; Domain labels cannot be empty and cannot start/end with '-'
(declare-const dom_label0 String)
(declare-const tld String)
(assert (= dom_label0 (split_at domain_part "." 0)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))

(assert (> (str.len dom_label0) 0))
(assert (> (str.len tld) 1))

(assert (not (= (str.at dom_label0 0) "-")))
(assert (not (= (str.at dom_label0 (- (str.len dom_label0) 1)) "-")))

(assert (not (= (str.at tld 0) "-")))
(assert (not (= (str.at tld (- (str.len tld) 1)) "-")))

; Domain must not contain spaces, consecutive dots, or '@'
(assert (not (str.contains domain_part " ")))
(assert (not (str.contains domain_part "..")))
(assert (not (str.contains domain_part "@")))

; Ensure at least one dot occurs after '@' (using split_rest for core-structure diversity)
(declare-const after_first_dot String)
(assert (= after_first_dot (split_rest domain_part "." 1)))
(assert (> (str.len after_first_dot) 0))

; Additional consistency: recomposition constraints for split behavior (relaxed)
(assert (= (str.++ local_part "@" domain_part) var_0xINPUT_161005))

; SAT branch with a concrete witness
(assert (= T_6 (= var_0xINPUT_161005 "alice.smith@sub.example.com")))
(assert T_6)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

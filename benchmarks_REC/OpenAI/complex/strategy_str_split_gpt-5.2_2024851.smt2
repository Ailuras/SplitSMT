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

; Seed-style Boolean structure (preserved but extended)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; Email input and derived parts
(declare-fun var_0xINPUT_54124 () String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const rest_after_tld String)

; Core split structure: local@domain
(assert (= local_part (split_at var_0xINPUT_54124 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_54124 "@" 1)))

; Basic non-emptiness checks
(assert (= T_1 (not (= "" var_0xINPUT_54124))))
(assert (= T_3 (and (not (= "" local_part)) (not (= "" domain_part)))))

; Exactly one '@' => two segments
(assert (= T_4 (= (num_splits var_0xINPUT_54124 "@") 2)))

; Domain must have at least two dot-separated labels
(assert (>= (num_splits domain_part ".") 2))

; Extract first two domain labels and the last (TLD)
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))
(assert (= rest_after_tld (split_rest domain_part "." (- (num_splits domain_part ".") 1))))

; Domain label non-emptiness and simple structure constraints
(assert (not (= "" domain_label0)))
(assert (not (= "" domain_label1)))
(assert (not (= "" tld)))

; No empty segments caused by consecutive dots: forbid ".." in domain
(assert (not (str.contains domain_part "..")))

; '.' must appear in domain (redundant with num_splits>=2, but explicit)
(assert (str.contains domain_part "."))

; Local part constraints: must not contain '@', and must not start/end with '.'
(assert (not (str.contains local_part "@")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; TLD length constraints (2..24)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Consistency: splitting at '.' at the last segment should yield exactly the TLD as rest
(assert (= rest_after_tld tld))

; UNSAT core-style toggle preserved from seed, but now tied to email validity
(assert (= T_2 (not (and T_1 T_3 T_4))))
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

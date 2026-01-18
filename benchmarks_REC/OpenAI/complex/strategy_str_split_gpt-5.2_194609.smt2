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

; CSV Processing: comma-separated field validation and empty-field detection

(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

(declare-const var_0xINPUT_40963 String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const n Int)

; str_split interface

(assert (= delim ","))

; Preserve core structure: input must be non-empty and not equal to a specific token
(assert (= T_1 (not (= "" var_0xINPUT_40963))))
(assert T_1)
(assert (= T_2 (not (= var_0xINPUT_40963 "6JX7G3VKFq"))))
(assert T_2)

; CSV constraints: exactly 3 fields and split projections
(assert (= n (num_splits var_0xINPUT_40963 delim)))
(assert (= T_3 (= n 3)))
(assert T_3)

(assert (= f0 (split_at var_0xINPUT_40963 delim 0)))
(assert (= f1 (split_at var_0xINPUT_40963 delim 1)))
(assert (= f2 (split_at var_0xINPUT_40963 delim 2)))
(assert (= rest1 (split_rest var_0xINPUT_40963 delim 1)))
(assert (= rest2 (split_rest var_0xINPUT_40963 delim 2)))

; Reconstructability checks (relaxation-friendly sanity constraints)
(assert (= var_0xINPUT_40963 (str.++ f0 delim rest1)))
(assert (= rest1 (str.++ f1 delim rest2)))
(assert (= rest2 f2))

; Detect empty fields: require at least one empty field among the 3
(assert (= T_4 (or (= f0 "") (= f1 "") (= f2 ""))))
(assert T_4)

; Additional CSV hygiene: disallow delimiter inside individual fields
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))

; Example quality constraints: first field looks like an ID and third field is numeric-ish
(assert (>= (str.len f0) 1))
(assert (or (= f2 "") (and (>= (str.len f2) 1) (<= (str.len f2) 5))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

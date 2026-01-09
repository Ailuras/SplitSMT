(set-logic ALL)

; Uninterpreted interface functions for str_split
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

; Scenario 1 (SAT): CSV processing with 4 fields, detects an empty third field
(declare-const csv1 String)
(declare-const f1_0 String)
(declare-const f1_1 String)
(declare-const f1_2 String)
(declare-const f1_3 String)
(declare-const tail1_2 String)
(declare-const tail1_3 String)

(assert (= csv1 "alpha,beta,,delta"))
(assert (= (num_splits csv1 ",") 4))
(assert (= f1_0 (split_at csv1 "," 0)))
(assert (= f1_1 (split_at csv1 "," 1)))
(assert (= f1_2 (split_at csv1 "," 2)))
(assert (= f1_3 (split_at csv1 "," 3)))

; Field content expectations
(assert (= f1_0 "alpha"))
(assert (= f1_1 "beta"))
(assert (= f1_2 ""))
(assert (= f1_3 "delta"))

; Rest-from-k constraints and consistency checks
(assert (= tail1_2 (split_rest csv1 "," 2)))
(assert (= tail1_3 (split_rest csv1 "," 3)))
(assert (= tail1_2 ",delta"))
(assert (= tail1_3 "delta"))
(assert (str.contains csv1 ",,"))
(assert (>= (str.len f1_3) 1))

; Index domain constraints (natural and within segment count)
(assert (and (<= 0 0) (< 0 (num_splits csv1 ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv1 ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv1 ","))))
(assert (and (<= 0 3) (< 3 (num_splits csv1 ","))))

; Additional CSV sanity: no whitespace inside fields for this row
(assert (not (str.contains f1_0 " ")))
(assert (not (str.contains f1_1 " ")))
(assert (not (str.contains f1_3 " ")))

(check-sat)

; Scenario 2 (UNSAT): contradictory constraints about empty field vs non-empty
(declare-const csv2 String)
(declare-const g2_0 String)
(declare-const g2_1 String)
(declare-const g2_2 String)
(declare-const g2_3 String)

(assert (= csv2 "a,b,c,d"))
(assert (= (num_splits csv2 ",") 4))
(assert (= g2_2 (split_at csv2 "," 2)))

; Contradiction: third field is "c" but also required to be empty
(assert (= g2_2 "c"))
(assert (= g2_2 ""))

(check-sat)
(exit)

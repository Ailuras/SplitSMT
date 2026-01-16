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
(declare-fun key2 () String)
(declare-fun value2 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (str.contains (str.++ (str.replace (str.substr value2 0 (- (+ (str.indexof value2 "P" 0) 1) 0)) "P" "p") (str.substr value2 (+ (str.indexof value2 "P" 0) 1) (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)))) "T") 1 0) 0)))) (not (not (= (ite (str.contains (str.++ (str.replace (str.substr value2 0 (- (+ (str.indexof value2 "P" 0) 1) 0)) "P" "p") (str.substr value2 (+ (str.indexof value2 "P" 0) 1) (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)))) "S") 1 0) 0)))) (not (not (= (ite (str.contains (str.++ (str.replace (str.substr value2 0 (- (+ (str.indexof value2 "P" 0) 1) 0)) "P" "p") (str.substr value2 (+ (str.indexof value2 "P" 0) 1) (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)))) "R") 1 0) 0)))) (not (not (= (ite (str.contains (str.++ (str.replace (str.substr value2 0 (- (+ (str.indexof value2 "P" 0) 1) 0)) "P" "p") (str.substr value2 (+ (str.indexof value2 "P" 0) 1) (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)))) "Q") 1 0) 0)))) (not (not (= (ite (str.contains (str.substr value2 (+ (str.indexof value2 "P" 0) 1) (- (str.len value2) (+ (str.indexof value2 "P" 0) 1))) "P") 1 0) 0)))) (not (= (ite (str.contains value2 "P") 1 0) 0))) (not (not (= (ite (str.contains value2 "O") 1 0) 0)))) (not (not (= (ite (str.contains value2 "N") 1 0) 0)))) (not (not (= (ite (str.contains value2 "M") 1 0) 0)))) (not (not (= (ite (str.contains value2 "L") 1 0) 0)))) (not (not (= (ite (str.contains value2 "K") 1 0) 0)))) (not (not (= (ite (str.contains value2 "J") 1 0) 0)))) (not (not (= (ite (str.contains value2 "I") 1 0) 0)))) (not (not (= (ite (str.contains value2 "H") 1 0) 0)))) (not (not (= (ite (str.contains value2 "G") 1 0) 0)))) (not (not (= (ite (str.contains value2 "F") 1 0) 0)))) (not (not (= (ite (str.contains value2 "E") 1 0) 0)))) (not (not (= (ite (str.contains value2 "D") 1 0) 0)))) (not (not (= (ite (str.contains value2 "C") 1 0) 0)))) (not (not (= (ite (str.contains value2 "B") 1 0) 0)))) (not (not (= (ite (str.contains value2 "A") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (>= 0 0)) (>= (- (+ (str.indexof value2 "P" 0) 1) 0) 0)) (>= (+ (str.indexof value2 "P" 0) 1) 0)) (>= (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)) 0)) (>= 0 0)) (>= (- (+ (str.indexof value2 "P" 0) 1) 0) 0)) (>= (+ (str.indexof value2 "P" 0) 1) 0)) (>= (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)) 0)) (>= 0 0)) (>= (- (+ (str.indexof value2 "P" 0) 1) 0) 0)) (>= (+ (str.indexof value2 "P" 0) 1) 0)) (>= (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)) 0)) (>= 0 0)) (>= (- (+ (str.indexof value2 "P" 0) 1) 0) 0)) (>= (+ (str.indexof value2 "P" 0) 1) 0)) (>= (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)) 0)) (>= (+ (str.indexof value2 "P" 0) 1) 0)) (>= (- (str.len value2) (+ (str.indexof value2 "P" 0) 1)) 0)))

; --- START CONSTRAINT ---

(declare-fun cc_first () String)
(declare-fun cc_rest () String)

(assert (= cc_first (split_at value2 "," 0)))
(assert (= cc_rest (split_rest value2 "," 1)))
(assert (>= (num_splits value2 ",") 1))
(assert (<= 1 (num_splits value2 "=")))
(assert (= (split_at value2 "=" 0) (split_at cc_first "=" 0)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

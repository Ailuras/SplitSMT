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
(declare-fun key1 () String)
(declare-fun value2 () String)
(declare-fun key2 () String)
(declare-fun value1 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.len (str.substr value1 (+ (str.indexof value1 "=" 0) 1) (- (str.len value1) (+ (str.indexof value1 "=" 0) 1)))) 0) 1 0) 0)))) (not (= (ite (str.contains value1 "=") 1 0) 0))) (not (not (= (ite (= (str.len value1) 0) 1 0) 0)))) (not (= (ite (not (= (str.indexof value1 "=" 0) (- 1))) 1 0) 0))) (not (not (= (ite (str.contains value1 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value1) 0) 1 0) 0)))) (not (= (ite (= key1 "cache-control") 1 0) 0))) (not (= (ite (= key1 "cache-control") 1 0) 0))) (not (not (= (ite (str.contains value2 "Z") 1 0) 0)))) (not (not (= (ite (str.contains value2 "Y") 1 0) 0)))) (not (not (= (ite (str.contains value2 "X") 1 0) 0)))) (not (not (= (ite (str.contains value2 "W") 1 0) 0)))) (not (not (= (ite (str.contains value2 "V") 1 0) 0)))) (not (not (= (ite (str.contains value2 "U") 1 0) 0)))) (not (not (= (ite (str.contains value2 "T") 1 0) 0)))) (not (not (= (ite (str.contains value2 "S") 1 0) 0)))) (not (not (= (ite (str.contains value2 "R") 1 0) 0)))) (not (not (= (ite (str.contains value2 "Q") 1 0) 0)))) (not (not (= (ite (str.contains value2 "P") 1 0) 0)))) (not (not (= (ite (str.contains value2 "O") 1 0) 0)))) (not (not (= (ite (str.contains value2 "N") 1 0) 0)))) (not (not (= (ite (str.contains value2 "M") 1 0) 0)))) (not (not (= (ite (str.contains value2 "L") 1 0) 0)))) (not (not (= (ite (str.contains value2 "K") 1 0) 0)))) (not (not (= (ite (str.contains value2 "J") 1 0) 0)))) (not (not (= (ite (str.contains value2 "I") 1 0) 0)))) (not (not (= (ite (str.contains value2 "H") 1 0) 0)))) (not (not (= (ite (str.contains value2 "G") 1 0) 0)))) (not (not (= (ite (str.contains value2 "F") 1 0) 0)))) (not (not (= (ite (str.contains value2 "E") 1 0) 0)))) (not (not (= (ite (str.contains value2 "D") 1 0) 0)))) (not (not (= (ite (str.contains value2 "C") 1 0) 0)))) (not (not (= (ite (str.contains value2 "B") 1 0) 0)))) (not (not (= (ite (str.contains value2 "A") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (>= (+ (str.indexof value1 "=" 0) 1) 0)) (>= (- (str.len value1) (+ (str.indexof value1 "=" 0) 1)) 0)))

; --- START CONSTRAINT ---

(declare-fun v1_key () String)
(declare-fun v1_val () String)
(declare-fun v2_key () String)
(declare-fun v2_val () String)

(assert (>= (num_splits value1 "=") 2))
(assert (= v1_key (split_at value1 "=" 0)))
(assert (= v1_val (split_rest value1 "=" 1)))

(assert (>= (num_splits value2 "=") 2))
(assert (= v2_key (split_at value2 "=" 0)))
(assert (= v2_val (split_rest value2 "=" 1)))

(assert (and (not (= v1_key "")) (not (= v1_val ""))))
(assert (and (not (= v2_key "")) (not (= v2_val ""))))

(assert (= v1_key key1))
(assert (= v2_key key2))

(assert (>= (num_splits value1 ",") 2))
(assert (= (split_at value1 "," 0) (split_at value1 "," 0)))
(assert (= (split_rest value1 "," 1) (split_rest value1 "," 1)))

(assert (>= (num_splits value2 ",") 2))
(assert (= (split_at value2 "," 0) (split_at value2 "," 0)))
(assert (= (split_rest value2 "," 1) (split_rest value2 "," 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

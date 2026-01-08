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

; Uninterpreted string split interface for CSV processing

; CSV input and extracted fields
(declare-const csv String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail1 String)
(declare-const tail2 String)

; Keep a mutated fragment of the seed's "core structure" idea: contradictory regex + empty string
(declare-const x String)
(assert (str.in_re x (re.++ (str.to_re "bb") (re.+ (str.to_re "1'' ''")))))
(assert (str.in_re x (re.++ (re.+ (re.* (str.to_re "7"))) (re.++ (str.to_re "'' ''L'' ''") (str.to_re "a")))))
(assert (= 0 (str.len x)))

; CSV structure constraints
(assert (= f0 (split_at csv "," 0)))
(assert (= f1 (split_at csv "," 1)))
(assert (= f2 (split_at csv "," 2)))
(assert (= tail1 (split_rest csv "," 1)))
(assert (= tail2 (split_rest csv "," 2)))

; Expect exactly 3 fields (i.e., 2 commas) and enforce valid indices
(assert (= (num_splits csv ",") 3))
(assert (and (<= 0 0) (< 0 (num_splits csv ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv ","))))

; Empty-field detection: require middle field empty, others non-empty
(assert (= f1 ""))
(assert (> (str.len f0) 0))
(assert (> (str.len f2) 0))

; Basic sanitation: no field contains a comma
(assert (not (str.contains f0 ",")))
(assert (not (str.contains f1 ",")))
(assert (not (str.contains f2 ",")))

; Tail consistency (semantic constraints without defining split behavior)
(assert (>= (str.len tail1) (str.len f1)))
(assert (>= (str.len tail2) (str.len f2)))

; Additional contradictory constraint to make this instance UNSAT
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

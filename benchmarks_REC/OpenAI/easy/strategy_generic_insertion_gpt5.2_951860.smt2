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
(declare-fun s () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (>= (- (- (- (- (- (str.len s) 1) 1) 1) 1) 1) 4) 1 0) 0)))) (not (= (ite (>= (- (- (- (- (- (str.len s) 1) 1) 1) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 4) 1 0) 0))) (not (= (ite (= (str.at s 3) (str.at s (- (- (- (- (str.len s) 1) 1) 1) 1))) 1 0) 0))) (not (= (ite (>= (- (- (- (- (str.len s) 1) 1) 1) 1) 3) 1 0) 0))) (not (= (ite (>= (- (- (- (- (str.len s) 1) 1) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 3) 1 0) 0))) (not (= (ite (= (str.at s 2) (str.at s (- (- (- (str.len s) 1) 1) 1))) 1 0) 0))) (not (= (ite (>= (- (- (- (str.len s) 1) 1) 1) 2) 1 0) 0))) (not (= (ite (>= (- (- (- (str.len s) 1) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 2) 1 0) 0))) (not (= (ite (= (str.at s 1) (str.at s (- (- (str.len s) 1) 1))) 1 0) 0))) (not (= (ite (>= (- (- (str.len s) 1) 1) 1) 1 0) 0))) (not (= (ite (>= (- (- (str.len s) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 1) 1 0) 0))) (not (= (ite (= (str.at s 0) (str.at s (- (str.len s) 1))) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 0) 1 0) 0))))

; --- START CONSTRAINT ---

(declare-fun delim () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (= delim "|"))
(assert (>= (num_splits s delim) 2))
(assert (= seg0 (split_at s delim 0)))
(assert (= seg1 (split_at s delim 1)))
(assert (= rest1 (split_rest s delim 1)))
(assert (= rest1 (str.++ seg1 delim (split_rest s delim 2))))
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

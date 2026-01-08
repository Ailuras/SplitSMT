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
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.union (re.* (str.to_re "00")) (re.+ (str.to_re "111"))) (re.++ (re.* (re.union (str.to_re "22") (str.to_re "3"))) (re.++ (re.+ (re.* (str.to_re "44"))) (re.++ (re.+ (re.union (str.to_re "555") (str.to_re "666"))) (re.++ (re.union (re.* (str.to_re "777")) (re.union (str.to_re "888") (str.to_re "99"))) (re.++ (re.* (re.* (str.to_re "a"))) (re.++ (re.+ (re.* (str.to_re "bb"))) (re.++ (re.+ (re.+ (str.to_re "c"))) (re.++ (re.* (re.* (str.to_re "dd"))) (re.++ (re.+ (re.+ (str.to_re "ee"))) (re.++ (re.+ (re.+ (str.to_re "fff"))) (re.++ (re.* (re.* (str.to_re "gg"))) (re.++ (re.* (re.* (str.to_re "hhh"))) (re.++ (re.* (re.union (str.to_re "i") (str.to_re "j"))) (re.++ (re.union (re.* (str.to_re "k")) (re.+ (str.to_re "l"))) (re.++ (re.+ (re.+ (str.to_re "mm"))) (re.++ (re.+ (re.* (str.to_re "nn"))) (re.++ (re.+ (re.+ (str.to_re "o"))) (re.++ (re.+ (re.+ (str.to_re "p"))) (re.++ (re.+ (re.* (str.to_re "qqq"))) (re.++ (re.+ (re.union (str.to_re "rrr") (str.to_re "ss"))) (re.++ (re.union (re.union (str.to_re "tt") (str.to_re "uu")) (re.* (str.to_re "v"))) (re.++ (re.* (re.union (str.to_re "www") (str.to_re "x"))) (re.++ (re.union (re.* (str.to_re "y")) (re.* (str.to_re "zz"))) (re.++ (re.+ (re.+ (str.to_re "A"))) (re.+ (re.* (str.to_re "BBB"))))))))))))))))))))))))))))))
(assert (not (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "000") (str.to_re "11"))) (re.++ (re.* (re.+ (str.to_re "2"))) (re.++ (re.+ (re.+ (str.to_re "3"))) (re.++ (re.* (re.union (str.to_re "4") (str.to_re "5"))) (re.++ (re.+ (re.* (str.to_re "6"))) (re.++ (re.+ (re.+ (str.to_re "77"))) (re.++ (re.+ (re.union (str.to_re "88") (str.to_re "999"))) (re.++ (re.* (re.* (str.to_re "a"))) (re.++ (re.+ (re.* (str.to_re "bbb"))) (re.++ (re.+ (re.union (str.to_re "ccc") (str.to_re "dd"))) (re.++ (re.union (re.* (str.to_re "ee")) (re.* (str.to_re "fff"))) (re.++ (re.+ (re.* (str.to_re "ggg"))) (re.++ (re.+ (re.union (str.to_re "hh") (str.to_re "iii"))) (re.++ (re.* (re.union (str.to_re "jj") (str.to_re "k"))) (re.++ (re.* (re.+ (str.to_re "l"))) (re.++ (re.union (re.union (str.to_re "mm") (str.to_re "nnn")) (re.* (str.to_re "ooo"))) (re.++ (re.+ (re.* (str.to_re "p"))) (re.++ (re.+ (re.+ (str.to_re "qqq"))) (re.++ (re.+ (re.union (str.to_re "r") (str.to_re "s"))) (re.++ (re.+ (re.+ (str.to_re "t"))) (re.++ (re.union (re.* (str.to_re "u")) (re.union (str.to_re "v") (str.to_re "www"))) (re.++ (re.+ (re.* (str.to_re "xx"))) (re.++ (re.* (re.union (str.to_re "y") (str.to_re "z"))) (re.++ (re.union (re.+ (str.to_re "AA")) (re.union (str.to_re "B") (str.to_re "CC"))) (re.++ (re.+ (re.* (str.to_re "D"))) (re.* (re.+ (str.to_re "E")))))))))))))))))))))))))))))))

; --- START CONSTRAINT ---
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (>= (num_splits var0 "a") 2))
(assert (= seg0 (split_at var0 "a" 0)))
(assert (= seg1 (split_at var0 "a" 1)))
(assert (= rest1 (split_rest var0 "a" 1)))
(assert (not (str.contains seg0 "a")))
(assert (not (str.contains seg1 "a")))
(assert (str.prefixof seg1 rest1))
(assert (>= (str.len seg0) 0))
(assert (>= (str.len seg1) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

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
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "000") (str.to_re "1"))) (re.++ (re.* (re.* (str.to_re "2"))) (re.++ (re.+ (re.+ (str.to_re "33"))) (re.++ (re.* (re.* (str.to_re "44"))) (re.++ (re.* (re.union (str.to_re "55") (str.to_re "666"))) (re.++ (re.+ (re.* (str.to_re "77"))) (re.++ (re.* (re.union (str.to_re "8") (str.to_re "9"))) (re.++ (re.+ (re.+ (str.to_re "a"))) (re.++ (re.* (re.union (str.to_re "bbb") (str.to_re "c"))) (re.++ (re.union (re.* (str.to_re "d")) (re.union (str.to_re "eee") (str.to_re "fff"))) (re.++ (re.* (re.union (str.to_re "ggg") (str.to_re "hh"))) (re.++ (re.* (re.union (str.to_re "i") (str.to_re "j"))) (re.++ (re.+ (re.+ (str.to_re "k"))) (re.++ (re.* (re.union (str.to_re "l") (str.to_re "mmm"))) (re.++ (re.+ (re.+ (str.to_re "nn"))) (re.++ (re.* (re.union (str.to_re "o") (str.to_re "p"))) (re.++ (re.* (re.+ (str.to_re "qq"))) (re.++ (re.+ (re.+ (str.to_re "rr"))) (re.++ (re.+ (re.+ (str.to_re "s"))) (re.++ (re.* (re.+ (str.to_re "ttt"))) (re.++ (re.* (re.union (str.to_re "uu") (str.to_re "v"))) (re.++ (re.union (re.* (str.to_re "w")) (re.union (str.to_re "xx") (str.to_re "yy"))) (re.++ (re.+ (re.+ (str.to_re "zz"))) (re.++ (re.union (re.* (str.to_re "AA")) (re.+ (str.to_re "BBB"))) (re.++ (re.+ (re.* (str.to_re "C"))) (re.++ (re.+ (re.* (str.to_re "DD"))) (re.++ (re.+ (re.+ (str.to_re "EE"))) (re.++ (re.* (re.+ (str.to_re "FF"))) (re.++ (re.* (re.+ (str.to_re "GGG"))) (re.++ (re.* (re.+ (str.to_re "HH"))) (re.++ (re.* (re.union (str.to_re "II") (str.to_re "JJJ"))) (re.++ (re.+ (re.* (str.to_re "KK"))) (re.++ (re.union (re.* (str.to_re "LLL")) (re.union (str.to_re "M") (str.to_re "NNN"))) (re.++ (re.union (re.* (str.to_re "O")) (re.union (str.to_re "P") (str.to_re "Q"))) (re.++ (re.+ (re.* (str.to_re "RRR"))) (re.++ (re.+ (re.union (str.to_re "SS") (str.to_re "T"))) (re.++ (re.union (re.* (str.to_re "UUU")) (re.+ (str.to_re "VVV"))) (re.++ (re.* (re.union (str.to_re "W") (str.to_re "XXX"))) (re.++ (re.union (re.+ (str.to_re "YYY")) (re.union (str.to_re "Z") (str.to_re "!!!"))) (re.++ (re.+ (re.* (str.to_re """"))) (re.++ (re.union (re.+ (str.to_re "#")) (re.+ (str.to_re "$$"))) (re.++ (re.* (re.* (str.to_re "%%%"))) (re.++ (re.* (re.union (str.to_re "&") (str.to_re "'"))) (re.++ (re.* (re.* (str.to_re "(("))) (re.++ (re.* (re.union (str.to_re ")") (str.to_re "***"))) (re.++ (re.union (re.* (str.to_re "++")) (re.+ (str.to_re ",,,"))) (re.++ (re.* (re.+ (str.to_re "---"))) (re.++ (re.+ (re.* (str.to_re "."))) (re.++ (re.* (re.+ (str.to_re "///"))) (re.++ (re.* (re.union (str.to_re "::") (str.to_re ";"))) (re.++ (re.* (re.union (str.to_re "<") (str.to_re "=="))) (re.++ (re.+ (re.+ (str.to_re ">"))) (re.++ (re.+ (re.+ (str.to_re "???"))) (re.++ (re.union (re.union (str.to_re "@@") (str.to_re "[")) (re.+ (str.to_re "\\\\\\"))) (re.* (re.union (str.to_re "]") (str.to_re "^")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

; --- START CONSTRAINT ---

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const rest1 String)
(declare-const ns Int)

(assert (= ns (num_splits var0 "33")))
(assert (>= ns 2))
(assert (= seg0 (split_at var0 "33" 0)))
(assert (= seg1 (split_at var0 "33" 1)))
(assert (= rest1 (split_rest var0 "33" 1)))
(assert (= var0 (str.++ seg0 "33" rest1)))
(assert (not (str.contains seg0 "33")))
(assert (not (str.contains seg1 "33")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

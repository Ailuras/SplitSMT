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
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "000") (str.to_re "11"))) (re.++ (re.union (re.+ (str.to_re "2")) (re.+ (str.to_re "33"))) (re.++ (re.+ (re.* (str.to_re "44"))) (re.++ (re.union (re.union (str.to_re "55") (str.to_re "666")) (re.+ (str.to_re "7"))) (re.++ (re.union (re.+ (str.to_re "88")) (re.union (str.to_re "9") (str.to_re "aa"))) (re.++ (re.union (re.+ (str.to_re "bbb")) (re.* (str.to_re "cc"))) (re.++ (re.* (re.union (str.to_re "dd") (str.to_re "e"))) (re.++ (re.* (re.+ (str.to_re "ff"))) (re.++ (re.union (re.+ (str.to_re "g")) (re.* (str.to_re "hh"))) (re.union (re.* (str.to_re "i")) (re.+ (str.to_re "j"))))))))))))))
(assert (str.in_re var0 (re.++ (re.* (re.union (str.to_re "000") (str.to_re "111"))) (re.++ (re.union (re.union (str.to_re "2") (str.to_re "333")) (re.union (str.to_re "4") (str.to_re "555"))) (re.++ (re.+ (re.* (str.to_re "666"))) (re.++ (re.union (re.* (str.to_re "77")) (re.* (str.to_re "88"))) (re.++ (re.+ (re.* (str.to_re "99"))) (re.++ (re.union (re.* (str.to_re "aaa")) (re.* (str.to_re "b"))) (re.++ (re.+ (re.+ (str.to_re "ccc"))) (re.++ (re.* (re.+ (str.to_re "d"))) (re.++ (re.+ (re.+ (str.to_re "ee"))) (re.union (re.union (str.to_re "fff") (str.to_re "g")) (re.union (str.to_re "hh") (str.to_re "i"))))))))))))))
(assert (str.in_re var0 (re.++ (re.* (re.+ (str.to_re "0"))) (re.++ (re.+ (re.* (str.to_re "1"))) (re.++ (re.union (re.* (str.to_re "22")) (re.union (str.to_re "333") (str.to_re "444"))) (re.++ (re.union (re.union (str.to_re "555") (str.to_re "6")) (re.* (str.to_re "777"))) (re.++ (re.+ (re.* (str.to_re "8"))) (re.++ (re.union (re.+ (str.to_re "999")) (re.union (str.to_re "a") (str.to_re "bb"))) (re.++ (re.* (re.union (str.to_re "c") (str.to_re "dd"))) (re.++ (re.* (re.* (str.to_re "eee"))) (re.++ (re.union (re.* (str.to_re "f")) (re.+ (str.to_re "ggg"))) (re.* (re.+ (str.to_re "hhh"))))))))))))))
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "0") (str.to_re "11"))) (re.++ (re.union (re.* (str.to_re "222")) (re.* (str.to_re "33"))) (re.++ (re.+ (re.union (str.to_re "44") (str.to_re "5"))) (re.++ (re.union (re.* (str.to_re "666")) (re.union (str.to_re "7") (str.to_re "888"))) (re.++ (re.union (re.* (str.to_re "9")) (re.* (str.to_re "aaa"))) (re.++ (re.+ (re.union (str.to_re "bbb") (str.to_re "cc"))) (re.++ (re.* (re.* (str.to_re "d"))) (re.++ (re.+ (re.union (str.to_re "e") (str.to_re "f"))) (re.++ (re.union (re.union (str.to_re "g") (str.to_re "hhh")) (re.* (str.to_re "i"))) (re.union (re.* (str.to_re "j")) (re.union (re.+ (re.* (re.+ (str.to_re "")))) (str.to_re "lll"))))))))))))))

; --- START CONSTRAINT ---

(declare-const v0_prefix0 String)
(declare-const v0_suffix1 String)

(assert (>= (num_splits var0 "bbb") 2))
(assert (= v0_prefix0 (split_at var0 "bbb" 0)))
(assert (= v0_suffix1 (split_rest var0 "bbb" 1)))
(assert (not (str.contains v0_prefix0 "bbb")))
(assert (not (str.contains v0_suffix1 "bbb")))
(assert (>= (str.len v0_prefix0) 0))
(assert (>= (str.len v0_suffix1) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

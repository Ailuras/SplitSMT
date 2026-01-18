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
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "0") (str.to_re "111"))) (re.++ (re.union (re.* (str.to_re "2")) (re.+ (str.to_re "333"))) (re.++ (re.+ (re.+ (str.to_re "4"))) (re.++ (re.union (re.+ (str.to_re "555")) (re.+ (str.to_re "6"))) (re.++ (re.+ (re.+ (str.to_re "7"))) (re.++ (re.* (re.* (str.to_re "888"))) (re.++ (re.union (re.union (str.to_re "9") (str.to_re "a")) (re.* (str.to_re "bb"))) (re.++ (re.* (re.+ (str.to_re "c"))) (re.++ (re.* (re.+ (str.to_re "ddd"))) (re.++ (re.union (re.union (str.to_re "e") (str.to_re "ff")) (re.* (str.to_re "ggg"))) (re.++ (re.+ (re.* (str.to_re "h"))) (re.++ (re.union (re.+ (str.to_re "ii")) (re.* (str.to_re "jj"))) (re.++ (re.+ (re.* (str.to_re "k"))) (re.++ (re.+ (re.union (str.to_re "lll") (str.to_re "m"))) (re.++ (re.+ (re.union (str.to_re "n") (str.to_re "o"))) (re.++ (re.* (re.* (str.to_re "pp"))) (re.++ (re.union (re.union (str.to_re "q") (str.to_re "rrr")) (re.+ (str.to_re "s"))) (re.++ (re.union (re.* (str.to_re "ttt")) (re.* (str.to_re "uuu"))) (re.++ (re.union (re.* (str.to_re "vvv")) (re.* (str.to_re "w"))) (re.++ (re.union (re.+ (str.to_re "xx")) (re.* (str.to_re "yyy"))) (re.++ (re.+ (re.* (str.to_re "z"))) (re.++ (re.union (re.* (str.to_re "AA")) (re.+ (str.to_re "BB"))) (re.++ (re.union (re.* (str.to_re "C")) (re.* (str.to_re "DDD"))) (re.++ (re.+ (re.+ (str.to_re "EE"))) (re.++ (re.union (re.union (str.to_re "F") (str.to_re "G")) (re.union (str.to_re "HH") (str.to_re "III"))) (re.++ (re.union (re.+ (str.to_re "JJJ")) (re.+ (str.to_re "KKK"))) (re.++ (re.union (re.+ (str.to_re "LLL")) (re.union (str.to_re "MM") (str.to_re "NNN"))) (re.++ (re.* (re.* (str.to_re "O"))) (re.++ (re.* (re.+ (str.to_re "PPP"))) (re.++ (re.+ (re.* (str.to_re "QQ"))) (re.++ (re.+ (re.union (str.to_re "RR") (str.to_re "SSS"))) (re.++ (re.+ (re.* (str.to_re "TT"))) (re.++ (re.+ (re.union (str.to_re "U") (str.to_re "V"))) (re.++ (re.+ (re.* (str.to_re "WWW"))) (re.++ (re.+ (re.+ (str.to_re "XX"))) (re.++ (re.union (re.union (str.to_re "YYY") (str.to_re "Z")) (re.* (str.to_re "!!!"))) (re.++ (re.+ (re.+ (str.to_re """"""""))) (re.++ (re.union (re.+ (str.to_re "##")) (re.+ (str.to_re "$"))) (re.++ (re.* (re.union (str.to_re "%") (str.to_re "&&&"))) (re.++ (re.* (re.+ (str.to_re "'"))) (re.++ (re.+ (re.union (str.to_re "(((") (str.to_re "))"))) (re.++ (re.union (re.+ (str.to_re "***")) (re.* (str.to_re "+"))) (re.++ (re.+ (re.union (str.to_re ",,") (str.to_re "--"))) (re.++ (re.union (re.+ (str.to_re ".")) (re.union (str.to_re "/") (str.to_re ":::"))) (re.++ (re.+ (re.+ (str.to_re ";;"))) (re.++ (re.union (re.union (str.to_re "<<") (str.to_re "===")) (re.+ (str.to_re ">>"))) (re.++ (re.+ (re.+ (str.to_re "???"))) (re.++ (re.+ (re.+ (str.to_re "@@@"))) (re.++ (re.+ (re.+ (str.to_re "[[["))) (re.* (re.+ (str.to_re "\\"))))))))))))))))))))))))))))))))))))))))))))))))))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":::"))
(assert (= segment0 (split_at var0 delimiter 0)))
(assert (= segment1 (split_at var0 delimiter 1)))
(assert (= total_segments (num_splits var0 delimiter)))
(assert (>= total_segments 2))
(assert (str.contains (split_rest var0 delimiter 2) "HH"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

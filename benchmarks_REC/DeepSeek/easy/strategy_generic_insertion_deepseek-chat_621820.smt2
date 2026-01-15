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
(assert (str.in_re var0 (re.++ (re.+ (re.+ (str.to_re "00"))) (re.++ (re.+ (re.union (str.to_re "1") (str.to_re "22"))) (re.++ (re.+ (re.* (str.to_re "333"))) (re.++ (re.union (re.+ (str.to_re "444")) (re.+ (str.to_re "55"))) (re.++ (re.+ (re.* (str.to_re "66"))) (re.++ (re.* (re.+ (str.to_re "77"))) (re.++ (re.* (re.union (str.to_re "888") (str.to_re "9"))) (re.++ (re.* (re.union (str.to_re "a") (str.to_re "bbb"))) (re.++ (re.* (re.* (str.to_re "ccc"))) (re.++ (re.* (re.+ (str.to_re "dd"))) (re.++ (re.union (re.+ (str.to_re "ee")) (re.* (str.to_re "ff"))) (re.++ (re.union (re.* (str.to_re "ggg")) (re.* (str.to_re "hh"))) (re.++ (re.union (re.union (str.to_re "ii") (str.to_re "j")) (re.+ (str.to_re "kkk"))) (re.++ (re.union (re.union (str.to_re "l") (str.to_re "mm")) (re.* (str.to_re "n"))) (re.++ (re.* (re.+ (str.to_re "oo"))) (re.++ (re.+ (re.+ (str.to_re "ppp"))) (re.++ (re.+ (re.* (str.to_re "qqq"))) (re.++ (re.union (re.+ (str.to_re "rr")) (re.union (str.to_re "sss") (str.to_re "t"))) (re.++ (re.+ (re.union (str.to_re "uuu") (str.to_re "vvv"))) (re.++ (re.union (re.* (str.to_re "w")) (re.union (str.to_re "xxx") (str.to_re "yy"))) (re.++ (re.union (re.union (str.to_re "zzz") (str.to_re "AAA")) (re.union (str.to_re "BBB") (str.to_re "CCC"))) (re.++ (re.+ (re.* (str.to_re "DD"))) (re.++ (re.+ (re.+ (str.to_re "EEE"))) (re.++ (re.union (re.* (str.to_re "F")) (re.union (str.to_re "GGG") (str.to_re "H"))) (re.++ (re.+ (re.* (str.to_re "II"))) (re.++ (re.* (re.union (str.to_re "JJ") (str.to_re "K"))) (re.++ (re.union (re.* (str.to_re "LLL")) (re.+ (str.to_re "M"))) (re.++ (re.union (re.union (str.to_re "NNN") (str.to_re "O")) (re.* (str.to_re "P"))) (re.++ (re.* (re.+ (str.to_re "QQ"))) (re.++ (re.union (re.union (str.to_re "RR") (str.to_re "S")) (re.+ (str.to_re "T"))) (re.++ (re.* (re.union (str.to_re "U") (str.to_re "V"))) (re.++ (re.+ (re.+ (str.to_re "WWW"))) (re.++ (re.* (re.* (str.to_re "XX"))) (re.++ (re.* (re.union (str.to_re "Y") (str.to_re "Z"))) (re.++ (re.union (re.union (str.to_re "!") (str.to_re """""""")) (re.+ (str.to_re "#"))) (re.++ (re.+ (re.union (str.to_re "$$$") (str.to_re "%%%"))) (re.++ (re.union (re.* (str.to_re "&&")) (re.union (str.to_re "'''") (str.to_re "((("))) (re.++ (re.* (re.union (str.to_re "))") (str.to_re "**"))) (re.++ (re.+ (re.* (str.to_re "+"))) (re.++ (re.* (re.* (str.to_re ",,"))) (re.++ (re.* (re.union (str.to_re "--") (str.to_re ".."))) (re.++ (re.* (re.+ (str.to_re "/"))) (re.++ (re.+ (re.+ (str.to_re ":::"))) (re.++ (re.+ (re.+ (str.to_re ";;;"))) (re.++ (re.* (re.union (str.to_re "<") (str.to_re "==="))) (re.++ (re.* (re.+ (str.to_re ">>"))) (re.++ (re.union (re.union (str.to_re "???") (str.to_re "@")) (re.+ (str.to_re "["))) (re.++ (re.+ (re.+ (str.to_re "\\"))) (re.++ (re.+ (re.union (str.to_re "]]") (str.to_re "^^^"))) (re.++ (re.union (re.* (str.to_re "__")) (re.* (str.to_re "`"))) (re.++ (re.+ (re.union (str.to_re "{") (str.to_re "|"))) (re.++ (re.union (re.union (str.to_re "}}}") (str.to_re "~")) (re.* (str.to_re "0"))) (re.* (re.union (str.to_re "11") (str.to_re "222")))))))))))))))))))))))))))))))))))))))))))))))))))))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const rest_segments String)
; Assert constraints using str_split operations
(assert (= delimiter ":::"))
(assert (= segment0 (split_at var0 delimiter 0)))
(assert (= segment1 (split_at var0 delimiter 1)))
(assert (= rest_segments (split_rest var0 delimiter 2)))
(assert (>= (num_splits var0 delimiter) 3))
(assert (>= (str.len segment0) 5))
(assert (>= (str.len segment1) 3))
(assert (str.contains rest_segments "00"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

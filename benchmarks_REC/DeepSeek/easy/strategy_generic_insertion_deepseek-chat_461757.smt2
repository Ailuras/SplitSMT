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
(declare-fun T1_20 () String)
(declare-fun T1_9 () String)
(declare-fun T2_20 () String)
(declare-fun T2_9 () String)
(declare-fun T_1 () String)
(declare-fun T_2 () String)
(declare-fun T_3 () String)
(declare-fun T_4 () String)
(declare-fun T_5 () String)
(declare-fun T_6 () String)
(declare-fun T_7 () String)
(declare-fun T_9 () String)
(declare-fun T_a () String)
(declare-fun var_0xINPUT_9534 () String)
(assert (= T_1 (str.++ T1_9 T2_9)))
(assert (= T2_9 "?d=gg"))
(assert (= T1_9 var_0xINPUT_9534))
(assert (= T_2 (str.++ "&utmn=1332076825&utmcs=UTF-8&utmsr=1680x976&utmsc=24-bit&utmul=en-us&utmje=0&utmfl=-&utmcn=1&utmdt=Ask%20A%20Word&utmhn=www.askaword.com&utmhid=1325034730&utmr=0&utmp=" T_1)))
(assert (= T_3 (str.++ "http://www.google-analytics.com/__utm.gif?utmwv=1.3" T_2)))
(assert (= T_4 (str.++ T_3 "&utmac=")))
(assert (= T_5 (str.++ T_4 "UA-167675-3")))
(assert (= T_6 (str.++ T_5 "&utmcc=")))
(assert (= T_7 (str.++ T_6 "__utma%3D169413169.1332076825.1266911488.1266911488.1266911488.1%3B%2B__utmz%3D169413169.1266911488.1.1.utmccn%3D(direct)%7Cutmcsr%3D(direct)%7Cutmcmd%3D(none)%3B%2B")))
(assert (= T_9 (str.++ T1_20 T2_20)))
(assert (= T2_20 "?d=gg"))
(assert (= T1_20 var_0xINPUT_9534))
(assert (= T_a (str.++ "&utmn=1332076825&utmcs=UTF-8&utmsr=1680x976&utmsc=24-bit&utmul=en-us&utmje=0&utmfl=-&utmcn=1&utmdt=Ask%20A%20Word&utmhn=www.askaword.com&utmhid=1325034730&utmr=0&utmp=" T_9)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const split_result_1 String)
(declare-const split_result_2 String)
(declare-const num_segments Int)
; Assert constraints using str_split operations
(assert (= split_result_1 (split_at var_0xINPUT_9534 "?d=gg" 0)))
(assert (= split_result_2 (split_at var_0xINPUT_9534 "?d=gg" 1)))
(assert (= num_segments (num_splits var_0xINPUT_9534 "?d=gg")))
(assert (>= num_segments 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

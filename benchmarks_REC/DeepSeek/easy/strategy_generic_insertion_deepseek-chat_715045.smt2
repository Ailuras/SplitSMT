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
(declare-fun I0_6 () Int)
(declare-fun PCTEMP_LHS_1 () String)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun T0_6 () String)
(declare-fun T1_5 () String)
(declare-fun T1_6 () String)
(declare-fun T2_5 () String)
(declare-fun T2_6 () String)
(declare-fun T3_6 () String)
(declare-fun T4_6 () String)
(declare-fun T5_6 () String)
(declare-fun T_2 () String)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_SELECT_1 () Bool)
(assert (not (str.in_re PCTEMP_LHS_1 (re.++ (str.to_re "%") (str.to_re "h") (str.to_re "o") (str.to_re "s") (str.to_re "t") (str.to_re "%")))))
(assert (= PCTEMP_LHS_1 "//%host%/gadgets/makeRequest"))
(assert (= T_2 (str.++ T1_5 T2_5)))
(assert (= T2_5 "?refresh=3600&url=http%3A%2F%2Fwww.mylisty.net%2FListy%2Fhtml%2FUserManager.action%3Ftype%3Dnew_user%26sid%3D0.8560449686928593&httpMethod=GET&headers=&postData=&authz=&st=&contentType=DOM&numEntries=3&getSummaries=false&signOwner=true&signViewer=true&gadget=http%3A%2F%2Fwww.mylisty.net%2FListy%2Fgadget%2FMyListy.xml&container=ig&bypassSpecCache=0"))
(assert (= T1_5 PCTEMP_LHS_1))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_2 (+ I0_6 0)) (= T_2 (str.++ T0_6 T1_6)) (= I0_6 (str.len T4_6)) (= 0 (str.len T0_6)) (= T1_6 (str.++ T2_6 T3_6)) (= T2_6 (str.++ T4_6 T5_6)) (= T5_6 "//") (not (str.in_re T4_6 (re.++ (str.to_re "/") (str.to_re "/"))))) (and (= PCTEMP_LHS_2 (- 1)) (= T_2 (str.++ T0_6 T1_6)) (= 0 (str.len T0_6)) (not (str.in_re T1_6 (re.++ (str.to_re "/") (str.to_re "/")))))))
(assert (= T_4 (= PCTEMP_LHS_2 0)))
(assert (= T_5 (not T_4)))
(assert T_5)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const split_delim String)
(declare-const split_index Int)
(declare-const split_segment String)
(declare-const split_count Int)
(declare-const split_remaining String)
; Assert constraints using str_split operations
(assert (= split_delim "://"))
(assert (= split_index 1))
(assert (= split_segment (split_at T_2 split_delim split_index)))
(assert (= split_count (num_splits T_2 split_delim)))
(assert (>= split_count 2))
(assert (= split_remaining (split_rest T_2 split_delim split_index)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

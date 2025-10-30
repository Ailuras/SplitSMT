; (set-option :smt.recfun true)
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
(declare-fun var_12287016685897782247 () String)
(declare-fun var_4516353200763201657 () String)
(declare-fun var_9519974186703569041 () String)
(declare-fun url () String)
(define-fun protocol () String (split_at url "://" 0))
(define-fun rest1 () String (split_rest url "://" 1))
(define-fun host () String (split_at rest1 "/" 0))
(define-fun path_and_query () String (split_rest rest1 "/" 1))
(define-fun path1 () String (split_at var_4516353200763201657 "/" 0))
(define-fun path2 () String (split_at var_4516353200763201657 "/" 1))
(define-fun query () String (split_rest path_and_query "?" 1))
(define-fun host_without_port () String (split_at host ":" 0))
(define-fun port () String (split_rest var_9519974186703569041 ":" 1))
(assert (or (= protocol "http") (= protocol "https")))
(assert (not (= protocol "")))
(assert (= (num_splits url "://") 2))
(assert (distinct "" var_9519974186703569041))
(assert (> (num_splits var_9519974186703569041 ".") 1))
(assert (= (str.indexof var_9519974186703569041 "/" 0) (- 1)))
(assert (= (str.indexof var_9519974186703569041 "?" 0) (- 1)))
(assert (= (str.indexof var_9519974186703569041 "&" 0) (- 1)))
(assert (or (and (> (str.len port) 0) (forall ((i Int)) (=> (and (< i (str.len port)) (>= i 0)) (and (>= (str.to_code (str.at port i)) 48) (<= (str.to_code (str.at port i)) 57))))) (= "" port)))
(assert (or (= "" path1) (not (= path1 "admin"))))
(assert (or (> (num_splits var_4516353200763201657 "/") 0) (= "" var_4516353200763201657)))
(assert (or (distinct "forbidden" path2) (< (num_splits var_4516353200763201657 "/") 2)))
(assert (= "https://example.com:443/user/profile?token=abc&mode=edit" url))
(assert (= var_9519974186703569041 host))
(assert (= path_and_query var_4516353200763201657))
(assert (= var_12287016685897782247 rest1))
(check-sat)
(exit)
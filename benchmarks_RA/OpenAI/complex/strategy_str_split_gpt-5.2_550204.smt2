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

; Uninterpreted interface functions for str_split

; Variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)

; Preserve seed core structure but mutate from fixed literal to email validation
(assert (= T_1 (= email "Search")))

; Email split around '@'
(assert (= at_count (num_splits email "@")))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (split_rest email "@" 1) domain))

; Basic sanity constraints
(assert (>= at_count 2))
(assert (<= at_count 2))
(assert (= local_len (str.len local_part)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 0))

; Domain must have at least one '.' and exactly two labels (label.tld)
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))
(assert (<= dot_count 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= tld domain_label1))
(assert (= (split_rest domain "." 1) domain_label1))
(assert (> (str.len domain_label0) 0))
(assert (>= (str.len tld) 2))

; Common email format restrictions (syntactic)
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain "@")))

; Delimiter placement: local-part cannot start/end with '.'
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Domain label cannot start/end with '-'
(assert (not (= (str.at domain_label0 0) "-")))
(assert (not (= (str.at domain_label0 (- (str.len domain_label0) 1)) "-")))

; Tie to seed Boolean and add a second Boolean that makes the instance UNSAT
; If T_1 holds then email is exactly "Search", which cannot satisfy having exactly one '@'
(assert T_1)
(assert (= T_2 (and (= at_count 2) (= dot_count 2))))
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

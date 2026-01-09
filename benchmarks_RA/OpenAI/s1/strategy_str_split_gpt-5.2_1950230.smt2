(set-logic ALL)

; Boolean guards (preserve core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Input email
(declare-fun var_0xINPUT_228795 () String)

; str_split interface
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

; Email-derived components
(declare-const local_part String)
(declare-const domain_part String)
(declare-const first_domain_label String)
(declare-const tld String)
(declare-const domain_tail String)

; Basic non-empty input checks (as in seed)
(assert (= T_1 (not (= "" var_0xINPUT_228795))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_228795))))
(assert T_2)

; Mutated seed equality/inequality core
(assert (= T_3 (not (= "fB9De3KAY9" var_0xINPUT_228795))))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email split structure: exactly one '@' => two segments
(assert (= T_5 (= (num_splits var_0xINPUT_228795 "@") 2)))
(assert T_5)

; Bind local and domain parts
(assert (= local_part (split_at var_0xINPUT_228795 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_228795 "@" 1)))

; Local part constraints
(assert (not (= local_part "")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))
(assert (not (str.contains local_part "..")))

; Domain constraints: must have at least one '.' and not start/end with '.'
(assert (>= (num_splits domain_part ".") 2))
(assert (not (= domain_part "")))
(assert (not (= (str.at domain_part 0) ".")))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))
(assert (not (str.contains domain_part "..")))
(assert (not (str.contains domain_part "@")))

; Bind domain labels
(assert (= first_domain_label (split_at domain_part "." 0)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))
(assert (= domain_tail (split_rest domain_part "." 1)))

; Domain label constraints
(assert (not (= first_domain_label "")))
(assert (not (str.contains first_domain_label "_")))
(assert (not (str.contains domain_part " ")))

; TLD constraints: length between 2 and 6
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Force presence of at least one dot after first label (domain_tail non-empty)
(assert (not (= domain_tail "")))

; An additional boolean tying to a property (keeps similar shape)
(assert (= T_6 (and (>= (str.len local_part) 1) (>= (str.len domain_part) 3))))
(assert T_6)

; Ensure some determinism: pick a concrete satisfying email
(assert (= var_0xINPUT_228795 "user.name+tag@example.co"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted interface functions for str_split
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

; Seed variables (preserved core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_479903 () String)

; Additional variables for email validation scenario
(declare-const local_part String)
(declare-const domain_part String)
(declare-const tld String)
(declare-const domain_label0 String)
(declare-const domain_rest String)
(declare-const domain_with_dot String)
(declare-const dot String)
(declare-const at String)

(assert (= dot "."))
(assert (= at "@"))

; Core seed structure
(assert (= T_1 (not (= "" var_0xINPUT_479903))))
(assert (= T_2 (not T_1)))

; Email split constraints
(assert (= local_part (split_at var_0xINPUT_479903 at 0)))
(assert (= domain_part (split_at var_0xINPUT_479903 at 1)))
(assert (= (num_splits var_0xINPUT_479903 at) 2))

; local-part sanity (non-empty, no nested @)
(assert (not (= local_part "")))
(assert (= (num_splits local_part at) 1))

; domain structure: must contain at least one '.'
(assert (>= (num_splits domain_part dot) 2))
(assert (= domain_label0 (split_at domain_part dot 0)))
(assert (= tld (split_at domain_part dot (- (num_splits domain_part dot) 1))))
(assert (= domain_rest (split_rest domain_part dot 1)))

; domain labels non-empty
(assert (not (= domain_label0 "")))
(assert (not (= tld "")))

; domain_part should be reconstructible as label0 + '.' + rest (rest includes at least one segment)
(assert (= domain_with_dot (str.++ domain_label0 dot domain_rest)))
(assert (= domain_with_dot domain_part))

; Additional email-like character constraints (approximate with contains restrictions)
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain_part " ")))
(assert (not (str.contains domain_part "..")))

; Force UNSAT by requiring empty input while also requiring email splits and non-empty local/domain
(assert T_2)
(assert (= var_0xINPUT_479903 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

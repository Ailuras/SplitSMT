(set-logic ALL)

; Uninterpreted interface operations for string splitting
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

; Seed-style boolean structure retained and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)

(declare-fun var_0xINPUT_151642 () String)

; Email-related segments
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)

; Preserve core seed constraints: input not "-" and not empty
(assert (= T_1 (= "-" var_0xINPUT_151642)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_151642)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Basic email split around '@'
(assert (= local_part (split_at var_0xINPUT_151642 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_151642 "@" 1)))

; Must have exactly one '@' -> two segments
(assert (= T_5 (= (num_splits var_0xINPUT_151642 "@") 2)))
(assert T_5)

; Local and domain parts must be non-empty
(assert (= T_6 (and (> (str.len local_part) 0) (> (str.len domain_part) 0))))
(assert T_6)

; Local part should not start or end with '.' and should not contain ".."
(assert (= T_7 (and (not (= (str.at local_part 0) "."))
                    (not (= (str.at local_part (- (str.len local_part) 1)) "."))
                    (not (str.contains local_part "..")))))
(assert T_7)

; Domain structure: at least two labels separated by '.'
(assert (>= (num_splits domain_part ".") 2))
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))

; Each domain label should be non-empty
(assert (and (> (str.len domain_label0) 0)
             (> (str.len domain_label1) 0)
             (> (str.len tld) 1)))

; Domain should not contain consecutive dots, and should not start/end with '.'
(assert (= T_8 (and (not (str.contains domain_part ".."))
                    (not (= (str.at domain_part 0) "."))
                    (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))))
(assert T_8)

; SAT email example witness constraint (keeps instance satisfiable)
(assert (= T_9 (= var_0xINPUT_151642 "user.name+tag@example.co")))
(assert T_9)

; Additional UNSAT sub-instance under a guard (kept inactive to preserve SAT):
; if activated, it would require an impossible domain with exactly one label and >=2 labels simultaneously.
(declare-const unsat_guard Bool)
(assert (not unsat_guard))
(assert (=> unsat_guard (and (= (num_splits domain_part ".") 1)
                             (>= (num_splits domain_part ".") 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

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

; Uninterpreted str_split interface

; Seed-style boolean structure preserved and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)

; Inputs and derived segments
(declare-fun var_0xINPUT_168034 () String)
(declare-const local_part String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const tld String)

; Additional helper ints
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Core parsing by delimiters
(assert (= at_splits (num_splits var_0xINPUT_168034 "@")))
(assert (= local_part (split_at var_0xINPUT_168034 "@" 0)))
(assert (= domain (split_at var_0xINPUT_168034 "@" 1)))

(assert (= dot_splits (num_splits domain ".")))
(assert (= dom_label0 (split_at domain "." 0)))
(assert (= dom_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." 2)))

; Email validation constraints (complex structure)
; Exactly one '@' in the whole email => two segments
(assert (= T_1 (= at_splits 2)))

; Non-empty local and domain, no '.' at start of domain label, basic TLD length
(assert (= T_3 (and (> (str.len local_part) 0)
                    (> (str.len domain) 0)
                    (> (str.len dom_label0) 0)
                    (> (str.len tld) 1))))

; Domain must have at least 3 segments a.b.c (two dots) => three segments
(assert (= T_4 (and (>= dot_splits 3)
                    (not (str.contains domain "..")))))

; Preserve seed-like negation relationship but repurpose for email scenario
; T_2 is the negation of T_1, then assert T_2 along with other constraints to create UNSAT.
(assert (= T_2 (not T_1)))

; Extra domain structure checks: domain must not contain '@', local must not contain '@'
(assert (= T_5 (and (not (str.contains local_part "@"))
                    (not (str.contains domain "@"))
                    (not (str.contains domain " "))
                    (not (str.contains local_part " ")))))

; Enforce all validation constraints and also force the negation of the '@' constraint => UNSAT
(assert T_3)
(assert T_4)
(assert T_5)
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

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

; Scenario: CSV Processing
; Goal: model comma-separated fields, ensure correct field count, and detect empty fields.

; Seed variable (kept)
(declare-const x String)

; CSV-specific variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const hasEmptyField Bool)

; str_split interface

; Keep core structure flavor but adapt to CSV context
(assert (= delim ","))

; Tie x into CSV processing to preserve seed structure linkage
(assert (= csv (str.++ x "," "" "," "42" "," "end")))

; Ensure fixed-length payload part (seed) with a relaxed regex membership that is always true
(assert (= 16 (str.len x)))
(assert (str.in_re x (re.* (str.to_re "ddccbbaa"))))

; Extract fields
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= f2 (split_at csv delim 2)))
(assert (= f3 (split_at csv delim 3)))
(assert (= rest2 (split_rest csv delim 2)))
(assert (= rest3 (split_rest csv delim 3)))

; Field count constraints: expect exactly 4 segments (3 commas)
(assert (= (num_splits csv delim) 4))

; Detect empty fields: at least one field is empty
(assert (= hasEmptyField (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))
(assert hasEmptyField)

; Additional CSV sanity: no field may contain a comma
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; Make one specific empty-field location explicit to create a concrete CSV issue
(assert (= f1 ""))

; Relate rest concatenations to expected suffixes
(assert (= rest3 f3))
(assert (= rest2 (str.++ f2 delim f3)))

; SAT/UNSAT mix: add a contradictory requirement about f1 to force UNSAT in this instance
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

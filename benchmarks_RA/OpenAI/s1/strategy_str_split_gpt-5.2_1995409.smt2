(set-logic ALL)

; CSV Processing scenario: comma-separated data fields, ensuring correct field counts and detecting empty fields.
; Core seed structure preserved (same variables and equalities), extended with str_split constraints.

(declare-fun B () String)
(declare-fun A () String)
(declare-fun J () String)
(declare-fun C () String)

; str_split interface (uninterpreted per instructions)
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

; Derived CSV row string
(declare-const csv_row String)

; Field variables (CSV columns)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)

; Preserve core structure constraints from seed
(assert (= (str.++ "dbefbfbae" B "cc" J "dcbcfbe") (str.++ "dbefbfbaeb" C A "cbfbafcfdfcadcbcfbe")))
(assert (= (str.++ "fbfedbbcd" A "adeabed" A "dfafccdcfdddabcbfaff") (str.++ "fbfedbbcdeeadeabedeedfafccdcfdddabcbfaff" "")))
(assert (= (str.++ "cddaadaaddfbccdaafacaeadbcfadbfeedfcceca" "") (str.++ "cddaadaaddfbccdaafacaeadbcfadbf" A "dfcceca")))

; Adjusted size bounds (mutated slightly) while remaining consistent
(assert (<= (* (str.len A) 1) 4))
(assert (<= (* (str.len B) 12) 468))
(assert (>= (* (str.len J) 8) 88))
(assert (<= (* (str.len J) 3) 69))
(assert (>= (* (str.len C) 19) 95))

; CSV construction: four columns separated by commas
(assert (= csv_row (str.++ C "," A "," B "," J)))

; Enforce field count = 4 segments
(assert (= (num_splits csv_row ",") 4))

; Link split fields
(assert (= f0 (split_at csv_row "," 0)))
(assert (= f1 (split_at csv_row "," 1)))
(assert (= f2 (split_at csv_row "," 2)))
(assert (= f3 (split_at csv_row "," 3)))

; Field-to-variable mapping consistency
(assert (= f0 C))
(assert (= f1 A))
(assert (= f2 B))
(assert (= f3 J))

; Detect empty fields: ensure A is empty (forces an empty CSV field between commas)
(assert (= A ""))

; Non-empty constraints for other fields
(assert (> (str.len C) 0))
(assert (> (str.len B) 0))
(assert (> (str.len J) 0))

; Check that the rest from field 1 begins with the empty field delimiter pattern
(assert (= (split_rest csv_row "," 1) (str.++ A "," B "," J)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

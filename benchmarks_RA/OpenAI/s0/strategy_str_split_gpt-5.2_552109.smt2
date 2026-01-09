(set-logic ALL)

; Uninterpreted interface for string split
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

; -------------------------
; CSV Processing constraints
; -------------------------

; SAT instance: a CSV line with 4 fields, no empty fields, and a numeric 3rd field
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)

(declare-const idx0_sat Int)
(declare-const idx1_sat Int)

(assert (= csv_line_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (num_splits csv_line_sat ",") 4))
(assert (= f0_sat (split_at csv_line_sat "," 0)))
(assert (= f1_sat (split_at csv_line_sat "," 1)))
(assert (= f2_sat (split_at csv_line_sat "," 2)))
(assert (= f3_sat (split_at csv_line_sat "," 3)))
(assert (= (split_rest csv_line_sat "," 2) (str.++ f2_sat "," f3_sat)))

; No empty fields in SAT instance
(assert (and (> (str.len f0_sat) 0)
             (> (str.len f1_sat) 0)
             (> (str.len f2_sat) 0)
             (> (str.len f3_sat) 0)))

; Ensure delimiter exists and position is consistent with concatenation
(assert (>= (str.len csv_line_sat) 3))
(assert (= (str.indexof csv_line_sat "," 0) idx0_sat))
(assert (>= idx0_sat 0))
(assert (< idx0_sat (str.len csv_line_sat)))

(assert (= (str.indexof csv_line_sat "," (+ idx0_sat 1)) idx1_sat))
(assert (>= idx1_sat 0))
(assert (< idx1_sat (str.len csv_line_sat)))
(assert (> idx1_sat idx0_sat))

; Numeric 3rd field: only digits, non-empty
(assert (str.in_re f2_sat (re.+ (re.range "0" "9"))))

; Mild content constraints for diversity
(assert (str.contains f0_sat "A"))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; -------------------------
; UNSAT instance: claims exactly 3 fields, but also asserts an empty middle field is forbidden
; and simultaneously forces a double-comma pattern that creates an empty field.
; -------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const i_unsat Int)

; Force a CSV with an empty field: "X,,Y" (empty middle segment)
(assert (= csv_line_unsat (str.++ u0 ",," u2)))
(assert (= u0 "X"))
(assert (= u2 "Y"))

; Split expectations
(assert (= (num_splits csv_line_unsat ",") 3))
(assert (= u0 (split_at csv_line_unsat "," 0)))
(assert (= u1 (split_at csv_line_unsat "," 1)))
(assert (= u2 (split_at csv_line_unsat "," 2)))

; Detect empty fields: here u1 must be empty due to ",,"
(assert (= u1 ""))

; But also assert there are no empty fields (contradiction => UNSAT)
(assert (> (str.len u1) 0))

; Additional index bound constraints per interface guidance
(assert (= (str.indexof csv_line_unsat ",," 0) i_unsat))
(assert (>= i_unsat 0))
(assert (< i_unsat (str.len csv_line_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

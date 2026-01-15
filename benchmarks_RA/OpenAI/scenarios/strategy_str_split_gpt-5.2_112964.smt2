(set-logic ALL)

; Uninterpreted interface for string split operations
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

; =====================
; Scenario: CSV Processing
; =====================

; --- Shared constants
(declare-const comma String)
(assert (= comma ","))

; -------------------------------------------------
; SAT instance: a CSV line with 4 fields, with empty field detection
; Example target shape: "alpha,,gamma,delta" (second field is empty)
; -------------------------------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= 4 (num_splits csv_line_sat comma)))
(assert (= f0_sat (split_at csv_line_sat comma 0)))
(assert (= f1_sat (split_at csv_line_sat comma 1)))
(assert (= f2_sat (split_at csv_line_sat comma 2)))
(assert (= f3_sat (split_at csv_line_sat comma 3)))

; Empty field detection: require exactly the second field to be empty
(assert (= f1_sat ""))
(assert (not (= f0_sat "")))
(assert (not (= f2_sat "")))
(assert (not (= f3_sat "")))

; Basic sanity: reconstruct via rest segments (relaxation-style constraints)
(assert (= rest1_sat (split_rest csv_line_sat comma 1)))
(assert (= rest2_sat (split_rest csv_line_sat comma 2)))
(assert (= rest3_sat (split_rest csv_line_sat comma 3)))
(assert (str.contains rest1_sat comma))
(assert (str.contains rest2_sat comma))
(assert (not (str.contains rest3_sat comma)))

; Ensure comma count matches 4 fields -> at least 3 commas present
(assert (>= (str.len csv_line_sat) 3))
(assert (str.contains csv_line_sat comma))

; Pin to a concrete satisfying example
(assert (= csv_line_sat "alpha,,gamma,delta"))


; -------------------------------------------------
; UNSAT instance: claim 3 fields, but enforce both leading and trailing comma
; Leading comma -> first field empty; trailing comma -> last field empty => at least 4 segments
; This conflicts with num_splits = 3
; -------------------------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= 3 (num_splits csv_line_unsat comma)))
(assert (= u0 (split_at csv_line_unsat comma 0)))
(assert (= u1 (split_at csv_line_unsat comma 1)))
(assert (= u2 (split_at csv_line_unsat comma 2)))

; Enforce leading and trailing commas
(assert (str.prefixof "," csv_line_unsat))
(assert (str.suffixof "," csv_line_unsat))

; Make the middle contain some content to avoid degenerate all-empty line
(assert (>= (str.len csv_line_unsat) 2))
(assert (str.contains csv_line_unsat "x"))

; Also require that the last field (as per split_at) is non-empty, which contradicts trailing comma semantics
(assert (not (= u2 "")))


; -------------------------------------------------
; SAT instance: detect no empty fields for a fixed 3-column header
; Example: "id,name,age" with all non-empty and exactly 3 fields
; -------------------------------------------------
(declare-const header_line String)
(declare-const h0 String)
(declare-const h1 String)
(declare-const h2 String)

(assert (= 3 (num_splits header_line comma)))
(assert (= h0 (split_at header_line comma 0)))
(assert (= h1 (split_at header_line comma 1)))
(assert (= h2 (split_at header_line comma 2)))
(assert (and (not (= h0 "")) (not (= h1 "")) (not (= h2 ""))))
(assert (= header_line "id,name,age"))


; -------------------------------------------------
; Force combined satisfiability: include both SAT and UNSAT parts together
; This makes the whole file UNSAT overall, demonstrating detection.
; -------------------------------------------------
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted functions for string split interface
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

; =============================
; Scenario: CSV Processing
; =============================

; -----------------------------
; SAT instance: well-formed CSV row with 4 fields and an empty field in the middle
; Example shape: "Alice,30,,NY"
; -----------------------------
(declare-const csv_row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= (num_splits csv_row_sat ",") 4))
(assert (= f0_sat (split_at csv_row_sat "," 0)))
(assert (= f1_sat (split_at csv_row_sat "," 1)))
(assert (= f2_sat (split_at csv_row_sat "," 2)))
(assert (= f3_sat (split_at csv_row_sat "," 3)))

(assert (= rest1_sat (split_rest csv_row_sat "," 1)))
(assert (= rest2_sat (split_rest csv_row_sat "," 2)))
(assert (= rest3_sat (split_rest csv_row_sat "," 3)))

; enforce some content properties
(assert (= f0_sat "Alice"))
(assert (= f1_sat "30"))
(assert (= f2_sat ""))
(assert (= f3_sat "NY"))

; detect empty field and ensure row contains commas
(assert (str.contains csv_row_sat ","))
(assert (= (str.len f2_sat) 0))

; delimiter should not appear inside each extracted field (typical CSV without quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; additional consistency: reconstruct a canonical row from the fields
(assert (= csv_row_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))

; numeric check on an integer-like field length ("30" -> 2)
(assert (= (str.len f1_sat) 2))

; sanity constraints on split indices (natural)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory requirements about empty fields and field count
; -----------------------------
(declare-const csv_row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)
(declare-const u4 String)

; require 5 fields
(assert (= (num_splits csv_row_unsat ",") 5))
(assert (= u0 (split_at csv_row_unsat "," 0)))
(assert (= u1 (split_at csv_row_unsat "," 1)))
(assert (= u2 (split_at csv_row_unsat "," 2)))
(assert (= u3 (split_at csv_row_unsat "," 3)))
(assert (= u4 (split_at csv_row_unsat "," 4)))

; force a row that has no commas but still claims 5 splits (contradiction via contains)
(assert (not (str.contains csv_row_unsat ",")))

; additionally force each field to be non-empty
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))
(assert (> (str.len u4) 0))

; but also force u2 to be empty (direct contradiction)
(assert (= u2 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

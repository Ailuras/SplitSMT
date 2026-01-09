(set-logic ALL)

; CSV Processing: comma-separated fields, field counts, empty-field detection.
; Mix of SAT and UNSAT instances using str_split interface functions.

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

; -----------------------------
; SAT instance: a valid CSV row with exactly 4 fields,
; ensuring at least one empty field is present (e.g., trailing comma).
; -----------------------------
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= (num_splits csv_sat ",") 4))
(assert (>= (num_splits csv_sat ",") 1))

(assert (= f0_sat (split_at csv_sat "," 0)))
(assert (= f1_sat (split_at csv_sat "," 1)))
(assert (= f2_sat (split_at csv_sat "," 2)))
(assert (= f3_sat (split_at csv_sat "," 3)))
(assert (= rest2_sat (split_rest csv_sat "," 2)))

; Require an empty field exists (detect missing data)
(assert (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat "")))

; Constrain fields to not contain commas (typical raw CSV without quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; Make the SAT row concrete: "A,B,,D" (an empty third field)
(assert (= csv_sat (str.++ "A" "," "B" "," "" "," "D")))

; Sanity constraints on indices (natural)
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

; -----------------------------
; UNSAT instance: contradictory requirements about empty fields.
; Exactly 3 fields, but also requires (i) at least one empty field and
; (ii) all fields non-empty.
; -----------------------------
(declare-const csv_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= (num_splits csv_unsat ",") 3))

(assert (= u0 (split_at csv_unsat "," 0)))
(assert (= u1 (split_at csv_unsat "," 1)))
(assert (= u2 (split_at csv_unsat "," 2)))

; Require at least one empty field
(assert (or (= u0 "") (= u1 "") (= u2 "")))

; Contradiction: require all fields non-empty
(assert (and (not (= u0 "")) (not (= u1 "")) (not (= u2 ""))))

; Additional plausible CSV constraints
(assert (not (str.contains u0 ",")))
(assert (not (str.contains u1 ",")))
(assert (not (str.contains u2 ",")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

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

; Uninterpreted interface for string split

; -----------------------------
; Scenario: CSV Processing
; Processing comma-separated data fields to ensure correct field counts and detect empty fields.
; Mix of SAT and UNSAT instances in one file via a case split.
; -----------------------------

(declare-const csv_line String)
(declare-const delim String)

(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest2 String)

(declare-const nfields Int)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)

; Delimiter is a comma
(assert (= delim ","))

; Index bounds / natural indices (interface requirement)
(assert (>= k0 0))
(assert (>= k1 0))
(assert (>= k2 0))
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))

; Relate nfields to split operator
(assert (= nfields (num_splits csv_line delim)))
(assert (>= nfields 1))

; Define extracted fields and rest
(assert (= field0 (split_at csv_line delim k0)))
(assert (= field1 (split_at csv_line delim k1)))
(assert (= field2 (split_at csv_line delim k2)))
(assert (= rest2 (split_rest csv_line delim k2)))

; CSV sanity constraints: no newlines, at least one comma in the string for multi-field records
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))
(assert (=> (>= nfields 2) (str.contains csv_line delim)))

; A useful reconstruction-style constraint (relaxation-friendly): if at least 3 fields, then rest2 is non-empty
(assert (=> (>= nfields 3) (> (str.len rest2) 0)))

; Case split: one branch SAT (valid record with an empty field), other branch UNSAT (contradictory empty/non-empty requirement)
(declare-const choose_sat Bool)

; -----------------------------
; SAT branch: exactly 4 fields, second field empty, others non-empty
; Example: "alice,,42,NY"
; -----------------------------
(assert (=> choose_sat
  (and
    (= nfields 4)
    (>= nfields 4)
    (= field0 "alice")
    (= field1 "")
    (= field2 "42")
    (= field3 (split_at csv_line delim 3))
    (= field3 "NY")

    ; detect empty field explicitly
    (= (str.len field1) 0)
    (> (str.len field0) 0)
    (> (str.len field2) 0)
    (> (str.len field3) 0)

    ; minimal well-formedness: no spaces in fields for this simplified CSV
    (not (str.contains field0 " "))
    (not (str.contains field1 " "))
    (not (str.contains field2 " "))
    (not (str.contains field3 " "))

    ; strengthen: ensure comma appears and record length is plausible
    (str.contains csv_line ",,")
    (>= (str.len csv_line) 5)
  )))

; -----------------------------
; UNSAT branch: claim exactly 3 fields, but also require field1 empty and non-empty simultaneously
; -----------------------------
(assert (=> (not choose_sat)
  (and
    (= nfields 3)
    (>= nfields 3)

    ; bind fields to something (still via split)
    (= field0 (split_at csv_line delim 0))
    (= field1 (split_at csv_line delim 1))
    (= field2 (split_at csv_line delim 2))

    ; contradictory empty-field detection requirements
    (= field1 "")
    (> (str.len field1) 0)
  )))

; Ensure both branches are possible as separate instances by allowing either value.
; The solver will decide satisfiable overall by setting choose_sat = true.



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

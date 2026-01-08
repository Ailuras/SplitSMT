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

; Uninterpreted interface for string splitting (CSV style)

; -------------------------
; SAT instance: basic CSV validation with 4 fields, detect empty middle field
; -------------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const i0 Int)
(declare-const i2 Int)

(assert (= delim ","))

; fixed example line with an empty field between two commas
(assert (= csv_line "alice,,42,NY"))

; exactly 4 fields
(assert (= (num_splits csv_line delim) 4))

; extract fields
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))

; rest-of-line views
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; index constraints (natural numbers within segment bounds)
(assert (= i0 0))
(assert (= i2 2))
(assert (and (<= 0 i0) (< i0 (num_splits csv_line delim))))
(assert (and (<= 0 i2) (< i2 (num_splits csv_line delim))))

; sanity properties about emptiness and contents
(assert (= f1 ""))
(assert (not (= f0 "")))
(assert (not (= f2 "")))
(assert (not (= f3 "")))

; check that numeric field looks like digits only (simple regex)
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))

; last field should be two uppercase letters
(assert (str.in_re f3 (re.++ (re.range "A" "Z") (re.range "A" "Z"))))

; ensure rest segments contain delimiters as expected
(assert (str.contains rest1 ","))
(assert (str.contains rest2 ","))
(assert (not (str.contains rest3 ",")))

; ensure first field has no commas
(assert (not (str.contains f0 delim)))

; -------------------------
; UNSAT instance: contradictory requirements about empty-field detection
; -------------------------
(declare-const csv_line_bad String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)

(assert (= csv_line_bad "x,,y"))
(assert (= (num_splits csv_line_bad delim) 3))
(assert (= g0 (split_at csv_line_bad delim 0)))
(assert (= g1 (split_at csv_line_bad delim 1)))
(assert (= g2 (split_at csv_line_bad delim 2)))

; In "x,,y", middle field should be empty, but we also assert it is non-empty -> UNSAT
(assert (= g1 ""))
(assert (not (= g1 "")))

; -------------------------
; Additional SAT instance: variable CSV line constrained by patterns, allow optional empty trailing field
; (kept consistent by not over-constraining split behavior beyond interface usage)
; -------------------------
(declare-const csv_line2 String)
(declare-const h0 String)
(declare-const h1 String)
(declare-const h2 String)
(declare-const n2 Int)

; require at least 2 fields, and exactly 3 for this instance
(assert (= n2 (num_splits csv_line2 delim)))
(assert (= n2 3))
(assert (= h0 (split_at csv_line2 delim 0)))
(assert (= h1 (split_at csv_line2 delim 1)))
(assert (= h2 (split_at csv_line2 delim 2)))

; first field: lowercase letters
(assert (str.in_re h0 (re.+ (re.range "a" "z"))))

; second field may be empty (detect empty fields)
(assert (or (= h1 "") (str.in_re h1 (re.+ (re.range "a" "z")))))

; third field: integer possibly with leading minus
(assert (str.in_re h2 (re.union (re.+ (re.range "0" "9")) (re.++ (str.to_re "-") (re.+ (re.range "0" "9"))))))

; tie csv_line2 to concatenation shape to resemble CSV
(assert (= csv_line2 (str.++ h0 (str.++ delim (str.++ h1 (str.++ delim h2))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

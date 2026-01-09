(set-logic ALL)

; Uninterpreted interface for string splitting
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
; Scenario: CSV Processing
; -------------------------

; A CSV record with comma separator
(declare-const csv_line String)
(declare-const delim String)
(assert (= delim ","))

; Extracted fields (0-based)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)

(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))

; ========== SAT instance: well-formed record with 4 fields, and one empty field detected ==========
(declare-const sat_line String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)

(assert (= sat_f0 (split_at sat_line delim 0)))
(assert (= sat_f1 (split_at sat_line delim 1)))
(assert (= sat_f2 (split_at sat_line delim 2)))
(assert (= sat_f3 (split_at sat_line delim 3)))

; Field count constraint: exactly 4 segments
(assert (= (num_splits sat_line delim) 4))

; Construct a concrete-like CSV line with an empty middle field: "A,,C,D"
(assert (= sat_line (str.++ "A" (str.++ delim (str.++ "" (str.++ delim (str.++ "C" (str.++ delim "D"))))))))

; Detect empty field
(assert (= sat_f1 ""))
(assert (not (= sat_f0 "")))
(assert (not (= sat_f2 "")))
(assert (not (= sat_f3 "")))

; Consistency with rest-of-line from index 2: should be "C,D"
(declare-const sat_rest2 String)
(assert (= sat_rest2 (split_rest sat_line delim 2)))
(assert (= sat_rest2 (str.++ "C" (str.++ delim "D"))))

; ========== UNSAT instance: contradictory requirements about emptiness and structure ==========
(declare-const unsat_line String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= u0 (split_at unsat_line delim 0)))
(assert (= u1 (split_at unsat_line delim 1)))
(assert (= u2 (split_at unsat_line delim 2)))

; Exactly 3 segments
(assert (= (num_splits unsat_line delim) 3))

; Force line to have an empty second field: "X,,Z"
(assert (= unsat_line (str.++ "X" (str.++ delim (str.++ "" (str.++ delim "Z"))))) )

; Contradiction: require the empty field to be non-empty
(assert (= u1 ""))
(assert (not (= u1 "")))

; ========== Additional mixed constraints over an unconstrained csv_line (may or may not be satisfiable) ==========
; Intended: show field count and empty-field detection patterns

; Require at least 2 fields in csv_line
(assert (>= (num_splits csv_line delim) 2))

; If there are 4 fields, then field2 is empty (encoded as implication)
(assert (=> (= (num_splits csv_line delim) 4) (= field2 "")))

; If field0 is empty, then csv_line must start with a comma (approximate by requiring first segment empty)
(assert (=> (= field0 "") (= (split_at csv_line delim 0) "")))

; Basic index validity style constraints (natural indices)
(declare-const k0 Int)
(declare-const k1 Int)
(assert (>= k0 0))
(assert (>= k1 0))
(assert (< k0 (num_splits csv_line delim)))
(assert (< k1 (num_splits csv_line delim)))

; k0-th field not containing delimiter (typical CSV segment property)
(assert (not (str.contains (split_at csv_line delim k0) delim)))

; Ensure split_rest from k1 is a suffix (approximate by non-increasing length)
(assert (<= (str.len (split_rest csv_line delim k1)) (str.len csv_line)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

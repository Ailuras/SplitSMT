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

; Uninterpreted interface for string split operations

; -----------------------------
; SAT instance: CSV row processing with empty-field detection
; -----------------------------
(declare-const csv_row_sat String)
(declare-const delim String)
(declare-const field0_sat String)
(declare-const field1_sat String)
(declare-const field2_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const i0 Int)
(declare-const i1 Int)
(declare-const i2 Int)

(assert (= delim ","))

; Indices are natural
(assert (= i0 0))
(assert (= i1 1))
(assert (= i2 2))
(assert (and (>= i0 0) (>= i1 0) (>= i2 0)))

; Require exactly three fields (two commas => 3 segments)
(assert (= (num_splits csv_row_sat delim) 3))

; Extract fields via split interface
(assert (= field0_sat (split_at csv_row_sat delim i0)))
(assert (= field1_sat (split_at csv_row_sat delim i1)))
(assert (= field2_sat (split_at csv_row_sat delim i2)))

; Extract rests for additional consistency checks
(assert (= rest1_sat (split_rest csv_row_sat delim i1)))
(assert (= rest2_sat (split_rest csv_row_sat delim i2)))

; Concrete witness ensures satisfiable and includes an empty field in the middle
(assert (= csv_row_sat (str.++ "alpha" (str.++ delim (str.++ "" (str.++ delim "omega"))))))

; Empty-field detection: field1 is empty
(assert (= field1_sat ""))
(assert (> (str.len field0_sat) 0))
(assert (> (str.len field2_sat) 0))

; Basic sanity: CSV should contain delimiter when >= 2 fields
(assert (>= (num_splits csv_row_sat delim) 2))
(assert (str.contains csv_row_sat delim))

; Character-level check: first character of field0 is 'a'
(assert (= (str.at field0_sat 0) "a"))

; Regex check: field2 contains only lowercase letters
(assert (str.in_re field2_sat (re.+ (re.range "a" "z"))))

; Additional content constraint: rest from field2 onwards equals field2 (since it is the last)
(assert (= rest2_sat field2_sat))

; -----------------------------
; UNSAT instance: contradictory requirements about emptiness and field count
; -----------------------------
(declare-const csv_row_unsat String)
(declare-const f0_unsat String)
(declare-const f1_unsat String)
(declare-const f2_unsat String)
(declare-const j0 Int)
(declare-const j1 Int)
(declare-const j2 Int)

(assert (= j0 0))
(assert (= j1 1))
(assert (= j2 2))
(assert (and (>= j0 0) (>= j1 0) (>= j2 0)))

; Require exactly three fields
(assert (= (num_splits csv_row_unsat delim) 3))

(assert (= f0_unsat (split_at csv_row_unsat delim j0)))
(assert (= f1_unsat (split_at csv_row_unsat delim j1)))
(assert (= f2_unsat (split_at csv_row_unsat delim j2)))

; Force the row to a concrete shape with an empty middle field
(assert (= csv_row_unsat (str.++ "x" (str.++ delim (str.++ "" (str.++ delim "y"))))))

; Contradiction: middle field is empty by construction but required non-empty
(assert (= f1_unsat ""))
(assert (> (str.len f1_unsat) 0))

; Additional contradiction: claim only one field despite requiring three
(assert (= (num_splits csv_row_unsat delim) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

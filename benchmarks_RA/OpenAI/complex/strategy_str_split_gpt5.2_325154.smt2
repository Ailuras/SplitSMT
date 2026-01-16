; Scenario: CSV Processing (mutated/extended seed)
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

; --- str_split interface ---

; --- Variables ---
(declare-const value2 String)
(declare-const key2 String)

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const field_count Int)

; --- Basic scenario wiring ---
(assert (= delim ","))
(assert (= csv_line value2))
(assert (= field_count (num_splits csv_line delim)))
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest2 (split_rest csv_line delim 2)))

; --- Core CSV constraints: ensure correct field counts, detect empty fields ---
; Require at least 3 fields
(assert (>= field_count 3))

; Detect empty field: at least one of first three fields is empty
(assert (or (= (str.len field0) 0)
            (= (str.len field1) 0)
            (= (str.len field2) 0)))

; Commas must exist if we have multiple segments
(assert (=> (>= field_count 2) (str.contains csv_line ",")))

; Simple structural: if field_count is 3, then there are no commas in rest2
(assert (=> (= field_count 3) (not (str.contains rest2 ","))))

; If there are more than 3 fields, rest2 must contain a comma
(assert (=> (> field_count 3) (str.contains rest2 ",")))

; Some restrictions to avoid degenerate solutions
(assert (not (= (str.len csv_line) 0)))

; Key constraint: interpret this as processing a CSV header "cache-control"
(assert (= key2 "cache-control"))

; --- Mutated remnants (lightweight) inspired by the seed ---
; Ensure the line includes an '=' somewhere (like a key=value cell)
(assert (not (= (str.indexof csv_line "=" 0) (- 1))))

; Constrain that 'A' appears and it occurs before '=' (typical token pattern)
(assert (not (= (str.indexof csv_line "A" 0) (- 1))))
(assert (< (str.indexof csv_line "A" 0) (str.indexof csv_line "=" 0)))

; Avoid leading/trailing space
(assert (not (= (str.at csv_line 0) " ")))
(assert (not (= (str.at csv_line (- (str.len csv_line) 1)) " ")))

; --- Mix SAT and UNSAT instances: create one UNSAT branch guarded by a flag ---
(declare-const make_unsat Bool)

; If make_unsat, require all first three fields non-empty AND at least one empty: contradiction.
(assert (=> make_unsat (and (> (str.len field0) 0)
                            (> (str.len field1) 0)
                            (> (str.len field2) 0)
                            (or (= (str.len field0) 0)
                                (= (str.len field1) 0)
                                (= (str.len field2) 0)))))

; If not make_unsat, enforce a satisfiable concrete pattern: empty middle field
(assert (=> (not make_unsat)
            (and (= field1 "")
                 (>= field_count 3))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

(set-logic ALL)

; Uninterpreted interface operations for string splitting
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

; ---------------------------
; SAT instance: typical CSV processing with empty-field detection
; ---------------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest_after2 String)
(declare-const is_empty_field2 Bool)
(declare-const idx2 Int)

(assert (= delim ","))

; Bind fields via split interface
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= rest_after2 (split_rest csv_line delim 2)))

; Require exactly 4 fields total (indices 0..3)
(assert (= (num_splits csv_line delim) 4))

; Natural index example
(assert (= idx2 2))
(assert (>= idx2 0))

; Detect empty field2 (allowed but must be recognized)
(assert (= is_empty_field2 (= field2 "")))
(assert is_empty_field2)

; Concrete witness CSV line: third field empty
(assert (= csv_line "alpha,bravo,,delta"))

; Additional consistency/shape constraints
(assert (not (= field0 "")))
(assert (not (= field1 "")))
(assert (not (= field3 "")))
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field1 ",")))
(assert (not (str.contains field2 ",")))
(assert (not (str.contains field3 ",")))
(assert (>= (str.len rest_after2) (str.len field2)))

; ---------------------------
; UNSAT instance: contradictory constraints on field count and emptiness
; ---------------------------
(declare-const bad_csv String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)
(declare-const bad_is_empty1 Bool)
(declare-const bad_k Int)

(assert (= bad_f0 (split_at bad_csv "," 0)))
(assert (= bad_f1 (split_at bad_csv "," 1)))
(assert (= bad_f2 (split_at bad_csv "," 2)))

; Force a 3-field CSV with a concrete line that has 3 segments
(assert (= bad_csv "x,,z"))
(assert (= (num_splits bad_csv ",") 3))

; Empty-field detection says field1 is empty
(assert (= bad_is_empty1 (= bad_f1 "")))
(assert bad_is_empty1)

; Contradiction: also force field1 non-empty
(assert (not (= bad_f1 "")))

; Also require an impossible field count for the same string
(assert (= bad_k 4))
(assert (>= bad_k 0))
(assert (= (num_splits bad_csv ",") bad_k))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

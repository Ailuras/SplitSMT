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

; Uninterpreted interface operations for string splitting

; =====================
; Scenario: CSV Processing
; Goal: process comma-separated fields, enforce field counts, and detect empty fields
; Includes both SAT and UNSAT instances in one file using push/pop
; =====================

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const nfields Int)
(declare-const idx_empty Int)

(assert (= delim ","))

; Basic well-formedness and derived bindings
(assert (= nfields (num_splits csv_line delim)))
(assert (>= nfields 1))

(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= field4 (split_at csv_line delim 4)))

(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Index for an empty field witness
(assert (>= idx_empty 0))
(assert (< idx_empty nfields))

; ---------------------
; SAT instance: exactly 4 fields, detect at least one empty field, and enforce simple content constraints
; ---------------------

(assert (= nfields 4))

; Example-style CSV: name,age,city,country (but allow empties)
; Require first field non-empty and not containing comma
(assert (> (str.len field0) 0))
(assert (not (str.contains field0 delim)))

; Constrain second field to be digits or empty (using regex)
(assert (str.in_re field1 (re.union (str.to_re "") (re.+ (re.range "0" "9")))))

; Constrain third and fourth fields to be alphabetic or empty
(assert (str.in_re field2 (re.union (str.to_re "") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))))))
(assert (str.in_re field3 (re.union (str.to_re "") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))))))

; Detect existence of an empty field among the 4
(assert (or (and (= idx_empty 0) (= field0 ""))
            (and (= idx_empty 1) (= field1 ""))
            (and (= idx_empty 2) (= field2 ""))
            (and (= idx_empty 3) (= field3 ""))))

; Additional structural constraint: if field2 is empty, then rest2 starts with comma ("",field3)
(assert (=> (= field2 "") (str.prefixof "," rest2)))

(check-sat)
(exit)

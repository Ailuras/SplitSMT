(set-logic ALL)

; Uninterpreted interface functions for string split
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

; ========== Shared delimiter ==========
(declare-const comma String)
(assert (= comma ","))

; ========== SAT instance: well-formed CSV with possible empty middle fields ==========
(declare-const csv_line_sat String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_field4 String)
(declare-const sat_rest2 String)
(declare-const sat_rest4 String)

; Expect exactly 5 fields (4 commas)
(assert (= (num_splits csv_line_sat comma) 5))

; Bind fields via split_at
(assert (= sat_field0 (split_at csv_line_sat comma 0)))
(assert (= sat_field1 (split_at csv_line_sat comma 1)))
(assert (= sat_field2 (split_at csv_line_sat comma 2)))
(assert (= sat_field3 (split_at csv_line_sat comma 3)))
(assert (= sat_field4 (split_at csv_line_sat comma 4)))

; Rest bindings to constrain structure without defining split semantics
(assert (= sat_rest2 (split_rest csv_line_sat comma 2)))
(assert (= sat_rest4 (split_rest csv_line_sat comma 4)))

; Detect an empty field: field2 is empty
(assert (= sat_field2 ""))

; Basic non-emptiness requirements for some fields
(assert (> (str.len sat_field0) 0))
(assert (> (str.len sat_field4) 0))

; No leading/trailing spaces in selected fields (simple checks)
(assert (not (= (str.at sat_field0 0) " ")))
(assert (not (= (str.at sat_field4 0) " ")))

; A simple format requirement: field0 and field4 are numeric-like (digits only, at least 1 char)
(declare-const digit_re RegLan)
(assert (= digit_re (re.range "0" "9")))
(assert (str.in_re sat_field0 (re.+ digit_re)))
(assert (str.in_re sat_field4 (re.+ digit_re)))

; Ensure field1 contains a dash and is not empty
(assert (> (str.len sat_field1) 0))
(assert (str.contains sat_field1 "-"))

; Ensure the rest-from-4 equals field4 (common split_rest expectation for last index)
; This is a plausible interface constraint for many split APIs
(assert (= sat_rest4 sat_field4))

; Constrain rest-from-2 to contain field3 and comma and field4 in order (structural hint)
(assert (str.contains sat_rest2 (str.++ sat_field3 comma)))
(assert (str.contains sat_rest2 (str.++ comma sat_field4)))

; Provide a concrete witness to keep the instance clearly SAT
(assert (= csv_line_sat "123,aa-bb,,X,99"))


; ========== UNSAT instance: contradictory field count vs explicit structure ==========
(declare-const csv_line_unsat String)
(declare-const uns_field0 String)
(declare-const uns_field1 String)
(declare-const uns_field2 String)
(declare-const uns_field3 String)

; Force a specific line with three commas -> 4 fields
(assert (= csv_line_unsat "a,,b,c"))

; Contradict: claim it has only 3 fields
(assert (= (num_splits csv_line_unsat comma) 3))

; Also bind out-of-range field if only 3 fields existed (index 3 would be invalid), but we keep it as an additional constraint
(assert (= uns_field0 (split_at csv_line_unsat comma 0)))
(assert (= uns_field1 (split_at csv_line_unsat comma 1)))
(assert (= uns_field2 (split_at csv_line_unsat comma 2)))
(assert (= uns_field3 (split_at csv_line_unsat comma 3)))

; Impose expected empty field1 due to consecutive commas in the concrete string
(assert (= uns_field1 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

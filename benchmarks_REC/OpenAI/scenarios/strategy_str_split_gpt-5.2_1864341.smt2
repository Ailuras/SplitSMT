(set-logic ALL)

; Uninterpreted interface for string split
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
; Scenario: CSV Processing
; We model comma-separated fields, require correct field counts,
; and detect empty fields.
; Provide both SAT and UNSAT clusters under assumptions.
; -----------------------------

; Common delimiter
(declare-const delim String)
(assert (= delim ","))

; ===== SAT instance: a CSV row with 4 fields, with at least one empty field =====
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

; Indices are natural
(assert (>= (num_splits csv_sat delim) 0))

; Exactly 4 fields
(assert (= (num_splits csv_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_sat delim 0)))
(assert (= f1_sat (split_at csv_sat delim 1)))
(assert (= f2_sat (split_at csv_sat delim 2)))
(assert (= f3_sat (split_at csv_sat delim 3)))

; The remaining string from index 2 should be field2,comma,field3
(assert (= rest2_sat (split_rest csv_sat delim 2)))
(assert (= rest2_sat (str.++ f2_sat delim f3_sat)))

; Construct a concrete satisfiable shape with one empty middle field
(assert (= f0_sat "alpha"))
(assert (= f1_sat ""))
(assert (= f2_sat "gamma"))
(assert (= f3_sat "delta"))
(assert (= csv_sat (str.++ f0_sat delim f1_sat delim f2_sat delim f3_sat)))

; Detect empty fields: at least one empty among the 4
(assert (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat "")))

; Also ensure no field contains the delimiter itself (typical unquoted CSV restriction)
(assert (not (str.contains f0_sat delim)))
(assert (not (str.contains f1_sat delim)))
(assert (not (str.contains f2_sat delim)))
(assert (not (str.contains f3_sat delim)))

; ===== UNSAT instance: demand 3 fields but also force 4 delimiters worth of structure =====
(declare-const csv_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

; Indices are natural
(assert (>= (num_splits csv_unsat delim) 0))

; Claim: exactly 3 fields
(assert (= (num_splits csv_unsat delim) 3))

; But simultaneously constrain it to be composed of 4 fields separated by commas
(assert (= u0 (split_at csv_unsat delim 0)))
(assert (= u1 (split_at csv_unsat delim 1)))
(assert (= u2 (split_at csv_unsat delim 2)))
(assert (= u3 (split_at csv_unsat delim 3)))
(assert (= csv_unsat (str.++ u0 delim u1 delim u2 delim u3)))

; Further enforce non-empty fields to avoid degenerate interpretations
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))

; ===== Additional mixed constraints on another CSV row (kept SAT) =====
(declare-const csv_mixed String)
(declare-const m0 String)
(declare-const m1 String)
(declare-const m2 String)
(declare-const mrest1 String)

; Must have 3 fields
(assert (= (num_splits csv_mixed delim) 3))

; Extract
(assert (= m0 (split_at csv_mixed delim 0)))
(assert (= m1 (split_at csv_mixed delim 1)))
(assert (= m2 (split_at csv_mixed delim 2)))

; Rest from index 1 should be field1,comma,field2
(assert (= mrest1 (split_rest csv_mixed delim 1)))
(assert (= mrest1 (str.++ m1 delim m2)))

; Enforce that first field is an integer-like token (digits, possibly leading '-')
(declare-const digit_re RegLan)
(declare-const digits_re RegLan)
(declare-const int_re RegLan)
(assert (= digit_re (re.range "0" "9")))
(assert (= digits_re (re.+ digit_re)))
(assert (= int_re (re.union digits_re (re.++ (str.to_re "-") digits_re))))
(assert (str.in_re m0 int_re))

; Ensure second field is empty (detect missing value), third non-empty
(assert (= m1 ""))
(assert (> (str.len m2) 0))

; Build concrete mixed row
(assert (= m0 "42"))
(assert (= m2 "ok"))
(assert (= csv_mixed (str.++ m0 delim m1 delim m2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

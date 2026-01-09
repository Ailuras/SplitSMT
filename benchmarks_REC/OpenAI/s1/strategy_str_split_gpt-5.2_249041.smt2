(set-logic ALL)

; --- Boolean skeleton preserved/mutated from seed ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)

; --- CSV Processing scenario variables ---
(declare-const var_0xINPUT_80938 String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const expected_fields Int)

; --- str_split interface functions (uninterpreted per spec) ---
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

; Delimiter is a comma for CSV
(assert (= delim ","))

; Extract first three fields and the remainder
(assert (= f0 (split_at var_0xINPUT_80938 delim 0)))
(assert (= f1 (split_at var_0xINPUT_80938 delim 1)))
(assert (= f2 (split_at var_0xINPUT_80938 delim 2)))
(assert (= rest1 (split_rest var_0xINPUT_80938 delim 1)))
(assert (= rest2 (split_rest var_0xINPUT_80938 delim 2)))

; Expect exactly 3 fields in this record
(assert (= expected_fields 3))
(assert (= (num_splits var_0xINPUT_80938 delim) expected_fields))

; Core CSV well-formedness: non-empty record and contains delimiter if multiple fields
(assert (not (= var_0xINPUT_80938 "")))
(assert (str.contains var_0xINPUT_80938 delim))

; Detect empty field: require that at least one of the 3 fields is empty
(assert (or (= f0 "") (= f1 "") (= f2 "")))

; Simple structural constraints to tie together prefix/suffix intuition
(assert (>= (str.len f0) 0))
(assert (>= (str.len f1) 0))
(assert (>= (str.len f2) 0))
(assert (>= (str.len rest1) 0))
(assert (>= (str.len rest2) 0))

; --- Mutated boolean structure from seed, now referencing CSV constraints ---
; T_1: record is not the exact literal (kept from seed)
(assert (= T_1 (not (= "AA1ND6MEXd" var_0xINPUT_80938))))
; T_2: negation, forcing equality with the literal
(assert (= T_2 (not T_1)))
(assert T_2)

; T_3: record is not empty
(assert (= T_3 (not (= "" var_0xINPUT_80938))))
(assert T_3)

; T_4/T_5: record should not be "Example:" (kept from seed)
(assert (= T_4 (= var_0xINPUT_80938 "Example:")))
(assert (= T_5 (not T_4)))
(assert T_5)

; T_6/T_7: mirrored constraint forcing record equal to the literal again
(assert (= T_6 (not (= var_0xINPUT_80938 "AA1ND6MEXd"))))
(assert (= T_7 (not T_6)))
(assert T_7)

; Additional CSV-specific sanity: if exactly 3 fields, field2 is the last segment
(assert (= (split_rest var_0xINPUT_80938 delim 2) f2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

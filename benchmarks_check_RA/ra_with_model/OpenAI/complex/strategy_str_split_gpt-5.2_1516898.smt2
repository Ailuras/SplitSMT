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

; Scenario: CSV Processing
; Goal: process comma-separated data fields to ensure correct field counts and detect empty fields

; Split interface (uninterpreted)

; Seed remnants (mutated/extended)
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_283257 String)

; Additional CSV-related variables
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const empty_field Bool)
(declare-const has_trailing_comma Bool)
(declare-const bad_header Bool)

(assert (= delim ","))

; Mutate the seed: still relate T_1 to a string equality, but now as a header check
(assert (= T_1 (= var_0xINPUT_283257 "Search")))

; CSV structure: require 4 fields (indices 0..3)
(assert (= (num_splits var_0xINPUT_283257 delim) 4))
(assert (>= (num_splits var_0xINPUT_283257 delim) 1))

; Bind fields via split_at
(assert (= f0 (split_at var_0xINPUT_283257 delim 0)))
(assert (= f1 (split_at var_0xINPUT_283257 delim 1)))
(assert (= f2 (split_at var_0xINPUT_283257 delim 2)))
(assert (= f3 (split_at var_0xINPUT_283257 delim 3)))

; Rest reconstruction constraint
(assert (= (split_rest var_0xINPUT_283257 delim 2) (str.++ f2 delim f3)))

; Detect empty fields: any field can be empty
(assert (= empty_field (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))

; Trailing comma implies last field empty (a common CSV issue)
(assert (= has_trailing_comma (= f3 "")))

; Bad header: if first field equals "Search" while we expect a CSV header like "id"
(assert (= bad_header (= f0 "Search")))

; Mix SAT and UNSAT: keep main instance SAT, but include an UNSAT branch guarded by bad_header
; If bad_header holds, force contradictory properties.
(assert (=> bad_header (and (not empty_field) has_trailing_comma)))

; Core CSV sanity: require no empty fields in the main intended path
(assert (not empty_field))

; Also require the overall input not to be exactly "Search" to avoid degenerate single-token input
(assert (not T_1))



; [GENERATION STATUS: SUCCESS]
(assert (= var_0xINPUT_283257 ","))
(assert (= has_trailing_comma false))
(assert (= f2 "D"))
(assert (= bad_header false))
(assert (= f3 "B"))
(assert (= T_1 false))
(assert (= empty_field false))
(assert (= f0 "A"))
(assert (= delim ","))
(assert (= f1 "C"))
(check-sat)
(exit)

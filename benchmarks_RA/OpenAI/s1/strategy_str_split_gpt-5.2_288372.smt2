(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field count checks, and empty-field detection

; Non-primitive interface operations (str_split)
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

; Seed-style declarations preserved
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_35390 () String)

; New CSV-focused variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const empty_field_detected Bool)
(declare-const has_extra_fields Bool)

; Core structure retained but repurposed: keep the "not '-'" guard and the "is empty" marker style
(assert (= T_1 (= "-" var_0xINPUT_35390)))
(assert (= T_2 (not T_1)))
(assert T_2)

; For CSV, interpret input as the CSV string; keep T_3 equality but on csv
(assert (= csv var_0xINPUT_35390))
(assert (= T_3 (= "" csv)))

; Delimiter is comma
(assert (= delim ","))

; Split into fields
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= f2 (split_at csv delim 2)))
(assert (= rest2 (split_rest csv delim 2)))

; Derived booleans about CSV structure
(assert (= empty_field_detected (or (= f0 "") (= f1 "") (= f2 ""))))
(assert (= has_extra_fields (> (num_splits csv delim) 3)))

; Mutated PCTEMP_LHS_1 selection structure:
; - If selection holds, enforce a 3-field CSV with an empty middle field: "alpha,,gamma"
; - Else, create a contradictory requirement (UNSAT branch) by forcing exactly 2 fields while also needing 3
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert
 (ite T_SELECT_1
      (and
        ; SAT branch: concrete CSV with an empty field
        (= T0_5 "alpha")
        (= T1_5 (str.++ "," (str.++ "" (str.++ "," "gamma"))))
        (= csv (str.++ T0_5 T1_5))
        (= (num_splits csv delim) 3)
        (= f0 "alpha")
        (= f1 "")
        (= f2 "gamma")
        (= empty_field_detected true)
        (= has_extra_fields false)

        ; Keep some seed-like arithmetic linkage
        (= I0_5 (str.len f0))
        (= PCTEMP_LHS_1 (+ I0_5 0))

        ; Keep a seed-inspired regex avoidance: forbid a tracking-token-like substring in the whole CSV
        (not (str.in_re csv
                        (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "a") (str.to_re "=")
                              (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4")))))
      (and
        ; UNSAT branch: impossible combination (forces 2 splits and also references 3rd field as non-empty)
        (= PCTEMP_LHS_1 (- 1))
        (= csv (str.++ "x" (str.++ "," "y")))
        (= (num_splits csv delim) 2)
        (= f0 "x")
        (= f1 "y")
        (not (= f2 ""))
        (= (num_splits csv delim) 3))))

; Keep seed tail constraints form
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_6 (not T_5)))
(assert T_6)

; Force SAT by requiring we are in the non-((- 1)) branch
(assert (not (= PCTEMP_LHS_1 (- 1))))

; Also ensure CSV is not empty (contrasts with T_3 assignment possibility)
(assert (not T_3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

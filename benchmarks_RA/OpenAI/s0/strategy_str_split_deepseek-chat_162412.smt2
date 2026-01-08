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

; Uninterpreted interface for string split constraints

; Scenario: CSV Processing
; We model two CSV lines: one intended to be valid, and one intended to be invalid.

(declare-const csv_ok String)
(declare-const csv_bad String)

(declare-const delim String)
(assert (= delim ","))

; Fields for csv_ok
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

; Fields for csv_bad
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)
(declare-const bad_f3 String)

; ---- SAT instance: csv_ok has exactly 4 fields, and no empty fields ----
(assert (= (num_splits csv_ok delim) 4))
(assert (= ok_f0 (split_at csv_ok delim 0)))
(assert (= ok_f1 (split_at csv_ok delim 1)))
(assert (= ok_f2 (split_at csv_ok delim 2)))
(assert (= ok_f3 (split_at csv_ok delim 3)))

; Indices are natural
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; No empty fields in the valid CSV line
(assert (and (> (str.len ok_f0) 0)
             (> (str.len ok_f1) 0)
             (> (str.len ok_f2) 0)
             (> (str.len ok_f3) 0)))

; Additional realistic constraints: fields do not contain the delimiter
(assert (and (not (str.contains ok_f0 delim))
             (not (str.contains ok_f1 delim))
             (not (str.contains ok_f2 delim))
             (not (str.contains ok_f3 delim))))

; Concrete-ish shape: header-like 4 columns: ID, NAME, AGE, CITY
; (keep content flexible but constrained)
(assert (>= (str.len ok_f0) 1))
(assert (>= (str.len ok_f1) 1))
(assert (>= (str.len ok_f2) 1))
(assert (>= (str.len ok_f3) 1))

; ---- UNSAT instance: csv_bad contradictions about empty fields and delimiters ----
; Intend csv_bad to have 4 fields, but simultaneously force it to contain an empty field while also disallowing empty fields.
(assert (= (num_splits csv_bad delim) 4))
(assert (= bad_f0 (split_at csv_bad delim 0)))
(assert (= bad_f1 (split_at csv_bad delim 1)))
(assert (= bad_f2 (split_at csv_bad delim 2)))
(assert (= bad_f3 (split_at csv_bad delim 3)))

; Detect empty fields: enforce that one middle field is empty (e.g., consecutive commas)
(assert (= bad_f2 ""))

; But also (incorrectly) assert that no field is empty => contradiction for csv_bad
(assert (and (> (str.len bad_f0) 0)
             (> (str.len bad_f1) 0)
             (> (str.len bad_f2) 0)
             (> (str.len bad_f3) 0)))

; Extra constraints: also require that bad_f2 contains a character, another direct contradiction
(assert (>= (str.len bad_f2) 1))

; Some bounds / sanity checks for split_rest usage
(declare-const bad_tail_from_2 String)
(assert (= bad_tail_from_2 (split_rest csv_bad delim 2)))
(assert (>= (str.len bad_tail_from_2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

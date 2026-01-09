(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; -----------------------------
; Scenario: CSV Processing
; Goal: enforce field counts, detect empty fields, mix SAT and UNSAT subcases
; -----------------------------

; A SAT instance: a simple 4-field CSV row with no empty fields
(declare-const csv_row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)

(assert (= csv_row_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (num_splits csv_row_sat ",") 4))
(assert (= f0_sat (split_at csv_row_sat "," 0)))
(assert (= f1_sat (split_at csv_row_sat "," 1)))
(assert (= f2_sat (split_at csv_row_sat "," 2)))
(assert (= f3_sat (split_at csv_row_sat "," 3)))
(assert (= (split_rest csv_row_sat "," 2) (str.++ f2_sat "," f3_sat)))

; No empty fields in SAT row
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; Restrict fields to not contain commas (typical unquoted CSV simplifying assumption)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; Additional sanity: first field looks like an identifier (letters/underscore, then letters/digits/underscore)
(declare-const id_re RegLan)
(assert (= id_re (re.++ (re.union (str.to_re "_") (re.range "A" "Z") (re.range "a" "z"))
                        (re.* (re.union (str.to_re "_") (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))))))
(assert (str.in_re f0_sat id_re))

; -----------------------------
; Another SAT instance: detect an empty field (consecutive commas)
; Here we ensure there are 5 fields and one is empty
(declare-const csv_row_empty_sat String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)
(declare-const e3 String)
(declare-const e4 String)

(assert (= csv_row_empty_sat (str.++ e0 "," e1 "," e2 "," e3 "," e4)))
(assert (= (num_splits csv_row_empty_sat ",") 5))
(assert (= e0 (split_at csv_row_empty_sat "," 0)))
(assert (= e1 (split_at csv_row_empty_sat "," 1)))
(assert (= e2 (split_at csv_row_empty_sat "," 2)))
(assert (= e3 (split_at csv_row_empty_sat "," 3)))
(assert (= e4 (split_at csv_row_empty_sat "," 4)))

; Detect at least one empty field; pin it to e2 for concreteness
(assert (= e2 ""))

; Ensure others are non-empty and comma-free
(assert (> (str.len e0) 0))
(assert (> (str.len e1) 0))
(assert (> (str.len e3) 0))
(assert (> (str.len e4) 0))
(assert (not (str.contains e0 ",")))
(assert (not (str.contains e1 ",")))
(assert (not (str.contains e3 ",")))
(assert (not (str.contains e4 ",")))

; The row must contain ",," somewhere to witness an empty field
(assert (str.contains csv_row_empty_sat ",,"))

; -----------------------------
; An UNSAT instance: claims a 3-field CSV but also forces an empty middle field while forbidding ",,"
(declare-const csv_row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= csv_row_unsat (str.++ u0 "," u1 "," u2)))
(assert (= (num_splits csv_row_unsat ",") 3))
(assert (= u0 (split_at csv_row_unsat "," 0)))
(assert (= u1 (split_at csv_row_unsat "," 1)))
(assert (= u2 (split_at csv_row_unsat "," 2)))

; Force middle field empty => row must contain ",,"
(assert (= u1 ""))

; Contradiction: forbid consecutive commas
(assert (not (str.contains csv_row_unsat ",,")))

; Also require u0 and u2 are non-empty (to avoid trivialities like leading/trailing commas explanations)
(assert (> (str.len u0) 0))
(assert (> (str.len u2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

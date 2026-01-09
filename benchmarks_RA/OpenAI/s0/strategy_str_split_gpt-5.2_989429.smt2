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

; ------------------------------
; SAT instance: well-formed CSV with 4 fields, no empty fields
; ------------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= csv_line_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (num_splits csv_line_sat ",") 4))
(assert (= f0_sat (split_at csv_line_sat "," 0)))
(assert (= f1_sat (split_at csv_line_sat "," 1)))
(assert (= f2_sat (split_at csv_line_sat "," 2)))
(assert (= f3_sat (split_at csv_line_sat "," 3)))
(assert (= rest1_sat (split_rest csv_line_sat "," 1)))
(assert (= rest2_sat (split_rest csv_line_sat "," 2)))
(assert (= rest3_sat (split_rest csv_line_sat "," 3)))
(assert (= rest1_sat (str.++ f1_sat "," f2_sat "," f3_sat)))
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))
(assert (= rest3_sat f3_sat))

; No empty fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; Additional realistic constraints: disallow commas inside fields
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; Force a simple shape: first field is an integer-like token, second is alphabetic-like
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re f1_sat (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; ------------------------------
; UNSAT instance: claims 4 fields but also enforces an empty middle field while requiring all fields non-empty
; ------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

(assert (= csv_line_unsat (str.++ u0 "," u1 "," u2 "," u3)))
(assert (= (num_splits csv_line_unsat ",") 4))
(assert (= u0 (split_at csv_line_unsat "," 0)))
(assert (= u1 (split_at csv_line_unsat "," 1)))
(assert (= u2 (split_at csv_line_unsat "," 2)))
(assert (= u3 (split_at csv_line_unsat "," 3)))

; Detect an empty field (u1 is empty) but simultaneously require all fields non-empty
(assert (= u1 ""))
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))

; ------------------------------
; Mixed constraints: another independent SAT subproblem about trailing commas and empty last field detection
; ------------------------------
(declare-const csv_line_trailing String)
(declare-const t0 String)
(declare-const t1 String)
(declare-const t2 String)

; A line with a trailing comma encodes an empty last field (3 segments: t0, t1, "")
(assert (= csv_line_trailing (str.++ t0 "," t1 "," t2)))
(assert (= t2 ""))
(assert (= (num_splits csv_line_trailing ",") 3))
(assert (= t0 (split_at csv_line_trailing "," 0)))
(assert (= t1 (split_at csv_line_trailing "," 1)))
(assert (= t2 (split_at csv_line_trailing "," 2)))

; Ensure first two fields are non-empty and do not contain commas
(assert (> (str.len t0) 0))
(assert (> (str.len t1) 0))
(assert (not (str.contains t0 ",")))
(assert (not (str.contains t1 ",")))

; Guard-style index validity constraints (natural indices)
(assert (>= (num_splits csv_line_sat ",") 0))
(assert (>= (num_splits csv_line_unsat ",") 0))
(assert (>= (num_splits csv_line_trailing ",") 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

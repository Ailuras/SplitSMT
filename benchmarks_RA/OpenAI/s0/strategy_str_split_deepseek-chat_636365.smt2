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

; Uninterpreted interface for string split operations

; =====================
; SAT instance: well-formed CSV line with 4 fields, no empty fields
; =====================
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= f0_sat (split_at csv_line_sat "," 0)))
(assert (= f1_sat (split_at csv_line_sat "," 1)))
(assert (= f2_sat (split_at csv_line_sat "," 2)))
(assert (= f3_sat (split_at csv_line_sat "," 3)))
(assert (= rest2_sat (split_rest csv_line_sat "," 2)))

; exactly 4 fields
(assert (= (num_splits csv_line_sat ",") 4))

; no empty fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; sanity: delimiter must actually be present, and the tail from field 2 onward contains a comma
(assert (str.contains csv_line_sat ","))
(assert (str.contains rest2_sat ","))

; add simple content constraints to diversify
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re f1_sat (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))
(assert (str.in_re f2_sat (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))
(assert (str.in_re f3_sat (re.+ (re.range "0" "9"))))

; =====================
; UNSAT instance: claims 3 fields but forces an empty middle field while also requiring non-empty fields
; =====================
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= u0 (split_at csv_line_unsat "," 0)))
(assert (= u1 (split_at csv_line_unsat "," 1)))
(assert (= u2 (split_at csv_line_unsat "," 2)))

(assert (= (num_splits csv_line_unsat ",") 3))

; force empty middle field
(assert (= u1 ""))

; but also require no empty fields (inconsistent)
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))

; also require that the CSV line does not start or end with a comma (still consistent with empty middle, but doesn't fix the contradiction)
(assert (not (str.prefixof "," csv_line_unsat)))
(assert (not (str.suffixof "," csv_line_unsat)))

; =====================
; Additional SAT instance: detect an empty field via pattern, while allowing it
; =====================
(declare-const csv_line_empty_ok String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)
(declare-const e_rest1 String)

(assert (= e0 (split_at csv_line_empty_ok "," 0)))
(assert (= e1 (split_at csv_line_empty_ok "," 1)))
(assert (= e2 (split_at csv_line_empty_ok "," 2)))
(assert (= e_rest1 (split_rest csv_line_empty_ok "," 1)))

(assert (= (num_splits csv_line_empty_ok ",") 3))

; allow an empty field but ensure at least one field is empty and others are non-empty
(assert (= e1 ""))
(assert (> (str.len e0) 0))
(assert (> (str.len e2) 0))

; ensure the input line contains ",," to indicate an empty middle field in raw text
(assert (str.contains csv_line_empty_ok ",,"))

; constrain other fields to be alphanumeric strings
(assert (str.in_re e0 (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z")))))
(assert (str.in_re e2 (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z")))))

; relate rest from index 1 onward to contain a comma (since it covers fields 1 and 2)
(assert (str.contains e_rest1 ","))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

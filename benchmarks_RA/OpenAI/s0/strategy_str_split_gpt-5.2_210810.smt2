(set-logic ALL)

; Uninterpreted functions for str_split interface
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

; -------------------------------
; SAT instance: CSV line with 4 fields, no empty fields, specific patterns
; -------------------------------
(declare-const csv_line_sat String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail_from_2 String)
(declare-const idx_nonneg Int)

(assert (= comma ","))
(assert (= f0 (split_at csv_line_sat comma 0)))
(assert (= f1 (split_at csv_line_sat comma 1)))
(assert (= f2 (split_at csv_line_sat comma 2)))
(assert (= f3 (split_at csv_line_sat comma 3)))
(assert (= tail_from_2 (split_rest csv_line_sat comma 2)))

; Exactly 4 segments total
(assert (= (num_splits csv_line_sat comma) 4))

; No empty fields
(assert (> (str.len f0) 0))
(assert (> (str.len f1) 0))
(assert (> (str.len f2) 0))
(assert (> (str.len f3) 0))

; Field content constraints (typical CSV processing checks)
; f0: uppercase alphabetic code length 3
(assert (= (str.len f0) 3))
(assert (str.in_re f0 (re.++ (re.range "A" "Z") (re.++ (re.range "A" "Z") (re.range "A" "Z")))))

; f1: integer (optional leading '-') and at least 1 digit
(assert (str.in_re f1 (re.++ (re.opt (str.to_re "-")) (re.+ (re.range "0" "9")))))

; f2: email-like token without comma: [a-z]+ '@' [a-z]+ '.' [a-z]+
(assert (str.in_re f2 (re.++ (re.+ (re.range "a" "z"))
                            (re.++ (str.to_re "@")
                                  (re.++ (re.+ (re.range "a" "z"))
                                        (re.++ (str.to_re ".") (re.+ (re.range "a" "z"))))))))

; f3: non-empty, no commas (approximate by forbidding contains ",")
(assert (not (str.contains f3 comma)))

; Structural reconstruction (typical CSV: f0,f1,f2,f3)
(assert (= csv_line_sat (str.++ f0 (str.++ comma (str.++ f1 (str.++ comma (str.++ f2 (str.++ comma f3))))))))

; Consistency with split_rest: tail_from_2 should match f2,f3
(assert (= tail_from_2 (str.++ f2 (str.++ comma f3))))

; Index discipline example (natural integer)
(assert (>= idx_nonneg 0))
(assert (< idx_nonneg (str.len csv_line_sat)))

(check-sat)

; -------------------------------
; UNSAT instance: demand 4 fields but also require an empty field while forbidding empties
; Detect empty fields via split_at = ""
; -------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

(assert (= u0 (split_at csv_line_unsat comma 0)))
(assert (= u1 (split_at csv_line_unsat comma 1)))
(assert (= u2 (split_at csv_line_unsat comma 2)))
(assert (= u3 (split_at csv_line_unsat comma 3)))
(assert (= (num_splits csv_line_unsat comma) 4))

; Forbid empty fields
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))

; But also require an empty second field (classic consecutive commas like "a,,b,c")
(assert (= u1 ""))

(check-sat)
(exit)

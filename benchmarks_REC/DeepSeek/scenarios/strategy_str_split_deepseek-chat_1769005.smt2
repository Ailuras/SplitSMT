; CSV Processing scenario: Validate CSV format with str_split operations
(set-logic ALL)
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

; Declare string variables for CSV data
(declare-const csv_line String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)

; Declare str_split interface functions

; Constraint 1: CSV line must have exactly 4 fields when split by comma
(assert (= (num_splits csv_line ",") 4))

; Constraint 2: Extract individual fields using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Constraint 3: No field should be empty (minimum length 1)
(assert (> (str.len field1) 0))
(assert (> (str.len field2) 0))
(assert (> (str.len field3) 0))
(assert (> (str.len field4) 0))

; Constraint 4: Field1 must start with alphabetic character
(assert (str.in_re field1 (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re "_"))))))

; Constraint 5: Field2 must be numeric (digits only)
(assert (str.in_re field2 (re.+ (re.range "0" "9"))))

; Constraint 6: Field3 must contain only alphanumeric characters or hyphens
(assert (str.in_re field3 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 7: Field4 must be a valid email-like pattern (simplified)
(assert (str.in_re field4 (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re "_"))) (str.to_re "@") (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))) (str.to_re ".") (re.union (str.to_re "com") (str.to_re "org") (str.to_re "net")))))

; Constraint 8: The concatenation of split_rest from index 2 should equal field3 and field4 with comma
(assert (= (split_rest csv_line "," 2) (str.++ field3 "," field4)))

; Constraint 9: Ensure CSV line doesn't contain consecutive commas (no empty fields in middle)
(assert (not (str.contains csv_line ",,")))

; Constraint 10: Additional validation - total characters in CSV line must be at least 20
(assert (>= (str.len csv_line) 20))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

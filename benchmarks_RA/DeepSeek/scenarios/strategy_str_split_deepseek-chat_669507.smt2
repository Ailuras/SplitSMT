; CSV Processing: Validate field counts and detect empty fields using str_split operations
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

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Define delimiter as comma
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty
(assert (not (= (split_at csv_line delimiter 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1)) "")))

; Constraint 4: Middle field (second field) must be empty to detect missing data
(assert (= (split_at csv_line delimiter 1) ""))

; Constraint 5: Total field count must be exactly 5
(assert (= (num_splits csv_line delimiter) 5))

; Constraint 6: Concatenation of all fields after the first should match a specific pattern
(assert (str.contains (split_rest csv_line delimiter 1) "data"))

; Constraint 7: Ensure the CSV line does not start or end with the delimiter
(assert (not (str.prefixof delimiter csv_line)))
(assert (not (str.suffixof delimiter csv_line)))

; Additional constraint: Field lengths must be within reasonable bounds
(assert (<= (str.len (split_at csv_line delimiter 0)) 10))
(assert (<= (str.len (split_at csv_line delimiter 2)) 15))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

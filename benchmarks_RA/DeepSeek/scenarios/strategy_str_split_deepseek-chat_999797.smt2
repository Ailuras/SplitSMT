; CSV Processing: Validate comma-separated data fields with str_split operations
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

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const second_field String)
(declare-const last_field String)
(declare-const concatenated_rest String)

; Declare str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields (minimum for meaningful processing)
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty (no leading empty field)
(assert (> (str.len (split_at csv_line delimiter 0)) 0))

; Constraint 3: Second field must be exactly "data" (specific field validation)
(assert (= (split_at csv_line delimiter 1) "data"))

; Constraint 4: Last field (index = total splits - 1) must not be "empty"
(assert (not (= (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1)) "empty")))

; Constraint 5: Concatenation of fields from index 2 onwards must contain "value"
(assert (str.contains (split_rest csv_line delimiter 2) "value"))

; Constraint 6: Total field count must be between 3 and 5 inclusive
(assert (and (>= field_count 3) (<= field_count 5)))
(assert (= field_count (num_splits csv_line delimiter)))

; Constraint 7: CSV line must match a pattern: alphanumeric fields separated by commas
(assert (str.in_re csv_line (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",")))))

; Constraint 8: No two consecutive commas (to prevent empty fields in middle)
(assert (not (str.contains csv_line ",,")))

; Constraint 9: Define helper variables for specific fields
(assert (= first_field (split_at csv_line delimiter 0)))
(assert (= second_field (split_at csv_line delimiter 1)))
(assert (= last_field (split_at csv_line delimiter (- field_count 1))))
(assert (= concatenated_rest (split_rest csv_line delimiter 2)))

; Constraint 10: Ensure the line ends with a non-comma character (valid termination)
(assert (not (= (str.at csv_line (- (str.len csv_line) 1)) ",")))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

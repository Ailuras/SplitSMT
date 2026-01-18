; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
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

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const second_field String)
(declare-const third_field String)
(declare-const rest_fields String)

; Declare str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields (e.g., for ID, Name, Age)
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field (ID) must be non-empty and numeric (only digits)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))
(assert (str.in_re first_field (re.+ (re.range "0" "9"))))

; Constraint 3: Second field (Name) must be non-empty and contain only letters and spaces
(assert (= second_field (split_at csv_data delimiter 1)))
(assert (> (str.len second_field) 0))
(assert (str.in_re second_field (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re " ")))))

; Constraint 4: Third field (Age) must be a valid integer between 0 and 150
(assert (= third_field (split_at csv_data delimiter 2)))
(assert (str.in_re third_field (re.+ (re.range "0" "9"))))
(assert (let ((age_int (str.to_int third_field)))
  (and (>= age_int 0) (<= age_int 150))))

; Constraint 5: Rest of fields (if any) must not be empty
(assert (= rest_fields (split_rest csv_data delimiter 3)))
(assert (or (= rest_fields "") (not (str.contains rest_fields ",,"))))

; Constraint 6: Total field count must be exactly 4 (ID, Name, Age, and optional extra)
(assert (= field_count (num_splits csv_data delimiter)))
(assert (or (= field_count 3) (= field_count 4)))

; Additional constraint: CSV data must not start or end with delimiter to avoid empty leading/trailing fields
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

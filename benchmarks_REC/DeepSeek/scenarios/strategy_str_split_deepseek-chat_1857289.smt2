; CSV Processing: Validate comma-separated data fields with str_split operations
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

; Declare string variables for CSV data and fields
(declare-fun csv_data () String)
(declare-fun field0 () String)
(declare-fun field1 () String)
(declare-fun field2 () String)
(declare-fun field3 () String)
(declare-fun field4 () String)
(declare-fun field5 () String)
(declare-fun field6 () String)
(declare-fun field7 () String)
(declare-fun field8 () String)
(declare-fun field9 () String)
(declare-fun total_fields () Int)
(declare-fun empty_field_count () Int)
(declare-fun has_empty_fields () Bool)
(declare-fun valid_field_count () Bool)
(declare-fun all_fields_nonempty () Bool)

; Declare str_split interface functions

; CSV data constraints
(assert (= csv_data "name,age,city,,salary,department,phone,email,status,notes"))
(assert (>= (str.len csv_data) 10))

; Split CSV data by comma delimiter
(assert (= total_fields (num_splits csv_data ",")))
(assert (= field0 (split_at csv_data "," 0)))
(assert (= field1 (split_at csv_data "," 1)))
(assert (= field2 (split_at csv_data "," 2)))
(assert (= field3 (split_at csv_data "," 3)))
(assert (= field4 (split_at csv_data "," 4)))
(assert (= field5 (split_at csv_data "," 5)))
(assert (= field6 (split_at csv_data "," 6)))
(assert (= field7 (split_at csv_data "," 7)))
(assert (= field8 (split_at csv_data "," 8)))
(assert (= field9 (split_at csv_data "," 9)))

; Field count validation
(assert (= valid_field_count (and (>= total_fields 8) (<= total_fields 10))))
(assert valid_field_count)

; Detect empty fields
(assert (= has_empty_fields (or (= field0 "") (= field1 "") (= field2 "") (= field3 "") (= field4 "") (= field5 "") (= field6 "") (= field7 "") (= field8 "") (= field9 ""))))
(assert has_empty_fields)

; Count empty fields
(assert (= empty_field_count (+ (ite (= field0 "") 1 0) (ite (= field1 "") 1 0) (ite (= field2 "") 1 0) (ite (= field3 "") 1 0) (ite (= field4 "") 1 0) (ite (= field5 "") 1 0) (ite (= field6 "") 1 0) (ite (= field7 "") 1 0) (ite (= field8 "") 1 0) (ite (= field9 "") 1 0))))
(assert (>= empty_field_count 1))
(assert (<= empty_field_count 3))

; Check if all fields are non-empty (should be false due to constraints above)
(assert (= all_fields_nonempty (and (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 "")) (not (= field4 "")) (not (= field5 "")) (not (= field6 "")) (not (= field7 "")) (not (= field8 "")) (not (= field9 "")))))
(assert (not all_fields_nonempty))

; Additional constraints on specific fields
(assert (>= (str.len field0) 2))  ; name field should have at least 2 characters
(assert (str.contains field1 "25"))  ; age field should contain "25"
(assert (str.contains field2 "York"))  ; city field should contain "York"
(assert (>= (str.len field4) 4))  ; salary field should have at least 4 characters
(assert (str.contains field5 "IT"))  ; department field should contain "IT"
(assert (str.contains field6 "555"))  ; phone field should contain "555"
(assert (str.contains field7 "@"))  ; email field should contain "@"
(assert (or (= field8 "active") (= field8 "inactive")))  ; status field must be either "active" or "inactive"
(assert (<= (str.len field9) 50))  ; notes field should not exceed 50 characters

; Verify split_rest functionality
(assert (= (split_rest csv_data "," 5) (str.++ field5 "," field6 "," field7 "," field8 "," field9)))
(assert (= (split_rest csv_data "," 0) csv_data))

; Ensure field indices are within bounds
(assert (>= total_fields 1))
(assert (forall ((i Int)) (=> (and (>= i 0) (< i total_fields)) (>= (str.len (split_at csv_data "," i)) 0))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

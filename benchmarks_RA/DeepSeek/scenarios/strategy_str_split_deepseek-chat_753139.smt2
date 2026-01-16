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

; Declare integer variables for field counts and indices
(declare-fun total_fields () Int)
(declare-fun non_empty_fields () Int)
(declare-fun empty_field_index () Int)
(declare-fun last_field_index () Int)

; Declare str_split interface functions

; Core CSV constraints
(assert (= total_fields (num_splits csv_data ",")))
(assert (>= total_fields 5))
(assert (<= total_fields 10))

; Extract specific fields using split_at
(assert (= field0 (split_at csv_data "," 0)))
(assert (= field1 (split_at csv_data "," 1)))
(assert (= field2 (split_at csv_data "," 2)))
(assert (= field3 (split_at csv_data "," 3)))
(assert (= field4 (split_at csv_data "," 4)))

; Constraints on field contents
(assert (str.contains field0 "ID"))
(assert (>= (str.len field1) 3))
(assert (str.in_re field2 (re.++ (str.to_re "[A-Z]") (re.* (str.to_re "[a-z]")))))
(assert (not (= field3 "")))
(assert (str.contains field4 "@"))

; Handle optional additional fields
(assert (=> (>= total_fields 6) (= field5 (split_at csv_data "," 5))))
(assert (=> (>= total_fields 7) (= field6 (split_at csv_data "," 6))))
(assert (=> (>= total_fields 8) (= field7 (split_at csv_data "," 7))))
(assert (=> (>= total_fields 9) (= field8 (split_at csv_data "," 8))))
(assert (=> (>= total_fields 10) (= field9 (split_at csv_data "," 9))))

; Count non-empty fields
(assert (= non_empty_fields
    (+ (ite (= (str.len field0) 0) 0 1)
       (ite (= (str.len field1) 0) 0 1)
       (ite (= (str.len field2) 0) 0 1)
       (ite (= (str.len field3) 0) 0 1)
       (ite (= (str.len field4) 0) 0 1)
       (ite (and (>= total_fields 6) (= (str.len field5) 0)) 0 1)
       (ite (and (>= total_fields 7) (= (str.len field6) 0)) 0 1)
       (ite (and (>= total_fields 8) (= (str.len field7) 0)) 0 1)
       (ite (and (>= total_fields 9) (= (str.len field8) 0)) 0 1)
       (ite (and (>= total_fields 10) (= (str.len field9) 0)) 0 1))))

; Ensure at least 80% of fields are non-empty
(assert (>= (* non_empty_fields 10) (* total_fields 8)))

; Find an empty field if it exists
(assert (or (and (= (str.len field0) 0) (= empty_field_index 0))
            (and (= (str.len field1) 0) (= empty_field_index 1))
            (and (= (str.len field2) 0) (= empty_field_index 2))
            (and (= (str.len field3) 0) (= empty_field_index 3))
            (and (= (str.len field4) 0) (= empty_field_index 4))
            (and (>= total_fields 6) (= (str.len field5) 0) (= empty_field_index 5))
            (and (>= total_fields 7) (= (str.len field6) 0) (= empty_field_index 6))
            (and (>= total_fields 8) (= (str.len field7) 0) (= empty_field_index 7))
            (and (>= total_fields 9) (= (str.len field8) 0) (= empty_field_index 8))
            (and (>= total_fields 10) (= (str.len field9) 0) (= empty_field_index 9))
            (= empty_field_index (- 1))))

; Last field should not be empty
(assert (= last_field_index (- total_fields 1)))
(assert (=> (= last_field_index 0) (not (= (str.len field0) 0))))
(assert (=> (= last_field_index 1) (not (= (str.len field1) 0))))
(assert (=> (= last_field_index 2) (not (= (str.len field2) 0))))
(assert (=> (= last_field_index 3) (not (= (str.len field3) 0))))
(assert (=> (= last_field_index 4) (not (= (str.len field4) 0))))
(assert (=> (= last_field_index 5) (not (= (str.len field5) 0))))
(assert (=> (= last_field_index 6) (not (= (str.len field6) 0))))
(assert (=> (= last_field_index 7) (not (= (str.len field7) 0))))
(assert (=> (= last_field_index 8) (not (= (str.len field8) 0))))
(assert (=> (= last_field_index 9) (not (= (str.len field9) 0))))

; Additional constraints for SAT/UNSAT diversity
(assert (not (str.contains csv_data ",,")))
(assert (str.in_re csv_data (re.++ (re.* (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "@") (str.to_re ".") (str.to_re "-") (str.to_re "_"))) (re.* (str.to_re ",")) (re.* (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "@") (str.to_re ".") (str.to_re "-") (str.to_re "_"))))))

; Bounds on indices
(assert (>= empty_field_index (- 1)))
(assert (< empty_field_index total_fields))
(assert (>= last_field_index 0))
(assert (< last_field_index total_fields))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

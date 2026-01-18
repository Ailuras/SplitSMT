; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
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

; Declare variables
(declare-const csv_line String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const total_fields Int)
(declare-const has_empty_field Bool)

; Declare str_split interface functions

; Assert constraints for CSV processing
; Constraint 1: CSV line must have at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: Extract first three fields
(assert (= field0 (split_at csv_line "," 0)))
(assert (= field1 (split_at csv_line "," 1)))
(assert (= field2 (split_at csv_line "," 2)))

; Constraint 3: Total fields count
(assert (= total_fields (num_splits csv_line ",")))

; Constraint 4: Detect if any of the first three fields is empty (length 0)
(assert (= has_empty_field (or (= (str.len field0) 0) (= (str.len field1) 0) (= (str.len field2) 0))))

; Constraint 5: Ensure CSV line is non-empty and contains commas
(assert (> (str.len csv_line) 0))
(assert (str.contains csv_line ","))

; Constraint 6: Additional constraint to create a SAT instance: field0 must not be empty if total_fields is exactly 3
(assert (=> (= total_fields 3) (> (str.len field0) 0)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

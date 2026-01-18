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
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions

; Assert CSV line has at least 3 fields (comma-separated)
(assert (>= (num_splits csv_line ",") 3))

; Define field_count as total number of splits
(assert (= field_count (num_splits csv_line ",")))

; Extract first field (index 0)
(assert (= first_field (split_at csv_line "," 0)))

; Extract last field (index field_count-1)
(assert (= last_field (split_at csv_line "," (- field_count 1))))

; Extract middle field (index 1) for checking
(assert (= middle_field (split_at csv_line "," 1)))

; Check if any field is empty (zero length)
(assert (= has_empty_field
    (or (= (str.len first_field) 0)
        (= (str.len middle_field) 0)
        (= (str.len last_field) 0)
        (exists ((i Int))
            (and (>= i 2) (< i (- field_count 1))
                 (= (str.len (split_at csv_line "," i)) 0))))))

; Additional constraints for meaningful CSV processing
(assert (not (= csv_line ""))) ; CSV line cannot be empty
(assert (>= (str.len csv_line) 5)) ; Minimum reasonable length
(assert (str.contains csv_line ",")) ; Must contain at least one comma

; Constraint to make it SAT: ensure first field is non-empty
(assert (not (= (str.len first_field) 0)))

; Constraint to potentially make UNSAT: conflicting empty field requirements
; (assert (and has_empty_field (not has_empty_field))) ; Uncomment for UNSAT version



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

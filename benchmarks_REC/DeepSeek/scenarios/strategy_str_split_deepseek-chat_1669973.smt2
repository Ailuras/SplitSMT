; CSV Processing: Validate field counts and detect empty fields using str_split operations
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

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)
(declare-const all_fields_nonempty Bool)

; Declare str_split interface functions

; Core CSV constraints
; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: First field must be non-empty
(assert (not (= (split_at csv_line "," 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (split_at csv_line "," (- (num_splits csv_line ",") 1)) "")))

; Constraint 4: Middle field (second field) must contain the substring "ID"
(assert (str.contains (split_at csv_line "," 1) "ID"))

; Constraint 5: Check if any field is empty (excluding first and last which are already constrained)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 2)
            (< i (- (num_splits csv_line ",") 1))
            (= (split_at csv_line "," i) "")
        )
    )
))

; Constraint 6: All fields must be non-empty (contradicts Constraint 5 to create UNSAT potential)
(assert (= all_fields_nonempty
    (forall ((j Int))
        (=>
            (and (>= j 0) (< j (num_splits csv_line ",")))
            (not (= (split_at csv_line "," j) ""))
        )
    )
))

; Constraint 7: Total field count must be exactly 5
(assert (= (num_splits csv_line ",") 5))

; Constraint 8: The concatenation of all fields (excluding delimiters) must equal the original line
; This is a tautology by definition of split_at, but included for completeness
(assert (= csv_line
    (str.++
        (split_at csv_line "," 0)
        ","
        (split_at csv_line "," 1)
        ","
        (split_at csv_line "," 2)
        ","
        (split_at csv_line "," 3)
        ","
        (split_at csv_line "," 4)
    )
))

; Constraint 9: The third field must be numeric (only digits)
(assert (str.in_re (split_at csv_line "," 2) (re.* (re.range "0" "9"))))

; Constraint 10: The line must not start or end with a comma
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))

; Final check


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

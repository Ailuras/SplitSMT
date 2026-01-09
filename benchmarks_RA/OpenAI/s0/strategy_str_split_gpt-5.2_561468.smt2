(set-logic ALL)

; Uninterpreted interface for str_split
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

; Scenario: CSV Processing
; We model CSV rows separated by ',' and enforce field counts and empty-field detection.

; ----------------------------
; SAT instance: valid-ish CSV row with an empty field
; ----------------------------
(declare-const csv_row_sat String)
(declare-const comma String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)

(assert (= comma ","))

; Exactly 4 fields
(assert (= (num_splits csv_row_sat comma) 4))

; Bind each field via split_at
(assert (= sat_f0 (split_at csv_row_sat comma 0)))
(assert (= sat_f1 (split_at csv_row_sat comma 1)))
(assert (= sat_f2 (split_at csv_row_sat comma 2)))
(assert (= sat_f3 (split_at csv_row_sat comma 3)))

; Indices are natural
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Detect an empty middle field (consecutive commas)
(assert (= sat_f1 ""))

; Other fields non-empty and no extra commas inside them
(assert (> (str.len sat_f0) 0))
(assert (> (str.len sat_f2) 0))
(assert (> (str.len sat_f3) 0))
(assert (not (str.contains sat_f0 comma)))
(assert (not (str.contains sat_f2 comma)))
(assert (not (str.contains sat_f3 comma)))

; Constrain a concrete shape: alpha,empty,numeric,alpha
(assert (str.in_re sat_f0 (re.+ (re.range "a" "z"))))
(assert (str.in_re sat_f2 (re.+ (re.range "0" "9"))))
(assert (str.in_re sat_f3 (re.+ (re.range "a" "z"))))

; Reconstruct row (sanity cross-check using concatenation)
(assert (= csv_row_sat (str.++ sat_f0 comma sat_f1 comma sat_f2 comma sat_f3)))

; Also relate split_rest: rest from index 2 equals f2,f3
(assert (= (split_rest csv_row_sat comma 2) (str.++ sat_f2 comma sat_f3)))

; ----------------------------
; UNSAT instance: impossible constraints about emptiness
; ----------------------------
(declare-const csv_row_unsat String)
(declare-const unsat_f0 String)
(declare-const unsat_f1 String)
(declare-const unsat_f2 String)

; Exactly 3 fields
(assert (= (num_splits csv_row_unsat comma) 3))
(assert (= unsat_f0 (split_at csv_row_unsat comma 0)))
(assert (= unsat_f1 (split_at csv_row_unsat comma 1)))
(assert (= unsat_f2 (split_at csv_row_unsat comma 2)))

; Require field 1 to be empty
(assert (= unsat_f1 ""))

; But also require it to have positive length (contradiction)
(assert (> (str.len unsat_f1) 0))

; Additional CSV-ish shape constraints
(assert (not (str.contains unsat_f0 comma)))
(assert (not (str.contains unsat_f2 comma)))
(assert (= csv_row_unsat (str.++ unsat_f0 comma unsat_f1 comma unsat_f2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

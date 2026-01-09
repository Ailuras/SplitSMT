(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection
; This file includes both a satisfiable instance (csv_ok) and an unsatisfiable instance (csv_bad).

; --- str_split interface (uninterpreted) ---
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

; --- Shared constants ---
(declare-const comma String)
(assert (= comma ","))

; ========== SAT instance: well-formed CSV with an empty middle field ==========
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_rest1 String)
(declare-const ok_rest2 String)
(declare-const ok_field_count Int)

; Field count constraints (3 fields)
(assert (= ok_field_count (num_splits csv_ok comma)))
(assert (= ok_field_count 3))

; Extract fields
(assert (= ok_f0 (split_at csv_ok comma 0)))
(assert (= ok_f1 (split_at csv_ok comma 1)))
(assert (= ok_f2 (split_at csv_ok comma 2)))

; Rest segments
(assert (= ok_rest1 (split_rest csv_ok comma 1)))
(assert (= ok_rest2 (split_rest csv_ok comma 2)))

; Ensure indices are natural
(assert (>= ok_field_count 0))

; Detect empty field: middle field is empty
(assert (= ok_f1 ""))

; Non-empty constraints for other fields
(assert (not (= ok_f0 "")))
(assert (not (= ok_f2 "")))

; No commas inside individual fields (simple CSV without quoting)
(assert (not (str.contains ok_f0 comma)))
(assert (not (str.contains ok_f1 comma)))
(assert (not (str.contains ok_f2 comma)))

; Make the instance concrete enough for SAT
(assert (= ok_f0 "alpha"))
(assert (= ok_f2 "gamma"))

; Optional sanity: length properties
(assert (> (str.len csv_ok) 0))
(assert (>= (str.len ok_rest1) (str.len ok_f2)))

; ========== UNSAT instance: contradictory constraints about emptiness ==========
(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)
(declare-const bad_count Int)
(declare-const bad_rest0 String)

; Claim 3 fields
(assert (= bad_count (num_splits csv_bad comma)))
(assert (= bad_count 3))

; Extract fields
(assert (= bad_f0 (split_at csv_bad comma 0)))
(assert (= bad_f1 (split_at csv_bad comma 1)))
(assert (= bad_f2 (split_at csv_bad comma 2)))

; Rest from 0 is the whole string (interface-style expectation for k=0)
(assert (= bad_rest0 (split_rest csv_bad comma 0)))

; Set a concrete CSV with an empty middle field
(assert (= csv_bad "x,,z"))

; Emptiness detection expects middle field empty
(assert (= bad_f1 ""))

; Contradiction: require all fields non-empty
(assert (not (= bad_f0 "")))
(assert (not (= bad_f1 "")))
(assert (not (= bad_f2 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

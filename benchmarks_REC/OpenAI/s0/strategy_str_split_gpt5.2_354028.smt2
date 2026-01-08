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

; Uninterpreted interface functions for string split

; =====================
; CSV Processing Scenario
; =====================

; A single CSV line and its delimiter
(declare-const csv_line String)
(declare-const delim String)
(assert (= delim ","))

; Extract some fields by index
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_from3 String)

(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest_from3 (split_rest csv_line delim 3)))

; Index domain constraints (natural indices)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

; ---------------------
; SAT instance: ensure correct field count and detect empty fields
; ---------------------

; Require exactly 4 fields (indices 0..3 exist)
(declare-const nfields Int)
(assert (= nfields (num_splits csv_line delim)))
(assert (= nfields 4))

; Constrain content patterns: IDs and numeric-like fields
; - field0: exactly 2 uppercase letters
; - field1: non-empty
; - field2: digits only (possibly empty allowed later, but here force non-empty)
(declare-const re_upper2 RegLan)
(declare-const re_digitplus RegLan)

(assert (= re_upper2 (re.++ (re.range "A" "Z") (re.range "A" "Z"))))
(assert (= re_digitplus (re.++ (re.+ (re.range "0" "9")) (re.* (re.range "0" "9")))))

(assert (str.in_re field0 re_upper2))
(assert (not (= field1 "")))
(assert (and (not (= field2 "")) (str.in_re field2 (re.+ (re.range "0" "9")))))

; Empty-field detection: enforce that the 4th field (index 3) is empty
(declare-const field3 String)
(assert (= field3 (split_at csv_line delim 3)))
(assert (= field3 ""))

; Ensure we actually have consecutive delimiters or trailing delimiter causing emptiness.
; Two common ways: ",," creates an empty middle field; trailing "," creates empty last field.
; Here we require last field empty, which implies the line ends with a comma in typical CSV.
; We approximate this by requiring csv_line ends with a comma.
(assert (str.suffixof "," csv_line))

; Also constrain earlier fields to avoid commas
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field1 ",")))
(assert (not (str.contains field2 ",")))
(assert (not (str.contains field3 ",")))

; Provide one concrete witness to keep SAT grounded
(assert (= csv_line "AB,hello,123,"))

(check-sat)

; ---------------------
; UNSAT instance: contradictory requirements about empty fields / field count
; ---------------------


; Force still 4 fields, but also require last field to be non-empty while csv_line ends with comma
(assert (= (num_splits csv_line delim) 4))
(assert (str.suffixof "," csv_line))
(assert (not (= (split_at csv_line delim 3) "")))

(check-sat)

(exit)

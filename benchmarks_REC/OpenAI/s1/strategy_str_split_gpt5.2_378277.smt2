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

; Scenario: CSV Processing
; Goal: process comma-separated fields, ensure correct field counts, and detect empty fields

; Base strings
(declare-const csv String)
(declare-const comma String)
(declare-const header String)
(declare-const y String)

; str_split interface

; Field variables
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail1 String)
(declare-const tail2 String)

; Basic setup
(assert (= comma ","))
(assert (= header "id,name,age,city"))

; CSV must start with the header and have at least one data row (newline separator)
(assert (str.contains csv header))
(assert (str.contains csv "\n"))

; Focus on the first data row after header newline
(assert (= y (str.replace csv (str.++ header "\n") "")))

; Core structure mutation from seed: keep a similar "not (= ... (= ...))" shape with string ops
(assert (not (= (str.contains csv (str.replace y "" csv)) (= csv (str.++ csv y)))))

; Interpret y as a CSV row (no newline inside it, for simplicity)
(assert (not (str.contains y "\n")))
(assert (>= (str.len y) 1))

; Ensure y has exactly 4 fields separated by commas
(assert (= (num_splits y comma) 4))
(assert (= f0 (split_at y comma 0)))
(assert (= f1 (split_at y comma 1)))
(assert (= f2 (split_at y comma 2)))
(assert (= f3 (split_at y comma 3)))
(assert (= tail1 (split_rest y comma 1)))
(assert (= tail2 (split_rest y comma 2)))

; Field sanity constraints
(assert (>= (str.len f0) 1))
(assert (not (str.contains f0 comma)))
(assert (not (str.contains f1 comma)))
(assert (not (str.contains f2 comma)))
(assert (not (str.contains f3 comma)))

; Detect empty fields: at least one empty field must exist
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Additional structure: tails should still contain expected commas when enough fields remain
(assert (str.contains tail1 comma))
(assert (str.contains tail2 comma))

; UNSAT trigger: simultaneously require all fields non-empty (contradicts empty-field detection)
(assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

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
; Scenario: CSV Processing
; Goal: process comma-separated fields, ensure correct field counts, and detect empty fields

; str_split interface (uninterpreted)

; CSV line and delimiter
(declare-const X String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail2 String)
(declare-const has_empty Bool)

(assert (= delim ","))

; Keep core structure: keep seed-style regex constraints but adapt to CSV-like prefix/suffix
(assert (str.in_re X
  (re.++
    (str.to_re "name,age,score")
    (str.to_re "\u{a}")
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",") (str.to_re " ") (str.to_re "-")))
  )
))

; Another regex: require at least one comma somewhere after header to ensure CSV nature
(assert (str.in_re X
  (re.++
    (re.* (re.comp (str.to_re "\u{a}")))
    (str.to_re ",")
    (re.* (re.comp (str.to_re "\u{a}")))
  )
))

; Adapt seed's negative pattern: forbid a filename-like injection in the CSV line
(assert (not (str.in_re X
  (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".f4p") )
)))

; Split constraints for CSV processing
(assert (>= (str.len X) 1))
(assert (>= (num_splits X delim) 3))

(assert (= f0 (split_at X delim 0)))
(assert (= f1 (split_at X delim 1)))
(assert (= f2 (split_at X delim 2)))
(assert (= tail2 (split_rest X delim 2)))

; Indices are natural / valid
(assert (and (>= 0 0) (>= 1 0) (>= 2 0)))

; Header fields must be exact and non-empty
(assert (= f0 "name"))
(assert (= f1 "age"))
(assert (= f2 "score\u{a}"))

; Detect empty fields: either a leading empty field, middle empty, or trailing empty
(assert (= has_empty
  (or
    (= (split_at X delim 0) "")
    (= (split_at X delim 1) "")
    (= (split_at X delim 2) "")
    (str.contains X ",,")
    (str.in_re X (re.++ (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ",\u{a}")))
  )
))

; For this instance, enforce that empty-field detection is false (i.e., no empty fields)
(assert (not has_empty))

; Also require exactly 3 fields for a simple CSV row after header
(assert (= (num_splits X delim) 3))



; [GENERATION STATUS: SUCCESS]
(assert (= tail2 ""))
(assert (= f2 "score\u{a}"))
(assert (= f1 "age"))
(assert (= f0 "name"))
(assert (= delim ","))
(assert (= X "name,age,score\u{a}"))
(assert (= has_empty false))
(check-sat)
(exit)

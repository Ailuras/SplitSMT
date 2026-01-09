(set-logic ALL)

; Scenario: CSV Processing
; Goal: enforce correct field counts and detect empty fields using split_at/num_splits/split_rest

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

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const tail_from2 String)
(declare-const has_empty Bool)
(declare-const idx2 Int)

; delimiter is comma for CSV
(assert (= delim ","))

; At least 4 fields => num_splits >= 4 (segments count)
(assert (>= (num_splits csv_line delim) 4))

; Constrain index used with split_rest to be natural and in-range
(assert (= idx2 2))
(assert (>= idx2 0))
(assert (< idx2 (num_splits csv_line delim)))

; Extract the first four fields
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))

; Tail from field2 onwards (field2,field3,...) as a single CSV suffix
(assert (= tail_from2 (split_rest csv_line delim idx2)))

; Core structural constraint: the tail should start with field2 and a comma (since there is at least field3)
(assert (str.prefixof (str.++ field2 delim) tail_from2))

; Detect empty fields among the first four
(assert (= has_empty (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; Require existence of at least one empty field (to "detect empty fields")
(assert has_empty)

; Also enforce that at least one of the first four fields is non-empty (avoid all-empty degenerate case)
(assert (or (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 ""))))

; CSV sanity: no newline characters in the line
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Keep a mutated fragment of the seed regex constraint as a side condition on csv_line
; Ensure csv_line is not in a particular complex regex (arbitrary blacklist)
(assert (not (str.in_re csv_line
  (re.++
    (str.to_re ".\u{a}")
    ((_ re.loop 2 3) (re.range "a" "z"))
    (re.* (re.++ (str.to_re ".")
                 (re.union (re.range "a" "z") (re.range "A" "Z"))
                 (re.* (re.union (re.range "a" "z")
                                 (re.range "A" "Z")
                                 (str.to_re "_")
                                 (str.to_re "$")
                                 (re.range "0" "9")))))
    (re.range "A" "Z")
    (re.* (re.union (re.range "a" "z")
                    (re.range "A" "Z")
                    (str.to_re "_")
                    (str.to_re "$")
                    (re.range "0" "9")))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

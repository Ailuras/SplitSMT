(set-logic ALL)

; Scenario: CSV Processing
; Goal: reason about comma-separated fields, ensure correct field counts, and detect empty fields.

; --- split interface (uninterpreted) ---
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

; --- seed vars preserved ---
(declare-const var_9 String)
(declare-const var_10 String)

; --- additional CSV vars ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const empty_field String)

; delimiter is comma
(assert (= delim ","))

; --- Seed-derived regex constraints (mutated but structurally similar) ---
(assert (str.in_re (str.++ var_9 "z" "b" var_10)
  (re.++
    (re.* (re.union (str.to_re "z") (re.union (str.to_re "a") (str.to_re "c"))))
    (re.union
      (str.to_re "")
      (re.++ (str.to_re "b") (re.* (re.union (str.to_re "b") (re.union (str.to_re "a") (str.to_re "c")))))
    ))))

; Make var_10 compatible with an alphabetic segment (slightly relaxed from seed)
(assert (str.in_re (str.++ "b" var_10) (re.* (re.range "a" "u"))))
(assert (str.in_re var_9 (re.* (re.range "a" "u"))))

; Keep a negated membership constraint to preserve core structure
(assert (not (str.in_re (str.++ var_9 "a" "z" var_10)
  (re.++
    (re.*
      (re.++
        (re.union (str.to_re "z") (re.union (str.to_re "a") (str.to_re "c")))
        (re.++
          (re.* (re.union (str.to_re "b") (re.union (str.to_re "a") (str.to_re "c"))))
          (str.to_re "z"))))
    (re.++
      (re.union (str.to_re "z") (re.union (str.to_re "a") (str.to_re "c")))
      (re.* (re.union (str.to_re "b") (re.union (str.to_re "a") (str.to_re "c")))))))))

; --- CSV construction tying seed vars into a CSV line ---
; csv_line = var_9 , var_10 , ""
(assert (= empty_field ""))
(assert (= csv_line (str.++ var_9 delim var_10 delim empty_field)))

; split interface usage
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest2  (split_rest csv_line delim 2)))

; correct field count: exactly 3 segments
(assert (= (num_splits csv_line delim) 3))

; extracted fields match the construction
(assert (= field0 var_9))
(assert (= field1 var_10))
(assert (= field2 empty_field))

; detect empty fields: ensure the 3rd field is empty, while the 1st two are non-empty
(assert (= (str.len field2) 0))
(assert (> (str.len field0) 0))
(assert (> (str.len field1) 0))

; sanity: no commas inside var_9 and var_10 (typical CSV unquoted fields)
(assert (not (str.contains var_9 delim)))
(assert (not (str.contains var_10 delim)))

; --- Additional constraints for processing consistency ---
; rest2 should equal the final field for a 3-field CSV
(assert (= rest2 field2))

; --- UNSAT pocket (guarded by a contradiction on purpose) ---
; This makes the whole instance UNSAT while preserving CSV structure.
; Empty field cannot also have positive length.
(assert (> (str.len field2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

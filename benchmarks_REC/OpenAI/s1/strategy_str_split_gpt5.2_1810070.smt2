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
; Goal: process comma-separated data fields, ensure field counts and detect empty fields.

; Non-primitive interface operations (string split)

; Primary CSV line
(declare-const s String)

; Additional CSV lines to create both SAT and UNSAT sub-instances
(declare-const csv_ok String)
(declare-const csv_bad String)

; ---------------------------
; Mutated/extended core from seed: numeric-only string constraints on s
; Keep a similar structure but incorporate CSV delimiter checks.
; ---------------------------

; s is a non-empty numeric token of bounded length (kept from seed spirit)
(assert (str.in_re s (re.+ (re.range "0" "9"))))
(assert (not (= (str.len s) 0)))
(assert (<= (str.len s) 12))

; Preserve a "core structure" style constraint about substr/len being 1
(assert (= (str.len (str.substr s 0 (- 1 0))) 1))

; Mutate the last seed constraint: force second character to be "0" but avoid trivial 1-length
(assert (>= (str.len s) 2))
(assert (= (str.at (str.substr s 1 1) 0) "0"))

; New CSV-related constraints about s used as a field: it must not contain comma
(assert (not (str.contains s ",")))

; ---------------------------
; SAT instance: csv_ok has exactly 3 fields, no empty fields
; ---------------------------
(assert (>= (num_splits csv_ok ",") 3))
(assert (<= (num_splits csv_ok ",") 3))

; Each field non-empty
(assert (> (str.len (split_at csv_ok "," 0)) 0))
(assert (> (str.len (split_at csv_ok "," 1)) 0))
(assert (> (str.len (split_at csv_ok "," 2)) 0))

; Constrain first field to be numeric-only and reuse s as that field
(assert (= (split_at csv_ok "," 0) s))
(assert (str.in_re (split_at csv_ok "," 1) (re.+ (re.range "A" "Z"))))
(assert (str.in_re (split_at csv_ok "," 2) (re.+ (re.range "a" "z"))))

; Delimiter sanity: the rest from index 1 should still contain a comma (since 3 fields)
(assert (str.contains (split_rest csv_ok "," 1) ","))

; ---------------------------
; UNSAT instance: csv_bad forced to have an empty middle field AND no empty fields
; ---------------------------
(assert (>= (num_splits csv_bad ",") 3))
(assert (<= (num_splits csv_bad ",") 3))

; Force an empty middle field
(assert (= (split_at csv_bad "," 1) ""))

; But also require all fields non-empty -> contradiction
(assert (> (str.len (split_at csv_bad "," 0)) 0))
(assert (> (str.len (split_at csv_bad "," 1)) 0))
(assert (> (str.len (split_at csv_bad "," 2)) 0))

; Additional structure: if middle field is empty, then ",," should appear (consistent, but doesn't resolve contradiction)
(assert (str.contains csv_bad ",,"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

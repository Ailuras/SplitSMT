(set-logic ALL)

; Uninterpreted interface for str_split
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
; We model two CSV lines: one intended to be well-formed (SAT) and one contradictory (UNSAT).

; ---------- SAT instance: well-formed CSV with 4 fields ----------
(declare-const csv_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= "," ","))
(assert (= f0_ok (split_at csv_ok "," 0)))
(assert (= f1_ok (split_at csv_ok "," 1)))
(assert (= f2_ok (split_at csv_ok "," 2)))
(assert (= f3_ok (split_at csv_ok "," 3)))
(assert (= 4 (num_splits csv_ok ",")))

; Require the CSV string to be exactly the concatenation of fields with commas
(assert (= csv_ok (str.++ f0_ok "," f1_ok "," f2_ok "," f3_ok)))

; Detect empty fields: force one empty middle field and ensure others non-empty
(assert (= f2_ok ""))
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f3_ok) 0))

; Simple content constraints (avoid commas within fields, typical for unquoted CSV)
(assert (not (str.contains f0_ok ",")))
(assert (not (str.contains f1_ok ",")))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; Additional check using split_rest: from index 1 onwards should match tail concatenation
(assert (= (split_rest csv_ok "," 1) (str.++ f1_ok "," f2_ok "," f3_ok)))

; ---------- UNSAT instance: contradictory requirements about empty fields and segment count ----------
(declare-const csv_bad String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= b0 (split_at csv_bad "," 0)))
(assert (= b1 (split_at csv_bad "," 1)))
(assert (= b2 (split_at csv_bad "," 2)))

; Claim exactly 3 fields
(assert (= 3 (num_splits csv_bad ",")))
(assert (= csv_bad (str.++ b0 "," b1 "," b2)))

; Contradiction: enforce b1 is empty, but also enforce all fields are non-empty
(assert (= b1 ""))
(assert (> (str.len b0) 0))
(assert (> (str.len b1) 0))
(assert (> (str.len b2) 0))

; Another contradiction: if there are 3 fields, rest from index 2 should be b2
(assert (= (split_rest csv_bad "," 2) b2))
; but also assert it equals b0 (impossible unless b0=b2 and b1 empty and csv structure aligns, yet b1 non-empty already contradicts)
(assert (= (split_rest csv_bad "," 2) b0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

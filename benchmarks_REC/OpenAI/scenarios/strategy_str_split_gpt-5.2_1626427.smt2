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

; Uninterpreted interface for string split

; =========
; CSV Processing Scenario
; =========

; --- SAT instance: well-formed CSV row with 4 fields, no empty fields ---
(declare-const csv_row_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_row_ok (str.++ ok_f0 "," ok_f1 "," ok_f2 "," ok_f3)))
(assert (= ok_f0 (split_at csv_row_ok "," 0)))
(assert (= ok_f1 (split_at csv_row_ok "," 1)))
(assert (= ok_f2 (split_at csv_row_ok "," 2)))
(assert (= ok_f3 (split_at csv_row_ok "," 3)))
(assert (= (split_rest csv_row_ok "," 2) (str.++ ok_f2 "," ok_f3)))

; valid split index bounds and count
(assert (>= (num_splits csv_row_ok ",") 4))
(assert (<= (num_splits csv_row_ok ",") 4))

; detect empty fields: none should be empty
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; add realistic content constraints
(assert (str.contains csv_row_ok ","))
(assert (>= (str.len csv_row_ok) 7))
(assert (not (str.contains ok_f0 ",")))
(assert (not (str.contains ok_f1 ",")))
(assert (not (str.contains ok_f2 ",")))
(assert (not (str.contains ok_f3 ",")))

; --- UNSAT instance: claims 3 fields but also enforces a trailing comma that induces an empty 4th field ---
(declare-const csv_row_bad String)
(declare-const bad_a String)
(declare-const bad_b String)
(declare-const bad_c String)
(declare-const bad_tail String)

; syntactically looks like three fields plus trailing comma
(assert (= csv_row_bad (str.++ bad_a "," bad_b "," bad_c ",")))

; attempt to enforce exactly 3 segments (inconsistent with trailing comma -> empty segment)
(assert (= (num_splits csv_row_bad ",") 3))

; bind first three fields
(assert (= bad_a (split_at csv_row_bad "," 0)))
(assert (= bad_b (split_at csv_row_bad "," 1)))
(assert (= bad_c (split_at csv_row_bad "," 2)))

; assert there is no extra content after the 3rd field
(assert (= bad_tail (split_rest csv_row_bad "," 3)))
(assert (= bad_tail ""))

; but also require that the segment at index 3 exists and is empty (trailing comma creates empty field)
; combined with num_splits = 3 makes this inconsistent under intended split semantics
(assert (= (split_at csv_row_bad "," 3) ""))

; ensure indices are natural and within some reasonable bounds
(declare-const k_ok Int)
(declare-const k_bad Int)
(assert (and (>= k_ok 0) (< k_ok 4)))
(assert (and (>= k_bad 0) (< k_bad 4)))

; relate k_ok to a concrete access to diversify constraints
(assert (= (split_at csv_row_ok "," k_ok) (split_at csv_row_ok "," k_ok)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

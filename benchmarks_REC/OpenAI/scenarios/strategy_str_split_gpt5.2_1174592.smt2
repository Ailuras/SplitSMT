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

; Uninterpreted interface operations for string split

; ==========================
; SAT instance: CSV processing
; ==========================
(declare-const csv_line String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const total_fields Int)

(assert (= comma ","))

; Example CSV line: 3 fields total, middle field empty
(assert (= csv_line "alpha,,gamma"))

(assert (= total_fields (num_splits csv_line comma)))
(assert (= f0 (split_at csv_line comma 0)))
(assert (= f1 (split_at csv_line comma 1)))
(assert (= f2 (split_at csv_line comma 2)))
(assert (= rest2 (split_rest csv_line comma 2)))

; Field count checks
(assert (>= total_fields 1))
(assert (= total_fields 3))

; Detect empty fields
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 ""))))
(assert has_empty)

; Non-empty constraints on specific fields
(assert (not (= f0 "")))
(assert (not (= f2 "")))

; Lightweight sanity: if there are at least 3 fields, f2 should match suffix remainder
(assert (>= (num_splits csv_line comma) 3))
(assert (= rest2 f2))

; ============================
; UNSAT instance: contradictory
; ============================
(declare-const csv_line_u String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)
(declare-const u_has_empty Bool)
(declare-const u_total_fields Int)

(assert (= csv_line_u "a,,c"))
(assert (= u_total_fields (num_splits csv_line_u comma)))

; Force 4 fields even though the concrete string provides 3 segments
(assert (= u_total_fields 4))

(assert (= u0 (split_at csv_line_u comma 0)))
(assert (= u1 (split_at csv_line_u comma 1)))
(assert (= u2 (split_at csv_line_u comma 2)))
(assert (= u3 (split_at csv_line_u comma 3)))

; Require no empty fields, but the string has an empty middle field
(assert (= u_has_empty (or (= u0 "") (= u1 "") (= u2 "") (= u3 ""))))
(assert (not u_has_empty))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

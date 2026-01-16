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

; -----------------------------
; Scenario: CSV Processing
; Goal: ensure correct field counts and detect empty fields
; Create both SAT and UNSAT instances in one file via a selector.
; -----------------------------

(declare-const mode Int)

(declare-const csv_line String)
(declare-const delim String)

(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const f4 String)

(declare-const rest2 String)
(declare-const rest3 String)

; Basic delimiter setup
(assert (= delim ","))

; Indices are natural
(assert (and (<= 0 mode) (<= mode 1)))

; Split-derived fields and suffixes
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= f4 (split_at csv_line delim 4)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Shared CSV well-formedness constraints
(assert (>= (num_splits csv_line delim) 1))
(assert (>= (num_splits csv_line delim) 3))

; Detect empty fields (use exact emptiness checks)
(declare-const has_empty Bool)
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 "") (= f3 "") (= f4 ""))))

; Mix in additional realistic constraints: disallow commas inside fields, trim-like property (no leading/trailing spaces)
(declare-const sp String)
(assert (= sp " "))

(declare-const no_commas_in_f0 Bool)
(declare-const no_commas_in_f1 Bool)
(declare-const no_commas_in_f2 Bool)
(assert (= no_commas_in_f0 (not (str.contains f0 delim))))
(assert (= no_commas_in_f1 (not (str.contains f1 delim))))
(assert (= no_commas_in_f2 (not (str.contains f2 delim))))
(assert (and no_commas_in_f0 no_commas_in_f1 no_commas_in_f2))

; Light whitespace hygiene on first three fields
(assert (or (= f0 "") (not (= (str.at f0 0) sp))))
(assert (or (= f1 "") (not (= (str.at f1 0) sp))))
(assert (or (= f2 "") (not (= (str.at f2 0) sp))))
(assert (or (= f0 "") (not (= (str.at f0 (- (str.len f0) 1)) sp))))
(assert (or (= f1 "") (not (= (str.at f1 (- (str.len f1) 1)) sp))))
(assert (or (= f2 "") (not (= (str.at f2 (- (str.len f2) 1)) sp))))

; Ensure index bounds when using str.at with (- (str.len s) 1)
(assert (or (= f0 "") (>= (str.len f0) 1)))
(assert (or (= f1 "") (>= (str.len f1) 1)))
(assert (or (= f2 "") (>= (str.len f2) 1)))

; -----------------------------
; SAT branch (mode = 0): exactly 4 fields, allow an empty middle field (e.g., "A,,C,D")
; -----------------------------
(declare-const sat_ok Bool)
(assert (= sat_ok
  (and
    (= (num_splits csv_line delim) 4)
    (= f0 "A")
    (= f1 "")
    (= f2 "C")
    (= f3 "D")
    has_empty
    (= rest2 (str.++ f2 delim f3))
    (= rest3 f3)
  )))

; -----------------------------
; UNSAT branch (mode = 1): claim exactly 3 fields but force an additional split segment
; Additionally require no empty fields, yet force an empty one.
; -----------------------------
(declare-const unsat_bad Bool)
(assert (= unsat_bad
  (and
    (= (num_splits csv_line delim) 3)
    ; Force at least 4 segments simultaneously (contradiction with =3)
    (>= (num_splits csv_line delim) 4)
    ; No empty fields, but force emptiness
    (not has_empty)
    (= f1 "")
  )))

; Mode selects which instance is active
(assert (ite (= mode 0) sat_ok unsat_bad))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

(set-logic ALL)

; Uninterpreted interface operations for str_split
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

; -----------------------------
; SAT instance: CSV with exactly 4 fields, detect empty fields, and enforce content constraints
; -----------------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const has_empty Bool)

(assert (= delim ","))

; Require exactly 4 fields after splitting by comma
(assert (= (num_splits csv_line delim) 4))

; Bind fields via split_at
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))

; Bind suffixes via split_rest
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Basic validity: indices are natural
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

; Concrete satisfiable example: "A,,C,42" (empty f1)
(assert (= csv_line "A,,C,42"))
(assert (= f0 "A"))
(assert (= f1 ""))
(assert (= f2 "C"))
(assert (= f3 "42"))

; Empty-field detection flag
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))
(assert has_empty)

; Additional content constraints (mix simple and complex)
; f0 must be a single uppercase letter
(assert (= (str.len f0) 1))
(assert (str.in_re f0 (str.to_re "A")))

; f2 must be non-empty and must not contain comma
(assert (> (str.len f2) 0))
(assert (not (str.contains f2 ",")))

; f3 must be exactly two digits
(assert (= (str.len f3) 2))
(assert (str.in_re f3 (re.++ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))
                              (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")))))

; Ensure rest variables are consistent with known concrete line (lightweight sanity)
(assert (= rest3 "42"))

(check-sat)

; -----------------------------
; UNSAT instance: Contradictory requirements about empty fields and field count
; -----------------------------
(declare-const csv_line_u String)
(declare-const d_u String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)
(declare-const no_empty Bool)

(assert (= d_u ","))

; Fix line to one that clearly contains an empty field
(assert (= csv_line_u "X,,Y,Z"))

; Require 4 fields
(assert (= (num_splits csv_line_u d_u) 4))
(assert (= u0 (split_at csv_line_u d_u 0)))
(assert (= u1 (split_at csv_line_u d_u 1)))
(assert (= u2 (split_at csv_line_u d_u 2)))
(assert (= u3 (split_at csv_line_u d_u 3)))

; Force specific field bindings (including empty u1)
(assert (= u0 "X"))
(assert (= u1 ""))
(assert (= u2 "Y"))
(assert (= u3 "Z"))

; Contradiction: state there are no empty fields
(assert (= no_empty (and (not (= u0 "")) (not (= u1 "")) (not (= u2 "")) (not (= u3 "")))))
(assert no_empty)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

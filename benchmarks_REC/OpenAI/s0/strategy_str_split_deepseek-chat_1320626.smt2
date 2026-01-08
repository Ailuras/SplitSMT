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

; Uninterpreted functions for string split interface

; =========================
; Scenario: CSV Processing
; =========================

; --------
; SAT part
; --------
(declare-const csv_line String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail1 String)
(declare-const tail2 String)
(declare-const tail3 String)
(declare-const total_fields Int)
(declare-const idx0 Int)
(declare-const idx1 Int)
(declare-const idx2 Int)
(declare-const idx3 Int)

(assert (= comma ","))

; Model a 4-field CSV row: f0,f1,f2,f3
(assert (= total_fields (num_splits csv_line comma)))
(assert (= total_fields 4))

; Indices are natural and within the valid segment range
(assert (= idx0 0))
(assert (= idx1 1))
(assert (= idx2 2))
(assert (= idx3 3))
(assert (and (<= 0 idx0) (< idx0 total_fields)))
(assert (and (<= 0 idx1) (< idx1 total_fields)))
(assert (and (<= 0 idx2) (< idx2 total_fields)))
(assert (and (<= 0 idx3) (< idx3 total_fields)))

; Extract fields via split_at
(assert (= f0 (split_at csv_line comma idx0)))
(assert (= f1 (split_at csv_line comma idx1)))
(assert (= f2 (split_at csv_line comma idx2)))
(assert (= f3 (split_at csv_line comma idx3)))

; Track remaining suffixes for additional structure
(assert (= tail1 (split_rest csv_line comma 1)))
(assert (= tail2 (split_rest csv_line comma 2)))
(assert (= tail3 (split_rest csv_line comma 3)))

; Basic consistency expectations (relaxation-friendly): tails should be substrings of the line
(assert (str.contains csv_line tail1))
(assert (str.contains csv_line tail2))
(assert (str.contains csv_line tail3))

; Detect empty fields: at least one field is empty, and at least one is non-empty
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))
(assert (or (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

; Simple CSV hygiene: no field contains an unescaped comma (approximated by forbidding comma in fields)
(assert (not (str.contains f0 comma)))
(assert (not (str.contains f1 comma)))
(assert (not (str.contains f2 comma)))
(assert (not (str.contains f3 comma)))

; Add concrete content constraints to keep it obviously satisfiable
(assert (= f0 "id"))
(assert (= f2 "42"))
; allow f1 to be empty to represent missing name
(assert (= f1 ""))
; allow f3 to be non-empty
(assert (= f3 "ok"))

; Optional format constraints on numeric field f2: only digits via regex
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))

; Ensure line has commas somewhere
(assert (str.contains csv_line comma))
; Keep line non-empty
(assert (> (str.len csv_line) 0))

; ----------
; UNSAT part
; ----------
; A second line with contradictory requirements: exactly 3 fields but also claims 4th field is non-empty.
(declare-const csv_line_bad String)
(declare-const bad_fields Int)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)
(declare-const b3 String)

(assert (= bad_fields (num_splits csv_line_bad comma)))
(assert (= bad_fields 3))

; Extracting b3 at index 3 is forced to be in-range by the following, contradicting bad_fields=3.
(assert (= b0 (split_at csv_line_bad comma 0)))
(assert (= b1 (split_at csv_line_bad comma 1)))
(assert (= b2 (split_at csv_line_bad comma 2)))
(assert (= b3 (split_at csv_line_bad comma 3)))

; Interface index bounds (enforced for this bad instance)
(assert (and (<= 0 3) (< 3 bad_fields)))

; Additional constraints to make the contradiction independent of string content
(assert (not (= b3 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

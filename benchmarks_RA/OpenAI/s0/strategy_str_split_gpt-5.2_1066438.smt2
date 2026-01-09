(set-logic ALL)

; Uninterpreted split interface
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

; =========================
; SAT instance: CSV row processing
; =========================
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail_from_2 String)
(declare-const header String)

(assert (= delim ","))

; Require exactly 4 fields (segments) after splitting on comma
(assert (= (num_splits csv_line delim) 4))

; Extract fields
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))

; Basic schema constraints
; Field0: non-empty identifier with no commas
(assert (> (str.len f0) 0))
(assert (not (str.contains f0 delim)))

; Field1: may be empty (detect empty field), still cannot contain commas
(assert (not (str.contains f1 delim)))

; Field2: integer-like: optional leading '-', then digits only
(assert (str.in_re f2 (re.++ (re.opt (str.to_re "-")) (re.+ (re.range "0" "9")))))

; Field3: must be non-empty and contain no commas
(assert (> (str.len f3) 0))
(assert (not (str.contains f3 delim)))

; Ensure csv_line reconstructs from pieces with commas (one possible well-formedness axiom)
(assert (= csv_line (str.++ f0 delim f1 delim f2 delim f3)))

; Also use split_rest: tail from index 2 should be f2,f3
(assert (= tail_from_2 (split_rest csv_line delim 2)))
(assert (= tail_from_2 (str.++ f2 delim f3)))

; Detect empty field1: enforce it empty in this SAT instance
(assert (= f1 ""))

; Add a prefix-like requirement: a header tag must appear in field0
(assert (= header "ID"))
(assert (str.contains f0 header))

; =========================
; UNSAT instance: contradictory CSV requirements
; =========================
(declare-const bad_csv String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)

(assert (= (num_splits bad_csv delim) 3))
(assert (= g0 (split_at bad_csv delim 0)))
(assert (= g1 (split_at bad_csv delim 1)))
(assert (= g2 (split_at bad_csv delim 2)))

; Force an explicit reconstruction with exactly two commas
(assert (= bad_csv (str.++ g0 delim g1 delim g2)))

; Contradiction: require g1 both empty and non-empty
(assert (= g1 ""))
(assert (> (str.len g1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

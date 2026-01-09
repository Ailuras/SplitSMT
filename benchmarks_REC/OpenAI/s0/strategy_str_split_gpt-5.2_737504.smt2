(set-logic ALL)

; Uninterpreted interface for string split operations
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

; ========== CSV Processing: SAT instance ========== 
; We model a CSV line with 4 fields (3 commas), and enforce some field constraints,
; including detection of an empty field.
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const commaCount Int)

(assert (= delim ","))

; Field extraction via split interface
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))

; Rest-of-line extractions (useful for constraints that talk about suffix segments)
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; CSV must have exactly 4 fields
(assert (= (num_splits csv_line delim) 4))

; Equivalent concrete construction of the CSV string (connect split theory to concrete CSV)
(assert (= csv_line (str.++ f0 delim f1 delim f2 delim f3)))

; Detect empty field: f2 is empty
(assert (= f2 ""))

; Some additional realistic constraints
(assert (>= (str.len f0) 1))
(assert (>= (str.len f1) 1))
(assert (>= (str.len f3) 1))

; No field contains the delimiter itself
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; Example: first field is alphabetic-ish: only letters and underscore (simple regex)
(declare-const re_alpha_uscore RegLan)
(assert (= re_alpha_uscore (re.+ (re.union (str.to_re "_") (re.range "a" "z") (re.range "A" "Z")))) )
(assert (str.in_re f0 re_alpha_uscore))

; Example: last field is an integer token: optional leading '-' then digits
(declare-const re_int RegLan)
(assert (= re_int (re.++ (re.opt (str.to_re "-")) (re.+ (re.range "0" "9")))) )
(assert (str.in_re f3 re_int))

; Ensure the rest strings correspond to concatenations in the concrete model
(assert (= rest1 (str.++ f1 delim f2 delim f3)))
(assert (= rest2 (str.++ f2 delim f3)))
(assert (= rest3 f3))

; A derived metric: number of commas is fields-1 for non-empty CSV in this model
(assert (= commaCount (- (num_splits csv_line delim) 1)))
(assert (= commaCount 3))

; Make the SAT instance non-trivial by pinning specific values
(assert (= f0 "Name"))
(assert (= f1 "Alice"))
(assert (= f3 "42"))

(check-sat)

; ========== CSV Processing: UNSAT instance ========== 
; Second scenario: claim a CSV line has 3 fields, but also force it to be built with 4 fields.
(declare-const csv_line_bad String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)
(declare-const g3 String)

(assert (= g0 (split_at csv_line_bad delim 0)))
(assert (= g1 (split_at csv_line_bad delim 1)))
(assert (= g2 (split_at csv_line_bad delim 2)))
(assert (= g3 (split_at csv_line_bad delim 3)))

; Contradictory field count constraints
(assert (= (num_splits csv_line_bad delim) 3))
(assert (= csv_line_bad (str.++ g0 delim g1 delim g2 delim g3)))
(assert (= (num_splits csv_line_bad delim) 4))

; Also require a non-empty empty-field detection inconsistency
(assert (= g1 ""))
(assert (> (str.len g1) 0))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)

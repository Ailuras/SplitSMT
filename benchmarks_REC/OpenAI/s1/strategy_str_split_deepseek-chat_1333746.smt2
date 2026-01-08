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
; Core idea: Process comma-separated fields, ensure correct field counts and detect empty fields.

; --- str_split interface (uninterpreted) ---

; --- Variables ---
(declare-const X String)              ; entire CSV line including trailing newline
(declare-const csv String)            ; CSV content without newline
(declare-const delimiter String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const idx Int)

; Preserve the seed's core structural constraint: X ends with newline and begins with optional "BG" followed by 9 or 10 digits.
(assert (str.in_re X
  (re.++
    (re.opt (str.to_re "BG"))
    (re.union
      ((_ re.loop 9 9) (re.range "0" "9"))
      ((_ re.loop 10 10) (re.range "0" "9")))
    (str.to_re "\u{a}"))))

; Keep the seed's negative constraint (not containing a specific filename pattern).
(assert (not (str.in_re X
  (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".xpm/i\u{a}")))))

; CSV-specific: separate newline; csv is X without final \n.
(assert (> (str.len X) 0))
(assert (= (str.at X (- (str.len X) 1)) "\u{a}"))
(assert (= csv (str.substr X 0 (- (str.len X) 1))))

; CSV delimiter setup
(assert (= delimiter ","))

; Basic well-formedness: CSV contains commas, no embedded newlines.
(assert (str.contains csv delimiter))
(assert (not (str.contains csv "\u{a}")))

; Use str_split to talk about fields.
(assert (>= (num_splits csv delimiter) 2))
(assert (= f0 (split_at csv delimiter 0)))
(assert (= f1 (split_at csv delimiter 1)))
(assert (= rest2 (split_rest csv delimiter 2)))

; Field constraints: allow detecting empty field; at least one of first two fields must be empty.
(assert (or (= f0 "") (= f1 "")))

; But also require that the line is not trivially all empty segments.
(assert (or (> (str.len f0) 0) (> (str.len f1) 0) (> (str.len rest2) 0)))

; Require a fixed number of fields: exactly 4 fields (3 commas) is typical in CSV.
(assert (= (num_splits csv delimiter) 4))
(assert (= f2 (split_at csv delimiter 2)))
(assert (= f3 (split_at csv delimiter 3)))

; Field content restrictions using regex: f2 must be digits only (possibly empty), f3 must be non-empty alphabetic token.
(assert (str.in_re f2 (re.* (re.range "0" "9"))))
(assert (str.in_re f3 (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))

; Index constraint: show natural index usage for split_at; keep within bounds.
(assert (= idx 1))
(assert (and (<= 0 idx) (< idx (num_splits csv delimiter))))
(assert (= (split_at csv delimiter idx) f1))

; UNSAT sub-instance embedded as an additional requirement: cannot have exactly 4 fields and simultaneously fewer than 3.
; This makes the overall instance UNSAT while still representing the CSV processing scenario.
(assert (< (num_splits csv delimiter) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

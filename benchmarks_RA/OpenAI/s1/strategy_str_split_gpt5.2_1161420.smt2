(set-logic ALL)
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

; Scenario: CSV Processing
; Goal: Constrain a CSV line with comma-separated numeric fields,
; ensure correct field counts, and detect empty fields.

; --- str_split interface (uninterpreted, per methodology) ---

; --- Variables ---
(declare-const s String)            ; CSV line
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const delim String)

; --- Delimiter ---
(assert (= delim ","))

; --- Core split structure ---
(assert (= f0 (split_at s delim 0)))
(assert (= f1 (split_at s delim 1)))
(assert (= f2 (split_at s delim 2)))
(assert (= f3 (split_at s delim 3)))
(assert (= rest2 (split_rest s delim 2)))

; --- Field count: require exactly 4 fields (3 commas) ---
(assert (= (num_splits s delim) 4))

; --- Non-empty line and length bounds (CSV line small) ---
(assert (not (= (str.len s) 0)))
(assert (<= (str.len s) 32))

; --- Ensure there are commas and avoid trailing/leading comma (no empty edge field) ---
(assert (not (str.prefixof delim s)))
(assert (not (str.suffixof delim s)))

; --- Field format constraints: numeric fields only ---
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))
(assert (str.in_re f1 (re.+ (re.range "0" "9"))))
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))
(assert (str.in_re f3 (re.+ (re.range "0" "9"))))

; --- Detect empty fields (make at least one field empty) ---
; This contradicts the numeric regex requirements above, creating an UNSAT instance.
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; --- Extra consistency constraints resembling seed-style checks ---
(assert (not (= (str.len f0) 1)))
(assert (not (= (str.at f0 0) "0")))

; Numeric range checks on two fields (if conversion fails, str.to_int returns (- 1))
(assert (and (>= (str.to_int f1) 0) (<= (str.to_int f1) 255)))
(assert (and (>= (str.to_int f2) 0) (<= (str.to_int f2) 255)))

; Ensure rest from index 2 contains at least one comma separating f2 and f3
(assert (str.contains rest2 delim))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

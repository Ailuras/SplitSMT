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
; Goal: process comma-separated data fields, ensure correct field counts, and detect empty fields.

; --- str_split interface (uninterpreted) ---

; --- Variables ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const empty_field Bool)

; Delimiter is comma
(assert (= delim ","))

; Core structure: retain multiple regex membership constraints on the main string (mutated for CSV)
; csv_line ends with newline
(assert (str.in_re csv_line (re.++ (re.* re.allchar) (str.to_re "\u{a}"))))

; csv_line contains a CSV-looking prefix: "id," then arbitrary then ",host" then arbitrary then "Host:" and newline
(assert (str.in_re csv_line
  (re.++
    (str.to_re "id,")
    (re.* re.allchar)
    (str.to_re ",host")
    (re.* re.allchar)
    (str.to_re "Host:")
    (re.* re.allchar)
    (str.to_re "\u{a}"))))

; Also require that the line begins with digits (id field start)
(assert (str.in_re csv_line (re.++ (re.+ (re.range "0" "9")) (re.* re.allchar) (str.to_re "\u{a}"))))

; --- Split-based CSV constraints ---
; Extract first fields
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Indices and count constraints
(assert (>= (num_splits csv_line delim) 3))
(assert (<= (num_splits csv_line delim) 6))

; Field 0 is a non-empty integer id
(assert (> (str.len f0) 0))
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))

; Field 1 should be a short tag, no commas/newlines, non-empty
(assert (> (str.len f1) 0))
(assert (not (str.contains f1 ",")))
(assert (not (str.contains f1 "\u{a}")))
(assert (<= (str.len f1) 12))

; Field 2 is "host" literal (after split)
(assert (= f2 "host"))

; rest2 should still contain "Host:" somewhere after the 2nd comma
(assert (str.contains rest2 "Host:"))

; Detect empty field: either f1 empty or some later segment empty
(assert (= empty_field (or (= f1 "") (= (split_at csv_line delim 3) ""))))

; Force detection of an empty field to be possible in this instance
(assert empty_field)

; Ensure there is at least a 4th segment if we refer to index 3
(assert (>= (num_splits csv_line delim) 4))

; Additional constraint: after the id, the first comma appears (consistent with CSV)
(assert (str.contains csv_line ","))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

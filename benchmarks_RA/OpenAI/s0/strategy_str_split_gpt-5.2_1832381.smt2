(set-logic ALL)

; Uninterpreted interface for string split operations
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

; =====================
; Scenario: CSV Processing
; =====================

; --------- SAT instance: well-formed CSV with 4 fields, no empty fields, numeric constraints
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_ok (str.++ ok_f0 "," ok_f1 "," ok_f2 "," ok_f3)))
(assert (= 4 (num_splits csv_ok ",")))

(assert (= ok_f0 (split_at csv_ok "," 0)))
(assert (= ok_f1 (split_at csv_ok "," 1)))
(assert (= ok_f2 (split_at csv_ok "," 2)))
(assert (= ok_f3 (split_at csv_ok "," 3)))

; No empty fields (detect empty field as "")
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Basic sanitation: no field contains commas
(assert (not (str.contains ok_f0 ",")))
(assert (not (str.contains ok_f1 ",")))
(assert (not (str.contains ok_f2 ",")))
(assert (not (str.contains ok_f3 ",")))

; Numeric field constraints: ok_f1 is exactly 3 digits, ok_f2 is a signed integer token, ok_f3 is 2 uppercase letters
(declare-const digit_re RegLan)
(declare-const digits3_re RegLan)
(declare-const sign_re RegLan)
(declare-const int_re RegLan)
(declare-const upper_re RegLan)
(declare-const upper2_re RegLan)

(assert (= digit_re (re.range "0" "9")))
(assert (= digits3_re (re.++ digit_re (re.++ digit_re digit_re))))
(assert (= sign_re (re.union (str.to_re "-") (str.to_re "+"))))
(assert (= int_re (re.++ (re.opt sign_re) (re.+ digit_re))))
(assert (= upper_re (re.range "A" "Z")))
(assert (= upper2_re (re.++ upper_re upper_re)))

(assert (str.in_re ok_f1 digits3_re))
(assert (str.in_re ok_f2 int_re))
(assert (str.in_re ok_f3 upper2_re))

; Additional split_rest sanity: rest from index 2 equals f2,f3
(assert (= (split_rest csv_ok "," 2) (str.++ ok_f2 "," ok_f3)))

; --------- UNSAT instance: constraints intentionally conflicting to model empty-field detection and incorrect counts
(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

; Shape suggests 3 segments (2 commas)
(assert (= csv_bad (str.++ bad_f0 "," bad_f1 "," bad_f2)))
(assert (= 3 (num_splits csv_bad ",")))

; Define split components
(assert (= bad_f0 (split_at csv_bad "," 0)))
(assert (= bad_f1 (split_at csv_bad "," 1)))
(assert (= bad_f2 (split_at csv_bad "," 2)))

; Require empty middle field (detect empty)
(assert (= bad_f1 ""))

; Contradiction: simultaneously require no empty fields
(assert (> (str.len bad_f1) 0))

; Further conflicting count requirement: claim 4 fields
(assert (= 4 (num_splits csv_bad ",")))

; Index bounds (natural indices)
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted string-split interface for CSV-like processing
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

; === Shared delimiter ===
(declare-const comma String)
(assert (= comma ","))

; ----------------------------------------------------------------------
; SAT instance: well-formed CSV record with exactly 4 fields, no empties
; ----------------------------------------------------------------------
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= (num_splits csv_ok comma) 4))
(assert (= ok_f0 (split_at csv_ok comma 0)))
(assert (= ok_f1 (split_at csv_ok comma 1)))
(assert (= ok_f2 (split_at csv_ok comma 2)))
(assert (= ok_f3 (split_at csv_ok comma 3)))

; No empty fields
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Basic content constraints (avoid commas inside fields; allow simple patterns)
(assert (not (str.contains ok_f0 comma)))
(assert (not (str.contains ok_f1 comma)))
(assert (not (str.contains ok_f2 comma)))
(assert (not (str.contains ok_f3 comma)))

; Enforce a plausible shape: first field starts with a letter, last field is numeric-like
(assert (>= (str.len ok_f0) 1))
(assert (str.in_re (str.at ok_f0 0) (re.union (re.range "A" "Z") (re.range "a" "z"))))
(assert (str.in_re ok_f3 (re.++ (re.+ (re.range "0" "9")) (re.* (str.to_re "")))))

; Rest-of-record reconstruction usage
(declare-const ok_rest1 String)
(declare-const ok_rest2 String)
(assert (= ok_rest1 (split_rest csv_ok comma 1)))
(assert (= ok_rest2 (split_rest csv_ok comma 2)))
(assert (> (str.len ok_rest1) (str.len ok_rest2)))

; Witness example to keep SAT concrete
(assert (= csv_ok "alice,blue,NY,12345"))

; ----------------------------------------------------------------------
; UNSAT instance: claims 3 fields but also demands an empty field while forbidding empties
; ----------------------------------------------------------------------
(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

(assert (= (num_splits csv_bad comma) 3))
(assert (= bad_f0 (split_at csv_bad comma 0)))
(assert (= bad_f1 (split_at csv_bad comma 1)))
(assert (= bad_f2 (split_at csv_bad comma 2)))

; Require detection of an empty middle field
(assert (= bad_f1 ""))

; But simultaneously assert policy that no field may be empty (contradiction)
(assert (> (str.len bad_f0) 0))
(assert (> (str.len bad_f1) 0))
(assert (> (str.len bad_f2) 0))

; Also constrain that the record contains two commas (consistent with 3 fields, but irrelevant due to contradiction)
(assert (str.contains csv_bad comma))
(assert (str.contains (split_rest csv_bad comma 1) comma))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

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

; Uninterpreted interface functions for string split

; ---------- SAT instance: a well-formed CSV line with some constraints ----------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const comma_count Int)

(assert (= delim ","))

; Field extraction via split
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Expect exactly 4 fields
(assert (= (num_splits csv_line delim) 4))

; Basic CSV well-formedness in this simplified setting:
; length non-empty line and delimiter actually appears
(assert (> (str.len csv_line) 0))
(assert (str.contains csv_line delim))

; No empty fields in positions 0 and 2; allow field1 to be empty (tests empty-field detection)
(assert (> (str.len f0) 0))
(assert (= (str.len f1) 0))
(assert (> (str.len f2) 0))

; Constrain content patterns for fields: f0 alphabetic, f2 numeric-ish, f3 fixed tag
(assert (str.in_re f0 (re.+ (re.range "A" "Z"))))
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))
(assert (= f3 "END"))

; Tie rest2 to a concrete shape "<f2>,<f3>" using concatenation
(assert (= rest2 (str.++ f2 delim f3)))

; Extra consistency: commas count derived from field count
(assert (= comma_count (- (num_splits csv_line delim) 1)))
(assert (= comma_count 3))

; A concrete satisfying witness (still consistent with split interface)
(assert (= csv_line (str.++ "ABC" delim "" delim "123" delim "END")))

; ---------- UNSAT instance: contradictory requirements about emptiness and split results ----------
(declare-const bad_csv String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)
(declare-const g3 String)

(assert (= g0 (split_at bad_csv "," 0)))
(assert (= g1 (split_at bad_csv "," 1)))
(assert (= g2 (split_at bad_csv "," 2)))
(assert (= g3 (split_at bad_csv "," 3)))

; Exactly 4 fields
(assert (= (num_splits bad_csv ",") 4))

; Force a concrete bad_csv where second field is empty
(assert (= bad_csv (str.++ "X" "," "" "," "Y" "," "Z")))

; Contradiction: require g1 to be both empty and non-empty
(assert (= g1 ""))
(assert (> (str.len g1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

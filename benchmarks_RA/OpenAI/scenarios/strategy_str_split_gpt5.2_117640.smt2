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

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection
; Uses uninterpreted str_split interface functions split_at / split_rest / num_splits.


; ----------------------------
; SAT instance: well-formed CSV with 4 fields, third field empty
; ----------------------------
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= csv_sat (str.++ "Alice" "," "42" "," "" "," "NY")))

(assert (= (num_splits csv_sat ",") 4))
(assert (= f0_sat (split_at csv_sat "," 0)))
(assert (= f1_sat (split_at csv_sat "," 1)))
(assert (= f2_sat (split_at csv_sat "," 2)))
(assert (= f3_sat (split_at csv_sat "," 3)))

(assert (= rest1_sat (split_rest csv_sat "," 1)))
(assert (= rest2_sat (split_rest csv_sat "," 2)))
(assert (= rest3_sat (split_rest csv_sat "," 3)))

; Field content checks
(assert (= f0_sat "Alice"))
(assert (= f1_sat "42"))
(assert (= f2_sat ""))
(assert (= f3_sat "NY"))

; Detect empty field: at least one segment has length 0
(assert (or (= (str.len f0_sat) 0)
            (= (str.len f1_sat) 0)
            (= (str.len f2_sat) 0)
            (= (str.len f3_sat) 0)))

; Basic structural expectations about comma presence
(assert (str.contains csv_sat ","))
(assert (>= (str.len csv_sat) 0))

; Index constraints (natural indices)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

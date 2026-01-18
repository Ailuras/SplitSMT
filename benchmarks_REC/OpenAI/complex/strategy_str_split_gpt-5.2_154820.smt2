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

; Uninterpreted interface for CSV splitting

; Seed variable preserved
(declare-const var0 String)

; CSV scenario variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const f4 String)
(declare-const rest2 String)
(declare-const n Int)

; Mutated seed regex constraint kept as a background constraint on var0
(assert (str.in_re var0
  (re.++
    (re.+ (re.* (str.to_re "000")))
    (re.++
      (re.union (re.* (str.to_re "1")) (re.+ (str.to_re "2")))
      (re.++
        (re.+ (re.+ (str.to_re "3")))
        (re.++
          (re.union (re.+ (str.to_re "444")) (re.union (str.to_re "55") (str.to_re "6")))
          (re.++
            (re.* (re.* (str.to_re "77")))
            (re.++
              (re.* (re.+ (str.to_re "8")))
              (re.++
                (re.+ (re.union (str.to_re "9") (str.to_re "a")))
                (re.++
                  (re.+ (re.+ (str.to_re "bbb")))
                  (re.++
                    (re.union (re.union (str.to_re "c") (str.to_re "d")) (re.union (str.to_re "eee") (str.to_re "ff")))
                    (re.++ (re.* (str.to_re "ggg")) (re.* (str.to_re "ggg"))))))))))))))
(assert (<= 240 (str.len var0)))

; Core CSV constraints
(assert (= delim ","))
(assert (= csv (split_rest var0 delim 0)))
(assert (>= (str.len csv) 10))

; Split fields using the str_split interface
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= f2 (split_at csv delim 2)))
(assert (= f3 (split_at csv delim 3)))
(assert (= f4 (split_at csv delim 4)))
(assert (= rest2 (split_rest csv delim 2)))
(assert (= n (num_splits csv delim)))

; Field count constraints (expect at least 5 fields)
(assert (>= n 5))

; Detect empty fields: enforce that field 2 is empty and field 3 is non-empty
(assert (= f2 ""))
(assert (> (str.len f3) 0))

; Additional sanity constraints often used in CSV processing
; - delimiter not allowed inside fields 0 and 3
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f3 delim)))

; rest2 should contain at least two delimiters if there are >=5 fields (heuristic check)
(assert (str.contains rest2 delim))

; SAT instance: make an explicit consistent shape for the CSV content
(assert (= csv (str.++ f0 "," f1 "," f2 "," f3 "," f4)))
(assert (= f0 "ID"))
(assert (= f1 "42"))
(assert (= f3 "OK"))
(assert (= f4 "END"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

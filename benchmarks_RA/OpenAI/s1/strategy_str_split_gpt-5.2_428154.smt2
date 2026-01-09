(set-logic ALL)

; CSV Processing: comma-separated fields, field count, and empty field detection

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

; Primary CSV line
(declare-const x String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)

; Secondary CSV line to create an UNSAT sub-instance
(declare-const y String)
(declare-const y0 String)
(declare-const y1 String)
(declare-const y2 String)

(assert (= delim ","))

; Core structure preserved: nested let with regex membership relations (mutated to CSV-oriented patterns)
(assert
  (let ((_let_0 (re.* re.allchar)))
    (let ((_let_1 (str.to_re delim)))
      (let ((_let_2 (re.++ _let_0 _let_1 _let_0 _let_1 _let_0)))
        (let ((_let_3 (str.in_re x _let_2)))
          (and
            ; must contain at least two commas (>= 3 fields)
            _let_3
            ; ensure it is not the case that x matches a pattern with exactly one comma
            (not (= (str.in_re x (re.++ _let_0 _let_1 _let_0)) _let_3))
            ; ensure it is not trivially empty (some non-comma character exists somewhere)
            (str.in_re x (re.++ _let_0 (re.union (str.to_re "A") (str.to_re "B")) _let_0))
          ))))))

; Split-based CSV constraints: three fields expected
(assert (>= (num_splits x delim) 3))
(assert (= f0 (split_at x delim 0)))
(assert (= f1 (split_at x delim 1)))
(assert (= f2 (split_at x delim 2)))
(assert (= rest1 (split_rest x delim 1)))
(assert (= rest2 (split_rest x delim 2)))

; Field bounds and empty-field detection
(assert (and (>= (str.len f0) 0) (>= (str.len f1) 0) (>= (str.len f2) 0)))
(assert (or (= f0 "") (= f1 "") (= f2 "")))

; Light sanity: first field is not containing a comma (best-effort constraint)
(assert (not (str.contains f0 delim)))

; A separate UNSAT instance: y is declared to have 3 splits but also constrained to have no commas
(assert (= (num_splits y delim) 3))
(assert (not (str.contains y delim)))
(assert (= y0 (split_at y delim 0)))
(assert (= y1 (split_at y delim 1)))
(assert (= y2 (split_at y delim 2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

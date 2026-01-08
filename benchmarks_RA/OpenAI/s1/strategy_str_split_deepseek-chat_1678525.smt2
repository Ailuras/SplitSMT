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

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; str_split interface

; Log entry and extracted fields
(declare-const X String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Preserve mutated core seed constraints (kept but integrated into this scenario)
(assert (not (str.in_re X (str.to_re "/=\u{a}/P\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/")
                              (re.union (str.to_re "\u{17}\u{0}") (str.to_re "\u{0}\u{5c}"))
                              (str.to_re "\u{0}e\u{0}l\u{0}s\u{0}e\u{0}x\u{0}t\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")))))

; Expect at least: "<timestamp> <level>:<component>:<message...>"
(assert (>= (num_splits X " ") 3))
(assert (= ts (split_at X " " 0)))
(assert (= level (split_at X " " 1)))
(assert (= component (split_at (split_rest X " " 2) ":" 0)))
(assert (= message (split_rest (split_rest X " " 2) ":" 1)))

; Level extraction checks
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))
(assert (>= (str.len component) 1))
(assert (>= (str.len message) 1))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS
(assert (= date_part (split_at ts "T" 0)))
(assert (= time_part (split_at ts "T" 1)))
(assert (= (num_splits ts "T") 2))

; Date: 3 parts by '-'
(assert (= (num_splits date_part "-") 3))
(assert (= (str.len (split_at date_part "-" 0)) 4))
(assert (= (str.len (split_at date_part "-" 1)) 2))
(assert (= (str.len (split_at date_part "-" 2)) 2))

; Time: 3 parts by ':'
(assert (= (num_splits time_part ":") 3))
(assert (= hh (split_at time_part ":" 0)))
(assert (= mm (split_at time_part ":" 1)))
(assert (= ss (split_at time_part ":" 2)))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Regex digit constraints for timestamp fields
(assert (str.in_re (split_at date_part "-" 0) (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re (split_at date_part "-" 1) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (split_at date_part "-" 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Component should be alphanumeric/underscore only (simple policy)
(assert (str.in_re component (re.+ (re.union (re.range "a" "z")
                                            (re.union (re.range "A" "Z")
                                                      (re.union (re.range "0" "9") (str.to_re "_")))))))

; SAT instance: pick a concrete-looking pattern for message prefix, but keep X symbolic overall
(assert (str.contains message "started"))

(check-sat)

; UNSAT instance block (separate check) by contradicting log-level constraints
(assert (= level "INFO"))
(assert (= level "ERROR"))
(check-sat)
(exit)

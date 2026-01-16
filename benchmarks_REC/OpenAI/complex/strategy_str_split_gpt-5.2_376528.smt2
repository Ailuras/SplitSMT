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

; Uninterpreted split interface (space/colon separated parsing)

; Seed-style booleans preserved/extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; Log entry input and extracted fields
(declare-const var_0xINPUT_364697 String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date String)
(declare-const time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Core non-empty input constraint preserved
(assert (= T_1 (= var_0xINPUT_364697 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; Basic structure: "<timestamp> <level>: <message>"
(assert (>= (num_splits var_0xINPUT_364697 " ") 3))
(assert (= ts (split_at var_0xINPUT_364697 " " 0)))
(assert (= level (split_at var_0xINPUT_364697 " " 1)))
(assert (= message (split_rest var_0xINPUT_364697 " " 2)))

; Level must end with ':' and be one of a small set
(assert (str.in_re level (re.union (str.to_re "INFO:") (re.union (str.to_re "WARN:") (str.to_re "ERROR:")))))

; Timestamp validation: "YYYY-MM-DD:HH:MM:SS"
(assert (>= (num_splits ts ":") 4))
(assert (= date (split_at ts ":" 0)))
(assert (= time (split_rest ts ":" 1)))
(assert (= hh (split_at ts ":" 1)))
(assert (= mm (split_at ts ":" 2)))
(assert (= ss (split_at ts ":" 3)))

; Enforce fixed widths
(assert (= (str.len date) 10))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Date pattern YYYY-MM-DD with digits and dashes
(assert (str.in_re date (re.++ (re.++ (re.++ (re.++ (re.* (re.range "0" "9")) (str.to_re "-")) (re.* (re.range "0" "9"))) (str.to_re "-")) (re.* (re.range "0" "9")))))

; Stronger digit-only checks for HH/MM/SS
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Message must be non-empty and contain a keyword indicating an action
(assert (not (= message "")))
(assert (or (str.contains message "user") (str.contains message "request") (str.contains message "failed")))

; Add a deliberately contradictory condition to make this instance UNSAT
; If level is ERROR:, require message to contain "failed"; then contradict with negation.
(assert (= T_3 (and (= level "ERROR:") (str.contains message "failed"))))
(assert (=> (= level "ERROR:") T_3))
(assert (=> (= level "ERROR:") (not (str.contains message "failed"))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

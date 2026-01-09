(set-logic ALL)

; Uninterpreted split interface (per scenario)
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

; Log analysis variables
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date String)
(declare-const time String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Auxiliary strings (mutated from seed: keep simple regex over + and *)
(declare-const x String)
(declare-const y String)

; Seed-like constraints retained but adjusted to connect with log parsing
(assert (str.in_re x (re.* (str.to_re "+*"))))
(assert (str.in_re y (re.* (str.to_re "+*"))))
(assert (= (str.len x) 2))
(assert (= (str.len y) 4))

; Core structure: parsing log entries separated by spaces and colons
; Expected shape: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= message (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Timestamp validation: split into date and time by space inside ts
(assert (= date (split_at ts " " 0)))
(assert (= time (split_at ts " " 1)))
(assert (= (num_splits ts " ") 2))

; Basic timestamp length checks: "YYYY-MM-DD" is 10, "HH:MM:SS" is 8
(assert (= (str.len date) 10))
(assert (= (str.len time) 8))

; Time parts extraction by ':'
(assert (= hour (split_at time ":" 0)))
(assert (= minute (split_at time ":" 1)))
(assert (= second (split_at time ":" 2)))
(assert (= (num_splits time ":") 3))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level extraction: level must end with ':' and be one of common levels
; We encode by requiring a 2-way split on ':' with empty rest (i.e., exactly one colon at end)
(declare-const level_tag String)
(declare-const level_after_colon String)
(assert (= level_tag (split_at level ":" 0)))
(assert (= level_after_colon (split_at level ":" 1)))
(assert (= (num_splits level ":") 2))
(assert (= level_after_colon ""))
(assert (or (= level_tag "INFO") (= level_tag "WARN") (= level_tag "ERROR") (= level_tag "DEBUG")))

; Message must be non-empty
(assert (> (str.len message) 0))

; Use x and y to constrain message slightly (still within +/* alphabet via concatenation)
; Enforce message starts with x and contains y somewhere
(assert (str.prefixof x message))
(assert (str.contains message y))

; SAT/UNSAT mix: add a deliberate contradiction about level to create UNSAT
(assert (= level_tag "INFO"))
(assert (= level_tag "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

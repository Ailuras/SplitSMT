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

; Uninterpreted string split interface

; Seed variables (kept) and additional log-analysis variables
(declare-fun x1 () String)
(declare-fun x2 () String)
(declare-fun z () String)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(declare-fun t4 () String)
(declare-fun t5 () String)
(declare-fun t6 () String)
(declare-fun t7 () String)

(declare-const logline String)
(declare-const ts String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const msg String)
(declare-const datepart String)
(declare-const timepart String)

(declare-const y1 String)
(declare-const y2 String)
(declare-const y3 String)

; --- Core seed structure preserved (mutated by adding side constraints, but equality kept) ---
(assert
  (= (str.++ (str.++ (str.++ "ab" z) (str.++ x1 "abdc")) x2)
     (str.++ (str.++ z "ba")
            (str.++ (str.++ (str.++ x2 "dcba") x1)
                   (str.++ (str.++ t6 (str.++ t1 t3))
                          (str.++ (str.++ t7 t5) (str.++ t2 t4)))))))

; Connect seed vars to a plausible log line: "<ts> <LEVEL>: <msg>"
(assert (= ts (str.++ t1 "T" t2)))
(assert (= t3 "-"))
(assert (= t4 ":"))
(assert (= t5 "Z"))
(assert (= logline (str.++ ts " " level_with_colon " " msg)))

; Split by spaces: must have at least 3 segments
(assert (>= (num_splits logline " ") 3))
(assert (= (split_at logline " " 0) ts))
(assert (= (split_at logline " " 1) level_with_colon))
(assert (= (split_rest logline " " 2) msg))

; Extract log level by splitting on ":"
(assert (>= (num_splits level_with_colon ":") 2))
(assert (= (split_at level_with_colon ":" 0) level))

; Timestamp basic shape checks: YYYY-MM-DDThh:mmZ (length 17)
(assert (= (str.len ts) 17))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) "Z"))

; Ensure digits at key positions (approximate numeric validation)
(assert (str.in_re (str.at ts 0) (re.range "0" "9")))
(assert (str.in_re (str.at ts 1) (re.range "0" "9")))
(assert (str.in_re (str.at ts 2) (re.range "0" "9")))
(assert (str.in_re (str.at ts 3) (re.range "0" "9")))
(assert (str.in_re (str.at ts 5) (re.range "0" "9")))
(assert (str.in_re (str.at ts 6) (re.range "0" "9")))
(assert (str.in_re (str.at ts 8) (re.range "0" "9")))
(assert (str.in_re (str.at ts 9) (re.range "0" "9")))
(assert (str.in_re (str.at ts 11) (re.range "0" "9")))
(assert (str.in_re (str.at ts 12) (re.range "0" "9")))
(assert (str.in_re (str.at ts 14) (re.range "0" "9")))
(assert (str.in_re (str.at ts 15) (re.range "0" "9")))

; Restrict level to common options
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message contains a key-value pair separated by ':' and spaces (light structure)
(assert (str.contains msg "="))
(assert (>= (num_splits msg "=") 2))

; Additional structure constraints tied to seed variables to preserve interaction
(assert (= z ""))
(assert (= x1 ""))
(assert (= x2 ""))
(assert (= t6 ""))
(assert (= t7 ""))

; --- Deliberate contradiction to create an UNSAT instance (diversity requirement) ---
; If level is INFO, force it also to be ERROR.
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

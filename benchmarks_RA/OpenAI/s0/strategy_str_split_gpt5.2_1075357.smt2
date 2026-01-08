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

; Uninterpreted interface for string split (as provided)

; --------- SAT instance: plausible structured log entry ---------
(declare-const log_line String)
(declare-const ts String)          ; full timestamp token, e.g., "2026-01-07T12:34:56"
(declare-const level String)       ; e.g., "INFO"
(declare-const module String)      ; e.g., "auth"
(declare-const msg String)         ; rest of the message after module

(declare-const date_part String)   ; "2026-01-07"
(declare-const time_part String)   ; "12:34:56"
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Assume a structure: "<ts> <level> <module>: <msg>"
(assert (= ts (split_at log_line " " 0)))
(assert (= level (split_at log_line " " 1)))
(assert (= module (split_at log_line " " 2)))
(assert (= msg (split_rest log_line " " 3)))

; Require at least 4 space-separated segments (ts, level, module:, msg...)
(assert (>= (num_splits log_line " ") 4))

; Module token must contain a colon and split into exactly 2 parts around ':'
(assert (str.contains module ":"))
(assert (>= (num_splits module ":") 2))
(assert (= (split_at module ":" 1) ""))

; Timestamp token must contain 'T' separating date and time
(assert (str.contains ts "T"))
(assert (>= (num_splits ts "T") 2))
(assert (= date_part (split_at ts "T" 0)))
(assert (= time_part (split_at ts "T" 1)))

; Date part is split by '-' into 3 components
(assert (= year (split_at date_part "-" 0)))
(assert (= month (split_at date_part "-" 1)))
(assert (= day (split_at date_part "-" 2)))
(assert (= (num_splits date_part "-") 3))

; Time part is split by ':' into 3 components
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))
(assert (= (num_splits time_part ":") 3))

; Log level must be one of a small set
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Basic timestamp format validation via regex for each piece
(assert (str.in_re year (re.range "0" "9"))) ; will be strengthened below
(assert (str.in_re month (re.range "0" "9")))
(assert (str.in_re day (re.range "0" "9")))
(assert (str.in_re hour (re.range "0" "9")))
(assert (str.in_re minute (re.range "0" "9")))
(assert (str.in_re second (re.range "0" "9")))

; Strengthen: fixed widths
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Ensure all characters in each component are digits by matching against digit-star and fixed length
(declare-const DIGIT_RE RegLan)
(assert (= DIGIT_RE (re.range "0" "9")))
(assert (str.in_re year (re.++ DIGIT_RE (re.++ DIGIT_RE (re.++ DIGIT_RE DIGIT_RE)))))
(assert (str.in_re month (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re day (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re hour (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re minute (re.++ DIGIT_RE DIGIT_RE)))
(assert (str.in_re second (re.++ DIGIT_RE DIGIT_RE)))

; Concrete anchoring to make the SAT instance definitely satisfiable
(assert (= log_line "2026-01-07T12:34:56 INFO auth: login succeeded"))

; --------- UNSAT instance: contradictory requirements about level extraction ---------
(declare-const bad_line String)
(declare-const bad_level String)
(declare-const bad_ts String)

(assert (= bad_ts (split_at bad_line " " 0)))
(assert (= bad_level (split_at bad_line " " 1)))
(assert (>= (num_splits bad_line " ") 3))

; Require that level is both INFO and ERROR simultaneously (impossible)
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Also put some timestamp structure constraints (irrelevant to inconsistency but realistic)
(assert (str.contains bad_ts "T"))
(assert (= (num_splits bad_ts "T") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

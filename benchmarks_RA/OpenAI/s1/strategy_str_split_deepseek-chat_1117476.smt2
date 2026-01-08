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

; Uninterpreted split interface

; Log entry parsing scenario: "YYYY-MM-DD:HH:MM:SS LEVEL message..."
(declare-const log_entry String)
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const timepart String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Keep core structure from seed with mutated variable
(declare-fun var_4 () String)
(declare-const v Int)

; Base split structure: timestamp, level, rest
(assert (= ts (split_at log_entry " " 0)))
(assert (= level (split_at log_entry " " 1)))
(assert (= msg (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; Timestamp is split by ':' into date and time
(assert (= year (split_at ts "-" 0)))
(assert (= month (split_at ts "-" 1)))
(assert (= day (split_at ts "-" 2)))
(assert (>= (num_splits ts "-") 3))
(assert (= timepart (split_rest ts "-" 3)))
(assert (= hour (split_at timepart ":" 0)))
(assert (= minute (split_at timepart ":" 1)))
(assert (= second (split_at timepart ":" 2)))
(assert (>= (num_splits timepart ":") 3))

; Regex building blocks
(declare-const digitRE RegLan)
(declare-const twoDigitsRE RegLan)
(declare-const fourDigitsRE RegLan)
(assert (= digitRE (re.range "0" "9")))
(assert (= twoDigitsRE (re.++ digitRE digitRE)))
(assert (= fourDigitsRE (re.++ twoDigitsRE twoDigitsRE)))

; Timestamp format validation: YYYY-MM-DD:HH:MM:SS
(assert (str.in_re year fourDigitsRE))
(assert (str.in_re month twoDigitsRE))
(assert (str.in_re day twoDigitsRE))
(assert (str.in_re hour twoDigitsRE))
(assert (str.in_re minute twoDigitsRE))
(assert (str.in_re second twoDigitsRE))
(assert (= (str.len ts) 19))

; Log level extraction/validation
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message must be non-empty and contain a colon somewhere (structured key:value)
(assert (> (str.len msg) 0))
(assert (str.contains msg ":"))

; Mutated seed-style constraints over var_4 and v
(assert (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (re.++ (str.to_re "b") (re.* (str.to_re "b"))))))
(assert (str.in_re var_4 (re.++ (str.to_re "a") (re.* (str.to_re "b")))))
(assert (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (str.to_re "b"))))
(assert (str.in_re var_4 (re.* (re.range "a" "u"))))

; Tie var_4 to message prefix to preserve core structure while adapting to log analysis
(assert (str.contains msg var_4))
(assert (and (<= 0 (str.len var_4)) (= (* v 2) (+ (str.len var_4) 2))))

; Make this instance UNSAT by contradicting allowed log levels
(assert (not (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

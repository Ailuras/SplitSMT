(set-logic ALL)

; Uninterpreted interface for split operations
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

; Log analysis scenario: parse "timestamp level: message"
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const message String)

; Mutated seed variables preserved
(declare-const key2 String)
(declare-const value2 String)

; Core structure: space-separated fields
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= level_with_colon (split_at log_entry " " 1)))
(assert (= message (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; Level extraction via colon separator
(assert (= level (split_at level_with_colon ":" 0)))
(assert (>= (num_splits level_with_colon ":") 2))

; Timestamp format validation: YYYY-MM-DDThh:mm:ssZ (length 20)
(assert (= (str.len timestamp) 20))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))
(assert (= (str.at timestamp 19) "Z"))

; Regex for digits-only positions in timestamp
(define-fun isDigit ((c String)) Bool (str.in_re c (re.range "0" "9")))
(assert (isDigit (str.at timestamp 0)))
(assert (isDigit (str.at timestamp 1)))
(assert (isDigit (str.at timestamp 2)))
(assert (isDigit (str.at timestamp 3)))
(assert (isDigit (str.at timestamp 5)))
(assert (isDigit (str.at timestamp 6)))
(assert (isDigit (str.at timestamp 8)))
(assert (isDigit (str.at timestamp 9)))
(assert (isDigit (str.at timestamp 11)))
(assert (isDigit (str.at timestamp 12)))
(assert (isDigit (str.at timestamp 14)))
(assert (isDigit (str.at timestamp 15)))
(assert (isDigit (str.at timestamp 17)))
(assert (isDigit (str.at timestamp 18)))

; Log level constraints: typical levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message must be non-empty and contain a colon-delimited kv pair somewhere
(assert (> (str.len message) 0))
(assert (str.contains message "="))

; Extend/mutate seed constraints: interpret key2/value2 as a parsed kv token inside message
(assert (= key2 (split_at message "=" 0)))
(assert (= value2 (split_at message "=" 1)))
(assert (>= (num_splits message "=") 2))

; Preserve some seed-like structure: index/bounds + contains checks
(assert (>= 1 0))
(assert (>= (- (str.len value2) 1) 0))
(assert (not (= (str.indexof value2 "=" 0) (- 1))))
(assert (str.contains value2 ","))

; Key should not be empty and must look like a header-ish token
(assert (> (str.len key2) 0))
(assert (str.in_re key2 (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "-"))))) (re.* (str.to_re "")))))

; SAT: consistent constraints
(check-sat)

; UNSAT variant: force contradictory timestamp length while keeping structure
(assert (= (str.len timestamp) 19))
(check-sat)
(exit)

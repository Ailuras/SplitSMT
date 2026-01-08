; HTTP Header Parsing with str_split operations
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

; Declare variables for HTTP request header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)

; Declare uninterpreted functions for str_split interface

; Assert that header contains at least two lines separated by newline
(assert (>= (num_splits header "\n") 2))

; Extract first key-value pair: split by colon in first line
(assert (= key1 (split_at (split_at header "\n" 0) ":" 0)))
(assert (= value1 (split_rest (split_at header "\n" 0) ":" 1)))

; Extract second key-value pair: split by colon in second line
(assert (= key2 (split_at (split_at header "\n" 1) ":" 0)))
(assert (= value2 (split_rest (split_at header "\n" 1) ":" 1)))

; Validate that one key is "Content-Length" and extract its value
(assert (or (= key1 "Content-Length") (= key2 "Content-Length")))
(assert (=> (= key1 "Content-Length") (= content_length_str value1)))
(assert (=> (= key2 "Content-Length") (= content_length_str value2)))

; Convert content_length_str to integer and ensure it's positive
(assert (str.is_digit content_length_str))
(assert (> (str.to_int content_length_str) 0))
(assert (= content_length_val (str.to_int content_length_str)))

; Additional constraints for diversity: ensure header ends with newline and has no empty lines
(assert (str.suffixof "\n" header))
(assert (not (str.contains header "\n\n")))

; Seed mutation: add regex constraints for header format (e.g., keys are alphabetic, values may include digits)
(assert (str.in_re key1 (re.++ (re.* (re.range "A" "Z")) (re.* (re.range "a" "z")) (re.* (str.to_re "-")))))
(assert (str.in_re key2 (re.++ (re.* (re.range "A" "Z")) (re.* (re.range "a" "z")) (re.* (str.to_re "-")))))
(assert (str.in_re value1 (re.++ (re.* (re.range "0" "9")) (re.* (re.range "a" "z")) (re.* (str.to_re " ")))))
(assert (str.in_re value2 (re.++ (re.* (re.range "0" "9")) (re.* (re.range "a" "z")) (re.* (str.to_re " ")))))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

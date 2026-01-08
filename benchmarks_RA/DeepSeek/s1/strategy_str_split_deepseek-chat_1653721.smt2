; HTTP Header Parsing with str_split operations
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

; Declare variables for HTTP headers and components
(declare-fun header_line1 () String)
(declare-fun header_line2 () String)
(declare-fun header_line3 () String)
(declare-fun full_header () String)
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun content_length_str () String)
(declare-fun content_length_val () Int)

; Declare str_split interface functions

; Define full_header as concatenation of header lines with newline delimiters
(assert (= full_header (str.++ header_line1 "\n" header_line2 "\n" header_line3)))

; Assert that each header line contains a colon to separate key and value
(assert (str.contains header_line1 ":"))
(assert (str.contains header_line2 ":"))
(assert (str.contains header_line3 ":"))

; Parse key1 and value1 from header_line1 using split_at
(assert (= key1 (split_at header_line1 ":" 0)))
(assert (= value1 (split_at header_line1 ":" 1)))
(assert (>= (num_splits header_line1 ":") 2))

; Parse key2 and value2 from header_line2 using split_at
(assert (= key2 (split_at header_line2 ":" 0)))
(assert (= value2 (split_at header_line2 ":" 1)))
(assert (>= (num_splits header_line2 ":") 2))

; Validate that key2 is "content-length" (case-sensitive)
(assert (= key2 "content-length"))

; Extract content_length_str from value2 by trimming whitespace
(assert (not (str.contains value2 " ")))
(assert (not (str.contains value2 "\t")))
(assert (not (str.contains value2 "\n")))
(assert (not (str.contains value2 "\r")))
(assert (= content_length_str value2))

; Convert content_length_str to an integer and assert it's positive
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))

; Additional constraints for header_line3: key must be "user-agent" and value non-empty
(declare-fun key3 () String)
(declare-fun value3 () String)
(assert (= key3 (split_at header_line3 ":" 0)))
(assert (= value3 (split_at header_line3 ":" 1)))
(assert (>= (num_splits header_line3 ":") 2))
(assert (= key3 "user-agent"))
(assert (> (str.len value3) 0))

; Ensure no duplicate keys in the header lines
(assert (not (= key1 key2)))
(assert (not (= key1 key3)))
(assert (not (= key2 key3)))

; Final check for satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

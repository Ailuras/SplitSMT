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

; Declare string variables for HTTP request headers
(declare-const request String)
(declare-const header_line String)
(declare-const key String)
(declare-const value String)
(declare-const content_length_str String)

; Declare integer variables for validation
(declare-const content_length Int)
(declare-const num_headers Int)

; Declare uninterpreted functions for str_split interface

; Constraint 1: Request contains multiple header lines separated by newlines
(assert (>= (num_splits request "\n") 2))

; Constraint 2: Extract first header line
(assert (= header_line (split_at request "\n" 0)))

; Constraint 3: First header line must have a colon separator
(assert (>= (num_splits header_line ":") 2))

; Constraint 4: Extract key from first header line (before colon)
(assert (= key (split_at header_line ":" 0)))

; Constraint 5: Extract value from first header line (after colon)
(assert (= value (split_at header_line ":" 1)))

; Constraint 6: Key must be non-empty
(assert (> (str.len key) 0))

; Constraint 7: Value must be non-empty
(assert (> (str.len value) 0))

; Constraint 8: Look for Content-Length header in the request
(assert (str.contains request "Content-Length"))

; Constraint 9: Extract the line containing Content-Length
(assert (str.contains (split_at request "\n" 1) "Content-Length"))

; Constraint 10: Get the Content-Length value string
(assert (= content_length_str (split_at (split_at request "\n" 1) ":" 1)))

; Constraint 11: Convert Content-Length string to integer
(assert (= content_length (str.to_int content_length_str)))

; Constraint 12: Content-Length must be a positive integer
(assert (> content_length 0))

; Constraint 13: Content-Length must be less than 10000
(assert (< content_length 10000))

; Constraint 14: Total number of headers (lines) must be at least 3
(assert (= num_headers (num_splits request "\n")))
(assert (>= num_headers 3))

; Constraint 15: All header lines must contain a colon
(assert (forall ((i Int))
    (=> (and (>= i 0) (< i num_headers))
        (>= (num_splits (split_at request "\n" i) ":") 2))))

; Constraint 16: No empty header lines
(assert (forall ((i Int))
    (=> (and (>= i 0) (< i num_headers))
        (> (str.len (split_at request "\n" i)) 0))))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting, integer constraints, and validation for content-length
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

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for the str_split interface

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting on newline
(assert (= content_length_str (split_at header "\n" 0)))

; Ensure the first line has a colon to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the value part after the colon in the first line (e.g., " 123")
(assert (= content_length_str (split_rest content_length_str ":" 1)))

; Convert the extracted string to an integer for content-length validation
(assert (= content_length_val (str.to_int content_length_str)))

; Validate that content-length is a positive integer (e.g., > 0)
(assert (> content_length_val 0))

; Extract the second line (e.g., "Host: example.com") by splitting on newline
(assert (= host_str (split_at header "\n" 1)))

; Ensure the second line has a colon to separate key and value
(assert (>= (num_splits host_str ":") 2))

; Extract the value part after the colon in the second line (e.g., " example.com")
(assert (= host_str (split_rest host_str ":" 1)))

; Assert that the host value is non-empty (e.g., length > 0)
(assert (> (str.len host_str) 0))

; Extract the third line (e.g., "User-Agent: Mozilla") by splitting on newline, if present
(assert (= user_agent_str (split_at header "\n" 2)))

; Ensure the third line has a colon to separate key and value (if it exists)
(assert (>= (num_splits user_agent_str ":") 2))

; Extract the value part after the colon in the third line (e.g., " Mozilla")
(assert (= user_agent_str (split_rest user_agent_str ":" 1)))

; Assert that the user-agent value is non-empty (e.g., length > 0)
(assert (> (str.len user_agent_str) 0))

; Additional constraint: Ensure the header does not contain invalid characters like semicolons in key parts
(assert (not (str.contains (split_at header "\n" 0) ";")))

; Check satisfiability of the constraints


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

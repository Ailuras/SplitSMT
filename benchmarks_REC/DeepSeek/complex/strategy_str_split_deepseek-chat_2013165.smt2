; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
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

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for str_split interface

; Assert that the header contains at least two lines separated by newline delimiter "\n"
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting header by newline and taking the 0-th segment
(assert (= content_length_str (split_at header "\n" 0)))

; Assert that the first line contains a colon delimiter ":" to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the value part after the colon from the first line (assuming format "Content-Length: 123")
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length: must be a non-negative integer
(assert (>= content_length_val 0))

; Extract the second line (e.g., "Host: example.com") by splitting header by newline and taking the 1-st segment
(assert (= host_str (split_at header "\n" 1)))

; Assert that the second line contains a colon delimiter ":"
(assert (>= (num_splits host_str ":") 2))

; Extract the value part after the colon from the second line
(assert (str.contains (split_at host_str ":" 1) "."))

; Extract the third line (e.g., "User-Agent: Mozilla") by splitting header by newline and taking the 2-nd segment
(assert (= user_agent_str (split_at header "\n" 2)))

; Assert that the third line contains a colon delimiter ":"
(assert (>= (num_splits user_agent_str ":") 2))

; Ensure the header has exactly three lines for a SAT instance (can be adjusted for UNSAT)
(assert (= (num_splits header "\n") 3))

; Additional constraint: content-length value must be less than 1000 for a SAT instance
(assert (< content_length_val 1000))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

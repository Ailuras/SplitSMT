; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
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

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for str_split interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual lines; assume first line is request line (e.g., GET / HTTP/1.1)
(assert (>= (num_splits header "\n") 2))

; Extract the second line (index 1) as the first header line after the request line
(assert (= host_str (split_at header "\n" 1)))

; Ensure the host line contains a colon to separate key and value
(assert (str.contains host_str ":"))

; Split the host line by colon to get the value part (index 1)
(assert (= host_str (str.++ "Host: " (split_at host_str ":" 1))))

; Extract the third line (index 2) as another header line, e.g., User-Agent
(assert (= user_agent_str (split_at header "\n" 2)))

; Ensure the user-agent line contains a colon
(assert (str.contains user_agent_str ":"))

; Split the user-agent line by colon to get the value part
(assert (= user_agent_str (str.++ "User-Agent: " (split_at user_agent_str ":" 1))))

; Find the Content-Length line by checking each line; use split_rest to search
(assert (str.contains header "Content-Length"))

; Extract the Content-Length line: assume it's at index 3 for simplicity
(assert (= content_length_str (split_at header "\n" 3)))

; Ensure the Content-Length line contains a colon
(assert (str.contains content_length_str ":"))

; Split the Content-Length line by colon to get the value string
(assert (= content_length_str (str.++ "Content-Length: " (split_at content_length_str ":" 1))))

; Convert the value string to an integer for validation
(assert (str.is_digit (split_at content_length_str ":" 1)))
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length: must be non-negative and less than a reasonable limit (e.g., 10000)
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Additional constraint to make it SAT: ensure the header has at least 4 lines (request line + 3 headers)
(assert (>= (num_splits header "\n") 4))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

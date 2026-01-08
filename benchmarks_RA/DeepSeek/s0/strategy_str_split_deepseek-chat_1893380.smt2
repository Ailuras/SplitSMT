; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string and integer arithmetic for validation
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
(declare-const host_val String)
(declare-const user_agent_str String)
(declare-const user_agent_val String)

; Declare uninterpreted functions for str_split interface operations

; Assert that the header contains at least one newline to ensure multiple lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual header lines
; First line (index 0) should be the request line, e.g., "GET / HTTP/1.1"
(assert (>= (num_splits header "\n") 2))
(declare-const request_line String)
(assert (= request_line (split_at header "\n" 0)))

; Extract Content-Length header value
; Assume Content-Length line format: "Content-Length: 123"
(declare-const content_length_line String)
; Find Content-Length line by checking each split; for simplicity, assume it's at index 1
(assert (= content_length_line (split_at header "\n" 1)))
(assert (str.contains content_length_line ":"))
(assert (= content_length_str (split_at content_length_line ":" 1)))
; Convert content_length_str to integer for validation
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000)) ; Reasonable upper bound

; Extract Host header value
(declare-const host_line String)
; Assume Host line is at index 2
(assert (= host_line (split_at header "\n" 2)))
(assert (str.contains host_line ":"))
(assert (= host_val (split_at host_line ":" 1)))
(assert (>= (str.len host_val) 1)) ; Host must not be empty

; Extract User-Agent header value
(declare-const user_agent_line String)
; Assume User-Agent line is at index 3
(assert (= user_agent_line (split_at header "\n" 3)))
(assert (str.contains user_agent_line ":"))
(assert (= user_agent_val (split_at user_agent_line ":" 1)))
(assert (>= (str.len user_agent_val) 1)) ; User-Agent must not be empty

; Additional constraints to ensure diversity and complexity
; Validate that the header ends with a newline for proper formatting
(assert (str.suffixof "\n" header))
; Ensure Content-Length value is numeric (digits only)
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
; Host value should not contain spaces
(assert (not (str.contains host_val " ")))
; User-Agent value should contain a common browser string
(assert (or (str.contains user_agent_val "Mozilla") (str.contains user_agent_val "Chrome") (str.contains user_agent_val "Safari")))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; This scenario validates content-length and key-value pairs with str_split operations
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

; Declare variables for HTTP request string and components
(declare-const request String)
(declare-const header_lines String)
(declare-const content_length_value String)
(declare-const host_value String)
(declare-const user_agent_value String)
(declare-const num_lines Int)
(declare-const line_delimiter String)
(declare-const kv_delimiter String)

; Define uninterpreted functions for str_split interface

; Set delimiters for splitting
(assert (= line_delimiter "\n"))
(assert (= kv_delimiter ":"))

; Define the HTTP request string with headers including content-length
(assert (= request "GET /index.html HTTP/1.1\nHost: example.com\nUser-Agent: Mozilla/5.0\nContent-Length: 12345\nAccept: */*\n\nBody data here"))

; Split request into header lines (before empty line)
(assert (= header_lines (split_at request "\n\n" 0)))
(assert (>= (num_splits request "\n\n") 1))

; Count number of header lines
(assert (= num_lines (num_splits header_lines line_delimiter)))
(assert (>= num_lines 3))

; Extract specific header values using split operations
; Get Host value (second line, index 1 after splitting by newline)
(assert (= host_value (split_at (split_at header_lines line_delimiter 1) kv_delimiter 1)))
(assert (str.contains host_value "example"))

; Get User-Agent value (third line, index 2)
(assert (= user_agent_value (split_at (split_at header_lines line_delimiter 2) kv_delimiter 1)))
(assert (str.contains user_agent_value "Mozilla"))

; Extract and validate Content-Length value
; Find the line containing "Content-Length"
(declare-const cl_line String)
(assert (str.contains header_lines "Content-Length"))
; Use split_rest to get substring after "Content-Length:"
(assert (= cl_line (split_rest header_lines "Content-Length:" 0)))
(assert (= content_length_value (split_at cl_line line_delimiter 0)))
; Validate content-length is numeric and within bounds
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.to_int content_length_value) 0))
(assert (<= (str.to_int content_length_value) 100000))

; Additional constraints for robustness
(assert (not (= host_value "")))
(assert (not (= user_agent_value "")))
(assert (not (= content_length_value "")))
(assert (<= (str.len host_value) 100))
(assert (<= (str.len user_agent_value) 200))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

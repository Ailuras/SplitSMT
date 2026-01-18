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

; Declare string variables for HTTP headers and components
(declare-const header String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const host_header String)
(declare-const host_value String)
(declare-const user_agent_header String)
(declare-const user_agent_value String)
(declare-const method String)
(declare-const path String)
(declare-const protocol String)

; Declare integer variables for validation
(declare-const content_length_int Int)
(declare-const header_length Int)
(declare-const num_lines Int)

; Declare uninterpreted functions for str_split interface

; Define header string with multiple lines (key-value pairs separated by newlines)
(assert (= header (str.++ "GET /index.html HTTP/1.1\r\n"
                          "Host: www.example.com\r\n"
                          "User-Agent: Mozilla/5.0\r\n"
                          "Content-Length: 1234\r\n"
                          "\r\n")))

; Extract method, path, and protocol from the first line
(assert (= method (split_at header " " 0)))
(assert (= path (split_at header " " 1)))
(assert (= protocol (split_at header " " 2)))

; Validate first line has exactly 3 parts
(assert (= (num_splits header " ") 3))

; Split header into lines using newline delimiter
(assert (= num_lines (num_splits header "\r\n")))
(assert (>= num_lines 4)) ; At least 4 lines including empty line

; Extract specific headers using split_at
(assert (= host_header (split_at header "\r\n" 1))) ; Second line
(assert (= user_agent_header (split_at header "\r\n" 2))) ; Third line
(assert (= content_length_header (split_at header "\r\n" 3))) ; Fourth line

; Split each header line into key and value using colon delimiter
(assert (= host_value (split_at host_header ": " 1)))
(assert (= user_agent_value (split_at user_agent_header ": " 1)))
(assert (= content_length_value (split_at content_length_header ": " 1)))

; Validate each header line has exactly 2 parts (key and value)
(assert (= (num_splits host_header ": ") 2))
(assert (= (num_splits user_agent_header ": ") 2))
(assert (= (num_splits content_length_header ": ") 2))

; Convert content-length value to integer and validate
(assert (str.is_digit content_length_value))
(assert (= content_length_int (str.to_int content_length_value)))
(assert (>= content_length_int 0))
(assert (<= content_length_int 10000))

; Additional constraints for diversity
(assert (str.contains host_value "example"))
(assert (str.contains user_agent_value "Mozilla"))
(assert (str.prefixof method "GET"))
(assert (str.suffixof protocol "HTTP/1.1"))

; Use split_rest to get remaining part after first line
(declare-const body String)
(assert (= body (split_rest header "\r\n" 1)))
(assert (>= (str.len body) 10))

; Check total header length
(assert (= header_length (str.len header)))
(assert (>= header_length 50))
(assert (<= header_length 200))

; Ensure no duplicate headers (simplified check)
(assert (not (= host_header user_agent_header)))
(assert (not (= host_header content_length_header)))
(assert (not (= user_agent_header content_length_header)))

; Final consistency check
(assert (str.contains header "Content-Length:"))
(assert (str.contains header "Host:"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

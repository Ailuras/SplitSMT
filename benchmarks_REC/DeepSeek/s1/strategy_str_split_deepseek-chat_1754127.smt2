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

; Declare string variables for HTTP request headers and components
(declare-const request_header String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const user_agent_key String)
(declare-const user_agent_value String)
(declare-const first_line String)
(declare-const header_lines String)
(declare-const num_lines Int)

; Declare uninterpreted functions for str_split interface

; Define the HTTP request header with key-value pairs separated by newlines and colons
(assert (= request_header (str.++ "GET /index.html HTTP/1.1\n"
                                 "Host: example.com\n"
                                 "User-Agent: Mozilla/5.0\n"
                                 "Content-Length: 1234\n"
                                 "\n")))

; Split the header into first line and the rest of the header lines
(assert (= first_line (split_at request_header "\n" 0)))
(assert (= header_lines (split_rest request_header "\n" 1)))
(assert (>= (num_splits request_header "\n") 2))

; Extract the number of header lines (excluding the first line and empty line at the end)
(assert (= num_lines (- (num_splits request_header "\n") 2)))
(assert (>= num_lines 3))

; Split header lines into individual key-value pairs using newline delimiter
(assert (= content_length_key (split_at (split_at header_lines "\n" 2) ":" 0)))
(assert (= content_length_value (str.substr (split_at header_lines "\n" 2) 
                                            (+ (str.len content_length_key) 2) 
                                            (- (str.len (split_at header_lines "\n" 2)) 
                                               (+ (str.len content_length_key) 2)))))
(assert (= host_key (split_at (split_at header_lines "\n" 0) ":" 0)))
(assert (= host_value (str.substr (split_at header_lines "\n" 0) 
                                  (+ (str.len host_key) 2) 
                                  (- (str.len (split_at header_lines "\n" 0)) 
                                     (+ (str.len host_key) 2)))))
(assert (= user_agent_key (split_at (split_at header_lines "\n" 1) ":" 0)))
(assert (= user_agent_value (str.substr (split_at header_lines "\n" 1) 
                                        (+ (str.len user_agent_key) 2) 
                                        (- (str.len (split_at header_lines "\n" 1)) 
                                           (+ (str.len user_agent_key) 2)))))

; Validate key names
(assert (= content_length_key "Content-Length"))
(assert (= host_key "Host"))
(assert (= user_agent_key "User-Agent"))

; Validate content-length value is a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (not (= content_length_value "")))
(assert (>= (str.to_int content_length_value) 0))

; Additional constraints for diversity
(assert (str.contains host_value ".com"))
(assert (str.contains user_agent_value "Mozilla"))
(assert (str.prefixof "GET" first_line))
(assert (str.suffixof "HTTP/1.1" first_line))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

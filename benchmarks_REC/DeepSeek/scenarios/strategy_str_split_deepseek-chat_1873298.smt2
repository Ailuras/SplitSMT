; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validating content-length and handling key-value pairs
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

; Declare string variables for header components
(declare-fun header_string () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun content_length_key () String)
(declare-fun content_length_value () String)
(declare-fun user_agent_key () String)
(declare-fun user_agent_value () String)
(declare-fun delimiter () String)

; Declare integer variables for validation
(declare-fun parsed_content_length () Int)
(declare-fun header_length () Int)

; Declare str_split interface functions

; Set delimiter for header lines (colon followed by space)
(assert (= delimiter ": "))

; Define header string with multiple key-value pairs separated by newlines
(assert (= header_string (str.++ "Host: example.com\n" 
                                 "Content-Length: 1024\n" 
                                 "User-Agent: Mozilla/5.0\n" 
                                 "Accept: */*")))

; Extract Host header using split operations
(assert (= host_key (split_at header_string "\n" 0)))
(assert (= host_value (split_at host_key delimiter 1)))
(assert (>= (num_splits host_key delimiter) 2))

; Extract Content-Length header
(assert (= content_length_key (split_at header_string "\n" 1)))
(assert (= content_length_value (split_at content_length_key delimiter 1)))
(assert (>= (num_splits content_length_key delimiter) 2))

; Extract User-Agent header
(assert (= user_agent_key (split_at header_string "\n" 2)))
(assert (= user_agent_value (split_at user_agent_key delimiter 1)))
(assert (>= (num_splits user_agent_key delimiter) 2))

; Validate Content-Length value is numeric and within reasonable bounds
(assert (str.is_digit content_length_value))
(assert (>= (str.to_int content_length_value) 0))
(assert (<= (str.to_int content_length_value) 10000))
(assert (= parsed_content_length (str.to_int content_length_value)))

; Ensure header has at least 3 lines (Host, Content-Length, User-Agent)
(assert (>= (num_splits header_string "\n") 3))

; Additional constraint: Host value must contain a dot
(assert (str.contains host_value "."))

; Additional constraint: User-Agent must contain "Mozilla"
(assert (str.contains user_agent_value "Mozilla"))

; Additional constraint: Total header length is reasonable
(assert (= header_length (str.len header_string)))
(assert (>= header_length 50))
(assert (<= header_length 500))

; Complex constraint: Verify split_rest functionality for remaining headers
(assert (str.contains (split_rest header_string "\n" 3) "Accept"))

; Seed constraint from original problem (modified to fit context)
(declare-fun x1 () String)
(declare-fun x2 () String)
(declare-fun z1 () String)
(declare-fun z2 () String)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (= (str.++ (str.++ (str.++ x1 "dcb") x2) 
                   (str.++ (str.++ z2 (str.++ "abf" z1)) 
                           (str.++ t1 t2))) 
           (str.++ (str.++ (str.++ x2 "bcd") x1) 
                   (str.++ (str.++ z1 (str.++ "fba" z2)) 
                           "x"))))

; Final check
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

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

; Declare string variables for HTTP headers and components
(declare-const headers String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const user_agent_header String)
(declare-const user_agent_value String)
(declare-const host_header String)
(declare-const host_value String)

; Declare integer variable for content-length validation
(declare-const content_length_int Int)

; Declare str_split interface functions

; Constraint 1: Headers must contain at least 3 key-value pairs separated by newlines
(assert (>= (num_splits headers "\n") 3))

; Constraint 2: Extract content-length header (first header line)
(assert (= content_length_header (split_at headers "\n" 0)))

; Constraint 3: Content-length header must have format "Content-Length: <value>"
(assert (>= (num_splits content_length_header ":") 2))
(assert (= content_length_value (split_at content_length_header ":" 1)))

; Constraint 4: Content-length value must be a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (> (str.len content_length_value) 0))

; Constraint 5: Convert content-length value to integer and validate range
(assert (= content_length_int (str.to_int content_length_value)))
(assert (<= content_length_int 10000))
(assert (>= content_length_int 0))

; Constraint 6: Extract user-agent header (second header line)
(assert (= user_agent_header (split_at headers "\n" 1)))
(assert (>= (num_splits user_agent_header ":") 2))
(assert (= user_agent_value (split_at user_agent_header ":" 1)))

; Constraint 7: User-agent value must contain common browser identifiers
(assert (str.contains user_agent_value "Mozilla"))

; Constraint 8: Extract host header (third header line)
(assert (= host_header (split_at headers "\n" 2)))
(assert (>= (num_splits host_header ":") 2))
(assert (= host_value (split_at host_header ":" 1)))

; Constraint 9: Host value must be a valid domain name
(assert (str.in_re host_value (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) (str.to_re ".") (re.union ((_ re.loop 2 2) (re.range "a" "z")) ((_ re.loop 3 3) (re.range "a" "z"))))))

; Constraint 10: Headers must end with double newline (\n\n)
(assert (str.suffixof "\n\n" headers))

; Constraint 11: Ensure no duplicate header keys
(assert (not (str.contains (split_rest headers "\n" 1) "Content-Length:")))

; Constraint 12: Additional validation - headers must start with valid HTTP method
(assert (str.prefixof "GET " (split_at headers "\n" 0)))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

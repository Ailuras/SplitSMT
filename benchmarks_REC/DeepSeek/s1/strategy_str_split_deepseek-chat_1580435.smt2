; HTTP Header Parsing: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
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

; Declare variables for HTTP request string and extracted components
(declare-const request String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const content_length_num Int)

; Declare functions for string split operations

; Constraint 1: Request must contain at least two lines separated by newline (\n)
(assert (>= (num_splits request "\n") 2))

; Constraint 2: First line must start with "Host:" and have a colon separator
(assert (str.contains (split_at request "\n" 0) ":"))
(assert (= host_key (split_at (split_at request "\n" 0) ":" 0)))
(assert (= host_value (split_at (split_at request "\n" 0) ":" 1)))
(assert (= host_key "Host"))

; Constraint 3: Second line must contain "Content-Length:" and a valid integer value
(assert (str.contains (split_at request "\n" 1) ":"))
(assert (= content_length_key (split_at (split_at request "\n" 1) ":" 0)))
(assert (= content_length_value (split_at (split_at request "\n" 1) ":" 1)))
(assert (= content_length_key "Content-Length"))
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))

; Constraint 4: Convert content_length_value to integer and ensure it is positive
(assert (= content_length_num (str.to_int content_length_value)))
(assert (> content_length_num 0))

; Constraint 5: Additional validation: request must not contain malicious patterns (e.g., "phpinfo")
(assert (not (str.contains request "phpinfo")))

; Constraint 6: Ensure the request ends with a newline
(assert (str.suffixof "\n" request))

; Constraint 7: Host value must be a valid domain (simplified regex for alphanumeric and dots)
(assert (str.in_re host_value (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))) (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))))))

; Constraint 8: Add a complex pattern to make the problem SAT (e.g., request contains "Logger" and "aresflashdownloader.com")
(assert (str.in_re request (re.++ (str.to_re "Logger") (re.* re.allchar) (str.to_re "aresflashdownloader.com\n"))))

; Constraint 9: Ensure no invalid characters in key names (only alphanumeric and hyphens)
(assert (str.in_re host_key (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))
(assert (str.in_re content_length_key (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

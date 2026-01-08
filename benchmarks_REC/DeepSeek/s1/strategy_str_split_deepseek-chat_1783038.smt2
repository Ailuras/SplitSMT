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

; Declare string variables for HTTP headers and components
(declare-fun header_string () String)
(declare-fun content_length_header () String)
(declare-fun content_length_value () String)
(declare-fun host_header () String)
(declare-fun host_value () String)
(declare-fun user_agent_header () String)
(declare-fun user_agent_value () String)

; Declare str_split interface functions

; Seed constraint: original pattern constraint on header_string
(assert (str.in_re header_string (re.++ (re.+ (re.union (str.to_re "0") (str.to_re "111"))) (re.+ (re.+ (str.to_re "222"))))))
(assert (<= 15 (str.len header_string)))

; Additional constraints for HTTP header parsing
; Constraint 1: Header string must contain at least 3 key-value pairs separated by newlines
(assert (>= (num_splits header_string "\n") 3))

; Constraint 2: Extract Content-Length header (first header)
(assert (= content_length_header (split_at header_string "\n" 0)))
(assert (str.contains content_length_header ":"))
(assert (>= (num_splits content_length_header ":") 2))
(assert (= content_length_value (split_at content_length_header ":" 1)))

; Constraint 3: Content-Length value must be a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.len content_length_value) 1))

; Constraint 4: Extract Host header (second header)
(assert (= host_header (split_at header_string "\n" 1)))
(assert (str.contains host_header ":"))
(assert (>= (num_splits host_header ":") 2))
(assert (= host_value (split_at host_header ":" 1)))

; Constraint 5: Host value must contain a dot (domain name)
(assert (str.contains host_value "."))

; Constraint 6: Extract User-Agent header (third header)
(assert (= user_agent_header (split_at header_string "\n" 2)))
(assert (str.contains user_agent_header ":"))
(assert (>= (num_splits user_agent_header ":") 2))
(assert (= user_agent_value (split_at user_agent_header ":" 1)))

; Constraint 7: User-Agent value must contain "Mozilla" or "Chrome"
(assert (or (str.contains user_agent_value "Mozilla") (str.contains user_agent_value "Chrome")))

; Constraint 8: Validate that all headers are properly formatted (no empty values)
(assert (not (= content_length_value "")))
(assert (not (= host_value "")))
(assert (not (= user_agent_value "")))

; Constraint 9: Ensure header string ends properly (optional trailing newline handling)
(assert (or 
    (= (split_rest header_string "\n" 3) "")
    (str.contains (split_rest header_string "\n" 3) "\n")
))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

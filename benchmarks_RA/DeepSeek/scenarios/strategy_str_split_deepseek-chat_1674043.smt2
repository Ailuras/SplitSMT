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

; Declare variables for HTTP header components
(declare-const header String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const user_agent_key String)
(declare-const user_agent_value String)
(declare-const header_line1 String)
(declare-const header_line2 String)
(declare-const header_line3 String)
(declare-const delimiter String)
(declare-const colon String)
(declare-const newline String)

; Define constants for delimiters
(assert (= colon ":"))
(assert (= newline "\n"))
(assert (= delimiter (str.++ colon " "))) ; Colon followed by space for key-value separation

; Define header as a multi-line string with key-value pairs
(assert (= header (str.++ "Content-Length: 1024" newline "Host: example.com" newline "User-Agent: Mozilla/5.0")))

; Split header into lines using newline delimiter
(assert (= header_line1 (split_at header newline 0)))
(assert (= header_line2 (split_at header newline 1)))
(assert (= header_line3 (split_at header newline 2)))
(assert (= (num_splits header newline) 3)) ; Ensure exactly 3 lines

; Parse Content-Length line
(assert (= content_length_key (split_at header_line1 delimiter 0)))
(assert (= content_length_value (split_at header_line1 delimiter 1)))
(assert (= (num_splits header_line1 delimiter) 2)) ; Key and value only
(assert (= content_length_key "Content-Length"))

; Parse Host line
(assert (= host_key (split_at header_line2 delimiter 0)))
(assert (= host_value (split_at header_line2 delimiter 1)))
(assert (= (num_splits header_line2 delimiter) 2))
(assert (= host_key "Host"))

; Parse User-Agent line
(assert (= user_agent_key (split_at header_line3 delimiter 0)))
(assert (= user_agent_value (split_at header_line3 delimiter 1)))
(assert (= (num_splits header_line3 delimiter) 2))
(assert (= user_agent_key "User-Agent"))

; Validate content-length value is a positive integer
(declare-const cl_int Int)
(assert (str.is_digit content_length_value)) ; Ensure all characters are digits
(assert (= cl_int (str.to_int content_length_value)))
(assert (> cl_int 0))
(assert (<= cl_int 10000)) ; Upper bound for content-length

; Additional constraints for robustness
(assert (not (str.contains header "\r"))) ; No carriage returns allowed
(assert (str.prefixof "Content-Length" header)) ; Header must start with Content-Length
(assert (str.suffixof "Mozilla/5.0" header)) ; Header must end with User-Agent value

; Introduce a potential conflict to create UNSAT scenario
; Uncomment below to make UNSAT:
; (assert (str.contains content_length_value "a")) ; Content-length value cannot contain 'a'

(check-sat)
(get-value (header content_length_value host_value user_agent_value))

; [GENERATION STATUS: SUCCESS]
(exit)

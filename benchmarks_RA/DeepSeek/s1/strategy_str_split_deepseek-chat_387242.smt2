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

; Declare string variables for HTTP request headers
(declare-const request String)
(declare-const host_header String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const first_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Declare integer variables for validation
(declare-const content_length Int)
(declare-const header_count Int)

; Declare str_split interface functions

; Constraint 1: Request must contain at least 3 headers (first line + Host + Content-Length)
(assert (>= (num_splits request "\u{a}") 3))

; Constraint 2: Extract first line (method path version)
(assert (= first_line (split_at request "\u{a}" 0)))
(assert (>= (num_splits first_line " ") 3))
(assert (= method (split_at first_line " " 0)))
(assert (= path (split_at first_line " " 1)))
(assert (= version (split_at first_line " " 2)))

; Constraint 3: Method must be GET or POST
(assert (or (= method "GET") (= method "POST")))

; Constraint 4: Extract Host header (second line)
(assert (= host_header (split_at request "\u{a}" 1)))
(assert (str.contains host_header "Host:"))
(assert (>= (num_splits host_header ":") 2))
(assert (str.contains (split_at host_header ":" 1) "example.com"))

; Constraint 5: Extract Content-Length header (third line)
(assert (= content_length_header (split_at request "\u{a}" 2)))
(assert (str.contains content_length_header "Content-Length:"))
(assert (>= (num_splits content_length_header ":") 2))
(assert (= content_length_value (split_at content_length_header ":" 1)))

; Constraint 6: Content-Length value must be a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (> (str.len content_length_value) 0))
(assert (<= (str.len content_length_value) 5))

; Constraint 7: Convert content_length_value string to integer
(assert (= content_length (str.to_int content_length_value)))
(assert (>= content_length 0))
(assert (<= content_length 10000))

; Constraint 8: If method is POST, Content-Length must be > 0
(assert (=> (= method "POST") (> content_length 0)))

; Constraint 9: If method is GET, Content-Length must be 0
(assert (=> (= method "GET") (= content_length 0)))

; Constraint 10: Validate there are no extra headers after Content-Length (optional)
(assert (= (split_rest request "\u{a}" 3) ""))

; Constraint 11: Ensure no malformed headers (no empty lines)
(assert (not (str.contains request "\u{a}\u{a}")))

; Constraint 12: Path must start with /
(assert (str.prefixof "/" path))

; Constraint 13: Version must be HTTP/1.1 or HTTP/2.0
(assert (or (= version "HTTP/1.1") (= version "HTTP/2.0")))

; Constraint 14: Host header value must not contain spaces after colon
(assert (not (str.contains (split_at host_header ":" 1) " ")))

; Final check for satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)

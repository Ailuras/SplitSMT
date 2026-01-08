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

; Uninterpreted interface for string split operations

; === HTTP Header Parsing scenario ===
(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_header_line String)
(declare-const cl_header_line String)
(declare-const ua_header_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const content_length Int)
(declare-const body String)

; === Basic structure: request-line, header-block, body ===
; Format sketch: "<request-line>\n<header1>\n<header2>\n...\n\n<body>"
(assert (= request_line (split_at request "\n" 0)))
(assert (= header_block (split_rest request "\n" 1)))

; The header_block still contains headers plus the blank-line and body.
; Force at least a few lines to exist.
(assert (>= (num_splits request "\n") 6))

; Request-line parsing: "METHOD SP PATH SP HTTP/1.1"
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (str.contains version "HTTP/"))

; Choose specific header lines by index in the original request
(assert (= host_header_line (split_at request "\n" 1)))
(assert (= ua_header_line (split_at request "\n" 2)))
(assert (= cl_header_line (split_at request "\n" 3)))

; The empty line separating headers and body is at index 4
(assert (= (split_at request "\n" 4) ""))
(assert (= body (split_rest request "\n" 5)))

; === Parse key-value pairs via colon delimiter ===
(assert (= host_key (split_at host_header_line ":" 0)))
(assert (= host_value (split_rest host_header_line ":" 1)))
(assert (>= (num_splits host_header_line ":") 2))

(assert (= ua_key (split_at ua_header_line ":" 0)))
(assert (= ua_value (split_rest ua_header_line ":" 1)))
(assert (>= (num_splits ua_header_line ":") 2))

(assert (= cl_key (split_at cl_header_line ":" 0)))
(assert (= cl_value (split_rest cl_header_line ":" 1)))
(assert (>= (num_splits cl_header_line ":") 2))

; Require expected keys (exact match, no canonicalization)
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Values should have a leading space in typical HTTP formatting: "Key: value"
(assert (str.prefixof " " host_value))
(assert (str.prefixof " " ua_value))
(assert (str.prefixof " " cl_value))

; Host should contain at least one dot after the leading space (e.g., " example.com")
(assert (str.contains host_value "."))

; === Validate Content-Length as digits and bind to an Int ===
; cl_value is like " 123"; strip the leading space by taking substring from index 1.
(declare-const cl_digits String)
(assert (= cl_digits (str.substr cl_value 1 (- (str.len cl_value) 1))))

; Digit regex: [0-9]+
(declare-const digit_re RegLan)
(assert (= digit_re (re.+ (re.range "0" "9"))))
(assert (str.in_re cl_digits digit_re))

; Convert to Int and relate to body length
(assert (= content_length (str.to_int cl_digits)))
(assert (>= content_length 0))

; Define body as a concrete payload to make the instance SAT and check length relation.
; body may include newlines since it is split_rest from index 5.
(assert (= body "HelloWorld"))
(assert (= content_length (str.len body)))

; Also constrain request to be consistent with the chosen concrete lines.
(assert (= request (str.++ request_line "\n" host_header_line "\n" ua_header_line "\n" cl_header_line "\n\n" body)))

; Provide concrete but nontrivial request-line and headers compatible with parsing constraints.
(assert (= request_line "POST /submit HTTP/1.1"))
(assert (= host_header_line "Host: example.com"))
(assert (= ua_header_line "User-Agent: TestAgent/1.0"))
; Content-Length must match "HelloWorld" length = 10
(assert (= cl_header_line "Content-Length: 10"))

; === Additional SAT-side sanity constraints ===
(assert (>= (str.len path) 1))
(assert (str.prefixof "/" path))
(assert (>= (num_splits host_header_line ":") 2))

; === Separate UNSAT instance constraints (in the same file) ===
; These constraints intentionally contradict the SAT construction above.
; 1) Force a different content-length than the body length.
(assert (= content_length (+ (str.len body) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

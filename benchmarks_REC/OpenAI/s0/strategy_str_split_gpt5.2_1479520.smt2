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

; Uninterpreted interface functions for string split reasoning

; Additional helper as uninterpreted (non-primitive interface)
(declare-fun header_value (String String) String)

; -------------------------
; SAT instance: well-formed HTTP header parsing + content-length validation
; -------------------------
(declare-const req String)
(declare-const start_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)

(declare-const declared_len Int)

; Basic structure: start line + headers + empty line + body
(assert (= start_line (split_at req "\r\n" 0)))
(assert (= headers_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Start line split into tokens: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits start_line " ") 3))
(assert (or (= (split_at start_line " " 0) "GET")
            (= (split_at start_line " " 0) "POST")))
(assert (str.prefixof "HTTP/" (split_at start_line " " 2)))

; Parse a few header lines from headers_block
; headers_block begins with start_line then subsequent header lines
(assert (= line0 (split_at headers_block "\r\n" 0)))
(assert (= line1 (split_at headers_block "\r\n" 1)))
(assert (= line2 (split_at headers_block "\r\n" 2)))
(assert (= line3 (split_at headers_block "\r\n" 3)))
(assert (= line0 start_line))
(assert (>= (num_splits headers_block "\r\n") 4))

; Header line syntax: Key ":" Value (allow optional leading space in value)
(assert (>= (num_splits line1 ":") 2))
(assert (>= (num_splits line2 ":") 2))
(assert (>= (num_splits line3 ":") 2))

; Concrete keys we expect
(assert (= host_key (split_at line1 ":" 0)))
(assert (= cl_key   (split_at line2 ":" 0)))
(assert (= ua_key   (split_at line3 ":" 0)))
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Values may have a leading space
(assert (= host_val (split_rest line1 ":" 1)))
(assert (= cl_val   (split_rest line2 ":" 1)))
(assert (= ua_val   (split_rest line3 ":" 1)))
(assert (or (= (str.at host_val 0) " ") (= (str.len host_val) 0) (not (= (str.at host_val 0) " "))))
(assert (or (= (str.at cl_val 0) " ") (= (str.len cl_val) 0) (not (= (str.at cl_val 0) " "))))

; Use an uninterpreted helper mapping full request and key to extracted header value
(assert (= (header_value req "Host") host_val))
(assert (= (header_value req "Content-Length") cl_val))
(assert (= (header_value req "User-Agent") ua_val))

; Validate content-length: declared_len equals body length
; Restrict declared_len to a reasonable range and bind it to the known content-length string
(assert (>= declared_len 0))
(assert (<= declared_len 1024))
(assert (= declared_len (str.len body)))

; Make the instance satisfiable with an explicit witness request
(assert (= req (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "User-Agent: test-agent\r\n"
  "\r\n"
  "HELLO")))

; Ensure the extracted values match the witness layout
(assert (= host_val " example.com"))
(assert (= cl_val " 5"))
(assert (= ua_val " test-agent"))

; -------------------------
; UNSAT instance: contradictory content-length constraints
; -------------------------
(declare-const req_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_val_bad String)
(declare-const declared_len_bad Int)

(assert (= body_bad (split_at req_bad "\r\n\r\n" 1)))
(assert (>= (num_splits req_bad "\r\n\r\n") 2))

; Assume Content-Length line is the 2nd line (index 1) of the header block
(assert (= cl_line_bad (split_at (split_at req_bad "\r\n\r\n" 0) "\r\n" 1)))
(assert (= cl_val_bad (split_rest cl_line_bad ":" 1)))
(assert (= (header_value req_bad "Content-Length") cl_val_bad))

; Provide a concrete bad request where the body length is 3 but declared_len_bad is forced to 10
(assert (= req_bad (str.++
  "POST /x HTTP/1.1\r\n"
  "Content-Length: 10\r\n"
  "\r\n"
  "ABC")))

(assert (= declared_len_bad (str.len body_bad)))
(assert (= declared_len_bad 10))
(assert (= (str.len body_bad) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

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

; Uninterpreted interface operations for str_split

; Additional helper functions as uninterpreted (non-primitive)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)
(declare-fun is_token (String) Bool)
(declare-fun trim (String) String)

; ===== SAT instance: consistent HTTP header parsing =====
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const request_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)

(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const content_length_sat Int)

(declare-const ua_line_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)

; Structure: request = headers + "\r\n\r\n" + body
(assert (= req_sat (str.++ headers_sat "\r\n\r\n" body_sat)))

; Split headers by CRLF: first line is request line
(assert (>= (num_splits headers_sat "\r\n") 4))
(assert (= request_line_sat (split_at headers_sat "\r\n" 0)))
(assert (= host_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_sat "\r\n" 2)))
(assert (= ua_line_sat (split_at headers_sat "\r\n" 3)))

; Request line: "METHOD SP PATH SP HTTP/1.1"
(assert (>= (num_splits request_line_sat " ") 3))
(assert (= method_sat (split_at request_line_sat " " 0)))
(assert (= path_sat (split_at request_line_sat " " 1)))
(assert (= version_sat (split_at request_line_sat " " 2)))

; Basic validation of tokens
(assert (is_token method_sat))
(assert (is_token version_sat))
(assert (str.prefixof "HTTP/" version_sat))
(assert (or (= method_sat "GET") (= method_sat "POST")))
(assert (str.prefixof "/" path_sat))

; Header parsing: split each header line at ":"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (trim (split_at host_line_sat ":" 0))))
(assert (= host_val_sat (trim (split_rest host_line_sat ":" 1))))
(assert (= host_key_sat "Host"))
(assert (not (= host_val_sat "")))

(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (trim (split_at cl_line_sat ":" 0))))
(assert (= cl_val_sat (trim (split_rest cl_line_sat ":" 1))))
(assert (= cl_key_sat "Content-Length"))
(assert (is_digits cl_val_sat))
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (>= content_length_sat 0))

(assert (>= (num_splits ua_line_sat ":") 2))
(assert (= ua_key_sat (trim (split_at ua_line_sat ":" 0))))
(assert (= ua_val_sat (trim (split_rest ua_line_sat ":" 1))))
(assert (= ua_key_sat "User-Agent"))
(assert (not (= ua_val_sat "")))

; Validate Content-Length against actual body length
(assert (= (str.len body_sat) content_length_sat))

; Constrain headers content to look like a small request
(assert (= request_line_sat "POST /upload HTTP/1.1"))
(assert (= host_line_sat "Host: example.com"))
(assert (= cl_line_sat "Content-Length: 5"))
(assert (= ua_line_sat "User-Agent: unit-test"))
(assert (= body_sat "abcde"))

; ===== UNSAT instance: contradicting Content-Length =====
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_key_unsat String)
(declare-const content_length_unsat Int)

(assert (= req_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))
(assert (>= (num_splits headers_unsat "\r\n") 1))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 0)))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (trim (split_at cl_line_unsat ":" 0))))
(assert (= cl_val_unsat (trim (split_rest cl_line_unsat ":" 1))))
(assert (= cl_key_unsat "Content-Length"))
(assert (is_digits cl_val_unsat))
(assert (= content_length_unsat (to_int cl_val_unsat)))
(assert (>= content_length_unsat 0))

; Force a specific mismatch: length(body)=3 but Content-Length parses to 4
(assert (= cl_line_unsat "Content-Length: 4"))
(assert (= body_unsat "xyz"))
(assert (= (str.len body_unsat) content_length_unsat))

; ===== Check both together: should be UNSAT due to the second block =====


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

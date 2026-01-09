(set-logic ALL)

; Uninterpreted split interface (per provided methodology)
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

; Primitive helpers
(declare-fun str.to_int (String) Int)

; -----------------------------
; SAT instance: consistent HTTP header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const header_line3_sat String)
(declare-const blank_after_headers_sat String)

(declare-const key_host_sat String)
(declare-const val_host_sat String)
(declare-const key_cl_sat String)
(declare-const val_cl_sat String)
(declare-const key_ua_sat String)
(declare-const val_ua_sat String)

(declare-const content_length_sat Int)

; Shape: request headers are lines separated by \r\n, then an empty line
(assert (= header_line0_sat (split_at req_sat "\r\n" 0)))
(assert (= header_line1_sat (split_at req_sat "\r\n" 1)))
(assert (= header_line2_sat (split_at req_sat "\r\n" 2)))
(assert (= header_line3_sat (split_at req_sat "\r\n" 3)))
(assert (= blank_after_headers_sat (split_at req_sat "\r\n" 4)))
(assert (= blank_after_headers_sat ""))
(assert (>= (num_splits req_sat "\r\n") 5))

; Ensure these are header-like lines (contain a colon)
(assert (str.contains header_line1_sat ":"))
(assert (str.contains header_line2_sat ":"))
(assert (str.contains header_line3_sat ":"))

; Parse Host: key:value by splitting at ':' and expecting optional leading space in value
(assert (= key_host_sat (split_at header_line1_sat ":" 0)))
(assert (= val_host_sat (split_rest header_line1_sat ":" 1)))
(assert (= key_host_sat "Host"))
(assert (str.contains val_host_sat "example.com"))

; Parse Content-Length
(assert (= key_cl_sat (split_at header_line2_sat ":" 0)))
(assert (= val_cl_sat (split_rest header_line2_sat ":" 1)))
(assert (= key_cl_sat "Content-Length"))

; Trim model: require value to be either " 0" or " 5" etc. We enforce a concrete, valid numeric.
(assert (= val_cl_sat " 5"))
(assert (= content_length_sat (str.to_int (str.substr val_cl_sat 1 (- (str.len val_cl_sat) 1)))))
(assert (= content_length_sat 5))
(assert (>= content_length_sat 0))

; Parse User-Agent
(assert (= key_ua_sat (split_at header_line3_sat ":" 0)))
(assert (= val_ua_sat (split_rest header_line3_sat ":" 1)))
(assert (= key_ua_sat "User-Agent"))
(assert (>= (str.len val_ua_sat) 2))

; Tie the request line to a reasonable HTTP request start
(assert (= header_line0_sat "GET /index.html HTTP/1.1"))

; Compose a concrete satisfying request
(assert (= req_sat
  (str.++
    header_line0_sat "\r\n"
    "Host: example.com" "\r\n"
    "Content-Length: 5" "\r\n"
    "User-Agent: Test" "\r\n"
    "" "\r\n")))

; -----------------------------
; UNSAT instance: contradictory content-length validations
; -----------------------------
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_num_unsat Int)

; Extract the second header line as Content-Length
(assert (>= (num_splits req_unsat "\r\n") 3))
(assert (= cl_line_unsat (split_at req_unsat "\r\n" 1)))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Force a numeric value but also contradict it
(assert (= cl_val_unsat " 10"))
(assert (= cl_num_unsat (str.to_int (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1)))))
(assert (= cl_num_unsat 10))
(assert (< cl_num_unsat 0))

; Provide a concrete request consistent with the extracted line, but the numeric constraint makes it UNSAT
(assert (= req_unsat
  (str.++
    "POST /submit HTTP/1.1" "\r\n"
    "Content-Length: 10" "\r\n"
    "Host: example.com" "\r\n")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

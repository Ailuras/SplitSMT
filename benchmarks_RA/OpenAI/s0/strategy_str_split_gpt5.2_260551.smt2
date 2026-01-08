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

; Uninterpreted interface for str_split

; -----------------------------
; SAT instance: consistent HTTP header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const header1_line_sat String)
(declare-const header2_line_sat String)
(declare-const content_length_value_sat String)
(declare-const host_value_sat String)
(declare-const method_sat String)
(declare-const uri_sat String)
(declare-const http_version_sat String)
(declare-const cl_num_sat Int)

; Request split into request-line and headers using newline
(assert (= request_line_sat (split_at req_sat "\n" 0)))
(assert (= headers_block_sat (split_rest req_sat "\n" 1)))
(assert (>= (num_splits req_sat "\n") 3))

; Parse request-line: "METHOD URI HTTP/1.1"
(assert (= method_sat (split_at request_line_sat " " 0)))
(assert (= uri_sat (split_at request_line_sat " " 1)))
(assert (= http_version_sat (split_at request_line_sat " " 2)))
(assert (>= (num_splits request_line_sat " ") 3))
(assert (= method_sat "GET"))
(assert (= http_version_sat "HTTP/1.1"))
(assert (str.prefixof "/" uri_sat))

; Two header lines in the header block (ignore possible extra lines)
(assert (= header1_line_sat (split_at headers_block_sat "\n" 0)))
(assert (= header2_line_sat (split_at headers_block_sat "\n" 1)))
(assert (>= (num_splits headers_block_sat "\n") 2))

; Each header line must contain a ':' separating key and value
(assert (>= (num_splits header1_line_sat ":") 2))
(assert (>= (num_splits header2_line_sat ":") 2))

; Constrain concrete keys via split_at
(assert (= (split_at header1_line_sat ":" 0) "Host"))
(assert (= host_value_sat (split_rest header1_line_sat ":" 1)))
(assert (str.contains host_value_sat "example.com"))

(assert (= (split_at header2_line_sat ":" 0) "Content-Length"))
(assert (= content_length_value_sat (split_rest header2_line_sat ":" 1)))

; Whitespace-tolerant numeric value: allow a leading space before digits
; Accept either " N" or "N" for some positive integer N
(assert (or
  (= content_length_value_sat (str.++ " " (int.to.str cl_num_sat)))
  (= content_length_value_sat (int.to.str cl_num_sat))
))
(assert (> cl_num_sat 0))

; The overall request must contain at least one Content-Length header line
(assert (str.contains req_sat "Content-Length:"))

; -----------------------------
; UNSAT instance: contradictory Content-Length parsing constraints
; -----------------------------
(declare-const req_unsat String)
(declare-const headers_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_num_unsat Int)

; Header block begins after request-line
(assert (= headers_block_unsat (split_rest req_unsat "\n" 1)))
(assert (>= (num_splits req_unsat "\n") 2))

; First header line is Content-Length
(assert (= cl_line_unsat (split_at headers_block_unsat "\n" 0)))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))

; Enforce it is a plain decimal rendering of an integer
(assert (= cl_value_unsat (int.to.str cl_num_unsat)))
(assert (>= cl_num_unsat 0))

; Contradiction: same value must also include a mandatory leading space
(assert (= cl_value_unsat (str.++ " " (int.to.str cl_num_unsat))))

; Additionally, pin a concrete request string that cannot satisfy both
(assert (= req_unsat "POST /submit HTTP/1.1\nContent-Length:5\n\n"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

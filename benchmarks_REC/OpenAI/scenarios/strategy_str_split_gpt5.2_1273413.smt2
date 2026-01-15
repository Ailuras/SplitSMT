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

; Uninterpreted interface functions for string split

; Additional helpers as uninterpreted functions (non-primitive interface operations)
(declare-fun to_int (String) Int)
(declare-fun trim (String) String)
(declare-fun lower (String) String)

; -------------------------------
; SAT instance: well-formed HTTP header parsing constraints
; -------------------------------
(declare-const request_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const header_line3_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Split request into lines by \n
(assert (>= (num_splits request_sat "\n") 5))
(assert (= header_line0_sat (split_at request_sat "\n" 0)))
(assert (= header_line1_sat (split_at request_sat "\n" 1)))
(assert (= header_line2_sat (split_at request_sat "\n" 2)))
(assert (= header_line3_sat (split_at request_sat "\n" 3)))

; Force a simple request line and required headers
(assert (= header_line0_sat "POST /upload HTTP/1.1"))

; Parse Host header line: "Host: example.com"
(assert (= (lower (trim (split_at header_line1_sat ":" 0))) "host"))
(assert (>= (num_splits header_line1_sat ":") 2))
(assert (= host_key_sat (trim (split_at header_line1_sat ":" 0))))
(assert (= host_val_sat (trim (split_rest header_line1_sat ":" 1))))
(assert (= host_val_sat "example.com"))

; Parse Content-Length header line: "Content-Length: <digits>"
(assert (= (lower (trim (split_at header_line2_sat ":" 0))) "content-length"))
(assert (>= (num_splits header_line2_sat ":") 2))
(assert (= cl_key_sat (trim (split_at header_line2_sat ":" 0))))
(assert (= cl_val_sat (trim (split_rest header_line2_sat ":" 1))))

; Enforce cl_val_sat is digits via regex, then interpret as int
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (>= content_length_sat 0))

; Header terminator: require a blank line somewhere after header_line3_sat
; We model that header_line3_sat is empty, and body is remainder after it.
(assert (= header_line3_sat ""))
(assert (= body_sat (split_rest request_sat "\n" 4)))

; Validate body length equals Content-Length
(assert (= (str.len body_sat) content_length_sat))

; Construct a concrete satisfiable request
(assert (= request_sat
  (str.++
    "POST /upload HTTP/1.1" "\n"
    "Host: example.com" "\n"
    "Content-Length: 4" "\n"
    "" "\n"
    "DATA")))


; -------------------------------
; UNSAT instance: conflicting Content-Length vs body size
; -------------------------------
(declare-const request_unsat String)
(declare-const u_line0 String)
(declare-const u_line1 String)
(declare-const u_line2 String)
(declare-const u_line3 String)
(declare-const u_cl_val String)
(declare-const u_content_length Int)
(declare-const u_body String)

(assert (>= (num_splits request_unsat "\n") 5))
(assert (= u_line0 (split_at request_unsat "\n" 0)))
(assert (= u_line1 (split_at request_unsat "\n" 1)))
(assert (= u_line2 (split_at request_unsat "\n" 2)))
(assert (= u_line3 (split_at request_unsat "\n" 3)))

(assert (= u_line0 "POST /submit HTTP/1.1"))

; Content-Length line at u_line2
(assert (= (lower (trim (split_at u_line2 ":" 0))) "content-length"))
(assert (>= (num_splits u_line2 ":") 2))
(assert (= u_cl_val (trim (split_rest u_line2 ":" 1))))
(assert (str.in_re u_cl_val (re.+ (re.range "0" "9"))))
(assert (= u_content_length (to_int u_cl_val)))
(assert (>= u_content_length 0))

; Terminate headers and define body
(assert (= u_line3 ""))
(assert (= u_body (split_rest request_unsat "\n" 4)))

; Conflict: set Content-Length to 10 but body is 3 bytes
(assert (= request_unsat
  (str.++
    "POST /submit HTTP/1.1" "\n"
    "Host: example.org" "\n"
    "Content-Length: 10" "\n"
    "" "\n"
    "abc")))

(assert (= (str.len u_body) u_content_length))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

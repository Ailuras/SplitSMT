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

; Uninterpreted interface operations for string splitting

; Basic string/integer helpers that are not primitive conversions in all solvers
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const request_sat String)
(declare-const header_section_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; The request is headers + blank line + body
(assert (= header_section_sat (split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at request_sat "\r\n\r\n" 1)))
(assert (>= (num_splits request_sat "\r\n\r\n") 2))

; Split header section into lines
(assert (= header_line0_sat (split_at header_section_sat "\r\n" 0)))
(assert (= header_line1_sat (split_at header_section_sat "\r\n" 1)))
(assert (= header_line2_sat (split_at header_section_sat "\r\n" 2)))
(assert (>= (num_splits header_section_sat "\r\n") 3))

; Parse Host: header (key:value)
(assert (= host_key_sat (split_at header_line1_sat ":" 0)))
(assert (= host_val_sat (split_rest header_line1_sat ":" 1)))
(assert (>= (num_splits header_line1_sat ":") 2))
(assert (= host_key_sat "Host"))
; Common formatting: allow an optional leading space in the value
(assert (or (= host_val_sat "example.com") (= host_val_sat " example.com")))

; Parse Content-Length: header (key:value)
(assert (= cl_key_sat (split_at header_line2_sat ":" 0)))
(assert (= cl_val_sat (split_rest header_line2_sat ":" 1)))
(assert (>= (num_splits header_line2_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))
(assert (or (= cl_val_sat "5") (= cl_val_sat " 5")))

; Request line sanity: "GET / HTTP/1.1"
(assert (= header_line0_sat "GET / HTTP/1.1"))

; Validate content-length against body length
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Constrain the request concretely to ensure satisfiable witness exists
(assert (= request_sat "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\n\r\nabcde"))

; =====================
; UNSAT instance: contradictory content-length
; =====================
(declare-const request_unsat String)
(declare-const header_section_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (= header_section_unsat (split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits request_unsat "\r\n\r\n") 2))

; Assume Content-Length is on line 1 (after request line)
(assert (= cl_line_unsat (split_at header_section_unsat "\r\n" 1)))
(assert (>= (num_splits header_section_unsat "\r\n") 2))

(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))

; The value says 4, but the body is length 5 -> unsat under equality check
(assert (or (= cl_val_unsat "4") (= cl_val_unsat " 4")))
(assert (= content_length_unsat 4))
(assert (= (str.len body_unsat) content_length_unsat))

; Fix the concrete request so the contradiction is unavoidable
(assert (= request_unsat "POST /submit HTTP/1.1\r\nContent-Length: 4\r\n\r\nabcde"))



; [GENERATION STATUS: SUCCESS]
(assert (= content_length_unsat 4))
(assert (= header_section_unsat " "))
(assert (= cl_val_unsat "4"))
(assert (= content_length_sat 5))
(assert (= header_line0_sat "GET / HTTP/1.1"))
(assert (= cl_val_sat "5"))
(assert (= host_val_sat "example.com"))
(assert (= body_unsat "JKNM"))
(assert (= cl_line_unsat "/"))
(assert (= host_key_sat "Host"))
(assert (= request_unsat "POST /submit HTTP/1.1\r\nContent-Length: 4\r\n\r\nabcde"))
(assert (= cl_key_sat "Content-Length"))
(assert (= header_line1_sat "E"))
(assert (= header_section_sat "G"))
(assert (= body_sat "ABDIF"))
(assert (= header_line2_sat "T"))
(assert (= request_sat "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\n\r\nabcde"))
(check-sat)
(exit)

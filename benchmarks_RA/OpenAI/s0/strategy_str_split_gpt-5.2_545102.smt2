(set-logic ALL)

; Uninterpreted string-split interface (per provided methodology)
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

; ========== SAT instance: well-formed HTTP header parsing ==========
(declare-const hdr_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Basic structure: request-line \n headers... \n\n body
(assert (= request_line_sat (split_at hdr_sat "\n" 0)))
(assert (= headers_block_sat (split_rest hdr_sat "\n" 1)))
(assert (>= (num_splits hdr_sat "\n") 5))

; Constrain concrete header text to make the instance satisfiable
(assert (= hdr_sat
  (str.++
    "POST /submit HTTP/1.1\n"
    "Host: example.com\n"
    "Content-Length: 5\n"
    "User-Agent: AgentX\n"
    "\n"
    "abcde")))

; Identify header lines by line splitting
(assert (= host_line_sat (split_at hdr_sat "\n" 1)))
(assert (= cl_line_sat   (split_at hdr_sat "\n" 2)))
(assert (= ua_line_sat   (split_at hdr_sat "\n" 3)))
(assert (= body_sat      (split_at hdr_sat "\n" 5)))

; Parse key/value with colon+space delimiter
(assert (= host_key_sat (split_at host_line_sat ": " 0)))
(assert (= host_val_sat (split_at host_line_sat ": " 1)))
(assert (= cl_key_sat   (split_at cl_line_sat   ": " 0)))
(assert (= cl_val_sat   (split_at cl_line_sat   ": " 1)))
(assert (= ua_key_sat   (split_at ua_line_sat   ": " 0)))
(assert (= ua_val_sat   (split_at ua_line_sat   ": " 1)))

; Interface/bounds-style constraints
(assert (>= (num_splits host_line_sat ": ") 2))
(assert (>= (num_splits cl_line_sat   ": ") 2))
(assert (>= (num_splits ua_line_sat   ": ") 2))

; Header key validation
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Content validation: content-length matches body length
(assert (= cl_val_sat "5"))
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Extra realism checks
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))
(assert (not (str.contains host_val_sat " ")))

; ========== UNSAT instance: conflicting content-length ==========
(declare-const hdr_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

; Constrain a concrete header where Content-Length disagrees with body length
(assert (= hdr_unsat
  (str.++
    "POST /x HTTP/1.1\n"
    "Host: a.test\n"
    "Content-Length: 4\n"
    "\n"
    "HELLO")))

(assert (= cl_line_unsat (split_at hdr_unsat "\n" 2)))
(assert (= cl_val_unsat  (split_at cl_line_unsat ": " 1)))
(assert (= body_unsat    (split_at hdr_unsat "\n" 4)))

(assert (>= (num_splits cl_line_unsat ": ") 2))
(assert (= cl_val_unsat "4"))
(assert (= content_length_unsat 4))

; Contradiction: body is "HELLO" length 5, but content-length forced to 4
(assert (= (str.len body_unsat) content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

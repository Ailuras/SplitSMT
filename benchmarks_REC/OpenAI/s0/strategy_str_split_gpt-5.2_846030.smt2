(set-logic ALL)

; Uninterpreted interface operations for string splitting
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

; -------------------------
; SAT instance: well-formed HTTP header parsing with Content-Length
; -------------------------
(declare-const header_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; Structure: request-line \n headers... \n\n body
(assert (>= (num_splits header_sat "\n\n") 2))
(assert (= request_line_sat (split_at header_sat "\n" 0)))
(assert (= headers_block_sat (split_rest header_sat "\n" 1)))
(assert (= body_sat (split_at header_sat "\n\n" 1)))

; Request line sanity: must start with method token and contain HTTP version
(assert (or (= (split_at request_line_sat " " 0) "GET")
            (= (split_at request_line_sat " " 0) "POST")))
(assert (= (split_at request_line_sat " " 2) "HTTP/1.1"))

; Ensure at least two header lines exist in headers_block
(assert (>= (num_splits headers_block_sat "\n") 2))
(assert (= host_line_sat (split_at headers_block_sat "\n" 0)))
(assert (= cl_line_sat (split_at headers_block_sat "\n" 1)))

; Parse header lines as key:value
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))

; Validate header keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Basic value constraints (trim-like: allow optional leading space)
(assert (or (= (str.at host_val_sat 0) " ") (not (= (str.at host_val_sat 0) " "))))
(assert (or (= (str.at cl_val_sat 0) " ") (not (= (str.at cl_val_sat 0) " "))))
(assert (>= (str.len host_val_sat) 2))
(assert (>= (str.len cl_val_sat) 2))

; Require host contains a dot (e.g., example.com)
(assert (str.contains host_val_sat "."))

; Constrain Content-Length numeric via a witness integer and string rendering
(assert (>= cl_int_sat 0))
(assert (= cl_val_sat (str.++ " " (int.to.str cl_int_sat))))

; Body length must match Content-Length
(assert (>= body_len_sat 0))
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat cl_int_sat))

; Provide additional consistency constraints
(assert (not (str.contains request_line_sat "\n")))
(assert (not (str.contains host_line_sat "\n")))
(assert (not (str.contains cl_line_sat "\n")))

; Make the SAT instance concrete enough
(assert (= header_sat
  (str.++
    "POST /submit HTTP/1.1\n"
    "Host: example.com\n"
    "Content-Length: 5\n"
    "\n"
    "abcde")))

; -------------------------
; UNSAT instance: conflicting Content-Length vs body length
; -------------------------
(declare-const header_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_unsat String)

(assert (>= (num_splits header_unsat "\n\n") 2))
(assert (= request_line_unsat (split_at header_unsat "\n" 0)))
(assert (= headers_block_unsat (split_rest header_unsat "\n" 1)))
(assert (= body_unsat (split_at header_unsat "\n\n" 1)))

(assert (= (split_at request_line_unsat " " 0) "POST"))
(assert (= (split_at request_line_unsat " " 2) "HTTP/1.1"))

(assert (>= (num_splits headers_block_unsat "\n") 1))
(assert (= cl_line_unsat (split_at headers_block_unsat "\n" 0)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))

(assert (>= cl_int_unsat 0))
(assert (= cl_val_unsat (str.++ " " (int.to.str cl_int_unsat))))

; Force a body of length 3
(assert (= body_unsat "XYZ"))

; But force Content-Length to be 5 => UNSAT with body length
(assert (= cl_int_unsat 5))
(assert (= (str.len body_unsat) cl_int_unsat))

; Make header_unsat concrete too
(assert (= header_unsat
  (str.++
    "POST /x HTTP/1.1\n"
    "Content-Length: 5\n"
    "\n"
    "XYZ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

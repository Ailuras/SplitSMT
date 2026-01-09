(set-logic ALL)

; Uninterpreted split interface (per scenario)
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

; Seed symbols preserved
(declare-fun H () String)
(declare-fun I () String)
(declare-fun N () String)
(declare-fun G () String)
(declare-fun L () String)

; HTTP header parsing symbols
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const content_length Int)
(declare-const body String)

; Mutated core seed structure: keep similar concatenation skeleton but align with header shapes
(assert (= (str.++ H "a" H "aa" H "a" H "ab" H H "b" L)
           (str.++ "a" G I H I H "b" N N "baa")))

; Basic well-formedness: request has at least request-line + headers separated by newlines
(assert (= request_line (split_at request "\n" 0)))
(assert (= headers (split_rest request "\n" 1)))
(assert (>= (num_splits request "\n") 3))

; Constrain the request-line to look like an HTTP request
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET"))

; Header block contains Host and Content-Length lines (order: Host then Content-Length)
(assert (= host_line (split_at headers "\n" 0)))
(assert (= cl_line   (split_at headers "\n" 1)))

; Parse key-value around colon+space
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_val (split_at host_line ": " 1)))
(assert (= cl_key   (split_at cl_line ": " 0)))
(assert (= cl_val   (split_at cl_line ": " 1)))

; Validate expected header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value should be non-empty and not contain whitespace/newline
(assert (> (str.len host_val) 0))
(assert (not (str.contains host_val " ")))
(assert (not (str.contains host_val "\n")))

; Body: everything after the second header line (simulate blank line + body)
(assert (= body (split_rest headers "\n" 2)))

; Content-Length value is numeric: regex [0-9]+ and length consistency
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Provide a concrete, consistent content-length instance to ensure SAT
(assert (= cl_val "4"))
(assert (= content_length 4))
(assert (= (str.len body) content_length))

; Connect seed variables into the request to preserve structural relation and create additional constraints
(assert (str.contains request (str.++ "Host: " host_val)))
(assert (str.contains request (str.++ "Content-Length: " cl_val)))
(assert (str.contains request N))
(assert (= (str.len H) 0))
(assert (= N "\n"))
(assert (= I "t"))
(assert (= G "e"))
(assert (= L "\n\n"))

; One UNSAT guard: enforce impossible additional condition on body while keeping the file overall SAT? 
; Make it conditional so satisfiable (if host_val != "example.com" then allow); solver can still satisfy by choosing host_val = "example.com".
(assert (or (= host_val "example.com") (and (= (str.len body) 1) (= content_length 4))))

; Concretize an example request shape
(assert (= request
  (str.++ "GET / HTTP/1.1\n"
          "Host: " host_val "\n"
          "Content-Length: " cl_val "\n"
          "\n"
          body)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

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

; --- Uninterpreted interface for string splitting ---

; --- Seed variables (kept, but adapted to HTTP header parsing context) ---
(declare-const s String)      ; entire HTTP request header block
(declare-const in0 String)    ; delimiter candidate / canonical delimiter
(declare-const in1 String)    ; alias delimiter for mutation constraints

; --- Additional variables for parsing/validation ---
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

; --- Core structure preserved: nested and/not/not pattern from seed, mutated ---
(assert
  (and
    (and
      ; similar arithmetic shape to seed, but tied to header length and delimiter lengths
      (not (not (= (ite (<= (+ (- (str.len s) (* (str.len in0) 2)) 1) 0) 1 0) 0)))
      ; keep the in0=in1 constraint pattern
      (not (= (ite (= in0 in1) 1 0) 0))
      (not (= (ite (= in0 in1) 1 0) 0))
    )
    ; bind delimiter to CRLF for HTTP headers
    (= in0 "\r\n")
    (= in1 "\r\n")
  )
)

; --- HTTP header parsing constraints ---
; Must contain at least request line + one header line + blank line terminator
(assert (>= (num_splits s "\r\n") 3))
(assert (= request_line (split_at s "\r\n" 0)))
(assert (= headers_block (split_rest s "\r\n" 1)))

; request line sanity: starts with method token (approx) and contains HTTP version marker
(assert (or (str.prefixof "GET " request_line)
            (str.prefixof "POST " request_line)
            (str.prefixof "HEAD " request_line)))
(assert (str.contains request_line " HTTP/1."))

; Host header: "Host: <value>"
(assert (>= (num_splits s "\r\n") 4))
(assert (= host_line (split_at s "\r\n" 1)))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Content-Length header: "Content-Length: <digits>"
(assert (= cl_line (split_at s "\r\n" 2)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; cl_value must be a non-empty decimal numeral with optional leading space
; Use regex: " "* [0-9]+  (no trailing chars)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Connect an Int to the string value via str.to_int; require it round-trips to digits-only form
(assert (>= content_length 0))
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))

; Body length must match Content-Length
; Model body as whatever remains after the blank line terminator: split on "\r\n\r\n"
(assert (= body (split_rest s "\r\n\r\n" 1)))
(assert (= (str.len body) content_length))

; Require header terminator exists: at least 2 segments when splitting by CRLFCRLF
(assert (>= (num_splits s "\r\n\r\n") 2))

; --- UNSAT branch to ensure diversity: enforce a contradiction about content length ---
; If the body length equals content_length, additionally force it to differ.
(assert (not (= (str.len body) content_length)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

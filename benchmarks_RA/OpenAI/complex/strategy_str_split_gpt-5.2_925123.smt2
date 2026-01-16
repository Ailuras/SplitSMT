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

; --- Uninterpreted interface for string split ---

; --- Seed variable preserved ---
(declare-fun var0 () String)

; --- HTTP header parsing scenario variables ---
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value_raw String)
(declare-const cl_key String)
(declare-const cl_value_raw String)

(declare-const host_value String)
(declare-const cl_value String)

(declare-const content_length Int)

; --- Mutated/extended seed regex: keep core structure (membership in a complex regex) but simplify to be solvable ---
(assert (str.in_re var0 (re.++ (re.+ (str.to_re "00")) (re.* (re.union (str.to_re "11") (str.to_re "222"))))))

; --- Construct a request with CRLF-separated lines: request-line, headers, blank line, body ---
(assert (= request (str.++ request_line "\r\n" headers_block "\r\n\r\n" body)))

; Request-line shape (simple): METHOD SP PATH SP HTTP/VERSION
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line " "))

; Split header block into lines
(assert (>= (num_splits headers_block "\r\n") 2))
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line (split_at headers_block "\r\n" 1)))

; Each header line must contain a colon
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

; Extract key/value via colon split
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value_raw (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value_raw (split_rest cl_line ":" 1)))

; Basic normalization: expect a single leading space before values (common in HTTP)
(assert (str.prefixof " " host_value_raw))
(assert (str.prefixof " " cl_value_raw))
(assert (= host_value (str.substr host_value_raw 1 (- (str.len host_value_raw) 1))))
(assert (= cl_value (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1))))

; Key validation
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value: simple constraint (not empty, contains a dot)
(assert (> (str.len host_value) 0))
(assert (str.contains host_value "."))

; Content-Length value: restrict to digits via regex
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Tie var0 to a concrete member of its regex to keep it relevant
(assert (= var0 "0011222"))

; --- Content-Length arithmetic vs body length ---
(assert (= content_length (str.len body)))
(assert (>= content_length 0))
(assert (<= content_length 20))

; Provide a concrete small request body, consistent with content-length
(assert (= body "DATA"))
(assert (= content_length 4))

; --- Additional sanity: no CRLF inside a single header line ---
(assert (not (str.contains host_line "\r\n")))
(assert (not (str.contains cl_line "\r\n")))

; --- Unsat branch as a separate instance encoded by contradiction under an assumption-like guard ---
(declare-const make_unsat Bool)
(assert (or (not make_unsat)
            (and (= body "HELLO")
                 (= content_length 4))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

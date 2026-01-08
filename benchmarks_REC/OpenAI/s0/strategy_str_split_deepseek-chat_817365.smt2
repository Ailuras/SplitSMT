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

; Uninterpreted interface functions for str_split

; -----------------------------
; SAT instance: plausible HTTP header parsing
; -----------------------------
(declare-const req String)
(declare-const headers String)
(declare-const body String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const user_agent_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const content_length Int)

; Request structure: request-line + CRLF + headers + CRLF CRLF + body
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= headers (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Parse request line: "METHOD SP PATH SP HTTP/V"
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (= version "HTTP/1.1"))
(assert (or (= method "GET") (= method "POST")))
(assert (>= (str.len path) 1))
(assert (= (str.at path 0) "/"))

; Headers must contain at least 3 lines: request-line + 2 header lines
(assert (>= (num_splits headers "\r\n") 3))

; Choose concrete positions for key headers
(assert (= host_line (split_at headers "\r\n" 1)))
(assert (= cl_line (split_at headers "\r\n" 2)))
(assert (= user_agent_line (split_at headers "\r\n" 3)))

; Host header parsing: "Host: <value>"
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (>= (num_splits host_line ":") 2))
(assert (>= (str.len host_value) 1))

; Content-Length header parsing: "Content-Length: <digits>"
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))
(assert (>= (num_splits cl_line ":") 2))

; UA header parsing: "User-Agent: <value>"
(assert (= ua_key (split_at user_agent_line ":" 0)))
(assert (= ua_value (split_rest user_agent_line ":" 1)))
(assert (= ua_key "User-Agent"))
(assert (>= (num_splits user_agent_line ":") 2))

; Content-Length validation: model cl_value as a fixed digit string, and align with body length
; (Since no string-to-int conversion is provided in SLIA here, we encode a consistent scenario.)
(assert (= cl_value " 5"))
(assert (= content_length 5))
(assert (= (str.len body) content_length))

; Ensure headers/body do not accidentally include header terminator inside body prefix
(assert (not (str.contains body "\r\n\r\n")))

; -----------------------------
; UNSAT instance: contradictory Content-Length constraints
; -----------------------------
(declare-const req_bad String)
(declare-const headers_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_key_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

(assert (= headers_bad (split_at req_bad "\r\n\r\n" 0)))
(assert (= body_bad (split_at req_bad "\r\n\r\n" 1)))
(assert (>= (num_splits req_bad "\r\n\r\n") 2))

; Put Content-Length on line 1 after request line
(assert (>= (num_splits headers_bad "\r\n") 2))
(assert (= cl_line_bad (split_at headers_bad "\r\n" 1)))
(assert (= cl_key_bad (split_at cl_line_bad ":" 0)))
(assert (= cl_value_bad (split_rest cl_line_bad ":" 1)))
(assert (= cl_key_bad "Content-Length"))
(assert (>= (num_splits cl_line_bad ":") 2))

; Contradiction: cl_value_bad fixed to " 0" but length constraint forces nonzero
(assert (= cl_value_bad " 0"))
(assert (= content_length_bad 0))
(assert (= (str.len body_bad) content_length_bad))
(assert (> (str.len body_bad) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

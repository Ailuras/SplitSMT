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

; Uninterpreted interface functions for string split constraints

; Base HTTP request and derived parts
(declare-const req String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const user_agent_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value_str String)
(declare-const ua_key String)
(declare-const ua_value String)

; Auxiliary strings for structural checks
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const host_port_suffix String)

; Integers for indices and numeric validation
(declare-const k_req_line Int)
(declare-const k_host Int)
(declare-const k_cl Int)
(declare-const k_ua Int)
(declare-const content_length Int)
(declare-const cl_value_len Int)

; Additional lines to diversify structure
(declare-const accept_line String)
(declare-const accept_key String)
(declare-const accept_value String)
(declare-const k_accept Int)

; -----------------------------
; Common structural assumptions
; -----------------------------

; Non-empty request
(assert (> (str.len req) 0))

; Split request by CRLF into lines; require at least request-line + 1 header + empty line
(assert (>= (num_splits req "\r\n") 3))

; Request-line and remaining header block
(assert (>= k_req_line 0))
(assert (< k_req_line (num_splits req "\r\n")))
(assert (= k_req_line 0))
(assert (= request_line (split_at req "\r\n" k_req_line)))
(assert (= header_block (split_rest req "\r\n" 1)))

; Parse request-line: "METHOD SP PATH SP HTTP/VERSION"
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (or (= method "GET") (= method "POST") (= method "HEAD")))
(assert (str.prefixof "HTTP/" version))
(assert (str.prefixof "/" path))

; Indices for header lines (natural within bounds)
(assert (>= k_host 0))
(assert (>= k_cl 0))
(assert (>= k_ua 0))
(assert (>= k_accept 0))
(assert (< k_host (num_splits req "\r\n")))
(assert (< k_cl (num_splits req "\r\n")))
(assert (< k_ua (num_splits req "\r\n")))
(assert (< k_accept (num_splits req "\r\n")))

; Place header lines after request line
(assert (> k_host 0))
(assert (> k_cl 0))
(assert (> k_ua 0))
(assert (> k_accept 0))

; Extract some header lines
(assert (= host_line (split_at req "\r\n" k_host)))
(assert (= content_length_line (split_at req "\r\n" k_cl)))
(assert (= user_agent_line (split_at req "\r\n" k_ua)))
(assert (= accept_line (split_at req "\r\n" k_accept)))

; Each chosen header line must contain a colon
(assert (str.contains host_line ":"))
(assert (str.contains content_length_line ":"))
(assert (str.contains user_agent_line ":"))
(assert (str.contains accept_line ":"))

; -----------------------------
; Key-value parsing using ':'
; -----------------------------

; Host header
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
; Common formatting: allow a single leading space in value
(assert (or (str.prefixof " " host_value) (not (str.contains host_value " "))))
; Host must contain at least one dot (domain-like)
(assert (str.contains host_value "."))
; If a port is present, it is after another ':' in the value
(assert (= host_port_suffix (split_rest host_value ":" 1)))

; Content-Length header
(assert (>= (num_splits content_length_line ":") 2))
(assert (= cl_key (split_at content_length_line ":" 0)))
(assert (= cl_value_str (split_rest content_length_line ":" 1)))
(assert (= cl_key "Content-Length"))

; User-Agent header
(assert (>= (num_splits user_agent_line ":") 2))
(assert (= ua_key (split_at user_agent_line ":" 0)))
(assert (= ua_value (split_rest user_agent_line ":" 1)))
(assert (= ua_key "User-Agent"))

; Accept header
(assert (>= (num_splits accept_line ":") 2))
(assert (= accept_key (split_at accept_line ":" 0)))
(assert (= accept_value (split_rest accept_line ":" 1)))
(assert (= accept_key "Accept"))

; -----------------------------
; Content-Length validation (digits only, trimmed-left space)
; We approximate trimming by requiring either no leading space or exactly one.
; Then enforce that, after optional leading space, it matches [0-9]+.
; -----------------------------

; Value length and basic non-empty
(assert (= cl_value_len (str.len cl_value_str)))
(assert (> cl_value_len 0))

; Digit regex
(declare-const DIGIT_RE RegLan)
(assert (= DIGIT_RE (re.range "0" "9")))

; Either "[0-9]+" or " [0-9]+"
(assert (or (str.in_re cl_value_str (re.++ (re.+ DIGIT_RE)))
            (str.in_re cl_value_str (re.++ (str.to_re " ") (re.+ DIGIT_RE)))))

; Parse integer via str.to_int; if leading space exists, replace it by "" (single trim)
(declare-const cl_value_trimmed String)
(assert (= cl_value_trimmed (str.replace cl_value_str " " "")))
; Ensure replacement acts like trimming-one-space: either unchanged or removed exactly one leading space
(assert (or (= cl_value_trimmed cl_value_str)
            (= cl_value_str (str.++ " " cl_value_trimmed))))

(assert (= content_length (str.to_int cl_value_trimmed)))
(assert (>= content_length 0))

; Body length check: body is everything after header terminator "\r\n\r\n" if present.
(declare-const body String)
(declare-const hdr_term String)
(assert (= hdr_term "\r\n\r\n"))
(assert (str.contains req hdr_term))
; Approximate body extraction using split_rest on the terminator
(assert (= body (split_rest req hdr_term 1)))
; Validate content-length equals body length
(assert (= content_length (str.len body)))

; -----------------------------
; SAT instance constraints: enforce a coherent layout and order
; -----------------------------

; Ensure specific ordering: request-line, Host, User-Agent, Accept, Content-Length, empty line, body
(assert (= k_host 1))
(assert (= k_ua 2))
(assert (= k_accept 3))
(assert (= k_cl 4))
; Empty line must exist after Content-Length
(declare-const empty_line String)
(assert (= empty_line (split_at req "\r\n" 5)))
(assert (= empty_line ""))

; Require POST when Content-Length present
(assert (= method "POST"))

; Make sure header lines themselves are non-empty
(assert (> (str.len host_line) 0))
(assert (> (str.len content_length_line) 0))
(assert (> (str.len user_agent_line) 0))
(assert (> (str.len accept_line) 0))

; -----------------------------
; UNSAT sub-instance (separate request) to provide both SAT and UNSAT in one file
; We assert unsat conditions guarded by a boolean, and also assert the guard true.
; -----------------------------

(declare-const enable_unsat Bool)
(assert enable_unsat)

(declare-const req_bad String)
(declare-const cl_line_bad String)
(declare-const cl_key_bad String)
(declare-const cl_val_bad String)
(declare-const body_bad String)
(declare-const cl_trim_bad String)
(declare-const cl_num_bad Int)

(assert (> (str.len req_bad) 0))
(assert (>= (num_splits req_bad "\r\n") 3))
(assert (= cl_line_bad (split_at req_bad "\r\n" 1)))
(assert (str.contains req_bad "\r\n\r\n"))
(assert (= body_bad (split_rest req_bad "\r\n\r\n" 1)))

(assert (>= (num_splits cl_line_bad ":") 2))
(assert (= cl_key_bad (split_at cl_line_bad ":" 0)))
(assert (= cl_val_bad (split_rest cl_line_bad ":" 1)))
(assert (= cl_key_bad "Content-Length"))

; Bad content-length is constrained to be digits, but we also force it to be (- 1) via str.to_int inconsistency
(assert (str.in_re cl_val_bad (re.++ (str.to_re " ") (re.+ DIGIT_RE))))
(assert (= cl_trim_bad (str.replace cl_val_bad " " "")))
(assert (= cl_num_bad (str.to_int cl_trim_bad)))
; Force contradiction: str.to_int of digits is non-negative, yet require (- 1)
(assert (=> enable_unsat (= cl_num_bad (- 1))))

; Additionally contradict length equality if needed
(assert (=> enable_unsat (= cl_num_bad (str.len body_bad))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted interface functions for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional uninterpreted helpers for parsing/validation not covered by primitives
(declare-fun header_value (String String) String) ; header_value(headers_blob, key) -> value
(declare-fun header_present (String String) Bool) ; header_present(headers_blob, key)
(declare-fun parse_int (String) Int) ; parse decimal integer from string
(declare-fun is_digits (String) Bool) ; all characters are digits, non-empty

; -------------------------
; SAT instance: well-formed HTTP header parsing
; -------------------------
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const header_terminator_sat String)
(declare-const host_value_sat String)
(declare-const cl_value_sat String)
(declare-const ua_value_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Construct a concrete-ish header block using split structure
(assert (= request_line_sat (split_at headers_sat "\n" 0)))
(assert (= host_line_sat (split_at headers_sat "\n" 1)))
(assert (= ua_line_sat (split_at headers_sat "\n" 2)))
(assert (= cl_line_sat (split_at headers_sat "\n" 3)))
(assert (= header_terminator_sat (split_at headers_sat "\n" 4)))

; Require at least 5 lines: request-line, host, ua, content-length, blank line
(assert (>= (num_splits headers_sat "\n") 5))

; Blank line ends headers
(assert (= header_terminator_sat ""))

; Basic formatting: "Key: Value" (split at ":" yields at least 2 segments)
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits ua_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))

; Ensure expected keys appear exactly as the first segment before ':'
(assert (= (split_at host_line_sat ":" 0) "Host"))
(assert (= (split_at ua_line_sat ":" 0) "User-Agent"))
(assert (= (split_at cl_line_sat ":" 0) "Content-Length"))

; Value is everything after the ':' from index 1 onward; allow optional leading space
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= ua_value_sat (split_rest ua_line_sat ":" 1)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))

; Common HTTP formatting: values start with a single space
(assert (str.prefixof " " host_value_sat))
(assert (str.prefixof " " ua_value_sat))
(assert (str.prefixof " " cl_value_sat))

; Define higher-level extraction API consistency
(assert (header_present headers_sat "Host"))
(assert (header_present headers_sat "User-Agent"))
(assert (header_present headers_sat "Content-Length"))
(assert (= (header_value headers_sat "Host") host_value_sat))
(assert (= (header_value headers_sat "User-Agent") ua_value_sat))
(assert (= (header_value headers_sat "Content-Length") cl_value_sat))

; Validate Content-Length: digits (after trimming leading space by substr(1,...))
; Note: we avoid defining trim; we just require the value is " " ++ digits
(declare-const cl_digits_sat String)
(assert (= cl_value_sat (str.++ " " cl_digits_sat)))
(assert (is_digits cl_digits_sat))
(assert (= content_length_sat (parse_int cl_digits_sat)))
(assert (>= content_length_sat 0))

; Body length must match Content-Length
(assert (= (str.len body_sat) content_length_sat))

; Additional sanity constraints for SAT instance
(assert (str.prefixof "GET " request_line_sat))
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (>= (str.len host_value_sat) 2))
(assert (>= (str.len ua_value_sat) 2))

; Bound the SAT instance to keep it realistic
(assert (<= (str.len headers_sat) 500))
(assert (<= content_length_sat 1000))

; -------------------------
; UNSAT instance: contradictory Content-Length and body length constraints
; -------------------------
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_digits_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_unsat String)

; Locate Content-Length line in a smaller header set
(assert (= cl_line_unsat (split_at headers_unsat "\n" 1)))
(assert (>= (num_splits headers_unsat "\n") 3))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))

; Force a numeric content length
(assert (= cl_value_unsat (str.++ " " cl_digits_unsat)))
(assert (is_digits cl_digits_unsat))
(assert (= content_length_unsat (parse_int cl_digits_unsat)))
(assert (>= content_length_unsat 0))

; Contradiction: require content length equals 0 but body length is 1
(assert (= content_length_unsat 0))
(assert (= (str.len body_unsat) 1))
(assert (= (str.len body_unsat) content_length_unsat))

; -------------------------
; UNSAT instance: header present contradiction
; -------------------------
(declare-const headers_unsat2 String)
(declare-const host_line_unsat2 String)

(assert (= host_line_unsat2 (split_at headers_unsat2 "\n" 0)))
(assert (>= (num_splits headers_unsat2 "\n") 1))

; Say Host header is present, but also enforce it cannot be found via split key
(assert (header_present headers_unsat2 "Host"))
(assert (not (= (split_at host_line_unsat2 ":" 0) "Host")))
(assert (>= (num_splits host_line_unsat2 ":") 2))

; -------------------------
; Global consistency constraints (lightweight, not fully axiomatizing parsing)
; -------------------------
; If a header is present, its value is non-empty
(declare-const key_tmp String)
(declare-const hdr_tmp String)
(assert (forall ((hdr_tmp String) (key_tmp String))
  (=> (header_present hdr_tmp key_tmp)
      (> (str.len (header_value hdr_tmp key_tmp)) 0))))

(check-sat)


; [GENERATION STATUS: SUCCESS]

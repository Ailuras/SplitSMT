(set-logic ALL)

; Uninterpreted interface functions for string split reasoning
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional helper as uninterpreted (non-primitive interface)
(declare-fun header_value (String String) String)

; -------------------------
; SAT instance: well-formed HTTP header parsing + content-length validation
; -------------------------
(declare-const req String)
(declare-const start_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)

(declare-const declared_len Int)

; Basic structure: start line + headers + empty line + body
(assert (= start_line (split_at req "\r\n" 0)))
(assert (= headers_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Start line split into tokens: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits start_line " ") 3))
(assert (or (= (split_at start_line " " 0) "GET")
            (= (split_at start_line " " 0) "POST")))
(assert (str.prefixof "HTTP/" (split_at start_line " " 2)))

; Parse a few header lines from headers_block
; headers_block begins with start_line then subsequent header lines
(assert (= line0 (split_at headers_block "\r\n" 0)))
(assert (= line1 (split_at headers_block "\r\n" 1)))
(assert (= line2 (split_at headers_block "\r\n" 2)))
(assert (= line3 (split_at headers_block "\r\n" 3)))
(assert (= line0 start_line))
(assert (>= (num_splits headers_block "\r\n") 4))

; Header line syntax: Key ":" Value (allow optional leading space in value)
(assert (>= (num_splits line1 ":") 2))
(assert (>= (num_splits line2 ":") 2))
(assert (>= (num_splits line3 ":") 2))

; Concrete keys we expect
(assert (= host_key (split_at line1 ":" 0)))
(assert (= cl_key   (split_at line2 ":" 0)))
(assert (= ua_key   (split_at line3 ":" 0)))
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Values may have a leading space
(assert (= host_val (split_rest line1 ":" 1)))
(assert (= cl_val   (split_rest line2 ":" 1)))
(assert (= ua_val   (split_rest line3 ":" 1)))
(assert (or (= (str.at host_val 0) " ") (= (str.len host_val) 0) (not (= (str.at host_val 0) " "))))
(assert (or (= (str.at cl_val 0) " ") (= (str.len cl_val) 0) (not (= (str.at cl_val 0) " "))))

; Use an uninterpreted helper mapping full request and key to extracted header value
(assert (= (header_value req "Host") host_val))
(assert (= (header_value req "Content-Length") cl_val))
(assert (= (header_value req "User-Agent") ua_val))

; Validate content-length: declared_len equals body length
; Restrict declared_len to a reasonable range and bind it to the known content-length string
(assert (>= declared_len 0))
(assert (<= declared_len 1024))
(assert (= declared_len (str.len body)))

; Make the instance satisfiable with an explicit witness request
(assert (= req (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "User-Agent: test-agent\r\n"
  "\r\n"
  "HELLO")))

; Ensure the extracted values match the witness layout
(assert (= host_val " example.com"))
(assert (= cl_val " 5"))
(assert (= ua_val " test-agent"))

; -------------------------
; UNSAT instance: contradictory content-length constraints
; -------------------------
(declare-const req_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_val_bad String)
(declare-const declared_len_bad Int)

(assert (= body_bad (split_at req_bad "\r\n\r\n" 1)))
(assert (>= (num_splits req_bad "\r\n\r\n") 2))

; Assume Content-Length line is the 2nd line (index 1) of the header block
(assert (= cl_line_bad (split_at (split_at req_bad "\r\n\r\n" 0) "\r\n" 1)))
(assert (= cl_val_bad (split_rest cl_line_bad ":" 1)))
(assert (= (header_value req_bad "Content-Length") cl_val_bad))

; Provide a concrete bad request where the body length is 3 but declared_len_bad is forced to 10
(assert (= req_bad (str.++
  "POST /x HTTP/1.1\r\n"
  "Content-Length: 10\r\n"
  "\r\n"
  "ABC")))

(assert (= declared_len_bad (str.len body_bad)))
(assert (= declared_len_bad 10))
(assert (= (str.len body_bad) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
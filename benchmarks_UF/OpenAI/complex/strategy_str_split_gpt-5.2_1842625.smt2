(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split methodology

; HTTP header parsing scenario
(declare-const req String)
(declare-const start_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const ua_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const ua_value String)
(declare-const cl_value String)
(declare-const body String)
(declare-const cl_int Int)
(declare-const X String)

; Preserve seed core structure: constrain X against a specific literal regex
(assert (not (str.in_re X (str.to_re "comUser-Agent:si=PORT=/pagead/ads?Host:/desktop/\u{a}"))))

; Request must contain header/body delimiter CRLFCRLF
(assert (>= (num_splits req "\r\n\r\n") 2))
(assert (= headers_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_rest req "\r\n\r\n" 1)))

; Split header block by CRLF: first line is start line
(assert (>= (num_splits headers_block "\r\n") 3))
(assert (= start_line (split_at headers_block "\r\n" 0)))
(assert (str.in_re start_line (str.to_re "GET /index.html HTTP/1.1")))

; Identify specific header lines by position (simplified parsing)
(assert (= host_line (split_at headers_block "\r\n" 1)))
(assert (= ua_line (split_at headers_block "\r\n" 2)))
(assert (= cl_line (split_at headers_block "\r\n" 3)))

; Each header line contains a colon and a space after it
(assert (>= (num_splits host_line ": ") 2))
(assert (>= (num_splits ua_line ": ") 2))
(assert (>= (num_splits cl_line ": ") 2))

; Keys must match expected header names
(assert (= (split_at host_line ": " 0) "Host"))
(assert (= (split_at ua_line ": " 0) "User-Agent"))
(assert (= (split_at cl_line ": " 0) "Content-Length"))

; Extract values
(assert (= host_value (split_rest host_line ": " 1)))
(assert (= ua_value (split_rest ua_line ": " 1)))
(assert (= cl_value (split_rest cl_line ": " 1)))

; Basic validation: host contains a dot, UA non-empty, Content-Length digits only
(assert (str.contains host_value "."))
(assert (> (str.len ua_value) 0))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Link Content-Length string to integer and validate against body length
(assert (>= cl_int 0))
(assert (= cl_int (str.to_int cl_value)))
(assert (= (str.len body) cl_int))

; Additional diversity constraints (still satisfiable)
(assert (not (str.contains ua_value "\\r")))
(assert (not (str.contains ua_value "\\n")))
(assert (not (str.contains host_value " ")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

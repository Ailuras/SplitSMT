(set-logic ALL)

; HTTP Header Parsing with split_at/num_splits/split_rest

(declare-const X String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const parsed_len Int)
(declare-const unsat_witness Bool)

; Seed constraint preserved (mutated scenario still excludes this exact payload)
(assert (not (str.in_re X (str.to_re ".myway.com\u{1b}ToolbarUI2Host:Subject:toxbqyosoe/cpvm\u{a}"))))

; Basic HTTP request structure: request line + headers + blank line + body
(assert (>= (str.len X) 0))
(assert (>= (str.num_splits X "\r\n") 3))
(assert (= request_line (str.split_at X "\r\n" 0)))
(assert (= headers_block (str.split_rest X "\r\n" 1)))

; Require presence of the header/body separator: \r\n\r\n
(assert (str.contains X "\r\n\r\n"))
(assert (>= (str.num_splits X "\r\n\r\n") 2))
(assert (= body (str.split_rest X "\r\n\r\n" 1)))

; Request line parsing: METHOD SP PATH SP HTTP/VERSION
(assert (>= (str.num_splits request_line " ") 3))
(assert (= "GET" (str.split_at request_line " " 0)))
(assert (str.in_re (str.split_at request_line " " 1) (str.to_re "/")))
(assert (= "HTTP/1.1" (str.split_at request_line " " 2)))

; Header parsing: at least Host and Content-Length exist somewhere in headers
(assert (>= (str.num_splits headers_block "\r\n") 2))

; Constrain two particular lines to represent key-value headers
(assert (= host_line (str.split_at headers_block "\r\n" 0)))
(assert (= cl_line (str.split_at headers_block "\r\n" 1)))

; Key/value splitting by colon for each header line
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))

; Host header constraints
(assert (= host_key "Host"))
(assert (str.contains host_value "."))
(assert (not (str.contains host_value "\u{1b}")))
(assert (not (str.contains host_value "\n")))
(assert (not (str.contains host_value "\r")))

; Content-Length header constraints
(assert (= cl_key "Content-Length"))
(assert (str.in_re cl_value (re.++ (str.to_re " ") (str.to_re "[0-9]+"))))

; Parse length as an Int (uninterpreted mapping, but constrained by sanity checks)
(declare-fun parse_int (String) Int)
(assert (= parsed_len (parse_int cl_value)))
(assert (>= parsed_len 0))
(assert (<= parsed_len 1024))

; Validate that content-length matches body length
(assert (= parsed_len (str.len body)))

; SAT branch: a consistent request with empty body and Content-Length 0
(declare-const sat_example String)
(assert (= sat_example (str.++ "GET / HTTP/1.1\r\n" "Host: example.com\r\n" "Content-Length: 0\r\n\r\n" "")))
(assert (or (= X sat_example) unsat_witness))

; UNSAT branch (guarded): if unsat_witness is true, force a contradiction on length
(assert (=> unsat_witness (and (= X (str.++ "GET / HTTP/1.1\r\n" "Host: example.com\r\n" "Content-Length: 1\r\n\r\n" ""))
                              (= parsed_len 1)
                              (= (str.len body) 0))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

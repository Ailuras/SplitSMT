(set-logic ALL)

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
(assert (>= (str.num_splits headers_block "\r\n") 2))
(assert (= host_line (str.split_at headers_block "\r\n" 0)))
(assert (= cl_line (str.split_at headers_block "\r\n" 1)))

; Each header line must contain a colon
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))

; Extract key/value via colon split
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value_raw (str.split_rest host_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value_raw (str.split_rest cl_line ":" 1)))

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

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

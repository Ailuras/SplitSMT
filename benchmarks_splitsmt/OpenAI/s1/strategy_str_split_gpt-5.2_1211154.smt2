(set-logic ALL)

; HTTP Header Parsing scenario: parse request headers with colon and CRLF, validate Content-Length

; --- str_split interface (uninterpreted) ---

; --- Variables ---
(declare-const X String)               ; full HTTP request headers (possibly including request-line)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const user_agent_line String)
(declare-const ua_key String)
(declare-const ua_value String)
(declare-const body String)
(declare-const cl_num_str String)

; Basic structure: request-line then headers then blank line then body
(assert (= request_line (str.split_at X "\r\n" 0)))
(assert (= headers_blob (str.split_rest X "\r\n" 1)))
(assert (>= (str.num_splits X "\r\n") 3))

; Require a blank line separator somewhere: "\r\n\r\n" must occur
(assert (str.contains X "\r\n\r\n"))

; Constrain request-line format: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line (re.++ (re.union (str.to_re "GET") (str.to_re "POST") (str.to_re "HEAD"))
                                           (str.to_re " ")
                                           (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "?") (str.to_re "=") (str.to_re "&")))
                                           (str.to_re " ")
                                           (str.to_re "HTTP/1.1"))))

; Parse specific header lines by index after request-line
(assert (= host_line (str.split_at X "\r\n" 1)))
(assert (= user_agent_line (str.split_at X "\r\n" 2)))
(assert (= cl_line (str.split_at X "\r\n" 3)))

; Each header line is Key:Value; split on first ':' (relaxed via split_at)
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= ua_key (str.split_at user_agent_line ":" 0)))
(assert (= ua_value (str.split_rest user_agent_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))

; Keys must match expected header names
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Whitespace after ':' allowed: optional spaces/tabs before actual value
(assert (str.in_re host_value (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\t")))
                                     (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re ".")))
                                     (re.opt (re.++ (str.to_re ":") (re.+ (re.range "0" "9")))))))

(assert (str.in_re ua_value (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\t")))
                                   (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "/") (str.to_re "(") (str.to_re ")"))))))

; Content-Length must be digits only (allow leading whitespace)
(assert (= cl_num_str (str.replace cl_value " " "")))
(assert (str.in_re cl_num_str (re.+ (re.range "0" "9"))))

; Also ensure Content-Length line has exactly one ':' occurrence (two segments)
(assert (= (str.num_splits cl_line ":") 2))

; Avoid obviously malformed headers (mutated from seed: forbid some embedded Host/Subject injection patterns)
(assert (not (str.contains X "Subject:")))
(assert (not (str.contains X "\u{1b}Host:")))
(assert (not (str.contains X "Host:\n")))

; Ensure CRLF is used, no bare LF-only lines inside the first part
(assert (not (str.contains request_line "\n")))
(assert (not (str.contains request_line "\r\r")))

; Body is the substring after the blank line; relaxed via split_rest on "\r\n\r\n"
(assert (= body (str.split_rest X "\r\n\r\n" 1)))
(assert (>= (str.num_splits X "\r\n\r\n") 2))

; Validate Content-Length against body length with a bounded numeric regex for 0..9999 then relate by cases
; (we avoid direct string-to-int conversion by constraining representative lengths)
(assert (str.in_re cl_num_str (re.union
  (str.to_re "0")
  (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))
)))

; Constrain body length to be consistent with a small content-length window for satisfiable instances
; Choose a concrete length by forcing cl_num_str and body length to match a specific value.
(assert (= cl_num_str "12"))
(assert (= (str.len body) 12))

; Extra: require Host value includes a dot (e.g., example.com)
(assert (str.contains host_value "."))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

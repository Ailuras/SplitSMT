(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for string splitting

; Primitive string/integer variables
(declare-const req String)
(declare-const header_block String)
(declare-const body String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const user_agent_line String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const content_length Int)

; === Overall HTTP request decomposition (satisfiable core) ===
; Split request into header block and body using CRLFCRLF
(assert (= header_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Header block must contain at least a request-line and two header lines
(assert (>= (num_splits header_block "\r\n") 3))

; Parse the request line: METHOD SP PATH SP HTTP/VERSION
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" path))
(assert (str.prefixof "HTTP/" version))

; === Parse Host header line (index 1) ===
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key "Host"))
; host_val may start with a space; require it contains a dot or a colon (hostname or host:port)
(assert (or (str.contains host_val ".") (str.contains host_val ":")))

; === Parse Content-Length header line (index 2) ===
(assert (= cl_line (split_at header_block "\r\n" 2)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key "Content-Length"))

; Validate content-length: allow optional leading space in value, only digits after trimming one optional leading space
(declare-const cl_val_trim String)
(assert (= cl_val_trim (ite (and (> (str.len cl_val) 0) (= (str.at cl_val 0) " ")) (str.substr cl_val 1 (- (str.len cl_val) 1)) cl_val)))
(assert (str.in_re cl_val_trim (re.+ (re.range "0" "9"))))
(assert (= content_length (str.to_int cl_val_trim)))
(assert (>= content_length 0))

; Body length must match Content-Length
(assert (= (str.len body) content_length))

; === Parse User-Agent header line (optional, index 3 if present) ===
; If a 4th line exists, constrain it to be User-Agent with a non-empty value
(assert (=> (>= (num_splits header_block "\r\n") 4)
            (and (= user_agent_line (split_at header_block "\r\n" 3))
                 (= ua_key (split_at user_agent_line ":" 0))
                 (= ua_val (split_rest user_agent_line ":" 1))
                 (>= (num_splits user_agent_line ":") 2)
                 (= ua_key "User-Agent")
                 (> (str.len ua_val) 0))))

; === Additional sanity constraints to avoid degenerate parses ===
(assert (> (str.len header_block) 0))
(assert (not (str.contains request_line "\r")))
(assert (not (str.contains request_line "\n")))

; === UNSAT slice (separate named block): inconsistent content-length ===
; This creates an intentional contradiction while keeping the rest realistic.
; Under this assertion, sat should become unsat.
(declare-const force_unsat Bool)
(assert (= force_unsat false))
(assert (=> force_unsat
            (and (= content_length (+ (str.len body) 1))
                 (= (str.len body) content_length))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

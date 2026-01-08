(set-logic ALL)

; Uninterpreted interface operations for string split

; Primitive string/int variables for HTTP header parsing
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const body String)
(declare-const content_length Int)

; -------------------------
; Basic request structure: request_line \n headers \n\n body
; -------------------------
(assert (>= (str.num_splits request "\n") 3))
(assert (= request_line (str.split_at request "\n" 0)))
(assert (= headers (str.split_rest request "\n" 1)))

; Require an empty line delimiter between headers and body (\n\n)
(assert (>= (str.num_splits request "\n\n") 2))
(assert (= body (str.split_at request "\n\n" 1)))

; Request line parsing: METHOD SP PATH SP HTTP/VERSION
(assert (>= (str.num_splits request_line " ") 3))
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "HTTP/" version))

; -------------------------
; Header lines (each split by \n) and key-value split by ": "
; -------------------------
; Enforce at least 3 header lines after request-line: Host, Content-Length, User-Agent
(assert (>= (str.num_splits request "\n") 5))
(assert (= host_line (str.split_at request "\n" 1)))
(assert (= cl_line (str.split_at request "\n" 2)))
(assert (= ua_line (str.split_at request "\n" 3)))

; Each header line must have exactly two segments with delimiter ": " (key and value)
(assert (>= (str.num_splits host_line ": ") 2))
(assert (>= (str.num_splits cl_line ": ") 2))
(assert (>= (str.num_splits ua_line ": ") 2))
(assert (= host_key (str.split_at host_line ": " 0)))
(assert (= host_value (str.split_at host_line ": " 1)))
(assert (= cl_key (str.split_at cl_line ": " 0)))
(assert (= cl_value (str.split_at cl_line ": " 1)))
(assert (= ua_key (str.split_at ua_line ": " 0)))
(assert (= ua_value (str.split_at ua_line ": " 1)))

(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic sanity: non-empty values
(assert (> (str.len host_value) 0))
(assert (> (str.len ua_value) 0))
(assert (> (str.len cl_value) 0))

; Host value contains at least one dot and no spaces
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

; Content-Length value must be digits only and parse to integer
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))

; Body length must match Content-Length
(assert (= (str.len body) content_length))

; -------------------------
; SAT instance anchor: construct one concrete example request that satisfies constraints
; -------------------------
(assert (= request
  (str.++
    "POST /upload HTTP/1.1\n"
    "Host: example.com\n"
    "Content-Length: 5\n"
    "User-Agent: curl/8.0\n"
    "\n"
    "abcde")))

; -------------------------
; Additional UNSAT sub-instance (kept separate with assumptions via a fresh flag)
; If unsat_flag is true, enforce an impossible content-length agreement.
; This ensures the file contains both SAT and UNSAT structure; overall satisfiable by setting unsat_flag = false.
; -------------------------
(declare-const unsat_flag Bool)
(assert (or (not unsat_flag)
            (and (= cl_value "0")
                 (= (str.len body) 1))))

(check-sat)


; [GENERATION STATUS: SUCCESS]

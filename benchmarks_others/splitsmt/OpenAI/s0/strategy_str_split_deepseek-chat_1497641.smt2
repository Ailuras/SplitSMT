(set-logic ALL)

; Uninterpreted interface: str_split

; Core inputs
(declare-const header_block String)
(declare-const req_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const blank_line String)
(declare-const body String)
(declare-const request String)

; Parsed pieces for specific header lines
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

; Additional structure fields
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Numeric validation for Content-Length
(declare-const content_length Int)
(declare-const cl_value_digits String)

; Delimiters
(declare-const NL String)
(declare-const COLON String)
(declare-const SP String)
(declare-const CRLFCRLF String)

; -------------------------------
; Basic delimiter setup
(assert (= NL "\n"))
(assert (= COLON ":"))
(assert (= SP " "))
(assert (= CRLFCRLF "\n\n"))

; Overall request structure: header_block + blank line + body
(assert (= request (str.++ header_block CRLFCRLF body)))

; header_block is split into lines by NL, at least request-line + 2 header lines
(assert (>= (str.num_splits header_block NL) 3))
(assert (= req_line (str.split_at header_block NL 0)))
(assert (= host_line (str.split_at header_block NL 1)))
(assert (= cl_line (str.split_at header_block NL 2)))

; Optionally a user-agent line exists if there are >=4 lines
(assert (=> (>= (str.num_splits header_block NL) 4)
            (= ua_line (str.split_at header_block NL 3))))

; -------------------------------
; Request line parsing: METHOD SP PATH SP VERSION
(assert (>= (str.num_splits req_line SP) 3))
(assert (= method (str.split_at req_line SP 0)))
(assert (= path (str.split_at req_line SP 1)))
(assert (= version (str.split_at req_line SP 2)))

; Constrain to common shapes
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" path))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; -------------------------------
; Host line parsing: "Host" ":" value
(assert (>= (str.num_splits host_line COLON) 2))
(assert (= host_key (str.split_at host_line COLON 0)))
(assert (= host_value (str.split_rest host_line COLON 1)))
(assert (= host_key "Host"))

; Basic host value sanity: non-empty, no newlines
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\n")))

; -------------------------------
; Content-Length line parsing and validation
(assert (>= (str.num_splits cl_line COLON) 2))
(assert (= cl_key (str.split_at cl_line COLON 0)))
(assert (= cl_value (str.split_rest cl_line COLON 1)))
(assert (= cl_key "Content-Length"))

; Allow optional leading space after colon: normalize by either " N" or "N"
; Create cl_value_digits to be the digit-only token used for numeric constraints
(assert (or (= cl_value_digits cl_value)
            (= cl_value (str.++ " " cl_value_digits))))

; cl_value_digits must be all digits and non-empty
(assert (str.in_re cl_value_digits (re.+ (re.range "0" "9"))))

; Bind numeric content_length to cl_value_digits with a limited domain mapping
; (SMT-LIB does not provide direct String->Int conversion in general.)
(assert (or
  (and (= cl_value_digits "0") (= content_length 0))
  (and (= cl_value_digits "1") (= content_length 1))
  (and (= cl_value_digits "2") (= content_length 2))
  (and (= cl_value_digits "3") (= content_length 3))
  (and (= cl_value_digits "4") (= content_length 4))
  (and (= cl_value_digits "5") (= content_length 5))
  (and (= cl_value_digits "6") (= content_length 6))
  (and (= cl_value_digits "7") (= content_length 7))
  (and (= cl_value_digits "8") (= content_length 8))
  (and (= cl_value_digits "9") (= content_length 9))
  (and (= cl_value_digits "10") (= content_length 10))
  (and (= cl_value_digits "11") (= content_length 11))
  (and (= cl_value_digits "12") (= content_length 12))
  (and (= cl_value_digits "13") (= content_length 13))
  (and (= cl_value_digits "14") (= content_length 14))
  (and (= cl_value_digits "15") (= content_length 15))
  (and (= cl_value_digits "16") (= content_length 16))
  (and (= cl_value_digits "17") (= content_length 17))
  (and (= cl_value_digits "18") (= content_length 18))
  (and (= cl_value_digits "19") (= content_length 19))
  (and (= cl_value_digits "20") (= content_length 20))
  (and (= cl_value_digits "21") (= content_length 21))
  (and (= cl_value_digits "22") (= content_length 22))
  (and (= cl_value_digits "23") (= content_length 23))
  (and (= cl_value_digits "24") (= content_length 24))
  (and (= cl_value_digits "25") (= content_length 25))
  (and (= cl_value_digits "26") (= content_length 26))
  (and (= cl_value_digits "27") (= content_length 27))
  (and (= cl_value_digits "28") (= content_length 28))
  (and (= cl_value_digits "29") (= content_length 29))
  (and (= cl_value_digits "30") (= content_length 30))
  (and (= cl_value_digits "31") (= content_length 31))
  (and (= cl_value_digits "32") (= content_length 32))
  (and (= cl_value_digits "33") (= content_length 33))
  (and (= cl_value_digits "34") (= content_length 34))
  (and (= cl_value_digits "35") (= content_length 35))
  (and (= cl_value_digits "36") (= content_length 36))
  (and (= cl_value_digits "37") (= content_length 37))
  (and (= cl_value_digits "38") (= content_length 38))
  (and (= cl_value_digits "39") (= content_length 39))
  (and (= cl_value_digits "40") (= content_length 40))
  (and (= cl_value_digits "41") (= content_length 41))
  (and (= cl_value_digits "42") (= content_length 42))
  (and (= cl_value_digits "43") (= content_length 43))
  (and (= cl_value_digits "44") (= content_length 44))
  (and (= cl_value_digits "45") (= content_length 45))
  (and (= cl_value_digits "46") (= content_length 46))
  (and (= cl_value_digits "47") (= content_length 47))
  (and (= cl_value_digits "48") (= content_length 48))
  (and (= cl_value_digits "49") (= content_length 49))
  (and (= cl_value_digits "50") (= content_length 50))
))

; Validate body length matches content_length
(assert (= (str.len body) content_length))

; If method is GET, require content_length = 0 and empty body
(assert (=> (= method "GET") (and (= content_length 0) (= body ""))))

; If method is POST, allow non-zero body, but keep it within the mapped range
(assert (=> (= method "POST") (and (>= content_length 0) (<= content_length 50))))

; -------------------------------
; User-Agent parsing (if present): "User-Agent" ":" value
(assert (=> (>= (str.num_splits header_block NL) 4)
            (and (>= (str.num_splits ua_line COLON) 2)
                 (= ua_key (str.split_at ua_line COLON 0))
                 (= ua_value (str.split_rest ua_line COLON 1))
                 (= ua_key "User-Agent")
                 (> (str.len ua_value) 0))))

; -------------------------------
; SAT branch: a concrete consistent example
(declare-const sat_guard Bool)
(assert sat_guard)
(assert (= header_block
  (str.++
    "POST /submit HTTP/1.1" NL
    "Host:example.com" NL
    "Content-Length: 4" NL
    "User-Agent: fuzz")))
(assert (= body "DATA"))

; -------------------------------
; UNSAT branch (disabled by default): contradictory content-length
(declare-const unsat_guard Bool)
(assert (not unsat_guard))
(assert (=> unsat_guard
            (and (= header_block
                    (str.++
                      "POST /x HTTP/1.1" NL
                      "Host:example.com" NL
                      "Content-Length: 3"))
                 (= body "DATA"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]

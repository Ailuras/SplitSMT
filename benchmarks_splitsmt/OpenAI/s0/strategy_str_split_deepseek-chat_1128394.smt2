(set-logic ALL)

; --- Uninterpreted interface: str_split ---

; --- Core variables for HTTP header parsing ---
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const method String)
(declare-const uri String)
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

(declare-const content_length Int)
(declare-const body String)

; --- Extra variables to create both SAT and UNSAT sub-instances ---
(declare-const request_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const cl_value_sat String)
(declare-const content_length_sat Int)

(declare-const request_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_value_unsat String)
(declare-const content_length_unsat Int)

; --- Helper constraints: basic structural well-formedness ---
; request = request_line + "\n" + headers + "\n\n" + body
(assert (= request (str.++ request_line "\n" headers "\n\n" body)))

; request line fields split by spaces: "METHOD URI VERSION"
(assert (>= (str.num_splits request_line " ") 3))
(assert (= method (str.split_at request_line " " 0)))
(assert (= uri (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))

; constrain plausible HTTP version
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; method restricted to common verbs
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "HEAD")))

; headers split by newline should have at least 3 lines (host, content-length, user-agent)
(assert (>= (str.num_splits headers "\n") 3))
(assert (= host_line (str.split_at headers "\n" 0)))
(assert (= cl_line (str.split_at headers "\n" 1)))
(assert (= ua_line (str.split_at headers "\n" 2)))

; each header line is "Key: Value" (split by ":")
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))

(assert (>= (str.num_splits cl_line ":") 2))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))

(assert (>= (str.num_splits ua_line ":") 2))
(assert (= ua_key (str.split_at ua_line ":" 0)))
(assert (= ua_value (str.split_rest ua_line ":" 1)))

; exact keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; tolerate optional leading space after ':' by allowing either " X" or "X" forms
(assert (or (= host_value (str.++ " " (str.replace host_value " " ""))) (= host_value (str.replace host_value " " ""))))
(assert (or (= ua_value (str.++ " " (str.replace ua_value " " ""))) (= ua_value (str.replace ua_value " " ""))))

; content-length value should be digits possibly preceded by a single space; we model trimmed digits via replace
(assert (= cl_value (str.++ " " cl_value_sat)) )

; NOTE: We keep numeric parsing abstract: content_length relates to cl_value through constraints in SAT/UNSAT instances.

; --- Global content-length constraints ---
(assert (>= content_length 0))
(assert (= content_length (str.len body)))

; =====================
; SAT instance: a consistent request with correct content-length
; =====================
(assert (= request_sat (str.++ "POST /submit HTTP/1.1\n" headers_sat "\n\n" body_sat)))
(assert (= headers_sat (str.++ "Host: example.com\n" "Content-Length: " cl_value_sat "\n" "User-Agent: test-agent")))
(assert (= body_sat "hello"))
(assert (= content_length_sat (str.len body_sat)))
(assert (= content_length_sat 5))
(assert (= cl_value_sat "5"))

; tie SAT instance into the general variables by allowing request to be request_sat
(assert (= request request_sat))
(assert (= headers headers_sat))
(assert (= body body_sat))
(assert (= content_length content_length_sat))

; ensure cl_line and cl_value match the constructed SAT headers
(assert (= cl_line "Content-Length: 5"))
(assert (= cl_value (str.++ " " cl_value_sat)))

; =====================
; UNSAT instance (separate variables): contradictory content-length
; This does NOT constrain the main request; it's a parallel unsat core for diversity.
; =====================
(assert (= request_unsat (str.++ "POST /x HTTP/1.1\n" headers_unsat "\n\n" body_unsat)))
(assert (= headers_unsat (str.++ "Host: a\n" "Content-Length: " cl_value_unsat "\n" "User-Agent: ua")))
(assert (= body_unsat "abcd"))
(assert (= content_length_unsat (str.len body_unsat)))
(assert (= cl_value_unsat "10"))
; contradictory: length("abcd")=4 but claimed numeric length is 10
(assert (= content_length_unsat 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

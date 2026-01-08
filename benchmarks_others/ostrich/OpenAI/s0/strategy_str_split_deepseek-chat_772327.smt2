(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Auxiliary uninterpreted functions for header semantics
(declare-fun header_value (String String) String) ; (headers, key) -> value
(declare-fun header_present (String String) Bool) ; (headers, key) -> present?
(declare-fun parse_int (String) Int)              ; parse decimal integer
(declare-fun body_of (String) String)             ; whole request -> body string
(declare-fun headers_of (String) String)          ; whole request -> header section (no body)

; -------------------------
; SAT instance: consistent parsing
; -------------------------
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const host_sat String)
(declare-const cl_str_sat String)
(declare-const cl_int_sat Int)
(declare-const first_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

(assert (= headers_sat (headers_of req_sat)))
(assert (= body_sat (body_of req_sat)))

; Request line parsing: "METHOD SP PATH SP VERSION"
(assert (= first_line_sat (split_at req_sat "\r\n" 0)))
(assert (= method_sat (split_at first_line_sat " " 0)))
(assert (= path_sat (split_at first_line_sat " " 1)))
(assert (= version_sat (split_at first_line_sat " " 2)))
(assert (= method_sat "POST"))
(assert (str.prefixof "/" path_sat))
(assert (or (= version_sat "HTTP/1.1") (= version_sat "HTTP/1.0")))
(assert (>= (num_splits first_line_sat " ") 3))

; Ensure headers section contains multiple header lines
(assert (>= (num_splits headers_sat "\r\n") 3))

; Constrain key-value extraction using ':' delimiter per line
; Host: example.org
(assert (header_present headers_sat "Host"))
(assert (= host_sat (header_value headers_sat "Host")))
(assert (= host_sat "example.org"))

; Content-Length: must match body length
(assert (header_present headers_sat "Content-Length"))
(assert (= cl_str_sat (header_value headers_sat "Content-Length")))
(assert (= cl_int_sat (parse_int cl_str_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Additional structural split constraints for a concrete Content-Length line
(declare-const cl_line_sat String)
(declare-const cl_key_part_sat String)
(declare-const cl_val_part_sat String)
(assert (= cl_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= cl_key_part_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_part_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_part_sat "Content-Length"))
(assert (str.contains cl_line_sat ":"))

; Tie the extracted value to header_value abstraction (allow optional leading space)
(assert (or (= cl_val_part_sat cl_str_sat)
            (= (str.++ " " cl_str_sat) cl_val_part_sat)))

; Constrain body to be some payload of given length
(assert (>= (str.len body_sat) 1))

; Some well-formedness constraints about request formatting
(assert (str.contains req_sat "\r\n\r\n"))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; -------------------------
; UNSAT instance: contradictory content-length validation
; -------------------------
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_str_unsat String)
(declare-const cl_int_unsat Int)
(declare-const cl_line_unsat String)
(declare-const cl_key_part_unsat String)
(declare-const cl_val_part_unsat String)

(assert (= headers_unsat (headers_of req_unsat)))
(assert (= body_unsat (body_of req_unsat)))

(assert (header_present headers_unsat "Content-Length"))
(assert (= cl_str_unsat (header_value headers_unsat "Content-Length")))
(assert (= cl_int_unsat (parse_int cl_str_unsat)))
(assert (>= cl_int_unsat 0))

; Force body length to be 3 but content-length to be 5 -> contradiction
(assert (= (str.len body_unsat) 3))
(assert (= cl_int_unsat 5))
(assert (= cl_int_unsat (str.len body_unsat)))

; Also assert a structural constraint that implies a different numeric value
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 0)))
(assert (= cl_key_part_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_part_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_part_unsat "Content-Length"))

; Make cl_str_unsat explicitly "3" while cl_int_unsat is forced to 5
(assert (= cl_str_unsat "3"))

; -------------------------
; Index/natural constraints for split interface usage
; -------------------------
(assert (and (>= 0 0) (>= 1 0) (>= 2 0)))

(check-sat)


; [GENERATION STATUS: SUCCESS]

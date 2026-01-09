(set-logic ALL)

; Uninterpreted interface for string splitting

; Additional uninterpreted helpers for HTTP header parsing
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)
(declare-fun header_value (String String) String)

; =========================
; SAT instance: well-formed request headers
; =========================
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_raw_sat String)
(declare-const cl_val_sat String)
(declare-const host_val_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)
(declare-const cl_int_sat Int)
(declare-const body_sat String)

; Request is "header-block" + blank line + body
(assert (= req_sat (str.++ header_block_sat "\r\n\r\n" body_sat)))

; Split header block by CRLF lines
(assert (= line0_sat (str.split_at header_block_sat "\r\n" 0)))
(assert (= line1_sat (str.split_at header_block_sat "\r\n" 1)))
(assert (= line2_sat (str.split_at header_block_sat "\r\n" 2)))
(assert (>= (str.num_splits header_block_sat "\r\n") 3))

; Request line structure: METHOD SP PATH SP HTTP/VERSION
(assert (= method_sat (str.split_at line0_sat " " 0)))
(assert (= path_sat (str.split_at line0_sat " " 1)))
(assert (= version_sat (str.split_at line0_sat " " 2)))
(assert (= method_sat "POST"))
(assert (str.prefixof "/" path_sat))
(assert (str.prefixof "HTTP/" version_sat))
(assert (>= (str.num_splits line0_sat " ") 3))

; Header lines: Key: Value
(assert (= cl_key_sat (trim (str.split_at line1_sat ":" 0))))
(assert (= cl_val_raw_sat (str.split_rest line1_sat ":" 1)))
(assert (= cl_val_sat (trim cl_val_raw_sat)))
(assert (= cl_key_sat "Content-Length"))

(assert (= host_val_sat (trim (str.split_rest line2_sat ":" 1))))
(assert (= (trim (str.split_at line2_sat ":" 0)) "Host"))
(assert (str.contains host_val_sat "."))

; Validate Content-Length is digits and matches body length
(assert (is_digits cl_val_sat))
(assert (>= (str.len cl_val_sat) 1))
(assert (= cl_int_sat (to_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Tie to a higher-level lookup API (uninterpreted) for diversity
(assert (= (header_value header_block_sat "Content-Length") cl_val_sat))
(assert (= (header_value header_block_sat "Host") host_val_sat))

; Provide a concrete consistent construction (still SAT)
(assert (= header_block_sat (str.++ "POST /submit HTTP/1.1\r\n" "Content-Length: 5\r\n" "Host: example.com")))
(assert (= body_sat "abcde"))

; =========================
; UNSAT instance: conflicting Content-Length
; =========================
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const line0_unsat String)
(declare-const line1_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_unsat String)

(assert (= req_unsat (str.++ header_block_unsat "\r\n\r\n" body_unsat)))
(assert (= line0_unsat (str.split_at header_block_unsat "\r\n" 0)))
(assert (= line1_unsat (str.split_at header_block_unsat "\r\n" 1)))
(assert (>= (str.num_splits header_block_unsat "\r\n") 2))

(assert (= (str.split_at line0_unsat " " 0) "POST"))
(assert (>= (str.num_splits line0_unsat " ") 3))

(assert (= (trim (str.split_at line1_unsat ":" 0)) "Content-Length"))
(assert (= cl_val_unsat (trim (str.split_rest line1_unsat ":" 1))))
(assert (is_digits cl_val_unsat))
(assert (= cl_int_unsat (to_int cl_val_unsat)))
(assert (>= cl_int_unsat 0))

; Force a concrete header declaring 4 bytes
(assert (= header_block_unsat (str.++ "POST /x HTTP/1.1\r\n" "Content-Length: 4")))

; Force body to have length 5, causing contradiction
(assert (= body_unsat "hello"))
(assert (= (str.len body_unsat) 5))
(assert (= cl_int_unsat (str.len body_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

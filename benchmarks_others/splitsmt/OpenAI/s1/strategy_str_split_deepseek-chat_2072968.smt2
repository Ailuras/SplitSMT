(set-logic ALL)

; Uninterpreted interface for str_split

; Seed variables (kept) and extended variables for HTTP header parsing
(declare-const x1 String)
(declare-const x2 String)
(declare-const z1 String)
(declare-const z2 String)
(declare-const z3 String)
(declare-const t1 String)
(declare-const t2 String)

(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const header_host_line String)
(declare-const header_cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_len Int)

; Mutated core structure from the seed: still a big concatenation equality, but adapted to header-like tokens
(assert
  (= (str.++ (str.++ (str.++ (str.++ x1 "Host" ) x2)
                      (str.++ (str.++ z1 t1) z2))
               (str.++ "\r\n" z3))
     (str.++ (str.++ (str.++ (str.++ x2 "Content-Length") x1)
                      (str.++ (str.++ z2 t2) z1))
               (str.++ z3 "\r\n"))))

; Basic request shape: request line then headers then blank line
(assert (= req (str.++ request_line (str.++ "\r\n" (str.++ headers_block "\r\n\r\n")))))

; Ensure at least two header lines exist (split by CRLF)
(assert (>= (str.num_splits headers_block "\r\n") 2))
(assert (>= (str.num_splits headers_block "\r\n") 3))

; Pin two specific header lines to positions 0 and 1
(assert (= header_host_line (str.split_at headers_block "\r\n" 0)))
(assert (= header_cl_line   (str.split_at headers_block "\r\n" 1)))

; Each header line must contain a colon delimiter into at least two segments
(assert (>= (str.num_splits header_host_line ":") 2))
(assert (>= (str.num_splits header_cl_line ":") 2))

; Keys and values extracted via split_at ("Key: Value" simplified as "Key:Value" or with leading spaces in value)
(assert (= "Host" (str.split_at header_host_line ":" 0)))
(assert (= host_value (str.split_rest header_host_line ":" 1)))

(assert (= "Content-Length" (str.split_at header_cl_line ":" 0)))
(assert (= cl_value (str.split_rest header_cl_line ":" 1)))

; Ensure values are non-empty
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))

; Content-Length must be digits only and consistent with an integer variable (lightweight via a few cases)
(assert (str.in_re cl_value (re.++ (str.to_re "") (re.+ (re.range "0" "9")))))

; Tie cl_len to a small set of allowed lengths to keep constraints decidable and meaningful
(assert (or (= cl_len 0) (= cl_len 1) (= cl_len 2) (= cl_len 3) (= cl_len 4) (= cl_len 5) (= cl_len 10) (= cl_len 12)))

; Map cl_value strings to cl_len for those cases (partial mapping)
(assert
  (or (and (= cl_len 0) (= cl_value "0"))
      (and (= cl_len 1) (= cl_value "1"))
      (and (= cl_len 2) (= cl_value "2"))
      (and (= cl_len 3) (= cl_value "3"))
      (and (= cl_len 4) (= cl_value "4"))
      (and (= cl_len 5) (= cl_value "5"))
      (and (= cl_len 10) (= cl_value "10"))
      (and (= cl_len 12) (= cl_value "12"))))

; Ensure headers_block actually contains the constructed key/value lines (order enforced by earlier split_at constraints)
(assert (= header_host_line (str.++ "Host:" host_value)))
(assert (= header_cl_line   (str.++ "Content-Length:" cl_value)))

; Connect seed variables into the request so they influence parsing
(assert (str.contains request_line x1))
(assert (str.contains request_line x2))
(assert (str.contains headers_block z1))
(assert (str.contains headers_block z2))
(assert (str.contains headers_block z3))

; Add a sanity constraint about request_line shape
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET"))

; Make sure the host_value does not contain CRLF (single-line value)
(assert (not (str.contains host_value "\r\n")))

; SAT/UNSAT mix: force a contradiction on Content-Length mapping for UNSAT instance
; cl_value is a digit string, but we force an impossible combination
(assert (= cl_value "12"))
(assert (= cl_len 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]

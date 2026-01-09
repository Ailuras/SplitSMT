(set-logic ALL)

; Uninterpreted string-split interface

; =========================
; SAT instance: plausible HTTP header parsing
; =========================
(declare-const hdr_sat String)
(declare-const reqline_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const content_length_sat Int)

; Shape: request line then headers (separated by \r\n)
(assert (= reqline_sat (str.split_at hdr_sat "\r\n" 0)))
(assert (= headers_sat (str.split_rest hdr_sat "\r\n" 1)))
(assert (>= (str.num_splits hdr_sat "\r\n") 4))

; Require a simple GET request line shape
(assert (str.in_re reqline_sat (re.++ (str.to_re "GET ") (re.* re.allchar))))
(assert (str.contains reqline_sat " HTTP/1.1"))

; First three header lines in headers_sat
(assert (= host_line_sat (str.split_at headers_sat "\r\n" 0)))
(assert (= ua_line_sat   (str.split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat   (str.split_at headers_sat "\r\n" 2)))

; Each header line contains a colon delimiter and has at least 2 segments when split
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits ua_line_sat ":") 2))
(assert (>= (str.num_splits cl_line_sat ":") 2))

; Extract keys and values (value is everything after the first colon)
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= ua_key_sat (str.split_at ua_line_sat ":" 0)))
(assert (= ua_val_sat (str.split_rest ua_line_sat ":" 1)))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))

; Validate required keys
(assert (= host_key_sat "Host"))
(assert (= ua_key_sat "User-Agent"))
(assert (= cl_key_sat "Content-Length"))

; Ensure values are non-empty and do not contain CR/LF
(assert (> (str.len host_val_sat) 1))
(assert (> (str.len ua_val_sat) 1))
(assert (> (str.len cl_val_sat) 0))
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (not (str.contains ua_val_sat "\r")))
(assert (not (str.contains ua_val_sat "\n")))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))

; Content-Length value must be digits only (optionally with a leading space)
(assert (str.in_re cl_val_sat (re.union (re.++ (str.to_re " ") (re.+ (re.range "0" "9"))) (re.+ (re.range "0" "9")))))

; Tie Content-Length to an integer via a fixed, constrained example (keeps arithmetic linear)
(assert (= content_length_sat 42))
(assert (or (= cl_val_sat "42") (= cl_val_sat " 42")))

; Basic sanity constraint: content length non-negative and bounded
(assert (and (>= content_length_sat 0) (<= content_length_sat 1000000)))

; Make hdr_sat concrete enough to be satisfiable
(assert (= hdr_sat (str.++ "GET /index.html HTTP/1.1\r\n" host_line_sat "\r\n" ua_line_sat "\r\n" cl_line_sat "\r\n\r\n")))

(check-sat)

; =========================
; UNSAT instance: contradictory Content-Length parsing/validation
; =========================
(declare-const hdr_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)

(assert (>= (str.num_splits hdr_unsat "\r\n") 2))
(assert (= headers_unsat (str.split_rest hdr_unsat "\r\n" 1)))
(assert (= cl_line_unsat (str.split_at headers_unsat "\r\n" 0)))
(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Force a non-digit value but simultaneously require digits-only
(assert (= cl_val_unsat "abc"))
(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))

; Additionally constrain integer to be 0 and require it to correspond to nonzero string (extra inconsistency)
(assert (= content_length_unsat 0))
(assert (or (= cl_val_unsat "0") (= cl_val_unsat " 0")))

(check-sat)
(exit)

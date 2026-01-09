(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Some primitive string/integer variables for HTTP header parsing
(declare-const raw_headers String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const http_version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value_str String)
(declare-const content_length Int)

(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const body String)

; ----------------------------
; Common structural constraints (newline separated header lines)
; ----------------------------
(assert (>= (num_splits raw_headers "\r\n") 4))
(assert (= request_line (split_at raw_headers "\r\n" 0)))
(assert (= host_line    (split_at raw_headers "\r\n" 1)))
(assert (= cl_line      (split_at raw_headers "\r\n" 2)))
(assert (= ua_line      (split_at raw_headers "\r\n" 3)))

; A rough request-line decomposition using spaces
(assert (>= (num_splits request_line " ") 3))
(assert (= method       (split_at request_line " " 0)))
(assert (= path         (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" path))
(assert (str.prefixof "HTTP/" http_version))

; ----------------------------
; Header key-value parsing with colon delimiter
; ----------------------------
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key   (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (str.contains host_value "."))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key       (split_at cl_line ":" 0)))
(assert (= cl_value_str (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

(assert (>= (num_splits ua_line ":") 2))
(assert (= ua_key   (split_at ua_line ":" 0)))
(assert (= ua_value (split_rest ua_line ":" 1)))
(assert (= ua_key "User-Agent"))
(assert (>= (str.len ua_value) 1))
(assert (not (str.contains ua_value "\r")))
(assert (not (str.contains ua_value "\n")))

; ----------------------------
; Content-Length validation (two instances: one SAT, one UNSAT)
; We model two separate content-length interpretations over the same parsed string.
; ----------------------------
(declare-const content_length_sat Int)
(declare-const content_length_unsat Int)

; Shared numeric sanity constraints
(assert (>= content_length_sat 0))
(assert (>= content_length_unsat 0))

; SAT instance: body length matches declared length
(assert (= content_length_sat (str.len body)))
(assert (<= content_length_sat 1024))

; Tie the value string to some lightweight digit-only regex (allow leading spaces after colon)
; cl_value_str matches: optional spaces then one-or-more digits
(assert (str.in_re cl_value_str (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; An additional SAT-friendly relation to ensure non-empty body when Content-Length > 0
(assert (=> (> content_length_sat 0) (> (str.len body) 0)))

; UNSAT instance: simultaneously require body length to match and not match
(assert (= content_length_unsat (str.len body)))
(assert (not (= content_length_unsat (str.len body))))

; ----------------------------
; Extra well-formedness constraints to keep indices natural and segments meaningful
; ----------------------------
(assert (>= (str.len raw_headers) 1))
(assert (>= (str.len request_line) 1))
(assert (>= (str.len host_line) 1))
(assert (>= (str.len cl_line) 1))
(assert (>= (str.len ua_line) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
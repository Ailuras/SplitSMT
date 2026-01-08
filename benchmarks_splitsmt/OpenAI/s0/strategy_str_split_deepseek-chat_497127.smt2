(set-logic ALL)

; Uninterpreted interface functions for string split

; Core HTTP request/header inputs
(declare-const raw_request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const headers_only String)
(declare-const method String)
(declare-const uri String)
(declare-const version String)

; Specific header lines
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ct_line String)
(declare-const ua_line String)

; Header keys/values
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ct_key String)
(declare-const ct_value String)
(declare-const ua_key String)
(declare-const ua_value String)

; Body and content-length numeric value
(declare-const body String)
(declare-const content_length Int)

; Auxiliary integers for indices and counts
(declare-const n_lines Int)
(declare-const idx_host Int)
(declare-const idx_cl Int)
(declare-const idx_ct Int)
(declare-const idx_ua Int)

; === High-level HTTP message structure ===
; header_block = request_line + "\r\n" + headers_only
(assert (= header_block (str.split_at raw_request "\r\n\r\n" 0)))
(assert (= body (str.split_at raw_request "\r\n\r\n" 1)))
(assert (>= (str.num_splits raw_request "\r\n\r\n") 2))

(assert (= request_line (str.split_at header_block "\r\n" 0)))
(assert (= headers_only (str.split_rest header_block "\r\n" 1)))

; request_line = "METHOD URI VERSION" with spaces
(assert (= method (str.split_at request_line " " 0)))
(assert (= uri (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))
(assert (>= (str.num_splits request_line " ") 3))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; Some basic sanity properties
(assert (> (str.len method) 0))
(assert (> (str.len uri) 0))
(assert (str.prefixof "/" uri))

; === Header lines are split by CRLF ===
(assert (= n_lines (str.num_splits header_block "\r\n")))
(assert (>= n_lines 2))

; Choose positions for a few relevant header lines (within bounds)
(assert (>= idx_host 1))
(assert (>= idx_cl 1))
(assert (>= idx_ct 1))
(assert (>= idx_ua 1))
(assert (< idx_host n_lines))
(assert (< idx_cl n_lines))
(assert (< idx_ct n_lines))
(assert (< idx_ua n_lines))

; Bind concrete lines by index
(assert (= host_line (str.split_at header_block "\r\n" idx_host)))
(assert (= cl_line   (str.split_at header_block "\r\n" idx_cl)))
(assert (= ct_line   (str.split_at header_block "\r\n" idx_ct)))
(assert (= ua_line   (str.split_at header_block "\r\n" idx_ua)))

; Require they are distinct indices so lines can differ
(assert (distinct idx_host idx_cl idx_ct idx_ua))

; === Parse each header line as "Key: Value" using split ':' ===
; Host
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (>= (str.num_splits host_line ":") 2))

; Content-Length
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))
(assert (>= (str.num_splits cl_line ":") 2))

; Content-Type
(assert (= ct_key (str.split_at ct_line ":" 0)))
(assert (= ct_value (str.split_rest ct_line ":" 1)))
(assert (>= (str.num_splits ct_line ":") 2))

; User-Agent
(assert (= ua_key (str.split_at ua_line ":" 0)))
(assert (= ua_value (str.split_rest ua_line ":" 1)))
(assert (>= (str.num_splits ua_line ":") 2))

; === Header name validation (case-sensitive for simplicity) ===
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ct_key "Content-Type"))
(assert (= ua_key "User-Agent"))

; Values should be non-empty (after ':')
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))
(assert (> (str.len ct_value) 0))
(assert (> (str.len ua_value) 0))

; Content-Type must mention json or text as a simple validation
(assert (or (str.contains ct_value "json") (str.contains ct_value "text")))

; === Content-Length validation against body length ===
(assert (>= content_length 0))
(assert (= content_length (str.to_int cl_value)))

; SAT branch: well-formed numeric content-length equals body length
(declare-const sat_ok Bool)
(assert sat_ok)
(assert (= content_length (str.len body)))

; Additional consistency constraints
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))

; === UNSAT branch: contradictory constraint (kept separate by a guard) ===
(declare-const unsat_mode Bool)
; Force unsat_mode to false to keep overall instance SAT, but still include an UNSAT sub-instance pattern.
(assert (not unsat_mode))
; If unsat_mode were true, we'd require an impossible length mismatch.
(assert (=> unsat_mode (and (= content_length (str.len body)) (not (= content_length (str.len body))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; -------------------------------
; Scenario: HTTP Header Parsing
; -------------------------------

; A raw header block with CRLF-separated lines. We model parsing with split operations.
(declare-const header_block String)

; Request line and first few header lines (segments after splitting by "\r\n")
(declare-const request_line String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const connection_line String)
(declare-const remaining_lines String)

; Key/value parts after splitting header lines by ":"
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value_raw String)
(declare-const conn_key String)
(declare-const conn_value String)

; Interpreted numeric Content-Length (provided by downstream integer parser)
; We relate it via constraints rather than defining parsing.
(declare-const content_length Int)

; A body whose size must match Content-Length
(declare-const body String)

; Additional variables for alternative instances and UNSAT branch
(declare-const header_block_bad String)
(declare-const cl_line_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

; -------------------------------
; Basic well-formedness constraints
; -------------------------------

; There should be at least 4 lines: request, Host, Content-Length, Connection, ...
(assert (>= (num_splits header_block "\r\n") 4))

(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= content_length_line (split_at header_block "\r\n" 2)))
(assert (= connection_line (split_at header_block "\r\n" 3)))
(assert (= remaining_lines (split_rest header_block "\r\n" 4)))

; Request line resembles: "GET /path HTTP/1.1" (approximate via contains)
(assert (str.contains request_line "HTTP/1.1"))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ")))

; -------------------------------
; Parse Host header: "Host: example.com"
; -------------------------------
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
; Require non-empty host value and no CR/LF inside (approximate by excluding "\r" and "\n")
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; -------------------------------
; Parse Content-Length header: "Content-Length: 123"
; -------------------------------
(assert (>= (num_splits content_length_line ":") 2))
(assert (= cl_key (split_at content_length_line ":" 0)))
(assert (= cl_value_raw (split_rest content_length_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value constraints:
; - Must be digits (allow leading spaces by requiring it contains at least one digit and no non-digit letters)
;   We approximate digit-only by forbidding alphabetic characters.
(assert (str.contains cl_value_raw "0"))
(assert (not (str.contains cl_value_raw "a")))
(assert (not (str.contains cl_value_raw "b")))
(assert (not (str.contains cl_value_raw "c")))
(assert (not (str.contains cl_value_raw "d")))
(assert (not (str.contains cl_value_raw "e")))
(assert (not (str.contains cl_value_raw "f")))
(assert (not (str.contains cl_value_raw "g")))
(assert (not (str.contains cl_value_raw "h")))
(assert (not (str.contains cl_value_raw "i")))
(assert (not (str.contains cl_value_raw "j")))
(assert (not (str.contains cl_value_raw "k")))
(assert (not (str.contains cl_value_raw "l")))
(assert (not (str.contains cl_value_raw "m")))
(assert (not (str.contains cl_value_raw "n")))
(assert (not (str.contains cl_value_raw "o")))
(assert (not (str.contains cl_value_raw "p")))
(assert (not (str.contains cl_value_raw "q")))
(assert (not (str.contains cl_value_raw "r")))
(assert (not (str.contains cl_value_raw "s")))
(assert (not (str.contains cl_value_raw "t")))
(assert (not (str.contains cl_value_raw "u")))
(assert (not (str.contains cl_value_raw "v")))
(assert (not (str.contains cl_value_raw "w")))
(assert (not (str.contains cl_value_raw "x")))
(assert (not (str.contains cl_value_raw "y")))
(assert (not (str.contains cl_value_raw "z")))

; Numeric bounds on parsed content length
(assert (>= content_length 0))
(assert (<= content_length 1048576))

; Validate body length matches Content-Length
(assert (= (str.len body) content_length))

; -------------------------------
; Parse Connection header: "Connection: keep-alive" or "close"
; -------------------------------
(assert (>= (num_splits connection_line ":") 2))
(assert (= conn_key (split_at connection_line ":" 0)))
(assert (= conn_value (split_rest connection_line ":" 1)))
(assert (= conn_key "Connection"))
(assert (or (str.contains conn_value "keep-alive") (str.contains conn_value "close")))

; -------------------------------
; SAT instance: make a concrete-looking header block consistent with constraints
; -------------------------------
(assert (str.contains header_block "Host:"))
(assert (str.contains header_block "Content-Length:"))
(assert (str.contains header_block "Connection:"))
(assert (str.contains header_block "\r\n"))

; Link the concrete block roughly to the extracted lines
; We only constrain the extracted lines to contain the expected prefixes.
(assert (str.contains host_line "Host:"))
(assert (str.contains content_length_line "Content-Length:"))
(assert (str.contains connection_line "Connection:"))

; Choose a small body length to keep this satisfiable
(assert (= content_length 5))
(assert (= (str.len body) 5))

; -------------------------------
; UNSAT instance: contradictory Content-Length constraints on a separate block
; -------------------------------
(assert (>= (num_splits header_block_bad "\r\n") 3))
(assert (= cl_line_bad (split_at header_block_bad "\r\n" 1)))
(assert (>= (num_splits cl_line_bad ":") 2))
(assert (= cl_value_bad (split_rest cl_line_bad ":" 1)))

; Force an explicit numeric interpretation and a mismatch: length 4 but value says 3
(assert (= content_length_bad 3))
(assert (= (str.len body) 4))
(assert (= (str.len body) content_length_bad))

(check-sat)


; [GENERATION STATUS: SUCCESS]

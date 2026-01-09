(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-style booleans preserved/mutated
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; HTTP header parsing scenario variables
(declare-const var_0xINPUT_10301 String) ; raw HTTP request headers (and possibly request line)
(declare-const headers String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const content_length Int)

; Core structure from seed: T_1 denotes non-empty input
(assert (= T_1 (not (= "" var_0xINPUT_10301))))
; Mutated: require non-empty input (so T_1 is true)
(assert T_1)

; Extract header section before first blank line (CRLFCRLF)
(assert (= headers (split_at var_0xINPUT_10301 "\r\n\r\n" 0)))
(assert (>= (num_splits var_0xINPUT_10301 "\r\n\r\n") 1))

; Ensure there are multiple header lines
(assert (>= (num_splits headers "\r\n") 3))

; Host and Content-Length lines appear as specific header lines (modeling assumption)
(assert (= host_line (split_at headers "\r\n" 1)))
(assert (= cl_line (split_at headers "\r\n" 2)))

; Both lines must contain a colon delimiter for key-value parsing
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

; Keys are fixed for this scenario
(assert (= (split_at host_line ":" 0) "Host"))
(assert (= (split_at cl_line ":" 0) "Content-Length"))

; Values after the first ':' (may include leading spaces)
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_value (split_rest cl_line ":" 1)))

; Host value must be non-empty after trimming assumption: disallow empty or just a single space
(assert (not (= host_value "")))
(assert (not (= host_value " ")))

; Content-Length value constraints: at least one digit and no CR/LF embedded
(assert (not (= cl_value "")))
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))

; Numeric interpretation of content length
(assert (>= content_length 0))
; Bind a concrete parsed value for this instance
(assert (= content_length 42))

; Create both SAT and UNSAT instances via T_2: force an impossible relationship with content length
(assert (= T_2 (and (= cl_value "0") (= content_length 42))))
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]
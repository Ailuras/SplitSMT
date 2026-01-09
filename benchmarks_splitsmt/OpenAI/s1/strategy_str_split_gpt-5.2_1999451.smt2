(set-logic ALL)

; Uninterpreted interface for string split constraints

; HTTP Header Parsing scenario variables
(declare-const req String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const host_name String)
(declare-const cl_line String)
(declare-const cl_value String)
(declare-const body String)
(declare-const cl_int Int)
(declare-const X String)

; Preserve core structure from seed: keep the same regex-negated assertion but apply it to a header value placeholder X
(assert (not (str.in_re X
  (re.++
    (re.opt
      (re.++
        (re.opt
          (re.++
            (str.to_re "+")
            ((_ re.loop 1 1) (re.range "1" "9"))
            ((_ re.loop 0 3) (re.range "0" "9"))
          )
        )
        (re.opt
          (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))
        )
        (str.to_re "(")
        ((_ re.loop 1 1) (re.range "1" "9"))
        ((_ re.loop 0 3) (re.range "0" "9"))
        (str.to_re ")")
      )
    )
    (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
    ((_ re.loop 1 9) (re.range "0" "9"))
    (str.to_re "\u{a}")
  )
)))

; Basic request structure: request-line, headers, blank line, body
(assert (>= (str.num_splits req "\r\n\r\n") 2))
(assert (= headers (str.split_at req "\r\n\r\n" 0)))
(assert (= body (str.split_at req "\r\n\r\n" 1)))

; Header block: request-line then header lines
(assert (>= (str.num_splits headers "\r\n") 2))
(assert (= request_line (str.split_at headers "\r\n" 0)))

; Constrain request line to begin with method token and space (simple structural check)
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line " "))

; Find specific header lines by position (a common simplified parsing model)
(assert (= host_line (str.split_at headers "\r\n" 1)))
(assert (= cl_line (str.split_at headers "\r\n" 2)))

; Each of these must contain a colon separating key/value
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))

; Parse Host: value after first ':'
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_name (str.split_at host_line ":" 1)))

; Parse Content-Length: value after first ':'
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= cl_value (str.split_at cl_line ":" 1)))

; Relate X to the parsed content-length value to preserve seed structure around X
(assert (= X cl_value))

; Content-Length value should be digits possibly preceded by a single space
; Also ensure it does not contain CR/LF
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))
(assert (str.in_re cl_value (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Numeric interpretation constraints (modeling validated content-length)
(assert (>= cl_int 0))
(assert (<= cl_int 1000))
(assert (= (str.len body) cl_int))

; Additional header well-formedness: Host header key must mention Host
(assert (str.contains host_line "Host"))

; Create an UNSAT corner: content-length must match body length but also contradict via fixed body length
(assert (= (str.len body) 5))
(assert (= cl_int 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

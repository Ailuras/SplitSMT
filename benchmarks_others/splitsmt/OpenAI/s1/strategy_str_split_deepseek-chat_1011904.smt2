(set-logic ALL)

; Uninterpreted interface for string split (provided methodology)

; Seed variables (kept core structure)
(declare-const var_7 String)
(declare-const var_8 String)

; HTTP header parsing variables
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

; Keep the seed-style regex constraints (mutated but structurally similar)
(assert (str.in_re (str.++ var_7 "z" var_8)
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (re.union (str.to_re "b") (str.to_re "a"))
                          (re.union (str.to_re "z") (str.to_re "b")))))
    (re.union (str.to_re "b") (str.to_re "a")))))
(assert (str.in_re var_8 (re.* (re.range "a" "u"))))
(assert (str.in_re var_7 (re.* (re.range "a" "u"))))
(assert (not (str.in_re (str.++ var_7 "z" var_8 "b")
  (re.++
    (re.* (re.++ (str.to_re "a")
                 (re.++ (re.* (re.union (str.to_re "b") (str.to_re "a")))
                       (str.to_re "z"))))
    (re.++ (str.to_re "a")
          (re.* (re.union (str.to_re "b") (str.to_re "a"))))))))
(assert (<= 0 (str.len var_8)))

; HTTP request structure: request_line \n headers_block
(assert (= request_line (str.split_at request "\n" 0)))
(assert (= headers_block (str.split_rest request "\n" 1)))
(assert (>= (str.num_splits request "\n") 2))

; Require at least two header lines in headers_block
(assert (>= (str.num_splits headers_block "\n") 2))

; Extract two specific header lines (order-dependent parsing)
(assert (= host_line (str.split_at headers_block "\n" 0)))
(assert (= cl_line (str.split_at headers_block "\n" 1)))

; Split header lines on ':' into key/value
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_at host_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_at cl_line ":" 1)))

; Ensure each of these lines actually contains ':' (at least 2 segments)
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))

; Validate expected keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value must be non-empty and limited to typical hostname characters [a-z0-9.-]
(assert (> (str.len host_value) 0))
(assert (str.in_re host_value
  (re.++
    (re.* (re.union (re.range "a" "z")
                    (re.range "0" "9")
                    (str.to_re ".")
                    (str.to_re "-")))
    (re.* (re.union (re.range "a" "z")
                    (re.range "0" "9")
                    (str.to_re ".")
                    (str.to_re "-"))))))

; Content-Length value must be digits only
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Connect content_length with cl_value via a definitional constraint
; (No str.to_int in this scenario: use an uninterpreted parser)
(declare-fun parse_nat (String) Int)
(assert (= content_length (parse_nat cl_value)))
(assert (>= content_length 0))

; SAT-side: a weak consistency bound between content_length and request size
(assert (<= content_length (str.len request)))

; Also relate HTTP parsing with seed vars to preserve core structure but extend scenario
; Make request contain var_7 and var_8 in a harmless way
(assert (str.contains request (str.++ var_7 "z" var_8)))

; ----------------------------
; UNSAT block: contradictory constraints to create an UNSAT instance within same file
; Force content_length to be both 0 and >0
(assert (= content_length 0))
(assert (> content_length 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]

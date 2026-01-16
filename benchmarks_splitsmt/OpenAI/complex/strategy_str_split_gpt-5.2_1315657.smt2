(set-logic ALL)

; Uninterpreted interface for split operations

; Header parsing scenario variables
(declare-const raw_headers String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

; Preserve core structure: boolean guards about a key input string
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_143519 () String)
(assert (= T_1 (= "-" var_0xINPUT_143519)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_143519)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Basic shape: at least two header lines separated by CRLF
(assert (>= (str.num_splits raw_headers "\r\n") 2))
(assert (= host_line (str.split_at raw_headers "\r\n" 0)))
(assert (= content_length_line (str.split_at raw_headers "\r\n" 1)))

; Each line is a key-value pair separated by ": "
(assert (>= (str.num_splits host_line ": ") 2))
(assert (>= (str.num_splits content_length_line ": ") 2))
(assert (= host_key (str.split_at host_line ": " 0)))
(assert (= host_value (str.split_rest host_line ": " 1)))
(assert (= cl_key (str.split_at content_length_line ": " 0)))
(assert (= cl_value (str.split_rest content_length_line ": " 1)))

; Require exact keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value must be non-empty and contain no CR or LF
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Content-Length value must be non-empty and contain only digits
(assert (> (str.len cl_value) 0))
(assert (forall ((i Int))
  (=> (and (<= 0 i) (< i (str.len cl_value)))
      (str.in_re (str.at cl_value i) (re.range "0" "9")))))

; Bind an integer content_length and validate it consistently (relational, not full parsing)
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; Relate digit-count to magnitude (sound necessary conditions)
(assert (=> (= (str.len cl_value) 1) (<= content_length 9)))
(assert (=> (= (str.len cl_value) 2) (<= content_length 99)))
(assert (=> (= (str.len cl_value) 3) (<= content_length 999)))
(assert (=> (>= (str.len cl_value) 4) (>= content_length 1000)))

; Ensure the header block terminator is present (empty line after at least two lines)
(assert (>= (str.num_splits raw_headers "\r\n\r\n") 2))

; Tie the seed input to header content to keep mutation connected
(assert (str.contains raw_headers var_0xINPUT_143519))

; Additional consistency: Host line must begin with "Host" and include ": "
(assert (str.contains host_line ": "))
(assert (= (str.substr host_line 0 4) "Host"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

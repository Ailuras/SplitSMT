(set-logic ALL)

; Uninterpreted interface for string splitting (as provided)

; Seed variables preserved
(declare-fun I0_2 () Int)
(declare-fun I0_4 () Int)
(declare-fun I0_6 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun PCTEMP_LHS_3 () Int)
(declare-fun T0_2 () String)
(declare-fun T0_4 () String)
(declare-fun T0_6 () String)
(declare-fun T1_2 () String)
(declare-fun T1_4 () String)
(declare-fun T1_6 () String)
(declare-fun T2_2 () String)
(declare-fun T2_4 () String)
(declare-fun T2_6 () String)
(declare-fun T3_2 () String)
(declare-fun T3_4 () String)
(declare-fun T3_6 () String)
(declare-fun T4_2 () String)
(declare-fun T4_4 () String)
(declare-fun T4_6 () String)
(declare-fun T5_2 () String)
(declare-fun T5_4 () String)
(declare-fun T5_6 () String)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun T_SELECT_3 () Bool)
(declare-fun var_0xINPUT_107890 () String)

; New variables for HTTP header parsing
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const body String)
(declare-const content_length Int)
(declare-const digit_re RegLan)

; --- Core structure preserved: tri-branch selection constraints (mutated constants toward HTTP-ish tokens)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_2 0))
    (= var_0xINPUT_107890 (str.++ T0_2 T1_2))
    (= I0_2 (str.len T4_2))
    (= 0 (str.len T0_2))
    (= T1_2 (str.++ T2_2 T3_2))
    (= T2_2 (str.++ T4_2 T5_2))
    (= T5_2 "Host:")
    (not (str.in_re T4_2 (re.++ (str.to_re "H") (str.to_re "o") (str.to_re "s") (str.to_re "t") (str.to_re ":"))))
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= var_0xINPUT_107890 (str.++ T0_2 T1_2))
    (= 0 (str.len T0_2))
    (not (str.in_re T1_2 (re.++ (str.to_re "H") (str.to_re "o") (str.to_re "s") (str.to_re "t") (str.to_re ":"))))
  )
))

(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_2
  (and
    (= PCTEMP_LHS_2 (+ I0_4 0))
    (= var_0xINPUT_107890 (str.++ T0_4 T1_4))
    (= I0_4 (str.len T4_4))
    (= 0 (str.len T0_4))
    (= T1_4 (str.++ T2_4 T3_4))
    (= T2_4 (str.++ T4_4 T5_4))
    (= T5_4 "Content-Length:")
    (not (str.in_re T4_4 (re.++ (str.to_re "C") (str.to_re "o") (str.to_re "n") (str.to_re "t") (str.to_re "e") (str.to_re "n") (str.to_re "t") (str.to_re "-") (str.to_re "L") (str.to_re "e") (str.to_re "n") (str.to_re "g") (str.to_re "t") (str.to_re "h") (str.to_re ":"))))
  )
  (and
    (= PCTEMP_LHS_2 (- 1))
    (= var_0xINPUT_107890 (str.++ T0_4 T1_4))
    (= 0 (str.len T0_4))
    (not (str.in_re T1_4 (re.++ (str.to_re "C") (str.to_re "o") (str.to_re "n") (str.to_re "t") (str.to_re "e") (str.to_re "n") (str.to_re "t") (str.to_re "-") (str.to_re "L") (str.to_re "e") (str.to_re "n") (str.to_re "g") (str.to_re "t") (str.to_re "h") (str.to_re ":"))))
  )
))

(assert (= T_SELECT_3 (not (= PCTEMP_LHS_3 (- 1)))))
(assert (ite T_SELECT_3
  (and
    (= PCTEMP_LHS_3 (+ I0_6 0))
    (= var_0xINPUT_107890 (str.++ T0_6 T1_6))
    (= I0_6 (str.len T4_6))
    (= 0 (str.len T0_6))
    (= T1_6 (str.++ T2_6 T3_6))
    (= T2_6 (str.++ T4_6 T5_6))
    (= T5_6 "\r\n")
    (not (str.in_re T4_6 (str.to_re "\r\n")))
  )
  (and
    (= PCTEMP_LHS_3 (- 1))
    (= var_0xINPUT_107890 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (not (str.in_re T1_6 (str.to_re "\r\n")))
  )
))

; Seed boolean scaffolding (mutated to be consistent but still meaningful)
(assert (= T_4 (= "-" var_0xINPUT_107890)))
(assert (= T_5 (not T_4)))
(assert T_5)
(assert (= T_6 (= "" var_0xINPUT_107890)))
(assert (= T_7 (not T_6)))
(assert T_7)

; Change from seed: require the selection index to be valid (SAT-friendly)
(assert (= T_8 (< (- 1) PCTEMP_LHS_1)))
(assert T_8)

; --- HTTP Header Parsing scenario constraints
; The overall request is a request line + CRLF + headers + CRLFCRLF + body
(assert (= request (str.++ request_line "\r\n" headers "\r\n\r\n" body)))

; request_line must look like: "POST /upload HTTP/1.1"
(assert (str.prefixof "POST /" request_line))
(assert (str.contains request_line " HTTP/1.1"))

; There are at least 2 header lines separated by CRLF
(assert (>= (str.num_splits headers "\r\n") 2))
(assert (= host_line (str.split_at headers "\r\n" 0)))
(assert (= cl_line (str.split_at headers "\r\n" 1)))

; Parse key/value by colon delimiter
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_val (str.split_rest host_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_val (str.split_rest cl_line ":" 1)))

; Validate keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Trim model: require host_val begins with a space and then a non-empty domain
(assert (str.prefixof " " host_val))
(assert (> (str.len host_val) 1))
(assert (str.contains host_val "."))

; Content-Length value must be " <digits>" (space then digits)
(assert (str.prefixof " " cl_val))
(assert (= digit_re (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9"))))))))))))
(assert (str.in_re (str.substr cl_val 1 (- (str.len cl_val) 1)) (re.++ digit_re (re.* digit_re))))

; Bind content_length to a concrete, consistent value (simplified numeric parsing)
(assert (= content_length 5))
(assert (= (str.len body) content_length))

; Connect seed input to request to preserve core structure: input is entire request
(assert (= var_0xINPUT_107890 request))

; Create both SAT and UNSAT instances via a selector; here we force UNSAT branch off
(declare-const make_unsat Bool)
(assert (= make_unsat false))

; SAT branch: no extra contradiction
; UNSAT branch: demand both Content-Length=5 and body length != 5
(assert (ite make_unsat
  (and (= content_length 5) (not (= (str.len body) 5)))
  true))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)

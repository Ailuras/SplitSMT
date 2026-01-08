(set-logic ALL)

; Uninterpreted string-split interface for HTTP header parsing
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Seed variables preserved
(declare-fun I0_14 () Int)
(declare-fun I0_5 () Int)
(declare-fun I0_8 () Int)
(declare-fun I1_14 () Int)
(declare-fun I2_14 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun PCTEMP_LHS_3 () String)
(declare-fun T0_5 () String)
(declare-fun T0_8 () String)
(declare-fun T1_14 () String)
(declare-fun T1_5 () String)
(declare-fun T1_8 () String)
(declare-fun T2_14 () String)
(declare-fun T2_5 () String)
(declare-fun T2_8 () String)
(declare-fun T3_14 () String)
(declare-fun T3_5 () String)
(declare-fun T3_8 () String)
(declare-fun T4_5 () String)
(declare-fun T4_8 () String)
(declare-fun T5_5 () String)
(declare-fun T5_8 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Int)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun T_a () Int)
(declare-fun T_c () String)
(declare-fun T_d () Bool)
(declare-fun T_e () Bool)
(declare-fun var_0xINPUT_47772 () String)

; New HTTP-header specific variables
(declare-const header_blob String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const body String)
(declare-const cl_num Int)
(declare-const idx_colon Int)

; -----------------------------
; Mutated/extended constraints for HTTP Header Parsing
; -----------------------------

; Input is the full header blob (request-line + headers + blank line + body)
(assert (= var_0xINPUT_47772 header_blob))

; Must not be exactly "-" and must not be empty
(assert (= T_1 (= "-" var_0xINPUT_47772)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_47772)))
(assert (not T_3))

; Ensure at least 1 newline in the request
(assert (>= (num_splits header_blob "\n") 2))
(assert (= request_line (split_at header_blob "\n" 0)))

; Simple request-line shape: "GET " prefix and " HTTP/1.1" suffix
(assert (str.prefixof "GET " request_line))
(assert (str.suffixof " HTTP/1.1" request_line))

; Host and Content-Length are in subsequent lines
(assert (>= (num_splits header_blob "\n") 4))
(assert (= host_line (split_at header_blob "\n" 1)))
(assert (= cl_line (split_at header_blob "\n" 2)))

; Blank line delimiter exists: line 3 is empty, body is rest
(assert (= "" (split_at header_blob "\n" 3)))
(assert (= body (split_rest header_blob "\n" 4)))

; Parse "Host: value" and "Content-Length: digits"
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))

; Exact header keys (case-sensitive) and spacing after colon
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (str.prefixof " " host_value))
(assert (str.prefixof " " cl_value))

; Host value must contain a dot, and no newline
(assert (str.contains host_value "."))
(assert (not (str.contains host_value "\n")))

; Content-Length value after the leading space is all digits
(assert (str.in_re (str.substr cl_value 1 (- (str.len cl_value) 1)) (re.+ (re.range "0" "9"))))

; Convert Content-Length string to int (core arithmetic check)
(assert (= cl_num (str.to_int (str.substr cl_value 1 (- (str.len cl_value) 1)))))
(assert (>= cl_num 0))
(assert (= cl_num (str.len body)))

; -----------------------------
; Preserve some seed structure while repurposing for header parsing
; -----------------------------

; PCTEMP_LHS_1: index of first ':' in Content-Length line
(assert (= idx_colon (str.indexof cl_line ":" 0)))
(assert (= PCTEMP_LHS_1 idx_colon))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert T_SELECT_1)
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert T_5)

; PCTEMP_LHS_2: index of newline after Content-Length line within full blob
(assert (= PCTEMP_LHS_2 (str.indexof header_blob "\n" (+ (str.indexof header_blob cl_line 0) (str.len cl_line)))))
(assert (= T_7 (< PCTEMP_LHS_2 0)))
(assert (= T_8 (not T_7)))
(assert T_8)

; Keep arithmetic chain, but make it consistent and meaningful
(assert (= I1_14 (str.len header_blob)))
(assert (<= PCTEMP_LHS_2 I1_14))
(assert (= I2_14 I1_14))

; PCTEMP_LHS_3 is body, I0_14 its length
(assert (= PCTEMP_LHS_3 body))
(assert (= I0_14 (str.len PCTEMP_LHS_3)))

; Tie to original concatenation layout: header_blob = (prefix up to body) ++ body
(assert (= header_blob (str.++ T1_14 T2_14)))
(assert (= T2_14 (str.++ PCTEMP_LHS_3 T3_14)))
(assert (= T3_14 ""))
(assert (= T_a (str.len T1_14)))
(assert (>= T_a 0))
(assert (<= T_a I1_14))

; Make T_c derived from request_line and ensure it is not "-"
(assert (= T_c request_line))
(assert (= T_d (= "-" T_c)))
(assert (= T_e (not T_d)))
(assert T_e)

; -----------------------------
; Additional constraints for diversity and robustness
; -----------------------------

; No carriage returns, normalize to \n only
(assert (not (str.contains header_blob "\r")))

; Ensure headers contain the delimiter ':' at least once in each header line
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]

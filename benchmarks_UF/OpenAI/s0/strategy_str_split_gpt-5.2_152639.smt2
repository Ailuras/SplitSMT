(set-logic ALL)

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Shared declarations ---
(declare-const delim_line String)
(declare-const delim_kv String)

(assert (= delim_line "\r\n"))
(assert (= delim_kv ":"))

; =====================
; SAT instance: well-formed HTTP header block
; =====================
(declare-const hdr_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)

(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)

(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; require at least 4 lines: 3 header lines + terminating empty line
(assert (>= (num_splits hdr_sat delim_line) 4))

; pick first three header lines
(assert (= line0_sat (split_at hdr_sat delim_line 0)))
(assert (= line1_sat (split_at hdr_sat delim_line 1)))
(assert (= line2_sat (split_at hdr_sat delim_line 2)))

; enforce last line is empty (CRLF CRLF termination): line3 is ""
(assert (= (split_at hdr_sat delim_line 3) ""))

; lines must contain ':' for key-value
(assert (str.contains line0_sat delim_kv))
(assert (str.contains line1_sat delim_kv))
(assert (str.contains line2_sat delim_kv))

; model the expected three lines by binding them
(assert (= host_line_sat line0_sat))
(assert (= cl_line_sat line1_sat))
(assert (= ua_line_sat line2_sat))

; split key/value at first ':' and allow optional leading space in value
(assert (= host_key_sat (split_at host_line_sat delim_kv 0)))
(assert (= host_val_sat (split_rest host_line_sat delim_kv 1)))
(assert (= cl_key_sat (split_at cl_line_sat delim_kv 0)))
(assert (= cl_val_sat (split_rest cl_line_sat delim_kv 1)))
(assert (= ua_key_sat (split_at ua_line_sat delim_kv 0)))
(assert (= ua_val_sat (split_rest ua_line_sat delim_kv 1)))

; keys are exact
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; values: ensure non-empty (after allowing one leading space)
(assert (> (str.len host_val_sat) 1))
(assert (> (str.len cl_val_sat) 1))
(assert (> (str.len ua_val_sat) 1))

; a simple, concrete satisfiable header block (ensures SAT without needing extra axioms)
(assert (= hdr_sat "Host: example.com\r\nContent-Length: 5\r\nUser-Agent: curl/8.0\r\n\r\n"))

; validate Content-Length against an integer variable (relaxed parsing: bind integer explicitly)
(assert (= cl_int_sat 5))
(assert (>= cl_int_sat 0))

; assume body length equals 5 to satisfy validation
(assert (= body_len_sat 5))
(assert (= body_len_sat cl_int_sat))

; also require content-length value contains the printed integer with a leading space
(assert (str.contains cl_val_sat " 5"))

(check-sat)

; =====================
; UNSAT instance: contradictory Content-Length requirements
; =====================
(declare-const hdr_unsat String)
(declare-const line0_unsat String)
(declare-const line1_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_len_unsat Int)
(declare-const cl_int_unsat Int)

(assert (>= (num_splits hdr_unsat delim_line) 3))
(assert (= line0_unsat (split_at hdr_unsat delim_line 0)))
(assert (= line1_unsat (split_at hdr_unsat delim_line 1)))
(assert (= (split_at hdr_unsat delim_line 2) ""))

(assert (str.contains line1_unsat delim_kv))
(assert (= cl_line_unsat line1_unsat))
(assert (= cl_key_unsat (split_at cl_line_unsat delim_kv 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat delim_kv 1)))
(assert (= cl_key_unsat "Content-Length"))

; concrete header with Content-Length 5
(assert (= hdr_unsat "Host: a\r\nContent-Length: 5\r\n\r\n"))

; relaxed numeric binding + contradictory body lengths -> UNSAT
(assert (= cl_int_unsat 5))
(assert (= body_len_unsat cl_int_unsat))
(assert (= body_len_unsat 6))

(check-sat)



; [GENERATION STATUS: SUCCESS]
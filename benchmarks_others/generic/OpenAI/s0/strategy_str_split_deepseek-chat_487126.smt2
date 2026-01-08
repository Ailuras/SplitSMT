(set-logic ALL)

; Uninterpreted string-split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; Scenario: HTTP Header Parsing
; - Parse request line and headers separated by CRLF
; - Parse header key/value pairs separated by ": "
; - Validate Content-Length as decimal digits and consistent with body length
; - Include both SAT and UNSAT sub-instances
; =========================

; ----- Shared constants -----
(declare-const CRLF String)
(declare-const COLONSP String)
(assert (= CRLF "\r\n"))
(assert (= COLONSP ": "))

; =========================
; SAT instance: well-formed request with valid Content-Length
; =========================
(declare-const req_sat String)
(declare-const body_sat String)
(declare-const request_line_sat String)
(declare-const header1_sat String)
(declare-const header2_sat String)
(declare-const header3_sat String)
(declare-const headers_tail_sat String)
(declare-const blankline_sat String)

(declare-const h1_key_sat String)
(declare-const h1_val_sat String)
(declare-const h2_key_sat String)
(declare-const h2_val_sat String)
(declare-const h3_key_sat String)
(declare-const h3_val_sat String)

(declare-const cl_str_sat String)
(declare-const body_len_sat Int)
(declare-const cl_num_sat Int)

; Structure: request-line, headers..., blank line, body
(assert (>= (num_splits req_sat CRLF) 6))
(assert (= request_line_sat (split_at req_sat CRLF 0)))
(assert (= header1_sat (split_at req_sat CRLF 1)))
(assert (= header2_sat (split_at req_sat CRLF 2)))
(assert (= header3_sat (split_at req_sat CRLF 3)))
(assert (= blankline_sat (split_at req_sat CRLF 4)))
(assert (= headers_tail_sat (split_rest req_sat CRLF 5)))
(assert (= blankline_sat ""))
(assert (= body_sat headers_tail_sat))

; Request line: "POST /submit HTTP/1.1"
(assert (= request_line_sat "POST /submit HTTP/1.1"))

; Header 1: Host
(assert (>= (num_splits header1_sat COLONSP) 2))
(assert (= h1_key_sat (split_at header1_sat COLONSP 0)))
(assert (= h1_val_sat (split_rest header1_sat COLONSP 1)))
(assert (= h1_key_sat "Host"))
(assert (= h1_val_sat "example.com"))

; Header 2: Content-Length
(assert (>= (num_splits header2_sat COLONSP) 2))
(assert (= h2_key_sat (split_at header2_sat COLONSP 0)))
(assert (= h2_val_sat (split_rest header2_sat COLONSP 1)))
(assert (= h2_key_sat "Content-Length"))
(assert (= cl_str_sat h2_val_sat))

; Header 3: Content-Type
(assert (>= (num_splits header3_sat COLONSP) 2))
(assert (= h3_key_sat (split_at header3_sat COLONSP 0)))
(assert (= h3_val_sat (split_rest header3_sat COLONSP 1)))
(assert (= h3_key_sat "Content-Type"))
(assert (= h3_val_sat "application/x-www-form-urlencoded"))

; Content-Length validation (SAT): constrain to a fixed decimal and body length consistent
(assert (= cl_str_sat "11"))
(assert (= body_sat "hello=world"))
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat 11))

; Numeric parse link (kept simple and consistent)
(assert (= cl_num_sat 11))
(assert (= cl_num_sat body_len_sat))

; Extra sanity: header lines must contain ": "
(assert (str.contains header1_sat COLONSP))
(assert (str.contains header2_sat COLONSP))
(assert (str.contains header3_sat COLONSP))

(check-sat)

; =========================
; UNSAT instance: contradictory Content-Length and body length
; =========================
(declare-const req_unsat String)
(declare-const body_unsat String)
(declare-const request_line_unsat String)
(declare-const headerA_unsat String)
(declare-const headerB_unsat String)
(declare-const blankline_unsat String)
(declare-const tail_unsat String)

(declare-const hA_key_unsat String)
(declare-const hA_val_unsat String)
(declare-const hB_key_unsat String)
(declare-const hB_val_unsat String)

(declare-const cl_str_unsat String)
(declare-const body_len_unsat Int)
(declare-const cl_num_unsat Int)

; Structure with fewer headers: request-line, two headers, blank line, body
(assert (>= (num_splits req_unsat CRLF) 5))
(assert (= request_line_unsat (split_at req_unsat CRLF 0)))
(assert (= headerA_unsat (split_at req_unsat CRLF 1)))
(assert (= headerB_unsat (split_at req_unsat CRLF 2)))
(assert (= blankline_unsat (split_at req_unsat CRLF 3)))
(assert (= blankline_unsat ""))
(assert (= tail_unsat (split_rest req_unsat CRLF 4)))
(assert (= body_unsat tail_unsat))

(assert (= request_line_unsat "POST /upload HTTP/1.1"))

; HeaderA: Content-Length
(assert (>= (num_splits headerA_unsat COLONSP) 2))
(assert (= hA_key_unsat (split_at headerA_unsat COLONSP 0)))
(assert (= hA_val_unsat (split_rest headerA_unsat COLONSP 1)))
(assert (= hA_key_unsat "Content-Length"))
(assert (= cl_str_unsat hA_val_unsat))

; HeaderB: Connection
(assert (>= (num_splits headerB_unsat COLONSP) 2))
(assert (= hB_key_unsat (split_at headerB_unsat COLONSP 0)))
(assert (= hB_val_unsat (split_rest headerB_unsat COLONSP 1)))
(assert (= hB_key_unsat "Connection"))
(assert (= hB_val_unsat "close"))

; Content-Length digits constraint (still allows digits)
(assert (str.in_re cl_str_unsat (re.+ (re.range "0" "9"))))

; Force a concrete mismatch: length says 4 but body is length 3
(assert (= cl_str_unsat "4"))
(assert (= cl_num_unsat 4))
(assert (= body_unsat "abc"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat 3))
(assert (= cl_num_unsat body_len_unsat))

(check-sat)



; [GENERATION STATUS: SUCCESS]

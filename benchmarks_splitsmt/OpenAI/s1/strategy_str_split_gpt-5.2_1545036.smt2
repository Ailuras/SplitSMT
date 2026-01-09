(set-logic ALL)

; Uninterpreted interface for string splitting

; Input HTTP request (headers section)
(declare-const req String)

; Extracted header lines (split by LF)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

; Header names and values (split by ":")
(declare-const host_name String)
(declare-const host_val String)
(declare-const cl_name String)
(declare-const cl_val String)

; A numeric content-length parsed elsewhere
(declare-const content_len Int)

; Preserve core structure: a regex-based disequality over in_re, now applied to req
(assert (let ((_let_0 (re.* re.allchar)))
  (not (= (str.in_re req (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" (str.++ "B" "A"))) _let_0 (str.to_re "A") _let_0))
          (str.in_re req (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" "B")) _let_0 (str.to_re (str.++ "A" "A")) _let_0))))))

; HTTP header parsing: split request into lines by "\n"
(assert (= line0 (str.split_at req "\n" 0)))
(assert (= line1 (str.split_at req "\n" 1)))
(assert (= line2 (str.split_at req "\n" 2)))
(assert (= line3 (str.split_at req "\n" 3)))
(assert (>= (str.num_splits req "\n") 4))

; Basic structure constraints for header lines
(assert (str.contains line1 ":"))
(assert (str.contains line2 ":"))
(assert (not (str.contains line3 ":")))

; Parse Host header: "Host: <value>"
(assert (= host_name (str.split_at line1 ":" 0)))
(assert (= host_val (str.split_rest line1 ":" 1)))
(assert (= host_name "Host"))
(assert (> (str.len host_val) 0))
(assert (not (str.contains host_val "\n")))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_name (str.split_at line2 ":" 0)))
(assert (= cl_val (str.split_rest line2 ":" 1)))
(assert (= cl_name "Content-Length"))

; cl_val must contain at least one digit somewhere
(assert (str.in_re cl_val (re.++ (re.* re.allchar) (re.range "0" "9") (re.* re.allchar))))

; Trim-like restriction: forbid spaces in cl_val to simplify numeric validation
(assert (not (str.contains cl_val " ")))

; content_len matches cl_val exactly, but also enforce an impossible extra condition to make this UNSAT
(assert (= cl_val (str.from_int content_len)))
(assert (>= content_len 0))

; Intentional contradiction for diversity (UNSAT instance):
; If cl_val equals from_int(content_len) and content_len>=0, then cl_val cannot be empty.
; Force empty anyway.
(assert (= cl_val ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

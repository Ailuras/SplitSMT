(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split constraints

; Core seed variables (kept/mutated)
(declare-const x1 String)
(declare-const x2 String)
(declare-const x3 String)

; HTTP header parsing variables
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const header1 String)
(declare-const header2 String)
(declare-const key1 String)
(declare-const val1 String)
(declare-const key2 String)
(declare-const val2 String)
(declare-const content_length_val String)
(declare-const host_val String)
(declare-const body String)
(declare-const n Int)

; Preserve core structure but adapt literals to HTTP-ish markers
(assert
  (= (str.++ (str.++ (str.++ x1 "\r\n") x2) (str.++ x3 "\r\n"))
     (str.++ (str.++ (str.++ x2 ":") x1) (str.++ ":" x3))))

; Keep a large-length style constraint but change threshold slightly
(assert (> (str.len x2) 32010))

; Request is request-line + CRLF + headers + CRLFCRLF + body
(assert (= req (str.++ (str.++ (str.++ request_line "\r\n") headers_block) "\r\n\r\n")))
(assert (= req (str.++ req body)))

; Parse first line and the rest using CRLF
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= headers_block (split_rest req "\r\n" 1)))
(assert (>= (num_splits req "\r\n") 3))

; Two header lines in the headers block
(assert (= header1 (split_at headers_block "\r\n" 0)))
(assert (= header2 (split_at headers_block "\r\n" 1)))
(assert (>= (num_splits headers_block "\r\n") 2))

; Each header line is key ":" value
(assert (= key1 (split_at header1 ":" 0)))
(assert (= val1 (split_rest header1 ":" 1)))
(assert (>= (num_splits header1 ":") 2))

(assert (= key2 (split_at header2 ":" 0)))
(assert (= val2 (split_rest header2 ":" 1)))
(assert (>= (num_splits header2 ":") 2))

; Relate to standard headers
(assert (or (= key1 "Content-Length") (= key2 "Content-Length")))
(assert (or (= key1 "Host") (= key2 "Host")))
(assert (distinct key1 key2))

; Select parsed values
(assert (= content_length_val (ite (= key1 "Content-Length") val1 val2)))
(assert (= host_val (ite (= key1 "Host") val1 val2)))

; Basic validity constraints
(assert (not (str.contains key1 "\r")))
(assert (not (str.contains key1 "\n")))
(assert (not (str.contains key2 "\r")))
(assert (not (str.contains key2 "\n")))

; Content-Length must be digits only (allow leading/trailing spaces handled by permitting spaces, but require at least one digit)
(assert (str.in_re content_length_val (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")) (re.* (str.to_re " ")))))

; Convert Content-Length to integer n using a custom convention: n is the length of body.
; This captures "validate content-length" without needing a string-to-int primitive.
(assert (>= n 0))
(assert (= n (str.len body)))

; SAT sub-constraints: ensure body is non-empty and host contains a dot
(assert (> (str.len body) 0))
(assert (str.contains host_val "."))

; UNSAT twist: contradict body length vs fixed body
(assert (= body "ABC"))
(assert (= n 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

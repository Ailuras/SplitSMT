(set-logic ALL)

; === Uninterpreted interface for string split ===
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; === Scenario: HTTP Header Parsing ===
; We model a request header block, split by CRLF, then split each header line by ": ".
; We validate that Content-Length is numeric and matches a body length.

(declare-const request String)
(declare-const headers String)
(declare-const body String)

(declare-const crlf String)
(declare-const sep String)

(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

(declare-const key1 String)
(declare-const val1 String)
(declare-const key2 String)
(declare-const val2 String)
(declare-const key3 String)
(declare-const val3 String)

(declare-const cl_str String)
(declare-const host String)
(declare-const ua String)

(declare-const cl Int)

; === Delimiters ===
(assert (= crlf "\r\n"))
(assert (= sep ": "))

; === Basic request shape ===
; request = headers + CRLF + CRLF + body
(assert (= request (str.++ headers crlf crlf body)))

; headers has at least 4 lines: request-line + 3 header lines
(assert (>= (num_splits headers crlf) 4))

; Extract first four lines
(assert (= line0 (split_at headers crlf 0)))
(assert (= line1 (split_at headers crlf 1)))
(assert (= line2 (split_at headers crlf 2)))
(assert (= line3 (split_at headers crlf 3)))

; Request line must look like: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re line0 (re.++ (str.to_re "GET") (str.to_re " ") (re.+ (re.union (str.to_re "/") (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_") (str.to_re "."))) (str.to_re " HTTP/1.1"))))

; Each header line must contain ": " and have non-empty key/value
(assert (>= (num_splits line1 sep) 2))
(assert (>= (num_splits line2 sep) 2))
(assert (>= (num_splits line3 sep) 2))

(assert (= key1 (split_at line1 sep 0)))
(assert (= val1 (split_rest line1 sep 1)))
(assert (= key2 (split_at line2 sep 0)))
(assert (= val2 (split_rest line2 sep 1)))
(assert (= key3 (split_at line3 sep 0)))
(assert (= val3 (split_rest line3 sep 1)))

(assert (> (str.len key1) 0))
(assert (> (str.len val1) 0))
(assert (> (str.len key2) 0))
(assert (> (str.len val2) 0))
(assert (> (str.len key3) 0))
(assert (> (str.len val3) 0))

; Constrain header keys to typical token characters (simplified)
(assert (str.in_re key1 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))
(assert (str.in_re key2 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))
(assert (str.in_re key3 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))

; Force presence of specific headers among the 3 lines
; Host
(assert (or (= key1 "Host") (= key2 "Host") (= key3 "Host")))
(assert (= host (ite (= key1 "Host") val1 (ite (= key2 "Host") val2 val3))))
(assert (str.in_re host (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "."))) (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") )))))))

; User-Agent (simplified: non-empty printable without CR/LF)
(assert (or (= key1 "User-Agent") (= key2 "User-Agent") (= key3 "User-Agent")))
(assert (= ua (ite (= key1 "User-Agent") val1 (ite (= key2 "User-Agent") val2 val3))))
(assert (str.in_re ua (re.+ (re.union (re.range " " "~")))))

; Content-Length
(assert (or (= key1 "Content-Length") (= key2 "Content-Length") (= key3 "Content-Length")))
(assert (= cl_str (ite (= key1 "Content-Length") val1 (ite (= key2 "Content-Length") val2 val3))))

; Content-Length must be digits only, and at least one digit
(assert (str.in_re cl_str (re.+ (re.range "0" "9"))))

; Interpret cl as integer via str.to_int; require it is not -1
(assert (= cl (str.to_int cl_str)))
(assert (>= cl 0))

; Validate content-length against actual body length
(assert (= (str.len body) cl))

; Additional constraints: body is arbitrary bytes but no CRLF to keep header/body split unambiguous here
(assert (not (str.contains body crlf)))

; === SAT instance: a consistent request exists ===
(push)
(assert (>= (str.len body) 0))
(check-sat)
(pop)

; === UNSAT instance: contradict content-length vs body length ===
(push)
; Force a concrete body of length 5
(assert (= body "ABCDE"))
; Force content-length to be 4 at the same time
(assert (= cl_str "4"))
(check-sat)
(pop)



; [GENERATION STATUS: SUCCESS]
(check-sat)
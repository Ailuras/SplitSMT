; ; SMT-LIB2 file for URL Parsing with protocol, host, and path extraction
; Using split operations and delimiters: '://', '/', ':', '?', '&'

(set-logic ALL)
(set-option :produce-models true)

; Declare the URL string variable
(declare-fun url () String)

; ; Declare string variables for extracted components
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun port () String)
(declare-fun path_full () String)
(declare-fun path_segment1 () String)
(declare-fun path_segment2 () String)
(declare-fun query_string () String)

; Split at '://': protocol is the part before, rest is after
(assert (= protocol (str.split_at url "://" 0)))
(assert (= (str.++ protocol "://" (str.split_rest url "://" 1)) url))

; Host and path: host is the first segment after '://', rest is path/query
(assert (= host (str.split_at (str.split_rest url "://" 1) "/" 0)))
(assert (= (str.++ host (str.split_rest (str.split_rest url "://" 1) "/" 1)) (str.split_rest url "://" 1)))

; Full path and query: everything after the host, starting with '/', may be empty
(assert (= path_full (str.split_rest (str.split_rest url "://" 1) "/" 1)))

; Path segments: split path_full by '/', get up to two segments for demonstration
(assert (= path_segment1 (str.split_at path_full "/" 1))) ; first segment after leading '/'
(assert (= path_segment2 (str.split_at path_full "/" 2))) ; second segment after leading '/'

; Query string: if exists, after '?'
(assert (= query_string (str.split_rest path_full "?" 1)))

; ; Port extraction: if present, after ':' in host
(assert (= port (str.split_at host ":" 1)))

; ; Satisfiable example: a valid HTTP URL with host and path
; ; URL: "http://example.com:8080/foo/bar?x=1&y=2"
(assert (= url "http://example.com:8080/foo/bar?x=1&y=2"))

; Protocol validation: Must be "http" or "https"
(assert (or (= protocol "http") (= protocol "https")))

; ; Host structure: host must start with "example" and contain ".com"
(assert (str.prefixof "example" host))
(assert (str.contains host ".com"))

; Path segments: path_segment1 = "foo", path_segment2 = "bar"
(assert (= path_segment1 "foo"))
(assert (= path_segment2 "bar"))

; Port value: must be "8080"
(assert (= port "8080"))

; Query string: must be "?x=1&y=2"
(assert (= query_string "?x=1&y=2"))

; Unsatisfiable constraints: host must also start with "testsite" simultaneously (conflict)
(assert (str.prefixof "testsite" host))

(check-sat)
(exit)
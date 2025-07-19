; SMT-LIB2 file for URL Parsing using split operations
; Focus: protocol validation, host structure, path segments
; Delimiters: '://', '/', ':', '?', '&'

(set-logic ALL)

; Declare the input URL string
(declare-fun url () String)

; ; Protocol extraction: protocol is substring before '://'
(define-fun protocol () String (str.split_at url "://" 0))

; The rest after '://', i.e., authority + path + query
(define-fun after_protocol () String (str.split_rest url "://" 1))

; ; Host extraction: the first segment after '://', before the next '/'
(define-fun host_and_rest () String (str.split_at after_protocol "/" 0))
(define-fun rest_after_host () String (str.split_rest after_protocol "/" 1))

; Host may contain port (host:port), so split at ':'
(define-fun host () String (str.split_at host_and_rest ":" 0))
(define-fun port () String (str.split_rest host_and_rest ":" 1))

; ; Path extraction: path is everything after the first '/', before '?'
(define-fun path_and_query () String rest_after_host)
(define-fun path () String (str.split_at path_and_query "?" 0))
(define-fun query () String (str.split_rest path_and_query "?" 1))

; Path segments: split path by '/'
(define-fun path_segment_0 () String (str.split_at path "/" 0))
(define-fun path_segment_1 () String (str.split_at path "/" 1))
(define-fun path_segment_2 () String (str.split_at path "/" 2))

; Satisfiable scenario: Valid HTTP URL with two path segments, port present, query parameters
(assert (= url "http://example.com:8080/dir1/dir2?key=value&foo=bar"))

; Protocol validation: only allow 'http' or 'https'
(assert (or (= protocol "http") (= protocol "https")))

; Host structure: host must contain '.', and must not be empty
(assert (str.contains host "."))
(assert (not (= host "")))

; Path segment constraints: first segment should be 'dir1', second 'dir2'
(assert (= path_segment_0 "")) ; due to leading '/', first segment is empty
(assert (= path_segment_1 "dir1"))
(assert (= path_segment_2 "dir2"))

; Query string constraints: must contain '&'
(assert (str.contains query "&"))

(check-sat)

; Unsatisfiable scenario: protocol is not http/https, but host appears valid
(push)
(assert (= url "ftp://example.org/home"))
(assert (not (or (= protocol "http") (= protocol "https"))))
(assert (str.contains host "."))
(check-sat)
(pop)

; Unsatisfiable scenario: host missing dot, but protocol is valid
(push)
(assert (= url "https://localhost/path"))
(assert (= protocol "https"))
(assert (not (str.contains host ".")))
(check-sat)
(pop)

(exit)
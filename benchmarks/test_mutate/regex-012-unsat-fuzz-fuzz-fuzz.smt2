; SMT-LIB2 file for URL Parsing using custom split operations
; Focus: protocol validation, host structure, path segments

(set-logic ALL)

; Declare the input URL string
(declare-fun url () String)

; Delimiters
(define-fun delim_proto () String "://")
(define-fun delim_slash () String "/")
(define-fun delim_colon () String ":")
(define-fun delim_qmark () String "?")
(define-fun delim_amp () String "&")

; ; Extract protocol as the 0th segment when splitting by "://"
(define-fun protocol () String (str.split_at url delim_proto 0))

; ; Extract the rest after protocol (should be host + optional port + path + query)
(define-fun rest_proto () String (str.split_rest url delim_proto 1))

; ; Extract host: it's the 0th segment of rest_proto split by "/"
(define-fun hostport () String (str.split_at rest_proto delim_slash 0))

; The path and beyond is everything from the first "/" onward in rest_proto
(define-fun path_and_query () String (str.split_rest rest_proto delim_slash 1))

; Host and optional port: split hostport by ":" (host:port)
(define-fun host () String (str.split_at hostport delim_colon 0))
(define-fun port () String (str.split_at hostport delim_colon 1))
(define-fun num_hostport_colon () Int (str.num_splits hostport delim_colon))

; Path: split path_and_query by "?" to separate path and query
(define-fun path_raw () String (str.split_at path_and_query delim_qmark 0))
(define-fun query () String (str.split_at path_and_query delim_qmark 1))
(define-fun num_pathquery_qmark () Int (str.num_splits path_and_query delim_qmark))

; Path segments: split path_raw by "/"
(define-fun path_segment0 () String (str.split_at path_raw delim_slash 0))
(define-fun path_segment1 () String (str.split_at path_raw delim_slash 1))
(define-fun path_segment2 () String (str.split_at path_raw delim_slash 2))
(define-fun num_path_segments () Int (str.num_splits path_raw delim_slash))

; ; Example 1: Satisfiable case
; ; URL: "https://example.com:8080/api/v1/resource?user=alice&debug=true"
(assert (= url "https://example.com:8080/api/v1/resource?user=alice&debug=true"))
; Protocol must be "https"
(assert (= protocol "https"))
; ; Host must be "example.com"
(assert (= host "example.com"))
; Port must be "8080"
(assert (= num_hostport_colon 2))
(assert (= port "8080"))
; At least 3 path segments: ["", "api", "v1", "resource"] (the leading "" due to leading slash)
(assert (>= num_path_segments 4))
; The first path segment after empty should be "api"
(assert (= path_segment1 "api"))
; The second path segment should be "v1"
(assert (= path_segment2 "v1"))

(check-sat)

; Unsatisfiable case
(push)
; URL disagrees with protocol constraint
(assert (not (= protocol "https")))
(check-sat)
(pop)

(push)
; ; Host structure is broken: force host to be "example.org" which is not in the given URL
(assert (= host "example.org"))
(check-sat)
(pop)

(push)
; Path segment constraint unsatisfiable: require more segments than exist
(assert (>= num_path_segments 10))
(check-sat)
(pop)

(exit)
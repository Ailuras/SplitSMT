; SMT-LIB2 file for URL Parsing using split operations
(set-logic QF_SLIA)
; Declare URL string variable
(declare-fun url () String)

; Delimiters used in URL parsing
(define-fun delim_scheme () String "://")
(define-fun delim_slash () String "/")
(define-fun delim_colon () String ":")
(define-fun delim_query () String "?")
(define-fun delim_amp () String "&")

; ; Split to extract protocol (scheme)
(define-fun protocol () String (str.split_at url delim_scheme 0))
; The rest after protocol delimiter
(define-fun after_scheme () String (str.split_rest url delim_scheme 1))

; ; Split to extract host (could include port)
(define-fun host_and_path () String (str.split_at after_scheme delim_slash 0))
(define-fun path_and_query () String (str.split_rest after_scheme delim_slash 1))

; Host may have port separated by ':'
(define-fun host () String (str.split_at host_and_path delim_colon 0))
(define-fun port () String (str.split_at host_and_path delim_colon 1))

; Path segments
(define-fun first_path_segment () String (str.split_at path_and_query delim_slash 0))
(define-fun second_path_segment () String (str.split_at path_and_query delim_slash 1))

; Number of path segments (useful for validation)
(define-fun num_path_segments () Int (str.num_splits path_and_query delim_slash))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Satisfiable scenario: a valid HTTP URL with path segments

; ; Example: "http://example.com:8080/foo/bar"
(assert (= url "http://example.com:8080/foo/bar"))

; Protocol should be "http"
(assert (= protocol "http"))

; ; Host should be "example.com"
(assert (= host "example.com"))

; Port should be "8080"
(assert (= port "8080"))

; The first path segment should be "foo"
(assert (= first_path_segment "foo"))

; The second path segment should be "bar"
(assert (= second_path_segment "bar"))

; There should be exactly 2 path segments after the host
(assert (= num_path_segments 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Unsatisfiable scenario: protocol must be "https" but actual is "http"

(assert (= protocol "https"))
; This should be UNSAT because protocol is "http" above but we now require "https"
(check-sat)







(exit)
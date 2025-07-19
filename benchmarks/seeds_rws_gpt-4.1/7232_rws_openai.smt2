; SMT-LIB2 file for URL Parsing using split operations
; Focus: protocol validation, host structure, path segments

(set-logic ALL)

; Declare URL string variable
(declare-fun url () String)

; Declare variables for protocol, host, port, path, and query
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query () String)

; Split at '://': protocol is before, rest is after
(assert (= protocol (str.split_at url "://" 0)))
(assert (= (str.substr url 0 (str.len protocol)) protocol)) ; protocol is prefix

; The rest after '://' is at index 1
(declare-fun after_protocol () String)
(assert (= after_protocol (str.split_rest url "://" 1)))

; Split after_protocol at first '/' to get host and the rest (path + query)
(assert (= host (str.split_at after_protocol "/" 0)))
(declare-fun after_host () String)
(assert (= after_host (str.split_rest after_protocol "/" 1)))

; Path is the segment after the first '/', without query
(assert (= path (str.split_at after_host "?" 0)))
(assert (= query (str.split_rest after_host "?" 1)))

; --- Protocol validation: must be "http" or "https" ---
(assert (or (= protocol "http") (= protocol "https")))

; --- Host structure: host contains no '/' or '?' ---
(assert (= (str.indexof host "/" 0) (- 1)))
(assert (= (str.indexof host "?" 0) (- 1)))

; Host may contain a port, separated by ':'
(declare-fun hostname () String)
(declare-fun port () String)
(assert (= hostname (str.split_at host ":" 0)))
(assert (= port (str.split_at host ":" 1)))

; Hostname must not be empty
(assert (not (= hostname "")))

; --- Path segments: path split by '/' ---
(declare-fun path_segment0 () String)
(declare-fun path_segment1 () String)
(declare-fun num_path_segments () Int)

(assert (= num_path_segments (str.num_splits path "/")))
(assert (>= num_path_segments 1))

(assert (= path_segment0 (str.split_at path "/" 0)))
(assert (= path_segment1 (str.split_at path "/" 1)))

; Path segments must not be empty (for first two segments)
(assert (not (= path_segment0 "")))
(assert (not (= path_segment1 "")))

; --- Query parameters: split by '&' ---
(declare-fun query_param0 () String)
(declare-fun query_param1 () String)
(declare-fun num_query_params () Int)

(assert (= num_query_params (str.num_splits query "&")))
(assert (>= num_query_params 1))

(assert (= query_param0 (str.split_at query "&" 0)))
(assert (= query_param1 (str.split_at query "&" 1)))

; Query params must contain '='
(assert (not (= (str.indexof query_param0 "=" 0) (- 1))))
(assert (not (= (str.indexof query_param1 "=" 0) (- 1))))

; --- Satisfiable scenario ---
; ; Example: "https://www.example.com:8080/path/to/resource?user=alice&mode=edit"
(assert (= protocol "https"))
(assert (= hostname "www.example.com"))
(assert (= port "8080"))
(assert (= path_segment0 "path"))
(assert (= path_segment1 "to"))
(assert (= query_param0 "user=alice"))
(assert (= query_param1 "mode=edit"))

; --- Unsatisfiable scenario ---
; Path segment1 must be both "to" and "admin" (contradiction)
(assert (= path_segment1 "admin"))

(check-sat)
(exit)
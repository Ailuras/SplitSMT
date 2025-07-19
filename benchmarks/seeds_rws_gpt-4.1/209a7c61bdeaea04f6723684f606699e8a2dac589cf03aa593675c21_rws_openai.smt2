; SMT-LIB2 file for URL Parsing using custom split operations
(set-logic QF_SLIA)

; Declare the input URL string
(declare-fun url () String)

; ; Declare variables for extracted protocol, host, and path
(declare-fun proto () String)
(declare-fun host () String)
(declare-fun path () String)

; Declare variables for intermediate splits
(declare-fun after_proto () String)
(declare-fun after_host () String)

; ; Extract the protocol: proto = str.split_at(url, "://", 0)
(assert (= proto (str.split_at url "://" 0)))

; ; Extract the rest of the URL after protocol: after_proto = str.split_rest(url, "://", 1)
(assert (= after_proto (str.split_rest url "://" 1)))

; ; Extract the host: host = str.split_at(after_proto, "/", 0)
(assert (= host (str.split_at after_proto "/" 0)))

; ; Extract the path and beyond: path = str.split_rest(after_proto, "/", 1)
(assert (= path (str.split_rest after_proto "/" 1)))

; ; Example 1: Satisfiable constraints - URL with valid protocol, host, and path structure

; Protocol validation: proto must be either "http" or "https"
(assert (or (= proto "http") (= proto "https")))

; Host should contain at least one dot but no colon (port not specified)
(assert (str.contains host "."))
(assert (not (str.contains host ":")))

; Path should start with "/" if not empty
(assert (or (= path "") (= (str.at path 0) "/")))

; Number of splits by "/" in path should be at least 1 (i.e., at least one path segment if not empty)
(assert (=> (not (= path "")) (>= (str.num_splits path "/") 1)))

; For demonstration, let's assert a concrete example is possible
(assert (= url "https://www.example.com/home/index.html"))

; ; Example 2: Unsatisfiable constraints - Protocol must NOT be "http" or "https", but other constraints force it

; Introduce a scenario where protocol is both forced to "http"/"https" and not allowed to be "http"/"https"
(declare-fun url2 () String)
(declare-fun proto2 () String)
(declare-fun after_proto2 () String)
(declare-fun host2 () String)
(declare-fun path2 () String)

(assert (= proto2 (str.split_at url2 "://" 0)))
(assert (= after_proto2 (str.split_rest url2 "://" 1)))
(assert (= host2 (str.split_at after_proto2 "/" 0)))
(assert (= path2 (str.split_rest after_proto2 "/" 1)))

; Force protocol to be either "http" or "https"
(assert (or (= proto2 "http") (= proto2 "https")))
; Also require protocol to be neither "http" nor "https" (contradiction)
(assert (and (not (= proto2 "http")) (not (= proto2 "https"))))
; Basic host and path constraints to keep realistic
(assert (str.contains host2 "."))
(assert (or (= path2 "") (= (str.at path2 0) "/")))

(check-sat)
(exit)
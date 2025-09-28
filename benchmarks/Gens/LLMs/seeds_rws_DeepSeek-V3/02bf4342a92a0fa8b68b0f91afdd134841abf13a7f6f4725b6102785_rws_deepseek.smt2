; ; Complete SMT-LIB2 file for URL parsing with protocol, host, and path extraction
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const protocol_delim String)
(assert (= protocol_delim "://"))
(declare-const path_delim String)
(assert (= path_delim "/"))
(declare-const port_delim String)
(assert (= port_delim ":"))
(declare-const query_delim String)
(assert (= query_delim "?"))
(declare-const param_delim String)
(assert (= param_delim "&"))

; Declare URL variable and its components
(declare-const url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Protocol must be one of common web protocols
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))

; ; Extract protocol (first segment before ://)
(assert (= protocol (str.split_at url protocol_delim 0)))

; ; Extract host and rest (after ://)
(assert (>= (str.num_splits url protocol_delim) 2))
(assert (= (str.split_rest url protocol_delim 1) 
 (str.++ host (str.split_rest url protocol_delim 1))))

; Host may contain port number (host:port)
(assert (or 
 ; Case 1: No port specified
 (and (not (str.contains host port_delim))
 (= port ""))
 ; Case 2: Port specified
 (and (str.contains host port_delim)
 (>= (str.num_splits host port_delim) 2)
 (= port (str.split_at host port_delim 1))
 ; Port must be numeric
 (str.is_digit port))))

; ; Extract path (after first /)
(assert (or
 ; Case 1: URL has path
 (and (str.contains (str.split_rest url protocol_delim 1) path_delim)
 (>= (str.num_splits (str.split_rest url protocol_delim 1) path_delim) 2)
 (= path (str.split_at (str.split_rest url protocol_delim 1) path_delim 1)))
 ; Case 2: No path specified
 (= path "")))

; Path segments constraints
(assert (or 
 (= path "")
 (and 
 (not (str.contains path query_delim))
 (not (str.contains path param_delim))
 ; Path must start with /
 (str.prefixof "/" path))))

; Query parameters (after ?)
(assert (or
 ; Case 1: URL has query parameters
 (and (str.contains url query_delim)
 (>= (str.num_splits url query_delim) 2)
 (= query (str.split_at url query_delim 1))
 ; Query must not contain protocol delimiter
 (not (str.contains query protocol_delim)))
 ; Case 2: No query parameters
 (= query "")))

; ; Example constraints for a valid URL
(assert (str.contains url protocol_delim))
(assert (>= (str.len host) 1))
(assert (not (str.contains host " ")))
(assert (not (str.contains host path_delim)))

; Test case 1: Simple HTTP URL (satisfiable)
(assert (= url "http://example.com/index.html"))
(check-sat)




(exit)
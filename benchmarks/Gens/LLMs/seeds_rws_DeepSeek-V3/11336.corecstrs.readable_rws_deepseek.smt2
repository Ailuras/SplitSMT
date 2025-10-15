; ; Complete SMT-LIB2 file for URL parsing with protocol, host, and path extraction
(set-logic QF_SLIA) ; Quantifier-free strings

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

; Declare URL variable
(declare-const url String)

; ; Example URL: "https://example.com:8080/path/to/resource?param1=val1&param2=val2"
(assert (str.contains url protocol_delim))
(assert (str.contains url path_delim))

; Protocol validation constraints
(assert (>= (str.num_splits url protocol_delim) 2))
(declare-const protocol String)
(assert (= protocol (str.split_at url protocol_delim 0)))
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))

; ; Host extraction constraints
(declare-const host_and_rest String)
(assert (= host_and_rest (str.split_at url protocol_delim 1)))

; ; Check if port exists
(declare-const has_port Bool)
(assert (= has_port (str.contains host_and_rest port_delim)))

; Host structure constraints
(declare-const host String)
(assert (ite has_port
 (and 
 ((>= (str.num_splits host_and_rest port_delim) 2)
 (= host (str.split_at host_and_rest port_delim 0)
)))
 (and
 (>= (str.num_splits host_and_rest path_delim) 1)
 (= host (str.split_at host_and_rest path_delim 0))
)
))

; ; Validate host format (simple domain validation)
(assert (str.prefixof "www." host))
(assert (str.suffixof ".com" host))

; ; Path extraction constraints
(declare-const path_and_query String)
(assert (ite has_port
 (= path_and_query (str.split_rest host_and_rest port_delim 1))
 (= path_and_query host_and_rest)
))

; Split path from query if exists
(declare-const has_query Bool)
(assert (= has_query (str.contains path_and_query query_delim)))

(declare-const path_segments String)
(assert (ite has_query
 (and
 (>= (str.num_splits path_and_query query_delim) 1)
 (= path_segments (str.split_at path_and_query query_delim 0))
)
 (= path_segments path_and_query)
))

; Path segment validation
(assert (>= (str.num_splits path_segments path_delim) 1))
(assert (not (str.contains (str.split_at path_segments path_delim 0) " "))) ; No spaces in first segment

; Query parameter validation if exists
(declare-const query_params String)
(assert (=> has_query 
 (and
  (and
    (>= (str.num_splits path_and_query query_delim) 2)
    (= query_params (str.split_at path_and_query query_delim 1))
  )
 (>= (str.num_splits query_params param_delim) 1)
)
))

; Unsatisfiable case: invalid protocol
(declare-const invalid_url String)
(assert (= invalid_url "invalid://test.com/path"))
(assert (not (or 
 (= (str.split_at invalid_url protocol_delim 0) "http")
 (= (str.split_at invalid_url protocol_delim 0) "https")
 (= (str.split_at invalid_url protocol_delim 0) "ftp")
)))

(check-sat)
(exit)
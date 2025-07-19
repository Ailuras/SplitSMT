
(set-logic QF_S)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const protocol_delim String) (assert (= protocol_delim "://"))
(declare-const path_delim String) (assert (= path_delim "/"))
(declare-const port_delim String) (assert (= port_delim ":"))
(declare-const query_delim String) (assert (= query_delim "?"))
(declare-const param_delim String) (assert (= param_delim "&"))

; Declare URL components
(declare-const full_url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Protocol must be either http or https
(assert (or (= protocol "http") (= protocol "https")))

; URL must contain protocol delimiter
(assert (str.contains full_url protocol_delim))

; ; Extract protocol (first segment before ://)
(assert (= protocol (str.split_at full_url protocol_delim 0)))

; ; Extract the rest after protocol
(declare-const after_protocol String)
(assert (= after_protocol (str.split_rest full_url protocol_delim 1)))

; ; Host extraction - handle cases with port, path, or query
(assert (or
 ; Case 1: host ends with port
 (and (str.contains after_protocol port_delim)
 (= host (str.split_at after_protocol port_delim 0))
 (str.prefixof host "www.")
 (>= (str.len host) 5))
 
 ; Case 2: host ends with path
 (and (str.contains after_protocol path_delim)
 (= host (str.split_at after_protocol path_delim 0))
 (str.prefixof host "www.")
 (>= (str.len host) 5))
 
 ; Case 3: host ends with query
 (and (str.contains after_protocol query_delim)
 (= host (str.split_at after_protocol query_delim 0))
 (str.prefixof host "www.")
 (>= (str.len host) 5))
 
 ; Case 4: host is standalone
 (and (not (str.contains after_protocol port_delim))
 (not (str.contains after_protocol path_delim))
 (not (str.contains after_protocol query_delim))
 (= host after_protocol)
 (str.prefixof host "www.")
 (>= (str.len host) 5))
))

; ; Path extraction (if exists)
(assert (or
 ; Case 1: path exists after host
 (and (str.contains after_protocol path_delim)
 (let ((after_host (str.split_rest after_protocol path_delim 0)))
 (and (str.prefixof after_host path_delim)
 (= path (str.split_rest after_host path_delim 1)))))
 
 ; Case 2: no path in URL
 (= path "")
))

; Path segments constraints
(assert (or
 (= path "")
 (and
 (>= (str.num_splits path path_delim) 1)
 (forall ((i Int))
 (=> (and (>= i 0) (< i (str.num_splits path path_delim)))
 (>= (str.len (str.split_at path path_delim i)) 1)))
)
))

; Query parameters constraints (if exists)
(assert (or
 (not (str.contains full_url query_delim))
 (and
 (str.contains full_url query_delim)
 (= query (str.split_rest full_url query_delim 1))
 (>= (str.num_splits query param_delim) 1)
)
))

; ; Example constraints for a specific URL structure
(push)
(assert (= full_url "https://www.example.com:8080/path/to/resource?param1=value1&param2=value2"))

; ; Verify protocol extraction
(assert (= protocol "https"))

; ; Verify host extraction
(assert (= host "www.example.com"))

; ; Verify port extraction
(assert (str.contains after_protocol port_delim))
(assert (= (str.split_at after_protocol port_delim 0) host))
(assert (= (str.split_at after_protocol port_delim 1) "8080/path/to/resource?param1=value1&param2=value2"))

; ; Verify path extraction
(assert (str.contains path "path/to/resource"))
(assert (= (str.num_splits path path_delim) 3))

; ; Verify query extraction
(assert (str.contains query "param1=value1&param2=value2"))
(assert (= (str.num_splits query param_delim) 2))

(check-sat)
(get-model)
(pop)

; Unsatisfiable case - invalid protocol
(push)
(assert (= full_url "ftp://invalid.com"))
(assert (= protocol "http"))
(check-sat)
(pop)

; Satisfiable case - minimal valid URL
(push)
(assert (= full_url "http://www.valid.com"))
(assert (= protocol "http"))
(assert (= host "www.valid.com"))
(assert (= path ""))
(check-sat)
(get-model)
(pop)

(exit)
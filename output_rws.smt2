
; SMT-LIB2 script for URL parsing constraints
(set-logic QF_S)

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

; Declare URL components
(declare-const full_url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Protocol must be one of these valid options
(assert (or (= protocol "http") 
 (= protocol "https") 
 (= protocol "ftp") 
 (= protocol "sftp")))

; URL must contain protocol delimiter
(assert (str.contains full_url protocol_delim))

; ; Extract protocol (first segment before ://)
(assert (= protocol (str.split_at full_url protocol_delim 0)))

; ; Extract the rest after protocol
(declare-const after_protocol String)
(assert (= after_protocol (str.split_rest full_url protocol_delim 1)))

; Host may contain port number
(declare-const host_with_port String)
(assert (= host_with_port (str.split_at after_protocol path_delim 0)))

; ; Check if port exists
(declare-const port_exists Bool)
(assert (= port_exists (str.contains host_with_port port_delim)))

; ; Extract host (before port if no port, use entire string)
(assert (ite port_exists
 (= host (str.split_at host_with_port port_delim 0))
 (= host host_with_port)))

; ; Extract port if exists
(assert (ite port_exists
 (= port (str.split_at host_with_port port_delim 1))
 (= port "")))

; Host must be non-empty and contain at least one dot
(assert (not (= host "")))
(assert (str.contains host "."))

; ; Extract path (everything after first / after protocol)
(assert (ite (str.contains after_protocol path_delim)
 (= path (str.split_rest after_protocol path_delim 1))
 (= path "")))

; Path may contain query parameters
(declare-const path_with_query String)
(assert (ite (str.contains path query_delim)
 (= path_with_query (str.split_at path query_delim 0))
 (= path_with_query path)))

; ; Extract query if exists
(assert (ite (str.contains path query_delim)
 (= query (str.split_rest path query_delim 1))
 (= query "")))

; Path segments constraints
(declare-const num_path_segments Int)
(assert (= num_path_segments (str.num_splits path_with_query path_delim)))

; Must have at least one path segment if path is not empty
(assert (=> (not (= path_with_query "")) (> num_path_segments 0)))

; First path segment must be empty (absolute path starts with /)
(assert (ite (not (= path_with_query ""))
 (= (str.split_at path_with_query path_delim 0) "")
 true))

; ; Example constraints for a specific URL structure
(assert (str.contains full_url "https://"))
(assert (str.contains host "example.com"))
(assert (str.contains path_with_query "/api/v1/users"))

; Uncomment to make unsatisfiable
; (assert (= protocol "invalid"))
; (assert (= port "99999"))

(check-sat)
(get-model)
(exit)

This script:
1. Defines common URL delimiters
; 2. Validates protocol against known values
; 3. Extracts and validates host structure
4. Handles optional port numbers
5. Processes path segments and query parameters
6. Includes constraints for absolute paths
; 7. Provides example constraints that can be modified
8. Contains commented-out unsatisfiable constraints for testing

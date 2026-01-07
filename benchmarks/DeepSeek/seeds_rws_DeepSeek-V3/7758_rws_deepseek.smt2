; ; Complete SMT-LIB2 file for URL parsing with protocol, host, and path extraction
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const delim_protocol String) ; "://"
(declare-const delim_path String) ; "/"
(declare-const delim_port String) ; ":"
(declare-const delim_query String) ; "?"
(declare-const delim_param String) ; "&"

(assert (= delim_protocol "://"))
(assert (= delim_path "/"))
(assert (= delim_port ":"))
(assert (= delim_query "?"))
(assert (= delim_param "&"))

; Declare URL variable and constraints
(declare-const url String)

; ; Example URL constraints
(assert (str.contains url delim_protocol))
(assert (>= (str.len url) 10)) ; Minimum reasonable URL length

; ; Protocol extraction and validation
(declare-const protocol String)
(assert (= protocol (str.split_at url delim_protocol 0)))

; Valid protocols (http, https, ftp)
(assert (or (= protocol "http") 
 (= protocol "https")
 (= protocol "ftp")))

; ; Host and port extraction
(declare-const after_protocol String)
(assert (= after_protocol (str.split_at url delim_protocol 1)))

(declare-const host_and_port String)
(declare-const host String)
(declare-const port String)

; ; Check if port exists
(assert (ite (str.contains after_protocol delim_port)
 (and (= host (str.split_at after_protocol delim_port 0))
 (= port (str.split_at after_protocol delim_port 1))
 (str.is_digit port)
 (<= (str.to_int port) 65535)) ; Valid port range
 (and (= host after_protocol)
 (= port ""))))

; Host validation - must contain at least one dot for domain
(assert (str.contains host "."))

; ; Path extraction
(declare-const path_and_query String)
(assert (ite (str.contains after_protocol delim_path)
 (and (= path_and_query (str.split_rest after_protocol delim_path 0))
 (>= (str.num_splits after_protocol delim_path) 1))
 (= path_and_query "")))

; Split path segments
(declare-const first_path_seg String)
(assert (ite (str.contains path_and_query delim_path)
 (= first_path_seg (str.split_at path_and_query delim_path 0))
 (= first_path_seg path_and_query)))

; Query parameters
(declare-const query String)
(assert (ite (str.contains path_and_query delim_query)
 (and (= query (str.split_at path_and_query delim_query 1))
 (>= (str.num_splits query delim_param) 0))
 (= query "")))

; Additional constraints for realistic URLs
(assert (not (str.contains host " "))) ; No spaces in host
(assert (not (str.prefixof "/" host))) ; Host shouldn't start with /
(assert (not (str.suffixof "/" host))) ; Host shouldn't end with /

; ; Example unsatisfiable constraint combination
(assert (= protocol "http"))
(assert (= port "80000")) ; Invalid port number
(check-sat) ; Should be UNSAT

(exit)
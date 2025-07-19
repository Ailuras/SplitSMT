(set-info :source |URL Parsing with Protocol, Host, and Path Extraction|)
(set-info :category "industrial")
(set-logic QF_S)

; Variable declarations for URL components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)
(declare-fun port () String)

; Helper variables for parsing
(declare-fun host_with_port () String)
(declare-fun path_with_query () String)
(declare-fun first_path_segment () String)
(declare-fun second_path_segment () String)

; URL structure: protocol://host:port/path?query
(assert (= url "https://api.example.com:8080/users/profile?id=123&format=json"))

; ; Protocol extraction using :// delimiter
(assert (= (str.num_splits url "://") 2))
(assert (= protocol (str.split_at url "://" 0)))
(assert (= (str.split_rest url "://" 1) host_with_port))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Host and port extraction using / delimiter
(assert (= (str.num_splits host_with_port "/") 3))
(assert (= host_with_port (str.split_at host_with_port "/" 0)))
(assert (= path_with_query (str.split_rest host_with_port "/" 1)))

; ; Port extraction from host using : delimiter
(assert (= (str.num_splits host_with_port ":") 2))
(assert (= host (str.split_at host_with_port ":" 0)))
(assert (= port (str.split_at host_with_port ":" 1)))

; Host structure validation - must contain at least one dot
(assert (>= (str.num_splits host ".") 2))
(assert (str.contains host "example.com"))

; Port validation - must be numeric representation between 1-65535
(assert (and (str.len port) (> (str.len port) 0)))
(assert (= port "8080"))

; ; Path extraction using ? delimiter to separate from query
(assert (= (str.num_splits path_with_query "?") 2))
(assert (= path (str.split_at path_with_query "?" 0)))
(assert (= query_string (str.split_at path_with_query "?" 1)))

; Path structure validation - should have multiple segments
(assert (>= (str.num_splits path "/") 3))
(assert (= first_path_segment (str.split_at path "/" 0)))
(assert (= second_path_segment (str.split_at path "/" 1)))

; Path segment validation
(assert (= first_path_segment "users"))
(assert (= second_path_segment "profile"))

; Query parameter validation using & delimiter
(assert (>= (str.num_splits query_string "&") 2))
(assert (str.contains (str.split_at query_string "&" 0) "id="))
(assert (str.contains (str.split_at query_string "&" 1) "format="))

; Additional URL parsing constraints
(declare-fun subdomain () String)
(declare-fun domain () String)
(declare-fun tld () String)

; ; Extract subdomain, domain, and TLD from host
(assert (= (str.num_splits host ".") 3))
(assert (= subdomain (str.split_at host "." 0)))
(assert (= domain (str.split_at host "." 1)))
(assert (= tld (str.split_at host "." 2)))

; ; Validate host components
(assert (= subdomain "api"))
(assert (= domain "example"))
(assert (= tld "com"))

; ; Test unsatisfiable constraint - protocol cannot be both validated and invalid
(declare-fun invalid_url () String)
(declare-fun invalid_protocol () String)

(assert (= invalid_url "ftp://files.server.net/data.txt"))
(assert (= invalid_protocol (str.split_at invalid_url "://" 0)))
(assert (= invalid_protocol "ftp"))
; This should make the system unsatisfiable if we also require http/https only
(assert (or (= invalid_protocol "http") (= invalid_protocol "https")))

; Path depth analysis
(declare-fun deep_path () String)
(declare-fun path_depth () Int)

(assert (= deep_path "/api/v2/users/123/settings/preferences"))
(assert (= path_depth (str.num_splits deep_path "/")))
(assert (> path_depth 5))

; ; Validate specific path segments exist
(assert (= (str.split_at deep_path "/" 1) "api"))
(assert (= (str.split_at deep_path "/" 2) "v2"))
(assert (= (str.split_at deep_path "/" 3) "users"))

; Query parameter structure validation
(declare-fun param1 () String)
(declare-fun param2 () String)
(declare-fun param1_key () String)
(declare-fun param1_value () String)

(assert (= param1 (str.split_at query_string "&" 0)))
(assert (= param2 (str.split_at query_string "&" 1)))

; ; Extract key-value pairs using = delimiter
(assert (= (str.num_splits param1 "=") 2))
(assert (= param1_key (str.split_at param1 "=" 0)))
(assert (= param1_value (str.split_at param1 "=" 1)))

(assert (= param1_key "id"))
(assert (= param1_value "123"))

; Ensure parameter value is numeric for id
(assert (and (> (str.len param1_value) 0) (str.is_digit param1_value)))

(check-sat)
(exit)
; SMT-LIB2 file for URL Parsing using split operations
; Focus: protocol validation, host structure, path segments
; Delimiters used: '://', '/', ':', '?', '&'

(set-logic ALL)

; Declare the input URL string
(declare-fun url () String)

; Declare variables for protocol, host_with_port, path_and_rest
(declare-fun protocol () String)
(declare-fun host_with_port () String)
(declare-fun path_and_rest () String)

; Split the URL at the first occurrence of '://'
; protocol = str.split_at(url, "://", 0)
; host_with_port = str.split_at(url, "://", 1)
(assert (= protocol (str.split_at url "://" 0)))
(assert (= host_with_port (str.split_at url "://" 1)))

; Ensure the delimiter '://' actually exists in the URL
(assert (> (str.indexof url "://" 0) -1))

; protocol validation: only allow 'http' or 'https'
(assert (or (= protocol "http") (= protocol "https")))

; Now, host_with_port is like: host[:port][/path][?query][&...]

; Split host_with_port at the first '/' to get host_port and path_and_rest
(declare-fun host_port () String)
(assert (= host_port (str.split_at host_with_port "/" 0)))
(assert (= path_and_rest (str.split_rest host_with_port "/" 1)))

; Host structure: host_port may have port, separated by ':'
; ; Let's extract host and port (if present)
(declare-fun host () String)
(declare-fun port () String)

; ; If there is a ':' in host_port, extract host and port, else port is empty
(assert (ite (> (str.indexof host_port ":" 0) -1)
 (and
 (= host (str.split_at host_port ":" 0))
 (= port (str.split_at host_port ":" 1))
)
 (and
 (= host host_port)
 (= port "")
)
))

; path_and_rest begins with '/' if there is a path, else is empty
; ; Extract path segments, ignoring query and fragment

; Split path_and_rest at '?' to separate path and query
(declare-fun path_with_slash () String)
(declare-fun query_and_more () String)
(assert (= path_with_slash (str.split_at path_and_rest "?" 0)))
(assert (= query_and_more (str.split_rest path_and_rest "?" 1)))

; Path segments are separated by '/'
; Number of path segments (excluding empty segments)
(declare-fun num_path_segments () Int)
(assert (= num_path_segments (str.num_splits path_with_slash "/")))

; ; For demonstration, extract the first path segment (if any)
(declare-fun first_path_segment () String)
(assert (ite (> num_path_segments 1)
 (= first_path_segment (str.split_at path_with_slash "/" 1))
 (= first_path_segment "")
))

; ; Example constraint: host must be a non-empty string (real-world host)
(assert (> (str.len host) 0))

; ; Example constraint: if port is present, it must be numeric and not empty
(assert (or
 (= port "")
 (and
 (> (str.len port) 0)
 (forall ((i Int))
 (=> (and (>= i 0) (< i (str.len port)))
 (and (>= (str.to_code (str.at port i)) 48)
 (<= (str.to_code (str.at port i)) 57))
)
)
)
))

; ; Example constraint: path must begin with '/' if it is non-empty
(assert (or (= path_with_slash "") (= (str.at path_with_slash 0) "/")))

; ; Example constraint: for unsatisfiable case, require the protocol must be 'ftp' (which is not allowed above)
(assert (not (= protocol "ftp")))

; ; Example: unsatisfiable constraint: require the first path segment to be 'admin' AND to be 'user'
(assert (or (= first_path_segment "admin") (= first_path_segment "user")))
(assert (not (= first_path_segment "admin")))
(assert (not (= first_path_segment "user")))

(check-sat)
(exit)
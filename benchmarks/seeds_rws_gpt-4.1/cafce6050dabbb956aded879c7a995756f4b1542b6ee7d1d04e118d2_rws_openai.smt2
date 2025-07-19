; SMT-LIB2 file for Authentication Token: JWT and API Key Validation
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)

; Declare constants for delimiters
(define-fun delim_dot () String ".")
(define-fun delim_dash () String "-")
(define-fun delim_colon () String ":")

; JWT token variable
(declare-fun jwt_token () String)

; API key variable
(declare-fun api_key () String)

; For base64 validation, we use a simple over-approximation: only [A-Za-z0-9+/=]
; ; Since SMT-LIB2 does not support regex, we only check for valid starting/ending chars for base64 here

; Declare variables for JWT segments
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)
(declare-fun jwt_dot_count () Int)

; JWT should have exactly 3 segments separated by '.'
(assert (= (str.num_splits jwt_token delim_dot) 3))

; ; Extract segments
(assert (= jwt_header (str.split_at jwt_token delim_dot 0)))
(assert (= jwt_payload (str.split_at jwt_token delim_dot 1)))
(assert (= jwt_signature (str.split_at jwt_token delim_dot 2)))

; ; Example base64 segment: starts with 'e', ends with '='
; ; We require the header to start with "e" and end with "=" (simplified base64 check)
(assert (= (str.at jwt_header 0) "e"))
(assert (= (str.at jwt_header (- (str.len jwt_header) 1)) "="))

; ; Require the payload to end with "=" (simplified base64 check)
(assert (= (str.at jwt_payload (- (str.len jwt_payload) 1)) "="))

; ; Signature checking: require the signature to be non-empty and not contain '.'
(assert (> (str.len jwt_signature) 0))
(assert (= (str.contains jwt_signature delim_dot) false))

; ; Unsatisfiable constraint: require the header to both start with "e" and "a" (impossible)
(assert (= (str.at jwt_header 0) "a"))

; API key: format "API-KEY:<user>:<random>"
; ; Example: "API-KEY:alice:xyz123"
(declare-fun api_segment0 () String)
(declare-fun api_segment1 () String)
(declare-fun api_segment2 () String)

; Split by colon
(assert (= (str.num_splits api_key delim_colon) 3))
(assert (= api_segment0 (str.split_at api_key delim_colon 0)))
(assert (= api_segment1 (str.split_at api_key delim_colon 1)))
(assert (= api_segment2 (str.split_at api_key delim_colon 2)))

; The first segment should be literal "API-KEY"
(assert (= api_segment0 "API-KEY"))

; The random segment should not be empty
(assert (> (str.len api_segment2) 0))

; ; Unsatisfiable constraint: user segment equals "bob" and "alice" at the same time
(assert (= api_segment1 "bob"))
(assert (= api_segment1 "alice"))

; ; API key signature check: ensure the entire string does not contain '.'
(assert (= (str.contains api_key delim_dot) false))

(check-sat)
(exit)
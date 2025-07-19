; SMT-LIB2 file for Authentication Token: JWT and API Key Validation
; Using str.split_at, str.num_splits, str.split_rest with delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation (simulated), signature checking

(set-logic ALL)
(set-option :produce-models true)

; Declare string variables for tokens
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; Fixed delimiter constants
(define-fun delim_dot () String ".")
(define-fun delim_dash () String "-")
(define-fun delim_colon () String ":")

; ; Simulated valid base64 alphabet (for simplicity, just check for A-Z, a-z, 0-9, +, /, =)
(define-fun is_base64_char ((c String)) Bool
 (or
 (and (>= (str.to_code c) 65) (<= (str.to_code c) 90)) ; 'A'-'Z'
 (and (>= (str.to_code c) 97) (<= (str.to_code c) 122)) ; 'a'-'z'
 (and (>= (str.to_code c) 48) (<= (str.to_code c) 57)) ; '0'-'9'
 (= c "+")
 (= c "/")
 (= c "=")
)
)

; --- JWT Token Constraints ---
; JWT: typically three segments separated by '.': header.payload.signature

(assert (= (str.num_splits jwt_token delim_dot) 3))

; ; Extract segments
(define-fun jwt_header () String (str.split_at jwt_token delim_dot 0))
(define-fun jwt_payload () String (str.split_at jwt_token delim_dot 1))
(define-fun jwt_sig () String (str.split_at jwt_token delim_dot 2))

; ; Simulated base64 check for header (first char only for demonstration)
(declare-fun jwt_h0 () String)
(assert (= jwt_h0 (str.at jwt_header 0)))
(assert (is_base64_char jwt_h0))

; ; Simulated base64 check for payload (first char only for demonstration)
(declare-fun jwt_p0 () String)
(assert (= jwt_p0 (str.at jwt_payload 0)))
(assert (is_base64_char jwt_p0))

; Signature must not be empty
(assert (not (= jwt_sig "")))

; --- API Key Constraints ---
; Format: key-id:timestamp:signature (delimited by ':')

(assert (= (str.num_splits api_key delim_colon) 3))

(define-fun api_key_id () String (str.split_at api_key delim_colon 0))
(define-fun api_key_time () String (str.split_at api_key delim_colon 1))
(define-fun api_key_sig () String (str.split_at api_key delim_colon 2))

; Key ID and timestamp must not be empty
(assert (not (= api_key_id "")))
(assert (not (= api_key_time "")))

; Signature must be at least 8 characters long
(assert (>= (str.len api_key_sig) 8))

; ; --- Relationship Constraint: Simulate Signature Checking ---
; Suppose the API key signature is the same as the JWT signature
(assert (= api_key_sig jwt_sig))

; ; --- Satisfiable Constraint Example ---
; The above constraints are satisfiable; now add an unsatisfiable constraint

; ; --- Unsatisfiable Constraint: Force JWT header and payload to have different first char, but both are 'A' ---
(assert (= jwt_h0 "A"))
(assert (= jwt_p0 "A"))
(assert (not (= jwt_h0 jwt_p0))) ; Contradicts the above

; --- End: Check for satisfiability and exit ---
(check-sat)
(exit)
; SMT-LIB2 file for Authentication Token: JWT and API key validation
; Delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)
(set-option :strings-exp true)

; Declare variables for JWT token and API key
(declare-const jwt String)
(declare-const api_key String)

; JWT tokens are typically of the form: header.payload.signature
; They are separated by '.'

; Constraint 1: JWT must have exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt ".") 3))

; ; Extract the three segments of the JWT
(define-fun jwt_header () String (str.split_at jwt "." 0))
(define-fun jwt_payload () String (str.split_at jwt "." 1))
(define-fun jwt_sig () String (str.split_at jwt "." 2))

; API keys in this system are of the form: <prefix>-<id>:<signature>
; ; Example: "API-123456:abcdef"

; Constraint 2: API key, split by '-', should have 2 segments (prefix, rest)
(assert (= (str.num_splits api_key "-") 2))

(define-fun api_prefix () String (str.split_at api_key "-" 0))
(define-fun api_rest () String (str.split_at api_key "-" 1))

; Constraint 3: api_rest, split by ':', should have 2 segments (id, signature)
(assert (= (str.num_splits api_rest ":") 2))

(define-fun api_id () String (str.split_at api_rest ":" 0))
(define-fun api_sig () String (str.split_at api_rest ":" 1))

; Base64 validation for JWT header and payload
; ; For simplicity, we check that they contain only base64url characters: [A-Za-z0-9_-]
; ; We'll check absence of '.' and ':' as a weak base64url validation

(assert (not (str.contains jwt_header ".")))
(assert (not (str.contains jwt_header ":")))
(assert (not (str.contains jwt_payload ".")))
(assert (not (str.contains jwt_payload ":")))

; ; Satisfiable constraint: JWT signature matches API signature
(assert (= jwt_sig api_sig))

; ; Example: Require API key prefix to be "API"
(assert (= api_prefix "API"))

; ; Unsatisfiable constraint: JWT header and payload must be identical (impossible for real-world JWTs)
(assert (not (= jwt_header jwt_payload)))

; ; Satisfiable constraint: API id must be at least 6 characters long
(assert (>= (str.len api_id) 6))

; ; Unsatisfiable constraint: JWT signature must be empty but also equal to API signature (impossible since api_sig is not empty)
(assert (and (= jwt_sig "") (= jwt_sig api_sig) (not (= api_sig ""))))

(check-sat)
(exit)
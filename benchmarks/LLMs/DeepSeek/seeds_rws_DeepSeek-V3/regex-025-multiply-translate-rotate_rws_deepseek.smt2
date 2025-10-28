
; SMT-LIB2 script for JWT and API key validation
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun is_base64 (String) Bool)
(declare-fun is_hex (String) Bool)

; Declare constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; Sample JWT token (header.payload.signature)
(declare-const jwt_token String)
(assert (>= (str.len jwt_token) 10)) ; Minimum reasonable JWT length

; JWT must have exactly 2 dots separating 3 parts
(assert (= (str.num_splits jwt_token dot) 3))

; ; Extract JWT parts
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)

(assert (= jwt_header (str.split_at jwt_token dot 0)))
(assert (= jwt_payload (str.split_at jwt_token dot 1)))
(assert (= jwt_signature (str.split_at jwt_token dot 2)))

; Header and payload must be valid base64
(assert (is_base64 jwt_header))
(assert (is_base64 jwt_payload))

; Signature must be hex (common for HMAC signatures)
(assert (is_hex jwt_signature))

; API key validation (format: prefix-key-id:secret)
(declare-const api_key String)
(assert (>= (str.len api_key) 16)) ; Minimum reasonable API key length

; API key must have exactly one colon
(assert (= (str.num_splits api_key colon) 2))

; ; Extract API key parts
(declare-const api_prefix String)
(declare-const api_secret String)

(assert (= api_prefix (str.split_at api_key colon 0)))
(assert (= api_secret (str.split_at api_key colon 1)))

; API prefix must contain at least one dash
(assert (>= (str.num_splits api_prefix dash) 1))

; API secret must be base64
(assert (is_base64 api_secret))

; Additional constraints for realistic scenarios
; 1. JWT header must contain "alg" field
(assert (str.contains jwt_header "alg"))

; 2. API prefix must start with 3 letters
(assert (>= (str.len (str.split_at api_prefix dash 0)) 3))

; 3. Signature must be at least 32 chars (for HS256)
(assert (>= (str.len jwt_signature) 32))

; 4. API secret must be at least 16 chars
(assert (>= (str.len api_secret) 16))

; Unsatisfiable constraint combinations
; JWT cannot have 4 parts
(assert (= (str.num_splits jwt_token dot) 4))
(check-sat) ; should be unsat


(exit)
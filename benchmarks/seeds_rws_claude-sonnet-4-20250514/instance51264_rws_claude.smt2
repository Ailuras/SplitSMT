(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare string variables for JWT tokens and API keys
(declare-fun jwt_token () String)
(declare-fun api_key () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_id () String)
(declare-fun api_key_secret () String)

; Declare variables for validation results
(declare-fun header_b64 () String)
(declare-fun payload_b64 () String)
(declare-fun signature_b64 () String)
(declare-fun timestamp_part () String)
(declare-fun user_id_part () String)
(declare-fun api_key_version () String)
(declare-fun exp_claim () String)

; JWT token structure: header.payload.signature
; Valid JWT must have exactly 3 parts when split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; ; Base64 validation for JWT components - check minimum lengths
(assert (>= (str.len jwt_header) 20))
(assert (>= (str.len jwt_payload) 50))
(assert (>= (str.len jwt_signature) 32))

; JWT header must contain algorithm specification
(assert (str.contains jwt_header "alg"))
(assert (or (str.contains jwt_header "HS256") (str.contains jwt_header "RS256")))

; JWT payload must contain standard claims
(assert (str.contains jwt_payload "iat"))
(assert (str.contains jwt_payload "exp"))
(assert (str.contains jwt_payload "sub"))

; Signature validation - length requirements
(assert (<= (str.len jwt_signature) 512))

; API Key structure: prefix-keyid:secret
; API key must have exactly 2 parts when split by ':'
(assert (= (str.num_splits api_key ":") 2))

; ; Extract API key components
(assert (= api_key_prefix (str.split_at api_key ":" 0)))
(assert (= api_key_secret (str.split_at api_key ":" 1)))

; API key prefix should contain key identifier separated by '-'
(assert (>= (str.num_splits api_key_prefix "-") 2))
(assert (= api_key_id (str.split_at api_key_prefix "-" 1)))

; API key validation constraints
(assert (str.prefixes api_key_prefix "ak"))
(assert (= (str.len api_key_id) 8))

; API key secret validation
(assert (= (str.len api_key_secret) 32))

; Cross-validation between JWT and API key
; ; Extract user ID from JWT payload
(assert (str.contains jwt_payload "sub"))

; Timestamp validation in JWT
(assert (str.contains jwt_payload "iat"))

; Security constraints
; JWT signature must not be empty or default values
(assert (not (= jwt_signature "")))
(assert (not (= jwt_signature "signature")))
(assert (not (str.contains jwt_signature "example")))

; API key secret must not contain common patterns
(assert (not (str.contains api_key_secret "password")))
(assert (not (str.contains api_key_secret "secret")))
(assert (not (str.contains api_key_secret "12345")))

; Length constraints for security
(assert (>= (str.len jwt_token) 100))

; API key format validation
(assert (str.prefixes api_key "ak"))
(assert (str.contains api_key ":"))
(assert (not (str.contains api_key " ")))

; Additional segment validation for complex API keys
; Some API keys might have multiple dash-separated components
(assert (>= (str.num_splits api_key_prefix "-") 3))
(assert (= api_key_version (str.split_at api_key_prefix "-" 2)))

; JWT expiration validation using split operations
(assert (str.contains jwt_payload "exp"))

; Ensure tokens are not malformed
(assert (not (str.contains jwt_token "..")))
(assert (not (str.contains api_key "::")))
(assert (not (str.contains api_key "--")))

; Base64 character validation using string operations
(assert (not (str.contains jwt_header " ")))
(assert (not (str.contains jwt_payload " ")))
(assert (not (str.contains jwt_signature " ")))

; Segment count validation for nested structures
; JWT payload may contain nested JSON with colon separators
(assert (>= (str.num_splits jwt_payload ":") 3))

; API key must have proper structure
(assert (= (str.len (str.split_at api_key ":" 0)) (+ (str.len api_key_prefix) 0)))
(assert (= (str.len (str.split_at api_key ":" 1)) (str.len api_key_secret)))

; ; Signature checking - ensure signature is last component
(assert (= jwt_signature (str.split_rest jwt_token "." 2)))

; Version validation in API key prefix
(assert (not (= api_key_version "")))
(assert (>= (str.len api_key_version) 1))

; Final validation constraints
(assert (not (= jwt_token "")))
(assert (not (= api_key "")))

(check-sat)
(exit)
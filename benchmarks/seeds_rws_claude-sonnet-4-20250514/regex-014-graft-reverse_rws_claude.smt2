(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-info :status unknown)
(set-logic QF_S)

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_id () String)
(declare-fun api_key_secret () String)

; Declare string variables for base64 validation
(declare-fun base64_chars () String)
(declare-fun valid_header_b64 () String)
(declare-fun valid_payload_b64 () String)

; Define base64 character set for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure validation - must have exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_header) 0))
(assert (str.prefixof "eyJ" jwt_header)) ; JWT headers typically start with eyJ in base64

; JWT payload must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_payload) 0))
(assert (not (= jwt_payload "")))

; JWT signature must be non-empty for valid tokens
(assert (> (str.len jwt_signature) 0))
(assert (not (str.contains jwt_signature " "))) ; No spaces in signature

; API key structure validation - format: prefix-id:secret
(assert (= (str.num_splits api_key "-") 2))
(assert (= (str.num_splits (str.split_at api_key "-" 1) ":") 2))

; ; Extract API key components
(assert (= api_key_prefix (str.split_at api_key "-" 0)))
(assert (= api_key_id (str.split_at (str.split_at api_key "-" 1) ":" 0)))
(assert (= api_key_secret (str.split_at (str.split_at api_key "-" 1) ":" 1)))

; API key prefix validation
(assert (or (= api_key_prefix "sk") (= api_key_prefix "pk") (= api_key_prefix "rk")))

; API key ID must be exactly 24 characters (typical for API keys)
(assert (= (str.len api_key_id) 24))
(assert (not (str.contains api_key_id " ")))

; API key secret must be at least 32 characters
(assert (>= (str.len api_key_secret) 32))
(assert (not (str.contains api_key_secret " ")))

; Base64 validation constraints for JWT components
; Header base64 validation - must only contain valid base64 characters
(assert (forall ((i Int)) 
 (=> (and (>= i 0) (< i (str.len jwt_header)))
 (str.contains base64_chars (str.at jwt_header i)))))

; Payload base64 validation - must only contain valid base64 characters
(assert (forall ((i Int)) 
 (=> (and (>= i 0) (< i (str.len jwt_payload)))
 (str.contains base64_chars (str.at jwt_payload i)))))

; Signature validation - must be valid base64 without padding issues
(assert (forall ((i Int)) 
 (=> (and (>= i 0) (< i (str.len jwt_signature)))
 (str.contains base64_chars (str.at jwt_signature i)))))

; Additional security constraints
; JWT token length should be reasonable (not too short or suspiciously long)
(assert (>= (str.len jwt_token) 100))
(assert (<= (str.len jwt_token) 2048))

; API key total length validation
(assert (>= (str.len api_key) 40))
(assert (<= (str.len api_key) 128))

; Cross-validation: if we have both JWT and API key, they should be consistent
(assert (=> (and (> (str.len jwt_token) 0) (> (str.len api_key) 0))
 (not (= jwt_header api_key_prefix))))

; ; Signature checking constraint - signature should not be predictable
(assert (not (str.prefixof jwt_header jwt_signature)))
(assert (not (str.prefixof jwt_payload jwt_signature)))
(assert (not (str.suffixof jwt_header jwt_signature)))

; Test case: Valid JWT structure
(assert (= jwt_token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"))

; Test case: Valid API key structure 
(assert (= api_key "sk-1234567890abcdef12345678:9876543210fedcba0987654321abcdef98765432"))

; Conflicting constraint for testing unsatisfiability
; This creates an impossible scenario where JWT has wrong number of segments
(assert (= (str.num_splits jwt_token ".") 5))

(check-sat)
(exit)
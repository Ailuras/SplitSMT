(set-logic QF_SLIA)
(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :category "industrial")

; Declare string variables for JWT tokens and API keys
(declare-fun jwt_token () String)
(declare-fun api_key () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_suffix () String)

; Declare auxiliary variables for validation
(declare-fun valid_base64_chars () String)
(declare-fun base64_pattern () String)
(declare-fun signature_valid () Bool)
(declare-fun token_expired () Bool)

; Define valid base64 character set
(assert (= valid_base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure constraints - must have exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT segments must be non-empty
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; Base64 validation constraints for JWT header
(assert (>= (str.len jwt_header) 4))
(assert (= (mod (str.len jwt_header) 4) 0))

; Base64 validation constraints for JWT payload
(assert (>= (str.len jwt_payload) 4))
(assert (= (mod (str.len jwt_payload) 4) 0))

; Base64 validation constraints for JWT signature
(assert (>= (str.len jwt_signature) 4))
(assert (= (mod (str.len jwt_signature) 4) 0))

; API key structure constraints - format: prefix-key:timestamp
(assert (= (str.num_splits api_key "-") 2))
(assert (= (str.num_splits api_key ":") 2))

; ; Extract API key components
(assert (= api_key_prefix (str.split_at api_key "-" 0)))
(assert (= api_key_suffix (str.split_rest api_key "-" 1)))

; API key prefix must be specific format
(assert (or (= api_key_prefix "ak") (= api_key_prefix "sk") (= api_key_prefix "pk")))

; API key suffix must contain timestamp after colon
(assert (str.contains api_key_suffix ":"))

; Signature validation constraints
(assert (=> signature_valid 
 (and (>= (str.len jwt_signature) 32)
 (str.contains valid_base64_chars (str.at jwt_signature 0))
 (str.contains valid_base64_chars (str.at jwt_signature 1)))))

; Token expiration logic based on payload content
(assert (=> (str.contains jwt_payload "exp")
 (=> token_expired (not signature_valid))))

; Cross-validation between JWT and API key
(assert (=> (and (= api_key_prefix "ak") (> (str.len jwt_token) 100))
 signature_valid))

; ; Security constraint: reject tokens with suspicious patterns
(assert (not (str.contains jwt_token "admin")))
(assert (not (str.contains api_key "test")))

; Length constraints for security
(assert (>= (str.len jwt_token) 50))
(assert (<= (str.len jwt_token) 2048))
(assert (>= (str.len api_key) 20))
(assert (<= (str.len api_key) 256))

; Specific test case constraints
(assert (str.prefixof jwt_token "eyJ"))
(assert (str.suffixof jwt_signature "="))

; API key timestamp validation
(assert (let ((timestamp_part (str.split_at api_key_suffix ":" 1)))
 (and (>= (str.len timestamp_part) 10)
 (<= (str.len timestamp_part) 13))))

; Ensure proper delimiter usage in JWT
(assert (not (str.contains jwt_header "-")))
(assert (not (str.contains jwt_header ":")))
(assert (not (str.contains jwt_payload "-")))
(assert (not (str.contains jwt_payload ":")))

; Ensure proper delimiter usage in API key
(assert (not (str.contains api_key ".")))

; Additional base64 padding validation
(assert (=> (str.suffixof jwt_header "=") 
 (or (str.suffixof jwt_header "=") (str.suffixof jwt_header "=="))))
(assert (=> (str.suffixof jwt_payload "=") 
 (or (str.suffixof jwt_payload "=") (str.suffixof jwt_payload "=="))))

; ; Consistency check between signature validity and token structure
(assert (=> signature_valid
 (and (= (str.num_splits jwt_token ".") 3)
 (> (str.len jwt_signature) 20))))

; Final validation state
(assert (not (and token_expired signature_valid)))

(check-sat)
(exit)
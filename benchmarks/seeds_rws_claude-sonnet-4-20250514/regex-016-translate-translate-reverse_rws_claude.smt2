(set-logic QF_S)
(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :status unknown)

; Variable declarations for JWT token processing
(declare-const jwt_token String)
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)

; Variable declarations for API key processing
(declare-const api_key String)
(declare-const api_key_prefix String)
(declare-const api_key_remainder String)
(declare-const api_key_id String)
(declare-const api_key_secret String)

; Variable declarations for segment counts
(declare-const jwt_segments Int)
(declare-const api_key_dash_segments Int)
(declare-const colon_segments Int)

; JWT token structure constraints - must have exactly 3 segments when split by dot
(assert (= jwt_segments (str.num_splits jwt_token ".")))
(assert (= jwt_segments 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT segment count validation
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; Base64 validation - JWT header must start with eyJ (base64 for {"alg")
(assert (str.prefixof "eyJ" jwt_header))

; JWT payload must start with eyJ typically for JSON
(assert (str.prefixof "eyJ" jwt_payload))

; ; Signature checking - JWT signature must be at least 43 characters (base64 encoded)
(assert (>= (str.len jwt_signature) 43))
(assert (<= (str.len jwt_signature) 86))

; API key format: sk-proj-keyid:secret
(assert (= api_key_dash_segments (str.num_splits api_key "-")))
(assert (>= api_key_dash_segments 3))

; ; Extract API key prefix
(assert (= api_key_prefix (str.split_at api_key "-" 0)))
(assert (= api_key_prefix "sk"))

; Get remainder after first two dashes for colon splitting
(assert (= api_key_remainder (str.split_rest api_key "-" 2)))

; Split remainder by colon to separate id and secret
(assert (= colon_segments (str.num_splits api_key_remainder ":")))
(assert (= colon_segments 2))

(assert (= api_key_id (str.split_at api_key_remainder ":" 0)))
(assert (= api_key_secret (str.split_at api_key_remainder ":" 1)))

; API key segment validation
(assert (>= (str.len api_key_id) 16))
(assert (>= (str.len api_key_secret) 32))

; Base64 validation for JWT components - no spaces or invalid characters
(assert (not (str.contains jwt_header " ")))
(assert (not (str.contains jwt_payload " ")))
(assert (not (str.contains jwt_signature " ")))

; API key validation - no spaces
(assert (not (str.contains api_key_id " ")))
(assert (not (str.contains api_key_secret " ")))

; Cross-validation between JWT and API key
(declare-const total_jwt_length Int)
(assert (= total_jwt_length (str.len jwt_token)))
(assert (>= total_jwt_length 100))
(assert (<= total_jwt_length 4096))

(declare-const total_api_length Int)
(assert (= total_api_length (str.len api_key)))
(assert (>= total_api_length 50))
(assert (<= total_api_length 200))

; ; Signature checking constraint - ensure signature is properly formatted
(assert (not (str.contains jwt_signature ".")))
(assert (not (str.contains jwt_signature ":")))
(assert (not (str.contains jwt_signature "-")))

; Additional validation - ensure proper structure
(declare-const second_dash_part String)
(assert (= second_dash_part (str.split_at api_key "-" 1)))
(assert (= second_dash_part "proj"))

; Mutual exclusivity - token format validation
(declare-const has_jwt_structure Bool)
(declare-const has_apikey_structure Bool)

(assert (= has_jwt_structure (= (str.num_splits jwt_token ".") 3)))
(assert (= has_apikey_structure (and (>= (str.num_splits api_key "-") 3) (str.contains api_key ":"))))

; ; Example valid tokens
(assert (or
 (and 
 (= jwt_token "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0In0.abcdefghijklmnopqrstuvwxyz1234567890ABCDEF")
 (= api_key "sk-proj-1234567890abcdef:ghijklmnopqrstuvwxyz0123456789abcdef"))
 (and
 (= jwt_token "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJ0ZXN0In0.differentSignatureHere123456789012345678901234")
 (= api_key "sk-proj-abcdef1234567890:secretkey9876543210fedcba0123456789abcdef"))))

(check-sat)
(exit)
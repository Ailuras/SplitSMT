
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.is_base64 (String) Bool)

; ; Example JWT token validation
(declare-const jwt_token String)
(assert (str.contains jwt_token "."))
(assert (= (str.num_splits jwt_token ".") 3)) ; JWT must have 3 parts

; ; Extract JWT segments
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; ; Validate Base64 encoding
(assert (str.is_base64 jwt_header))
(assert (str.is_base64 jwt_payload))
(assert (str.is_base64 jwt_signature))

; API key validation
(declare-const api_key String)
(assert (str.contains api_key "-"))
(assert (>= (str.num_splits api_key "-") 2)) ; At least prefix and secret

(declare-const api_prefix String)
(declare-const api_secret String)
(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_secret (str.split_rest api_key "-" 1)))

; API prefix must be 3 uppercase letters
(assert (= (str.len api_prefix) 3))
(assert (str.prefixof "API" api_prefix))

; Timestamp validation (common in API keys)
(declare-const timestamp String)
(assert (str.contains api_secret ":"))
(assert (= timestamp (str.split_at api_secret ":" 0)))
(assert (= (str.len timestamp) 10)) ; Unix timestamp length

; ; Signature checking (simplified)
(declare-const expected_sig String)
(assert (str.suffixof expected_sig jwt_token))

; Unsatisfiable case - invalid JWT structure
(declare-const bad_jwt String)
(assert (str.contains bad_jwt "."))
(assert (= (str.num_splits bad_jwt ".") 2)) ; Missing signature part
(assert (not (str.is_base64 (str.split_at bad_jwt "." 1))))

; Satisfiable case - valid API key
(declare-const good_api_key String)
(assert (= good_api_key "API-1234567890:abcdef"))
(assert (= (str.num_splits good_api_key "-") 2))
(assert (= (str.num_splits (str.split_rest good_api_key "-" 1) ":") 2))

(check-sat)
(exit)
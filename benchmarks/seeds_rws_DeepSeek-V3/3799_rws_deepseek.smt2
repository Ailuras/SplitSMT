
(set-logic QF_S) ; Set the string theory

; Declare string constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; JWT token validation constraints
(declare-const jwt_token String)
; JWT should have exactly 3 parts separated by dots
(assert (= (str.num_splits jwt_token dot) 3))
; ; Extract JWT segments
(declare-const jwt_header String)
(assert (= jwt_header (str.split_at jwt_token dot 0)))
(declare-const jwt_payload String)
(assert (= jwt_payload (str.split_at jwt_token dot 1)))
(declare-const jwt_signature String)
(assert (= jwt_signature (str.split_at jwt_token dot 2)))

; ; Header and payload must be valid base64 (simplified check - just length multiple of 4)
(assert (= (mod (str.len jwt_header) 4) 0))
(assert (= (mod (str.len jwt_payload) 4) 0))

; API key validation constraints
(declare-const api_key String)
; API key should have 4 parts separated by dashes
(assert (= (str.num_splits api_key dash) 4))
; ; Extract API key segments
(declare-const api_prefix String)
(assert (= api_prefix (str.split_at api_key dash 0)))
(declare-const api_client String)
(assert (= api_client (str.split_at api_key dash 1)))
(declare-const api_timestamp String)
(assert (= api_timestamp (str.split_at api_key dash 2)))
(declare-const api_signature String)
(assert (= api_signature (str.split_at api_key dash 3)))

; API prefix must be "sk" or "pk"
(assert (or (= api_prefix "sk") (= api_prefix "pk")))
; Client ID must be exactly 8 hex characters
(assert (= (str.len api_client) 8))
(assert (str.is_hex_digit api_client))
; Timestamp must be exactly 10 digits
(assert (= (str.len api_timestamp) 10))
(assert (str.is_digit api_timestamp))

; Combined constraints for authentication system
; Either JWT or API key must be valid, but not both
(assert (or
 (and
 (= (str.num_splits jwt_token dot) 3)
 (= (mod (str.len jwt_header) 4) 0)
 (= (mod (str.len jwt_payload) 4) 0)
 (= (str.num_splits api_key dash) 0) ; No API key when using JWT
)
 (and
 (= (str.num_splits api_key dash) 4)
 (or (= api_prefix "sk") (= api_prefix "pk"))
 (= (str.len api_client) 8)
 (str.is_hex_digit api_client)
 (= (str.len api_timestamp) 10)
 (str.is_digit api_timestamp)
 (= (str.num_splits jwt_token dot) 0) ; No JWT when using API key
)
))

; ; Unsatisfiable constraint example (comment out to make satisfiable)
;(assert (and
; (= (str.num_splits jwt_token dot) 3)
; (= (str.num_splits api_key dash) 4)
;))

; ; Check if constraints are satisfiable
(check-sat)
(get-model)
(exit)
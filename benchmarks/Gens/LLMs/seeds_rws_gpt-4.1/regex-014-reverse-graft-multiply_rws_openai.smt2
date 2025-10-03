; SMT-LIB2 file for JWT and API key validation using split operations
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation (simplified), signature checking

(set-logic ALL)

; Declare authentication token strings
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; --------------------------
; JWT constraints
; --------------------------

; JWT tokens must have exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract segments of the JWT
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; Simulate base64 validation by requiring segments to be non-empty and not contain delimiters
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))
(assert (= (str.indexof jwt_header "." 0) -1))
(assert (= (str.indexof jwt_payload "." 0) -1))
(assert (= (str.indexof jwt_signature "." 0) -1))

; Signature must be at least 10 characters
(assert (>= (str.len jwt_signature) 10))

; --------------------------
; API key constraints
; --------------------------

; API key must have exactly 2 segments when split by '-'
(assert (= (str.num_splits api_key "-") 2))

(declare-fun api_prefix () String)
(declare-fun api_rest () String)

(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_rest (str.split_at api_key "-" 1)))

; api_rest must have exactly 2 segments when split by ':'
(assert (= (str.num_splits api_rest ":") 2))

(declare-fun api_type () String)
(declare-fun api_secret () String)

(assert (= api_type (str.split_at api_rest ":" 0)))
(assert (= api_secret (str.split_at api_rest ":" 1)))

; Prefix must be "API"
(assert (= api_prefix "API"))

; Type must be "USER" or "ADMIN"
(assert (or (= api_type "USER") (= api_type "ADMIN")))

; Secret must be at least 8 characters and not contain delimiters
(assert (>= (str.len api_secret) 8))
(assert (= (str.indexof api_secret "-" 0) -1))
(assert (= (str.indexof api_secret ":" 0) -1))

; --------------------------
; Relationship between JWT and API key
; The JWT payload must contain the api_type as a substring
(assert (str.contains jwt_payload api_type))

; --------------------------
; Satisfiable scenario
; --------------------------
; No contradictory constraints here; this scenario should be satisfiable

; --------------------------
; Unsatisfiable scenario
; --------------------------
; ; Add an unsatisfiable constraint: Require api_secret to be both "ABCDEFGH" and "12345678"
(assert (not (= api_secret "ABCDEFGH")))
(assert (not (= api_secret "12345678")))
(assert (or (= api_secret "ABCDEFGH") (= api_secret "12345678")))

; --------------------------
; End of file
; --------------------------

(check-sat)
(exit)
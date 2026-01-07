; SMT-LIB2 file for Authentication Token (JWT and API key) validation using split operations
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)
(set-option :produce-models true)

; Declare string variables for inputs
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; JWT tokens are of the form: header.payload.signature (delimited by '.')
; API keys are of the form: prefix-key:signature (delimited by '-' and ':')

; --------------------------------------------------
; ; JWT: Check segment count is 3
(define-fun jwt_segment_count () Int
 (str.num_splits jwt_token "."))

; JWT: Get header, payload, signature
(define-fun jwt_header () String
 (str.split_at jwt_token "." 0))
(define-fun jwt_payload () String
 (str.split_at jwt_token "." 1))
(define-fun jwt_signature () String
 (str.split_at jwt_token "." 2))

; JWT: Check base64 validity (simulate by asserting only alphanum and '+', '/', '=' allowed)
(define-fun base64_chars () String
 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=")

; Helper: All chars in string are base64 valid (simulate, since SMT-LIB2 lacks str.replace_all)
(define-fun is_base64 ((s String)) Bool
 (and
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (str.contains base64_chars (str.at s i))))
 true
)
)

; JWT: Signature must not be empty
(define-fun jwt_sig_not_empty () Bool
 (not (= jwt_signature "")))

; ; JWT: Simulate signature checking by requiring signature to be a specific constant (e.g., "validsig")
(define-fun jwt_signature_valid () Bool
 (= jwt_signature "validsig"))

; --------------------------------------------------
; API Key: prefix-key:signature, split by '-' and ':'
; First split by '-' to separate prefix and key:signature
(define-fun api_prefix () String
 (str.split_at api_key "-" 0))
(define-fun api_key_rest () String
 (str.split_rest api_key "-" 1))

; Then split api_key_rest by ':' to get key and signature
(define-fun api_key_value () String
 (str.split_at api_key_rest ":" 0))
(define-fun api_key_sig () String
 (str.split_at api_key_rest ":" 1))

; API key: Segment counts
(define-fun api_dash_segments () Int
 (str.num_splits api_key "-"))
(define-fun api_colon_segments () Int
 (str.num_splits api_key_rest ":"))

; API: Key is base64, signature is not empty
(define-fun api_key_is_base64 () Bool
 (is_base64 api_key_value))
(define-fun api_sig_not_empty () Bool
 (not (= api_key_sig "")))

; ; API: Simulate signature check (e.g., expect signature to be "apivalidsig")
(define-fun api_signature_valid () Bool
 (= api_key_sig "apivalidsig"))

; --------------------------------------------------
; Satisfiable scenario: Both JWT and API key are valid

(assert (= jwt_segment_count 3))
(assert (is_base64 jwt_header))
(assert (is_base64 jwt_payload))
(assert jwt_sig_not_empty)
(assert jwt_signature_valid)

(assert (= api_dash_segments 2))
(assert (= api_colon_segments 2))
(assert api_key_is_base64)
(assert api_sig_not_empty)
(assert api_signature_valid)

; --------------------------------------------------
; Unsatisfiable scenario: Require the JWT signature to be both 'validsig' and 'invalidsig'

(assert (= jwt_signature "invalidsig"))

; The above two assertions on jwt_signature cause unsatisfiability

(check-sat)
(exit)
; SMT-LIB2 file for Authentication Token: JWT and API key validation
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)

; Declare variables for JWT and API key strings
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; JWT tokens are typically in the form: header.payload.signature (Base64 parts, separated by '.')
; ; Example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c

; API keys are typically in the form: prefix-key:signature (e.g., "AKIA-1234:ABCD")
; ; Example: AKIA-1234:ABCD

; --- JWT Constraints ---

; JWT must have exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; Declare variables for each JWT segment
(define-fun jwt_header () String (str.split_at jwt_token "." 0))
(define-fun jwt_payload () String (str.split_at jwt_token "." 1))
(define-fun jwt_sig () String (str.split_at jwt_token "." 2))

; Base64 validation (very simplified): base64 strings should not contain '.' or '-' or ':'
(assert (not (str.contains jwt_header ".")))
(assert (not (str.contains jwt_header "-")))
(assert (not (str.contains jwt_header ":")))

(assert (not (str.contains jwt_payload ".")))
(assert (not (str.contains jwt_payload "-")))
(assert (not (str.contains jwt_payload ":")))

; Signature part should be non-empty
(assert (not (= jwt_sig "")))

; JWT signature should not contain delimiters (for integrity)
(assert (not (str.contains jwt_sig ".")))
(assert (not (str.contains jwt_sig "-")))
(assert (not (str.contains jwt_sig ":")))

; --- API Key Constraints ---

; API key must have 2 segments when split by ':' (prefix-key, signature)
(assert (= (str.num_splits api_key ":") 2))

; Declare variables for each API key segment
(define-fun api_prefixkey () String (str.split_at api_key ":" 0))
(define-fun api_signature () String (str.split_at api_key ":" 1))

; The prefix and key are separated by '-'
(assert (= (str.num_splits api_prefixkey "-") 2))

(define-fun api_prefix () String (str.split_at api_prefixkey "-" 0))
(define-fun api_keyid () String (str.split_at api_prefixkey "-" 1))

; Prefix must start with 'AKIA'
(assert (str.prefixof "AKIA" api_prefix))

; Signature must be alphanumeric (simplified: does not contain delimiters)
(assert (not (str.contains api_signature ".")))
(assert (not (str.contains api_signature "-")))
(assert (not (str.contains api_signature ":")))

; The key id should not be empty
(assert (not (= api_keyid "")))

; ; --- Satisfiable Example ---

; There exists a jwt_token and api_key satisfying the above constraints

; ; --- Unsatisfiable Example: JWT with wrong segment count ---

(declare-fun bad_jwt () String)
; Bad JWT: only has 2 segments instead of 3
(assert (= (str.num_splits bad_jwt ".") 2))
; But require it to satisfy the same base64 constraints as a valid JWT
(assert (not (str.contains (str.split_at bad_jwt "." 0) ".")))
(assert (not (str.contains (str.split_at bad_jwt "." 1) ".")))
; Also require the (non-existent) third segment to be non-empty (unsatisfiable)
(assert (not (= (str.split_at bad_jwt "." 2) "")))

; ; --- Unsatisfiable Example: API key with invalid prefix ---

(declare-fun bad_api_key () String)
(assert (= (str.num_splits bad_api_key ":") 2))
(define-fun bad_api_prefixkey () String (str.split_at bad_api_key ":" 0))
(define-fun bad_api_signature () String (str.split_at bad_api_key ":" 1))
(assert (= (str.num_splits bad_api_prefixkey "-") 2))
(define-fun bad_api_prefix () String (str.split_at bad_api_prefixkey "-" 0))
(define-fun bad_api_keyid () String (str.split_at bad_api_prefixkey "-" 1))
; Require prefix to be 'ZZZZ', which conflicts with AKIA requirement, making it unsatisfiable
(assert (= bad_api_prefix "ZZZZ"))
(assert (str.prefixof "AKIA" bad_api_prefix))

; --- End of constraints ---

(check-sat)
(exit)
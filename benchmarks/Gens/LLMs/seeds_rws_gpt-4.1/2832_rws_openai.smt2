; SMT-LIB2 file for Authentication Token: JWT and API key validation
; Split operations used: str.split_at, str.num_splits, str.split_rest
; Delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)

; Declare the input tokens as string variables
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; Auxiliary variables for JWT segments
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Auxiliary variables for API key segments
(declare-fun api_id () String)
(declare-fun api_mid () String)
(declare-fun api_tail () String)

; ---------------------------------------------
; JWT VALIDATION
; JWTs are "header.payload.signature" (3 segments, delimiter '.')
; ---------------------------------------------

; The JWT must have exactly 3 segments split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract header, payload, signature
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; ; Example: Enforce header is base64 (only [A-Za-z0-9+/=])
; We'll approximate base64 for SMT by requiring no '-' or ':' present and nonempty
(assert (not (str.contains jwt_header "-")))
(assert (not (str.contains jwt_header ":")))
(assert (not (= jwt_header "")))

; Similarly, payload is base64-encoded (approximate)
(assert (not (str.contains jwt_payload "-")))
(assert (not (str.contains jwt_payload ":")))
(assert (not (= jwt_payload "")))

; Signature is base64url (usually [A-Za-z0-9-_]+) but for this test, enforce no ':' present and nonempty
(assert (not (str.contains jwt_signature ":")))
(assert (not (= jwt_signature "")))

; ; Signature check: JWT signature must not be "invalidsig"
(assert (not (= jwt_signature "invalidsig")))

; ---------------------------------------------
; API KEY VALIDATION
; API keys are of the form: "id-mid:tail"
; Typical delimiters: '-', ':'
; Enforce segment counts and relationships
; ---------------------------------------------

; The API key must split into exactly 2 segments with ':' (id-mid, tail)
(assert (= (str.num_splits api_key ":") 2))
(assert (= api_tail (str.split_at api_key ":" 1)))

; The first segment ("id-mid") must itself split into exactly 2 segments with '-' (id, mid)
(assert (= (str.num_splits (str.split_at api_key ":" 0) "-") 2))
(assert (= api_id (str.split_at (str.split_at api_key ":" 0) "-" 0)))
(assert (= api_mid (str.split_at (str.split_at api_key ":" 0) "-" 1)))

; Enforce all segments are nonempty
(assert (not (= api_id "")))
(assert (not (= api_mid "")))
(assert (not (= api_tail "")))

; API key validity: tail must be a 16-char alphanumeric string (approx: length = 16, no delimiters)
(assert (= (str.len api_tail) 16))
(assert (not (str.contains api_tail "-")))
(assert (not (str.contains api_tail ":")))
(assert (not (str.contains api_tail ".")))

; ---------------------------------------------
; ; SATISFIABLE EXAMPLE CONSTRAINTS
; There exist such tokens with these properties
; ---------------------------------------------

; For demonstration: allow any token satisfying above constraints

; ---------------------------------------------
; UNSATISFIABLE COMBINATION
; ; Example: Enforce that the JWT header contains ':' which contradicts the base64 check above
; ---------------------------------------------

(assert (str.contains jwt_header ":"))

; ; Check satisfiability (should be unsat because header cannot contain ':' and not contain ':' at the same time)
(check-sat)
(exit)
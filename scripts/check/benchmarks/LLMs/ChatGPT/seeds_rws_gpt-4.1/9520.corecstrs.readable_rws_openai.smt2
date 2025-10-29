; SMT-LIB2 file for Authentication Token: JWT and API key validation
; Delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)
(set-option :produce-models true)

; Declare variables for the JWT token and its segments
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; JWTs are of the form: base64(header) . base64(payload) . base64(signature)
; There must be exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract the three segments
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; ; Base64 validation: For simplicity, we check that the header and payload contain only base64 characters.
; Base64 alphabet: [A-Za-z0-9+/], but JWT uses URL-safe base64: [A-Za-z0-9-_]
; ; We'll check that header and payload consist only of these characters:
(define-fun is_base64url ((s String)) Bool
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (or (and (<= 48 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 57)) ; '0'-'9'
 (and (<= 65 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 90)) ; 'A'-'Z'
 (and (<= 97 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 122)) ; 'a'-'z'
 (= (str.at s i) "-")
 (= (str.at s i) "_")
)
)
)
)

(assert (is_base64url jwt_header))
(assert (is_base64url jwt_payload))
; For signature, it might be empty or base64, but let's require base64url too for this scenario
(assert (is_base64url jwt_signature))

; ; Signature checking: Suppose we have a known valid signature for a given header and payload
(declare-fun known_signature () String)
(assert (= jwt_signature known_signature))

; Unsatisfiable combination: 
; Suppose the known_signature is set to a value that cannot be produced from any valid base64 string of length > 0
(assert (= known_signature "!!!invalid_base64!!!"))
; This makes the problem UNSAT because jwt_signature must be base64url, but "!!!invalid_base64!!!" is not.

; Now, model an API Key validation scenario
; ; Example: API keys are of the form "prefix-username:secret"
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_username () String)
(declare-fun api_secret () String)

; API keys must have exactly 2 segments if split by ':'
(assert (= (str.num_splits api_key ":") 2))
(assert (= api_secret (str.split_at api_key ":" 1)))

; The part before ':' is "prefix-username"
(declare-fun prefix_and_username () String)
(assert (= prefix_and_username (str.split_at api_key ":" 0)))

; prefix_and_username must have exactly 2 segments if split by '-'
(assert (= (str.num_splits prefix_and_username "-") 2))
(assert (= api_prefix (str.split_at prefix_and_username "-" 0)))
(assert (= api_username (str.split_at prefix_and_username "-" 1)))

; Suppose only certain prefixes are allowed (e.g., "api", "user")
(assert (or (= api_prefix "api") (= api_prefix "user")))

; Username must be non-empty and all lowercase letters
(define-fun is_lower_alpha ((s String)) Bool
 (and (> (str.len s) 0)
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (and (<= 97 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 122)) ; 'a'-'z'
)
)
)
)
(assert (is_lower_alpha api_username))

; API secret must not contain ':' or '-'
(assert (= (str.indexof api_secret ":" 0) -1))
(assert (= (str.indexof api_secret "-" 0) -1))

; ; Satisfiable constraint: There exists an API key with prefix 'api', username 'alice', and secret 's3cr3t'
(assert (= api_prefix "api"))
(assert (= api_username "alice"))
(assert (= api_secret "s3cr3t"))
(assert (= api_key "api-alice:s3cr3t"))

; ; Satisfiable JWT example: All segments are base64url and signature is "abcDEF-_"
(assert (not (= jwt_token "")))
(assert (= jwt_header "abcDEF-_"))
(assert (= jwt_payload "uvwXYZ-1"))
(assert (= jwt_signature "abcDEF-_"))
(assert (= jwt_token (str.++ jwt_header "." jwt_payload "." jwt_signature)))

(check-sat)
(exit)
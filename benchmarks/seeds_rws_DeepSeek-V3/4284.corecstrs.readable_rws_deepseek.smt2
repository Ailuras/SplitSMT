; SMT-LIB2 script for JWT and API key validation with split operations
; ; Focuses on segment count, base64 validation, and signature checking
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and functions
(declare-sort String 0)
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.substr (String Int Int) String)
(declare-fun str.at (String Int) String)
(declare-fun str.is_base64 (String) Bool)

; Custom split functions
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; ; Example JWT token: header.payload.signature
(declare-const jwt_token String)
(declare-const api_key String)

; Delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; JWT constraints
; 1. Must have exactly 2 dots (3 segments)
(assert (= (str.num_splits jwt_token dot) 2))

; 2. All segments must be base64 encoded
(assert (str.is_base64 (str.split_at jwt_token dot 0))) ; header
(assert (str.is_base64 (str.split_at jwt_token dot 1))) ; payload
(assert (str.is_base64 (str.split_at jwt_token dot 2))) ; signature

; 3. Signature must be at least 32 chars
(assert (>= (str.len (str.split_at jwt_token dot 2)) 32))

; API key constraints (format: prefix-keyid-secret)
; 1. Must have exactly 2 dashes (3 segments)
(assert (= (str.num_splits api_key dash) 2))

; 2. First segment (prefix) must be "api"
(assert (= (str.split_at api_key dash 0) "api"))

; 3. Second segment (keyid) must be alphanumeric and length 8
(declare-const keyid String)
(assert (= keyid (str.split_at api_key dash 1)))
(assert (= (str.len keyid) 8))
(assert (str.is_base64 keyid)) ; Using base64 as alphanumeric proxy

; 4. Third segment (secret) must be at least 16 chars
(assert (>= (str.len (str.split_at api_key dash 2)) 16))

; Combined constraints
; 1. Either JWT or API key must be valid (but not both)
(assert (or
 (and
 (= (str.num_splits jwt_token dot) 2)
 (str.is_base64 (str.split_at jwt_token dot 0))
 (str.is_base64 (str.split_at jwt_token dot 1))
 (str.is_base64 (str.split_at jwt_token dot 2))
 (>= (str.len (str.split_at jwt_token dot 2)) 32)
 (not (= (str.num_splits api_key dash) 2))
)
 (and
 (= (str.num_splits api_key dash) 2)
 (= (str.split_at api_key dash 0) "api")
 (= (str.len (str.split_at api_key dash 1)) 8)
 (str.is_base64 (str.split_at api_key dash 1))
 (>= (str.len (str.split_at api_key dash 2)) 16)
 (not (= (str.num_splits jwt_token dot) 2))
)
))

; Unsatisfiable case: both tokens cannot be valid
(assert (not (and
 (= (str.num_splits jwt_token dot) 2)
 (str.is_base64 (str.split_at jwt_token dot 0))
 (str.is_base64 (str.split_at jwt_token dot 1))
 (str.is_base64 (str.split_at jwt_token dot 2))
 (>= (str.len (str.split_at jwt_token dot 2)) 32)
 (= (str.num_splits api_key dash) 2)
 (= (str.split_at api_key dash 0) "api")
 (= (str.len (str.split_at api_key dash 1)) 8)
 (str.is_base64 (str.split_at api_key dash 1))
 (>= (str.len (str.split_at api_key dash 2)) 16)
)))

(check-sat)
(get-model)
(exit)
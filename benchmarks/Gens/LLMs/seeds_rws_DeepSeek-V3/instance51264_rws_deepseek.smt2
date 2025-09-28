
; SMT-LIB2 file for JWT and API key validation
(set-logic QF_SLIA) ; Quantifier-free strings
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.is_base64 (String) Bool)
(declare-fun str.is_alphanum (String) Bool)

; Declare variables
(declare-const token String) ; JWT token
(declare-const api_key String) ; API key
(declare-const secret String) ; Secret for signature validation

; Delimiters
(define-const dot String ".")
(define-const dash String "-")
(define-const colon String ":")

; JWT constraints (3 segments separated by dots)
(assert (= (str.num_splits token dot) 3))
(assert (str.is_base64 (str.split_at token dot 0))) ; Header
(assert (str.is_base64 (str.split_at token dot 1))) ; Payload
(assert (> (str.len (str.split_at token dot 2)) 0)) ; Signature (non-empty)

; API key constraints (3 segments separated by colons)
(assert (= (str.num_splits api_key colon) 3))
(assert (str.is_alphanum (str.split_at api_key colon 0))) ; Client ID
(assert (str.is_alphanum (str.split_at api_key colon 1))) ; Key ID
(assert (> (str.len (str.split_at api_key colon 2)) 32)) ; Secret part (min 32 chars)

; Signature validation (simplified)
; In reality, this would involve cryptographic operations
(define-const jwt_sig String (str.split_at token dot 2))
(assert (str.contains jwt_sig secret)) ; Signature must contain the secret

; API key format validation (prefix-key-suffix)
(assert (str.prefixof "api_" (str.split_at api_key dash 0)))
(assert (str.suffixof "_key" (str.split_at api_key dash 2)))

; Combined constraints
(assert (not (= token "")))
(assert (not (= api_key "")))
(assert (not (= secret "")))

; Unsatisfiable case - invalid JWT segment count
(assert (= (str.num_splits token dot) 2)) ; Should be 3
(check-sat) ; Should be UNSAT


(exit)
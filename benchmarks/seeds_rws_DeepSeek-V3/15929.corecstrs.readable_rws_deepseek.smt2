
(set-logic QF_S)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; Declare token variables
(declare-const jwt String)
(declare-const api_key String)

; JWT must have exactly 3 parts separated by dots
(assert (= (str.num_splits jwt dot) 3))

; ; Extract JWT segments
(declare-const jwt_header String)
(assert (= jwt_header (str.split_at jwt dot 0)))

(declare-const jwt_payload String)
(assert (= jwt_payload (str.split_at jwt dot 1)))

(declare-const jwt_sig String)
(assert (= jwt_sig (str.split_at jwt dot 2)))

; JWT segments must not be empty
(assert (not (= jwt_header "")))
(assert (not (= jwt_payload "")))
(assert (not (= jwt_sig "")))

; API key must have 4 parts separated by dashes
(assert (= (str.num_splits api_key dash) 4))

; ; Extract API key segments
(declare-const api_prefix String)
(assert (= api_prefix (str.split_at api_key dash 0)))

(declare-const api_part1 String)
(assert (= api_part1 (str.split_at api_key dash 1)))

(declare-const api_part2 String)
(assert (= api_part2 (str.split_at api_key dash 2)))

(declare-const api_rest String)
(assert (= api_rest (str.split_rest api_key dash 3)))

; API key prefix must be "AKIA"
(assert (= api_prefix "AKIA"))

; API key parts must be alphanumeric (simplified)
(assert (str.contains "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" api_part1))
(assert (str.contains "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" api_part2))

; API rest part must contain a colon
(assert (str.contains api_rest colon))

; Split the timestamp from API rest
(declare-const api_timestamp String)
(assert (= api_timestamp (str.split_at api_rest colon 0)))

; Timestamp must be exactly 8 digits
(assert (= (str.len api_timestamp) 8))
(assert (str.is_digit api_timestamp))

; Signature verification (will make this UNSAT)
(declare-const expected_sig String)
(assert (= expected_sig "SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"))
(assert (not (= jwt_sig expected_sig)))

(check-sat)
(get-model)
(exit)

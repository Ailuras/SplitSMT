(set-logic QF_SLIA)
(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :category "industrial")

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_id () String)
(declare-fun api_key_secret () String)

; Declare variables for timestamp validation
(declare-fun timestamp_str () String)
(declare-fun date_part () String)
(declare-fun time_part () String)
(declare-fun hour_part () String)
(declare-fun minute_part () String)

; Base64 character set validation helpers
(declare-fun base64_chars () String)
(declare-fun valid_base64_char (String) Bool)

; Define base64 character set
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure validation
; A valid JWT has exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using dot delimiter
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must be non-empty and contain base64 characters
(assert (> (str.len jwt_header) 0))
(assert (str.contains base64_chars (str.at jwt_header 0)))

; JWT payload must be non-empty and longer than header
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_payload) (str.len jwt_header)))

; JWT signature must be exactly 43 characters for RS256
(assert (= (str.len jwt_signature) 43))

; API key validation with hyphen delimiter
; Format: prefix-keyid-secret (3 segments)
(assert (= (str.num_splits api_key "-") 3))

; ; Extract API key components
(assert (= api_key_prefix (str.split_at api_key "-" 0)))
(assert (= api_key_id (str.split_at api_key "-" 1)))
(assert (= api_key_secret (str.split_at api_key "-" 2)))

; API key prefix must be "ak" or "sk"
(assert (or (= api_key_prefix "ak") (= api_key_prefix "sk")))

; API key ID must be exactly 16 characters
(assert (= (str.len api_key_id) 16))

; API key secret must be at least 32 characters
(assert (>= (str.len api_key_secret) 32))

; Timestamp validation using colon delimiter
; Format: YYYY-MM-DD:HH:MM:SS
(assert (str.contains timestamp_str ":"))
(assert (= (str.num_splits timestamp_str ":") 3))

; ; Extract date and time parts
(assert (= date_part (str.split_at timestamp_str ":" 0)))
(assert (= hour_part (str.split_at timestamp_str ":" 1)))
(assert (= minute_part (str.split_at timestamp_str ":" 2)))

; Date part should be 10 characters (YYYY-MM-DD)
(assert (= (str.len date_part) 10))

; Hour part should be 2 characters
(assert (= (str.len hour_part) 2))

; Minute part should be 2 characters 
(assert (= (str.len minute_part) 2))

; Base64 validation constraints
; Header and payload should only contain valid base64 characters
(assert (str.prefixof (str.substr jwt_header 0 1) base64_chars))
(assert (str.prefixof (str.substr jwt_payload 0 1) base64_chars))

; ; Signature checking constraints
; Signature should not contain invalid characters
(assert (not (str.contains jwt_signature " ")))
(assert (not (str.contains jwt_signature "\n")))
(assert (not (str.contains jwt_signature "\t")))

; Cross-validation between JWT and API key
; If API key prefix is "ak", JWT payload should be longer
(assert (=> (= api_key_prefix "ak") (> (str.len jwt_payload) 100)))

; ; Security constraint: API key secret and JWT signature should not match
(assert (not (= api_key_secret jwt_signature)))

; Segment count validation for nested structures
; JWT header when split by dots should have only 1 segment (no nested dots)
(assert (= (str.num_splits jwt_header ".") 1))

; API key components should not contain their delimiters
(assert (not (str.contains api_key_prefix "-")))
(assert (not (str.contains api_key_id "-")))

; Timestamp components validation
(assert (str.contains date_part "-"))
(assert (= (str.num_splits date_part "-") 3))

; ; Extract year, month, day from date part
(declare-fun year_str () String)
(declare-fun month_str () String)
(declare-fun day_str () String)

(assert (= year_str (str.split_at date_part "-" 0)))
(assert (= month_str (str.split_at date_part "-" 1)))
(assert (= day_str (str.split_at date_part "-" 2)))

; Year should be 4 digits, month and day should be 2 digits
(assert (= (str.len year_str) 4))
(assert (= (str.len month_str) 2))
(assert (= (str.len day_str) 2))

; Additional security constraints
; JWT components concatenated should equal original token with delimiters
(assert (= jwt_token (str.++ jwt_header "." jwt_payload "." jwt_signature)))

; API key components concatenated should equal original key with delimiters 
(assert (= api_key (str.++ api_key_prefix "-" api_key_id "-" api_key_secret)))

; Timestamp components concatenated should equal original timestamp
(assert (= timestamp_str (str.++ date_part ":" hour_part ":" minute_part)))

; Use str.split_rest for validation of remaining segments
(declare-fun jwt_payload_and_sig () String)
(declare-fun api_remaining () String)
(declare-fun time_remaining () String)

(assert (= jwt_payload_and_sig (str.split_rest jwt_token "." 1)))
(assert (= api_remaining (str.split_rest api_key "-" 1)))
(assert (= time_remaining (str.split_rest timestamp_str ":" 1)))

; Remaining segments should contain expected delimiters
(assert (str.contains jwt_payload_and_sig "."))
(assert (str.contains api_remaining "-"))
(assert (str.contains time_remaining ":"))

; ; Final constraint: ensure all tokens have reasonable lengths
(assert (and (> (str.len jwt_token) 50)
 (> (str.len api_key) 20)
 (= (str.len timestamp_str) 19)))

(check-sat)
(exit)
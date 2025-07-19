; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the session token variable
(declare-fun token () String)

; Example token format: "appID:userID:timestamp:hash"

; Declare parts after splitting token by ":"
(declare-fun appID () String)
(declare-fun userID () String)
(declare-fun timestamp () String)
(declare-fun hash () String)

; Ensure token splits into exactly 4 parts
(assert (= (str.num_splits token ":") 4))

; Bind each part using str.split_at
(assert (= appID     (str.split_at token ":" 0)))
(assert (= userID    (str.split_at token ":" 1)))
(assert (= timestamp (str.split_at token ":" 2)))
(assert (= hash      (str.split_at token ":" 3)))

; Semantic constraints:
; appID must be exactly "APP01"
(assert (= appID "APP01"))

; userID must not contain the substring "admin"
(assert (not (str.contains userID "admin")))

; timestamp should be numeric and of fixed length 14 (e.g., YYYYMMDDHHMMSS)
(assert (str.in_re timestamp (re.+ (re.range "0" "9"))))
(assert (= (str.len timestamp) 14))

; hash must not be empty and must have at least length 32
(assert (not (= hash "")))
(assert (>= (str.len hash) 32))

; Verify that no remaining parts exist after extracting four
(assert (= (str.split_rest token ":" 3) ""))

; --- End LLM Generated Constraints ---

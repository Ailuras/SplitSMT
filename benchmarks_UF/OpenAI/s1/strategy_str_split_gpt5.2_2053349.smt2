(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface: string split operations

; Scenario: Log Analysis
; Structured server log entry: "YYYY-MM-DD:HH:MM:SS LEVEL message..."

(declare-const log_entry String)
(declare-const ts_field String)
(declare-const level_field String)
(declare-const msg_field String)

; Keep seed-like variables to preserve core structure and mutate it for logs
(declare-const key2 String)
(declare-const value2 String)

; Core parsing via spaces and colons
(assert (= ts_field (split_at log_entry " " 0)))
(assert (= level_field (split_at log_entry " " 1)))
(assert (= msg_field (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; Model the seed's key/value flavor as extracting a synthetic key=value from the level/message
(assert (= key2 "level"))
(assert (= value2 (str.++ key2 "=" level_field "," msg_field)))

; Basic sanity: entry and fields non-empty
(assert (> (str.len log_entry) 0))
(assert (> (str.len ts_field) 0))
(assert (> (str.len level_field) 0))

; Level must be one of common log levels
(assert (or (= level_field "INFO") (= level_field "WARN") (= level_field "ERROR") (= level_field "DEBUG")))

; Timestamp must contain at least 4 colon-separated pieces: YYYY-MM-DD:HH:MM:SS
(assert (>= (num_splits ts_field ":") 4))

; Enforce exact timestamp length: "YYYY-MM-DD:HH:MM:SS" = 19
(assert (= (str.len ts_field) 19))

; Validate fixed separators at expected positions: 4 and 7 are '-', 10 is ':', 13 is ':', 16 is ':'
(assert (= (str.at ts_field 4) "-"))
(assert (= (str.at ts_field 7) "-"))
(assert (= (str.at ts_field 10) ":"))
(assert (= (str.at ts_field 13) ":"))
(assert (= (str.at ts_field 16) ":"))

; Validate digits using regex for each chunk
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const min String)
(declare-const sec String)

(assert (= yyyy (split_at ts_field ":" 0)))
(assert (= hh (split_at ts_field ":" 1)))
(assert (= min (split_at ts_field ":" 2)))
(assert (= sec (split_at ts_field ":" 3)))

; yyyy contains "YYYY-MM-DD"; split by '-'
(declare-const year String)
(declare-const month String)
(declare-const day String)
(assert (>= (num_splits yyyy "-") 3))
(assert (= year (split_at yyyy "-" 0)))
(assert (= month (split_at yyyy "-" 1)))
(assert (= day (split_at yyyy "-" 2)))

; Length constraints
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hh) 2))
(assert (= (str.len min) 2))
(assert (= (str.len sec) 2))

; Regex: all digits for each numeric component
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_2digits () RegLan (re.++ re_digit re_digit))
(define-fun re_4digits () RegLan (re.++ re_digit (re.++ re_digit (re.++ re_digit re_digit))))
(assert (str.in_re year re_4digits))
(assert (str.in_re month re_2digits))
(assert (str.in_re day re_2digits))
(assert (str.in_re hh re_2digits))
(assert (str.in_re min re_2digits))
(assert (str.in_re sec re_2digits))

; Convert some fields to Int for range checks
(declare-const month_i Int)
(declare-const day_i Int)
(declare-const hh_i Int)
(declare-const min_i Int)
(declare-const sec_i Int)
(assert (= month_i (str.to_int month)))
(assert (= day_i (str.to_int day)))
(assert (= hh_i (str.to_int hh)))
(assert (= min_i (str.to_int min)))
(assert (= sec_i (str.to_int sec)))

; Ranges (conservative)
(assert (and (>= month_i 1) (<= month_i 12)))
(assert (and (>= day_i 1) (<= day_i 31)))
(assert (and (>= hh_i 0) (<= hh_i 23)))
(assert (and (>= min_i 0) (<= min_i 59)))
(assert (and (>= sec_i 0) (<= sec_i 59)))

; Mutated seed-like constraints about delimiters and forbidden leading whitespace/newlines
(assert (not (= (str.at log_entry 0) " ")))
(assert (not (= (str.at log_entry 0) "\u{9}")))
(assert (not (= (str.at log_entry 0) "\u{a}")))

; Require the synthetic key/value to contain both '=' and ',' similar to the seed
(assert (not (= (str.indexof value2 "=" 0) (- 1))))
(assert (str.contains value2 ","))

; --- UNSAT core addition (intentional contradiction for diversity) ---
; If level is ERROR then require it to be INFO simultaneously.
(assert (=> (= level_field "ERROR") (= level_field "INFO")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

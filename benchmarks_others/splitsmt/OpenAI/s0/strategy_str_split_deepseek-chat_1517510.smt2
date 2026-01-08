(set-logic ALL)

; Uninterpreted string split interface

; -----------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Target structure (informal):
;   <timestamp> <level>: <message>
; Example:
;   2026-01-07T12:34:56Z INFO: something happened
; -----------------------------

; Primary log entry (intended SAT)
(declare-const log_line String)
(declare-const ts String)
(declare-const level_colon String)
(declare-const level String)
(declare-const message_rest String)

; Secondary log entry (intended UNSAT via contradictory requirements)
(declare-const bad_log_line String)
(declare-const bad_ts String)
(declare-const bad_level_colon String)
(declare-const bad_level String)

; Regex for strict timestamp: YYYY-MM-DDTHH:MM:SSZ
(declare-const re_digit RegLan)
(declare-const re_2d RegLan)
(declare-const re_4d RegLan)
(declare-const re_ts RegLan)

(assert (= re_digit (re.range "0" "9")))
(assert (= re_2d (re.++ re_digit re_digit)))
(assert (= re_4d (re.++ re_2d re_2d)))
(assert (= re_ts
  (re.++
    re_4d (str.to_re "-") re_2d (str.to_re "-") re_2d
    (str.to_re "T")
    re_2d (str.to_re ":") re_2d (str.to_re ":") re_2d
    (str.to_re "Z"))))

; -----------------------------
; SAT instance constraints
; -----------------------------

; Must have at least 3 space-separated segments: ts, level_colon, and message...
(assert (>= (str.num_splits log_line " ") 3))

; Extract fields by splitting on spaces
(assert (= ts (str.split_at log_line " " 0)))
(assert (= level_colon (str.split_at log_line " " 1)))
(assert (= message_rest (str.split_rest log_line " " 2)))

; Timestamp must match strict format
(assert (str.in_re ts re_ts))

; The second token must contain ':' (e.g., "INFO:")
(assert (str.contains level_colon ":"))

; Extract level by splitting token on ':'
(assert (= level (str.split_at level_colon ":" 0)))

; Level must be one of common values
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Ensure level_colon is exactly <level> + ':' (no extra colons)
(assert (= (str.num_splits level_colon ":") 2))
(assert (= level_colon (str.++ level ":")))

; Message must be non-empty and not start with ':'
(assert (> (str.len message_rest) 0))
(assert (not (= (str.at message_rest 0) ":")))

; Concrete anchor to keep the instance grounded but still symbolic
(assert (str.contains message_rest "request"))

; -----------------------------
; UNSAT instance constraints (separate log line)
; -----------------------------

; Same intended structure, but with contradictory checks
(assert (>= (str.num_splits bad_log_line " ") 2))
(assert (= bad_ts (str.split_at bad_log_line " " 0)))
(assert (= bad_level_colon (str.split_at bad_log_line " " 1)))
(assert (= bad_level (str.split_at bad_level_colon ":" 0)))

; Contradiction: timestamp must match strict regex AND be too short
(assert (str.in_re bad_ts re_ts))
(assert (< (str.len bad_ts) 10))

; Additional plausible constraints (do not affect the core contradiction)
(assert (= (str.num_splits bad_level_colon ":") 2))
(assert (or (= bad_level "INFO") (= bad_level "ERROR")))

(check-sat)


; [GENERATION STATUS: SUCCESS]

(set-logic ALL)

; Log Analysis: parsing structured server log entries separated by spaces and colons.
; We model split constraints using the provided str_split interface and add
; timestamp format validation plus log level extraction.

; --- str_split interface (uninterpreted) ---

; --- Shared regex building blocks ---
(declare-const DIGIT_RE RegLan)
(assert (= DIGIT_RE (re.range "0" "9")))

(declare-const TWO_DIGITS_RE RegLan)
(assert (= TWO_DIGITS_RE (re.++ DIGIT_RE DIGIT_RE)))

(declare-const FOUR_DIGITS_RE RegLan)
(assert (= FOUR_DIGITS_RE (re.++ DIGIT_RE DIGIT_RE DIGIT_RE DIGIT_RE)))

; timestamp: YYYY-MM-DDTHH:MM:SSZ
(declare-const TS_RE RegLan)
(assert (= TS_RE
  (re.++ FOUR_DIGITS_RE (str.to_re "-") TWO_DIGITS_RE (str.to_re "-") TWO_DIGITS_RE
         (str.to_re "T") TWO_DIGITS_RE (str.to_re ":") TWO_DIGITS_RE (str.to_re ":") TWO_DIGITS_RE
         (str.to_re "Z"))))

; level: INFO|WARN|ERROR|DEBUG
(declare-const LEVEL_RE RegLan)
(assert (= LEVEL_RE
  (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; -----------------------------
; SAT instance: well-formed entry
; Format example:
;   2026-01-07T12:34:56Z INFO auth:user=jdoe action=login status:200
; We validate timestamp token and level token and parse colon-separated status.
; -----------------------------

(declare-const log_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const status_field_sat String)
(declare-const status_code_sat String)

; Split by spaces: ts, level, remainder
(assert (= ts_sat (str.split_at log_sat " " 0)))
(assert (= lvl_sat (str.split_at log_sat " " 1)))
(assert (= msg_sat (str.split_rest log_sat " " 2)))
(assert (>= (str.num_splits log_sat " ") 3))

; Timestamp and level validation
(assert (str.in_re ts_sat TS_RE))
(assert (str.in_re lvl_sat LEVEL_RE))

; Ensure message contains a status field with a colon
(assert (str.contains msg_sat "status:"))
(assert (= status_field_sat (str.split_at msg_sat " " 2)))
(assert (str.contains status_field_sat "status:"))

; Parse status_field by colon: "status" ":" "200"
(assert (= (str.split_at status_field_sat ":" 0) "status"))
(assert (= status_code_sat (str.split_at status_field_sat ":" 1)))
(assert (>= (str.num_splits status_field_sat ":") 2))
(assert (str.in_re status_code_sat (re.++ DIGIT_RE DIGIT_RE DIGIT_RE)))

; Constrain the concrete log to witness satisfiable parsing
(assert (= log_sat "2026-01-07T12:34:56Z INFO auth:user=jdoe action=login status:200"))

; -----------------------------
; UNSAT instance: conflicting requirements
; We require the extracted level to be a valid level token, but also force it to be "VERBOSE".
; Additionally, we require the timestamp to match TS_RE, but force a malformed timestamp.
; -----------------------------

(declare-const log_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_unsat String)

(assert (= ts_unsat (str.split_at log_unsat " " 0)))
(assert (= lvl_unsat (str.split_at log_unsat " " 1)))
(assert (>= (str.num_splits log_unsat " ") 2))

(assert (str.in_re ts_unsat TS_RE))
(assert (str.in_re lvl_unsat LEVEL_RE))

; Force contradictions
(assert (= lvl_unsat "VERBOSE"))
(assert (= ts_unsat "2026-1-07T12:34:56Z"))

; Also pin the overall log to be consistent with those first two tokens
(assert (= log_unsat (str.++ ts_unsat " " lvl_unsat " something:here")))

(check-sat)


; [GENERATION STATUS: SUCCESS]

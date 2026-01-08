(set-logic ALL)
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks include timestamp format validation and log level extraction.

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- Variables ---
(declare-const log_line String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const msg_tail String)

(declare-const k Int)

; --- Core structure: split by spaces, then split component: by ':' ---
(assert (= ts (split_at log_line " " 0)))
(assert (= level (split_at log_line " " 1)))
(assert (= component (split_at log_line " " 2)))
(assert (= msg_tail (split_rest log_line " " 3)))

(assert (>= (num_splits log_line " ") 4))
(assert (>= k 0))
(assert (<= k (str.len log_line)))

; component is like "service:" (trailing colon)
(assert (str.suffixof ":" component))
(assert (>= (num_splits component ":") 2))
(assert (= "" (split_at component ":" 1)))

; message is remainder; require non-empty, no leading spaces
(assert (= message msg_tail))
(assert (> (str.len message) 0))
(assert (not (str.prefixof " " message)))

; --- Timestamp format validation (mutated from seed) ---
; Accept: YYYY-MM-DDTHH:MM:SS or YYYY/MM/DD HH:MM:SS
(assert (str.in_re ts
  (re.++
    (str.to_re "20")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (re.union (str.to_re "-") (str.to_re "/"))
    (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2")))
    (re.union (str.to_re "-") (str.to_re "/"))
    (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (str.to_re "3") (re.range "0" "1")))
    (re.union (str.to_re "T") (str.to_re " "))
    (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3")))
    (str.to_re ":")
    (re.range "0" "5") (re.range "0" "9")
    (str.to_re ":")
    (re.range "0" "5") (re.range "0" "9")
  )
))

; Additional timestamp checks: fixed length 19, and no timezone suffix
(assert (= (str.len ts) 19))
(assert (not (str.contains ts "Z")))
(assert (not (str.contains ts "+")))

; --- Log level extraction and validation ---
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Ensure level token is exactly one of them (no brackets)
(assert (not (str.contains level "[")))
(assert (not (str.contains level "]")))

; --- Message constraints (basic log analysis properties) ---
; Must not contain newline, but may contain colons
(assert (not (str.contains message "\n")))
(assert (not (str.contains message "\r")))

; If level is ERROR then message must mention a keyword
(assert (=> (= level "ERROR") (str.contains message "exception")))

; --- Include an UNSAT branch to ensure diversity ---
; Contradiction: if level is DEBUG then it must be exactly "INFO".
(assert (=> (= level "DEBUG") (= level "INFO")))

(check-sat)


; [GENERATION STATUS: SUCCESS]

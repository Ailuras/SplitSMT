(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Checks: timestamp format validation and log level extraction.

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Primitive string/arith variables ---
(declare-const log_line String)
(declare-const ts String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_bracketed String)
(declare-const level String)
(declare-const message String)

(declare-const y String)
(declare-const m String)
(declare-const d String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

(declare-const digits2 RegLan)
(declare-const digits4 RegLan)
(declare-const dash RegLan)
(declare-const colon RegLan)

(declare-const idx_bracket_close Int)

; =========================
; SAT instance: well-formed log line
; Format: YYYY-MM-DD HH:MM:SS [LEVEL] message...
; =========================

; Concrete example log line
(assert (= log_line "2026-01-09 13:45:07 [INFO] Service started"))

; Split by spaces: ts = first two tokens (date and time)
(assert (>= (num_splits log_line " ") 4))
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= ts (str.++ date_part " " time_part)))
(assert (= level_bracketed (split_at log_line " " 2)))
(assert (= message (split_rest log_line " " 3)))

; Timestamp structure checks
(assert (= y (split_at date_part "-" 0)))
(assert (= m (split_at date_part "-" 1)))
(assert (= d (split_at date_part "-" 2)))
(assert (= hh (split_at time_part ":" 0)))
(assert (= mm (split_at time_part ":" 1)))
(assert (= ss (split_at time_part ":" 2)))

; Ensure split counts match expected tokenization
(assert (= (num_splits date_part "-") 3))
(assert (= (num_splits time_part ":") 3))

; Regex for digits
(assert (= digits2 (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (= digits4 (re.++ digits2 digits2)))
(assert (= dash (str.to_re "-")))
(assert (= colon (str.to_re ":")))

; Validate date/time components are correct lengths and digit-only
(assert (str.in_re y digits4))
(assert (str.in_re m digits2))
(assert (str.in_re d digits2))
(assert (str.in_re hh digits2))
(assert (str.in_re mm digits2))
(assert (str.in_re ss digits2))

; Validate date_part matches YYYY-MM-DD, time_part matches HH:MM:SS
(assert (str.in_re date_part (re.++ digits4 dash digits2 dash digits2)))
(assert (str.in_re time_part (re.++ digits2 colon digits2 colon digits2)))

; Log level extraction: [INFO] -> INFO
(assert (>= (str.len level_bracketed) 2))
(assert (= (str.at level_bracketed 0) "["))
(assert (= idx_bracket_close (str.indexof level_bracketed "]" 0)))
(assert (>= idx_bracket_close 1))
(assert (= (str.len level_bracketed) (+ idx_bracket_close 1)))
(assert (= level (str.substr level_bracketed 1 (- idx_bracket_close 1))))

; Check level is one of common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Basic message checks
(assert (>= (str.len message) 1))
(assert (not (str.contains message "\n")))

(check-sat)

; =========================
; UNSAT instance: contradictory timestamp constraints
; Reuse a second log line but force impossible digit/length properties.
; =========================

(push 1)
(declare-const bad_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_y String)
(declare-const bad_m String)
(declare-const bad_d String)
(declare-const bad_hh String)
(declare-const bad_mm String)
(declare-const bad_ss String)

(assert (= bad_line "2026-1-09 13:45:07 [INFO] ok"))
(assert (>= (num_splits bad_line " ") 4))
(assert (= bad_date (split_at bad_line " " 0)))
(assert (= bad_time (split_at bad_line " " 1)))

; Decompose and require strict 2-digit month/day/time tokens
(assert (= bad_y (split_at bad_date "-" 0)))
(assert (= bad_m (split_at bad_date "-" 1)))
(assert (= bad_d (split_at bad_date "-" 2)))
(assert (= bad_hh (split_at bad_time ":" 0)))
(assert (= bad_mm (split_at bad_time ":" 1)))
(assert (= bad_ss (split_at bad_time ":" 2)))

(assert (= (num_splits bad_date "-") 3))
(assert (= (num_splits bad_time ":") 3))

; Must match fixed-width date/time
(assert (str.in_re bad_date (re.++ digits4 dash digits2 dash digits2)))
(assert (str.in_re bad_time (re.++ digits2 colon digits2 colon digits2)))

; But also require the month token to be exactly "1" (length 1), which contradicts digits2
(assert (= bad_m "1"))
(assert (str.in_re bad_m digits2))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)
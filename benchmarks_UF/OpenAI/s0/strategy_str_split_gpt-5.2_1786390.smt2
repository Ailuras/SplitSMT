(set-logic ALL)

; Uninterpreted string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; Scenario: Log Analysis
; Structured log format (informal):
;   YYYY-MM-DD HH:MM:SS:LEVEL: message...
; Delimiters: space separates date/time from the rest, colons separate time fields and level.
; -----------------------------

; === SAT instance: a plausible well-formed log entry ===
(declare-const log_line_sat String)
(declare-const sat_part0 String)
(declare-const sat_part1plus String)
(declare-const sat_date String)
(declare-const sat_time_and_level_and_msg String)
(declare-const sat_time_h String)
(declare-const sat_time_m String)
(declare-const sat_time_s String)
(declare-const sat_level String)
(declare-const sat_msg String)

; Split by single space: date and the remainder
(assert (>= (num_splits log_line_sat " ") 2))
(assert (= sat_part0 (split_at log_line_sat " " 0)))
(assert (= sat_part1plus (split_rest log_line_sat " " 1)))
(assert (= sat_date sat_part0))
(assert (= sat_time_and_level_and_msg sat_part1plus))

; Date format: YYYY-MM-DD
(assert (str.in_re sat_date (str.to_re "2026-01-09")))

; Time+level+msg split by ':' => HH : MM : SS : LEVEL : <rest>
(assert (>= (num_splits sat_time_and_level_and_msg ":") 5))
(assert (= sat_time_h (split_at sat_time_and_level_and_msg ":" 0)))
(assert (= sat_time_m (split_at sat_time_and_level_and_msg ":" 1)))
(assert (= sat_time_s (split_at sat_time_and_level_and_msg ":" 2)))
(assert (= sat_level  (split_at sat_time_and_level_and_msg ":" 3)))
(assert (= sat_msg    (split_rest sat_time_and_level_and_msg ":" 4)))

; Basic timestamp component checks
(assert (str.in_re sat_time_h (re.union (str.to_re "00") (str.to_re "23"))))
(assert (str.in_re sat_time_m (re.union (str.to_re "00") (str.to_re "59"))))
(assert (str.in_re sat_time_s (re.union (str.to_re "00") (str.to_re "59"))))

; Log level extraction: must be one of common levels
(assert (str.in_re sat_level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message should be non-empty and can contain spaces/colons (modeled loosely)
(assert (>= (str.len sat_msg) 1))

; Also tie log_line_sat to a concrete exemplar to guarantee SAT
(assert (= log_line_sat "2026-01-09 23:59:59:INFO: service started"))

; === UNSAT instance: contradictory constraints about level and timestamp ===
(declare-const log_line_unsat String)
(declare-const uns_part0 String)
(declare-const uns_part1plus String)
(declare-const uns_date String)
(declare-const uns_time_and_level_and_msg String)
(declare-const uns_time_h String)
(declare-const uns_time_m String)
(declare-const uns_time_s String)
(declare-const uns_level String)
(declare-const uns_msg String)

(assert (>= (num_splits log_line_unsat " ") 2))
(assert (= uns_part0 (split_at log_line_unsat " " 0)))
(assert (= uns_part1plus (split_rest log_line_unsat " " 1)))
(assert (= uns_date uns_part0))
(assert (= uns_time_and_level_and_msg uns_part1plus))

; Set a concrete log line
(assert (= log_line_unsat "2026-01-09 12:34:56:INFO: hello"))

; Parse time/level/msg
(assert (>= (num_splits uns_time_and_level_and_msg ":") 5))
(assert (= uns_time_h (split_at uns_time_and_level_and_msg ":" 0)))
(assert (= uns_time_m (split_at uns_time_and_level_and_msg ":" 1)))
(assert (= uns_time_s (split_at uns_time_and_level_and_msg ":" 2)))
(assert (= uns_level  (split_at uns_time_and_level_and_msg ":" 3)))
(assert (= uns_msg    (split_rest uns_time_and_level_and_msg ":" 4)))

; Contradiction 1: extracted level must be ERROR, but concrete line has INFO
(assert (= uns_level "ERROR"))

; Contradiction 2: force impossible time second value given concrete line has 56
(assert (= uns_time_s "00"))

; Ensure message is non-empty (irrelevant, but adds diversity)
(assert (>= (str.len uns_msg) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

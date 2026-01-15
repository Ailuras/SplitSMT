(set-logic ALL)

; Log Analysis scenario: parsing structured server log entries separated by spaces and colons
; We create both SAT and UNSAT instances by asserting a disjunction of two cases.

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const log_line String)
(declare-const ts String)
(declare-const lvl String)
(declare-const msg String)

; Additional extracted timestamp fields
(declare-const date String)
(declare-const time String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Regex helpers
(declare-const re2 (RegLan String))
(declare-const re4 (RegLan String))
(declare-const reDate (RegLan String))
(declare-const reTime (RegLan String))
(declare-const reTS (RegLan String))

; --- Regex definitions for timestamp format YYYY-MM-DD:HH:MM:SS ---
(assert (= re2 (re.loop (re.range "0" "9") 2 2)))
(assert (= re4 (re.loop (re.range "0" "9") 4 4)))
(assert (= reDate (re.++ re4 (str.to_re "-") re2 (str.to_re "-") re2)))
(assert (= reTime (re.++ re2 (str.to_re ":") re2 (str.to_re ":") re2)))
(assert (= reTS (re.++ reDate (str.to_re ":") reTime)))

; --- Common parsing constraints (apply in both SAT and UNSAT branches) ---
; log format: "<timestamp> <level> <message...>"
(assert (= ts (split_at log_line " " 0)))
(assert (= lvl (split_at log_line " " 1)))
(assert (= msg (split_rest log_line " " 2)))

; require at least 3 segments when splitting on space: ts, lvl, msg (msg may contain spaces)
(assert (>= (num_splits log_line " ") 3))

; Timestamp must match strict format
(assert (str.in_re ts reTS))

; Further split timestamp into date and time around the middle ':' between date and time
(assert (= date (split_at ts ":" 0)))
(assert (= time (split_at ts ":" 1)))
(assert (>= (num_splits ts ":") 2))

; Split date into year-month-day
(assert (= year (split_at date "-" 0)))
(assert (= month (split_at date "-" 1)))
(assert (= day (split_at date "-" 2)))
(assert (= (num_splits date "-") 3))

; Split time into hour:minute:second
(assert (= hour (split_at time ":" 0)))
(assert (= minute (split_at time ":" 1)))
(assert (= second (split_at time ":" 2)))
(assert (= (num_splits time ":") 3))

; Basic length checks derived from the regex
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level should be one of common levels
(assert (or (= lvl "INFO") (= lvl "WARN") (= lvl "ERROR") (= lvl "DEBUG")))

; Message should be non-empty
(assert (> (str.len msg) 0))

; --- Create both SAT and UNSAT instances via branching ---
; SAT branch: concrete well-formed entry with consistent parsing
; UNSAT branch: forces a contradiction on timestamp length while keeping in_re constraint
(assert
  (or
    (and
      (= log_line "2025-12-31:23:59:58 INFO service:started")
      (str.contains msg "service")
      (not (str.contains msg "panic"))
      (<= (str.len msg) 64)
      (= lvl "INFO"))
    (and
      (= log_line "2025-01-02:03:04:05 ERROR bad:format")
      (= lvl "ERROR")
      ; Contradiction: valid timestamp regex implies length 19, but we assert it is 18
      (= (str.len ts) 18)
      (str.contains msg ":"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

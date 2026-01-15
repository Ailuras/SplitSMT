(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; --- str_split interface (uninterpreted) ---

; --- Variables ---
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_h String)
(declare-const ts_m String)
(declare-const ts_s String)
(declare-const level String)
(declare-const message String)

; --- Core structure: keep a seed-like regex nucleus but adapt to logs ---
; Require the full log line to contain at least one "00" pair (retains seed flavor).
(assert (str.in_re log_line (re.* (re.++ (re.* re.allchar) (re.++ (str.to_re "00") (re.* re.allchar))))))

; Split by spaces: "YYYY-MM-DD" "HH:MM:SS" "LEVEL:" rest...
(assert (>= (str.num_splits log_line " ") 4))
(assert (= ts_date (str.split_at log_line " " 0)))
(assert (= ts_time (str.split_at log_line " " 1)))
(assert (= level   (str.split_at log_line " " 2)))
(assert (= message (str.split_rest log_line " " 3)))

; Split time by ':' into HH MM SS
(assert (>= (str.num_splits ts_time ":") 3))
(assert (= ts_h (str.split_at ts_time ":" 0)))
(assert (= ts_m (str.split_at ts_time ":" 1)))
(assert (= ts_s (str.split_at ts_time ":" 2)))

; Timestamp format checks: fixed widths
(assert (= (str.len ts_date) 10))
(assert (= (str.len ts_time) 8))
(assert (= (str.len ts_h) 2))
(assert (= (str.len ts_m) 2))
(assert (= (str.len ts_s) 2))

; Date regex: YYYY-MM-DD where Y/M/D are digits
(define-fun DIGIT () RegLan (re.range "0" "9"))
(define-fun TWO_DIGITS () RegLan (re.++ DIGIT DIGIT))
(define-fun FOUR_DIGITS () RegLan (re.++ TWO_DIGITS TWO_DIGITS))
(define-fun DATE_RE () RegLan (re.++ FOUR_DIGITS (re.++ (str.to_re "-") (re.++ TWO_DIGITS (re.++ (str.to_re "-") TWO_DIGITS)))))
(assert (str.in_re ts_date DATE_RE))

; Time regex: HH:MM:SS with digits and colons
(define-fun TIME_RE () RegLan (re.++ TWO_DIGITS (re.++ (str.to_re ":") (re.++ TWO_DIGITS (re.++ (str.to_re ":") TWO_DIGITS)))))
(assert (str.in_re ts_time TIME_RE))

; Log level extraction: expect a trailing ':' like "INFO:" or "ERROR:"
(assert (str.in_re level (re.union (str.to_re "INFO:") (re.union (str.to_re "WARN:") (re.union (str.to_re "ERROR:") (str.to_re "DEBUG:"))))))

; Message sanity: must be non-empty and contain a colon-separated key:value somewhere
(assert (> (str.len message) 0))
(assert (str.contains message ":"))

; --- Create diversity: add a SAT branch plus an explicit UNSAT core guarded by a flag ---
(declare-const make_unsat Bool)

; SAT-friendly constraint: if not forcing UNSAT, forbid the message from containing "panic"
(assert (=> (not make_unsat) (not (str.contains message "panic"))))

; UNSAT block: if make_unsat then require incompatible regex conditions on log_line
; 1) log_line must be composed only of '0' and '1'
; 2) log_line must contain a '-' (from date), impossible under (1)
(assert (=> make_unsat (str.in_re log_line (re.* (re.union (str.to_re "0") (str.to_re "1"))))))
(assert (=> make_unsat (str.contains log_line "-")))

; Additionally retain a seed-like negated regex, but adapted to log_line:
; If make_unsat then forbid any occurrence of "000" or "1" in a star-language (makes it even tighter)
(assert (=> make_unsat (not (str.in_re log_line (re.* (re.union (str.to_re "000") (str.to_re "1")))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

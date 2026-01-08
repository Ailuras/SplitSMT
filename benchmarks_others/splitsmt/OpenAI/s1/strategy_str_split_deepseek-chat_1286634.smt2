(set-logic ALL)

; Log Analysis scenario: structured server log entry parsing
; Format sketch: "YYYY-MM-DD HH:MM:SS:LEVEL: message"

(declare-const X String)
(declare-const date String)
(declare-const time String)
(declare-const level String)
(declare-const rest1 String)
(declare-const msg String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; str_split interface

; Preserve core seed structure: keep the original negated regex membership
(assert (not (str.in_re X (re.++ (str.to_re "/.wk4") (re.union (str.to_re "?") (str.to_re "\\") (str.to_re "/")) (str.to_re "/smiU\u{a}")))))

; Basic space-separated parsing: date time:LEVEL: message
(assert (>= (str.num_splits X " ") 3))
(assert (= date (str.split_at X " " 0)))
(assert (= time (str.split_at X " " 1)))
(assert (= rest1 (str.split_rest X " " 2)))

; Split the remainder by ':' -> LEVEL and message (message may contain colons)
(assert (>= (str.num_splits rest1 ":") 3))
(assert (= level (str.split_at rest1 ":" 0)))
(assert (= msg (str.split_rest rest1 ":" 1)))

; Timestamp validation (regex-based): date and time formats
(declare-const digit String)
(assert (= digit "0123456789"))

; date: YYYY-MM-DD
(assert (str.in_re date (re.++ (re.loop (str.to_re digit) 4 4)
                               (str.to_re "-")
                               (re.loop (str.to_re digit) 2 2)
                               (str.to_re "-")
                               (re.loop (str.to_re digit) 2 2))))

; time: HH:MM:SS
(assert (str.in_re time (re.++ (re.loop (str.to_re digit) 2 2)
                               (str.to_re ":")
                               (re.loop (str.to_re digit) 2 2)
                               (str.to_re ":")
                               (re.loop (str.to_re digit) 2 2))))

; Extract HH,MM,SS using ':'
(assert (>= (str.num_splits time ":") 3))
(assert (= hour (str.split_at time ":" 0)))
(assert (= minute (str.split_at time ":" 1)))
(assert (= second (str.split_at time ":" 2)))

; Numeric bounds for time components
(declare-const h Int)
(declare-const m Int)
(declare-const s Int)
(assert (= h (str.to_int hour)))
(assert (= m (str.to_int minute)))
(assert (= s (str.to_int second)))
(assert (and (<= 0 h) (<= h 23)))
(assert (and (<= 0 m) (<= m 59)))
(assert (and (<= 0 s) (<= s 59)))

; Log level extraction: allow common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message should be non-empty and must not start with whitespace
(assert (> (str.len msg) 0))
(assert (not (= (str.at msg 0) " ")))

; Diversity constraint: ensure it's a single-line log entry (no newline)
(assert (not (str.contains X "\n")))

; Make the scenario concrete enough to be satisfiable
(assert (str.contains X " "))
(assert (str.contains rest1 ":"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

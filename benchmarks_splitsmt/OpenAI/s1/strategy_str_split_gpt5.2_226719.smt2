(set-logic ALL)

; Uninterpreted split interface

; Log analysis scenario: parse structured log entry with spaces and colons
(declare-const log_line String)
(declare-const timestamp String)
(declare-const level String)
(declare-const rest_after_level String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const msg_part String)

; Core structure preserved: keep a seed-like constant assignment and a membership-style constraint
(assert (= log_line "2026-01-07T09:15:30Z ERROR:disk full"))
(assert (str.in_re log_line (str.to_re "2026-01-07T09:15:30Z ERROR:disk full")))

; Split by spaces: [timestamp] [LEVEL:message...]
(assert (>= (str.num_splits log_line " ") 2))
(assert (= timestamp (str.split_at log_line " " 0)))
(assert (= rest_after_level (str.split_rest log_line " " 1)))

; Extract log level and message via ':'
(assert (>= (str.num_splits rest_after_level ":") 2))
(assert (= level (str.split_at rest_after_level ":" 0)))
(assert (= msg_part (str.split_rest rest_after_level ":" 1)))

; Timestamp format checks: YYYY-MM-DDTHH:MM:SSZ
(assert (= (str.len timestamp) 20))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))
(assert (= (str.at timestamp 19) "Z"))

; Break timestamp into date and time components
(assert (= date_part (str.substr timestamp 0 10)))
(assert (= time_part (str.substr timestamp 11 8)))

; Split time part HH:MM:SS and enforce lengths
(assert (>= (str.num_splits time_part ":") 3))
(assert (= hour (str.split_at time_part ":" 0)))
(assert (= minute (str.split_at time_part ":" 1)))
(assert (= second (str.split_at time_part ":" 2)))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level extraction constraints
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message sanity constraints
(assert (> (str.len msg_part) 0))
(assert (str.contains msg_part "disk"))

; Create an UNSAT tension: enforce contradictory level
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

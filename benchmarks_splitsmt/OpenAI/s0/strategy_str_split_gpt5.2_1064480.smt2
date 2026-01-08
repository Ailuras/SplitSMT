(set-logic ALL)

; Uninterpreted interface operations for split constraints

; Scenario: Log Analysis
; We model log lines like: "2026-01-07T12:34:56Z INFO: user=jdoe action=login"

; ---------- SAT instance ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

; Split by spaces: [0]=timestamp, [1]=level:, [2..]=message
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= level_colon_sat (str.split_at log_line_sat " " 1)))
(assert (= msg_sat (str.split_rest log_line_sat " " 2)))
(assert (>= (str.num_splits log_line_sat " ") 3))

; Timestamp ISO-8601-ish validation: YYYY-MM-DDTHH:MM:SSZ
; Use regex for structure.
(assert (str.in_re ts_sat (str.to_re ""))) ; allow solver freedom with empty re base
(assert (str.in_re ts_sat
  (re.++
    (re.loop (re.range "0" "9") 4 4)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "T")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "Z"))))

; Further parse timestamp by 'T' to get date and timeZ
(assert (= ts_date_sat (str.split_at ts_sat "T" 0)))
(assert (= ts_time_sat (str.split_at ts_sat "T" 1)))
(assert (= (str.num_splits ts_sat "T") 2))

; Time part must end with Z and have length 9 (HH:MM:SSZ)
(assert (= (str.len ts_time_sat) 9))
(assert (= (str.at ts_time_sat 8) "Z"))
(assert (= (str.at ts_time_sat 2) ":"))
(assert (= (str.at ts_time_sat 5) ":"))

; Extract log level from "LEVEL:" token by splitting on ':'
(assert (= level_sat (str.split_at level_colon_sat ":" 0)))
(assert (= (str.split_at level_colon_sat ":" 1) ""))
(assert (= (str.num_splits level_colon_sat ":") 2))

; Log level must be one of common set
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message checks: must include key=value and at least one space-separated token
(assert (str.contains msg_sat "="))
(assert (>= (str.num_splits msg_sat " ") 1))

; Constrain to a plausible concrete-ish example while leaving degrees of freedom
(assert (str.contains msg_sat "user="))
(assert (str.contains msg_sat "action="))

; ---------- UNSAT instance (in same file) ----------
; Here we force a malformed timestamp but also require it matches the strict regex.
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)

(assert (= ts_unsat (str.split_at log_line_unsat " " 0)))
(assert (= level_colon_unsat (str.split_at log_line_unsat " " 1)))
(assert (>= (str.num_splits log_line_unsat " ") 2))

; Force an impossible timestamp shape while simultaneously requiring ISO form
(assert (= ts_unsat "2026-1-07T12:34:56Z")) ; month has 1 digit -> violates 2-digit requirement
(assert (str.in_re ts_unsat
  (re.++
    (re.loop (re.range "0" "9") 4 4)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "T")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "Z"))))

; Also parse log level token and constrain it well-formed
(assert (= level_unsat (str.split_at level_colon_unsat ":" 0)))
(assert (= (str.split_at level_colon_unsat ":" 1) ""))
(assert (= (str.num_splits level_colon_unsat ":") 2))
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

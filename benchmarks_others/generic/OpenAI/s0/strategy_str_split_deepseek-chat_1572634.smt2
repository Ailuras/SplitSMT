(set-logic ALL)

; --- Uninterpreted interface for string splitting ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Scenario: Log Analysis ---
; We model structured server log entries separated by spaces and colons.
; Target: validate timestamp format and extract log level.

; === SAT instance: a well-formed log line ===
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const log_level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)
(declare-const ts_year_sat String)
(declare-const ts_month_sat String)
(declare-const ts_day_sat String)
(declare-const ts_hour_sat String)
(declare-const ts_min_sat String)
(declare-const ts_sec_sat String)

; Split by spaces: "DATE TIME LEVEL COMPONENT: MESSAGE..."
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= log_level_sat (split_at log_line_sat " " 2)))
(assert (= component_sat (split_at log_line_sat " " 3)))
(assert (= message_sat (split_rest log_line_sat " " 4)))
(assert (>= (num_splits log_line_sat " ") 5))

; Component token ends with a colon
(assert (> (str.len component_sat) 1))
(assert (= (str.at component_sat (- (str.len component_sat) 1)) ":"))

; Timestamp format: YYYY-MM-DD and HH:MM:SS
(assert (= 10 (str.len ts_date_sat)))
(assert (= 8 (str.len ts_time_sat)))
(assert (= (str.at ts_date_sat 4) "-"))
(assert (= (str.at ts_date_sat 7) "-"))
(assert (= (str.at ts_time_sat 2) ":"))
(assert (= (str.at ts_time_sat 5) ":"))

; Further split date/time by delimiters
(assert (= ts_year_sat (split_at ts_date_sat "-" 0)))
(assert (= ts_month_sat (split_at ts_date_sat "-" 1)))
(assert (= ts_day_sat (split_at ts_date_sat "-" 2)))
(assert (= 3 (num_splits ts_date_sat "-")))
(assert (= 4 (str.len ts_year_sat)))
(assert (= 2 (str.len ts_month_sat)))
(assert (= 2 (str.len ts_day_sat)))

(assert (= ts_hour_sat (split_at ts_time_sat ":" 0)))
(assert (= ts_min_sat (split_at ts_time_sat ":" 1)))
(assert (= ts_sec_sat (split_at ts_time_sat ":" 2)))
(assert (= 3 (num_splits ts_time_sat ":")))
(assert (= 2 (str.len ts_hour_sat)))
(assert (= 2 (str.len ts_min_sat)))
(assert (= 2 (str.len ts_sec_sat)))

; Log level extraction: must be one of common levels
(assert (or (= log_level_sat "INFO") (= log_level_sat "WARN") (= log_level_sat "ERROR") (= log_level_sat "DEBUG")))

; Message should be non-empty and contain some content
(assert (> (str.len message_sat) 0))
(assert (str.contains message_sat "="))

; Constrain the entire line to match a plausible concrete example while still using split constraints
(assert (= log_line_sat "2025-01-07 13:45:09 INFO auth: user_id=42 action=login"))

; === UNSAT instance: contradictory constraints about log level and timestamp ===
(declare-const log_line_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const log_level_unsat String)
(declare-const component_unsat String)
(declare-const message_unsat String)

(assert (= ts_date_unsat (split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= log_level_unsat (split_at log_line_unsat " " 2)))
(assert (= component_unsat (split_at log_line_unsat " " 3)))
(assert (= message_unsat (split_rest log_line_unsat " " 4)))
(assert (>= (num_splits log_line_unsat " ") 5))

; Demand a correct-looking timestamp delimiters
(assert (= 10 (str.len ts_date_unsat)))
(assert (= (str.at ts_date_unsat 4) "-"))
(assert (= (str.at ts_date_unsat 7) "-"))
(assert (= 8 (str.len ts_time_unsat)))
(assert (= (str.at ts_time_unsat 2) ":"))
(assert (= (str.at ts_time_unsat 5) ":"))

; Contradiction on log level: must be INFO and ERROR simultaneously
(assert (= log_level_unsat "INFO"))
(assert (= log_level_unsat "ERROR"))

; Also force the concrete line to one with WARN, creating additional inconsistency
(assert (= log_line_unsat "2025-01-07 13:45:09 WARN auth: event=logout"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

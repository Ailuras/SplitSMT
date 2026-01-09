(set-logic ALL)

; Uninterpreted split interface (str_split)

; -----------------------------
; SAT instance: well-formed log line
; Format (space-separated): "YYYY-MM-DDTHH:MM:SSZ LEVEL module: message"
; Example: "2026-01-09T12:34:56Z INFO auth: login ok"
; -----------------------------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const module_colon_sat String)
(declare-const module_sat String)
(declare-const msg_sat String)
(declare-const ts_date_sat String)
(declare-const ts_timez_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const time_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)

(assert (= log_line_sat "2026-01-09T12:34:56Z INFO auth: login ok"))

; Space split: timestamp, level, module:, rest(message)
(assert (>= (str.num_splits log_line_sat " ") 4))
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= level_sat (str.split_at log_line_sat " " 1)))
(assert (= module_colon_sat (str.split_at log_line_sat " " 2)))
(assert (= msg_sat (str.split_rest log_line_sat " " 3)))

; Log level extraction check
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; module_colon must end with ':' and be non-empty module name
(assert (>= (str.num_splits module_colon_sat ":") 2))
(assert (= module_sat (str.split_at module_colon_sat ":" 0)))
(assert (>= (str.len module_sat) 1))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SSZ
(assert (= (str.len ts_sat) 20))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) "T"))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))
(assert (= (str.at ts_sat 19) "Z"))

; Split date/timeZ
(assert (= ts_date_sat (str.split_at ts_sat "T" 0)))
(assert (= ts_timez_sat (str.split_at ts_sat "T" 1)))
(assert (= (str.len ts_date_sat) 10))
(assert (= (str.len ts_timez_sat) 9))

; Split date components
(assert (= year_sat (str.split_at ts_date_sat "-" 0)))
(assert (= month_sat (str.split_at ts_date_sat "-" 1)))
(assert (= day_sat (str.split_at ts_date_sat "-" 2)))
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))

; Split timeZ components
(assert (= time_sat (str.split_at ts_timez_sat "Z" 0)))
(assert (= (str.len time_sat) 8))
(assert (= hour_sat (str.split_at time_sat ":" 0)))
(assert (= minute_sat (str.split_at time_sat ":" 1)))
(assert (= second_sat (str.split_at time_sat ":" 2)))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Regex validation for digits in fields
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Message sanity: non-empty and contains a space (since "login ok")
(assert (>= (str.len msg_sat) 1))
(assert (str.contains msg_sat " "))

; Check-sat for SAT instance
(check-sat)
(exit)

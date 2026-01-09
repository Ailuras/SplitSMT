(set-logic ALL)

; Uninterpreted interface for string split

; === SAT instance: structured log parsing ===
(declare-const log_line String)
(declare-const ts_token String)
(declare-const level_token String)
(declare-const component_token String)
(declare-const message_tail String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const yyyy String)
(declare-const mon String)
(declare-const dd String)

; Split by spaces: "YYYY-MM-DD HH:MM:SS LEVEL component: message..."
(assert (>= (str.num_splits log_line " ") 5))
(assert (= ts_token (str.split_at log_line " " 0)))
(assert (= ts_time (str.split_at log_line " " 1)))
(assert (= level_token (str.split_at log_line " " 2)))
(assert (= component_token (str.split_at log_line " " 3)))
(assert (= message_tail (str.split_rest log_line " " 4)))

; Timestamp date validation: YYYY-MM-DD
(assert (= yyyy (str.split_at ts_token "-" 0)))
(assert (= mon (str.split_at ts_token "-" 1)))
(assert (= dd (str.split_at ts_token "-" 2)))
(assert (= 3 (str.num_splits ts_token "-")))
(assert (str.in_re yyyy (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re dd (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Timestamp time validation: HH:MM:SS
(assert (= hh (str.split_at ts_time ":" 0)))
(assert (= mm (str.split_at ts_time ":" 1)))
(assert (= ss (str.split_at ts_time ":" 2)))
(assert (= 3 (str.num_splits ts_time ":")))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction/validation
(assert (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG")))

; Component token ends with ':' and is non-empty
(assert (>= (str.len component_token) 2))
(assert (= (str.at component_token (- (str.len component_token) 1)) ":"))

; Message should be non-empty and should not contain newline
(assert (> (str.len message_tail) 0))
(assert (not (str.contains message_tail "\n")))

; Provide one concrete witness shape to ensure SAT
(assert (= log_line "2025-01-09 12:34:56 INFO auth: user login ok"))

; === UNSAT instance: contradictory timestamp checks on a second line ===
(declare-const bad_log_line String)
(declare-const bad_ts_date String)
(declare-const bad_ts_time String)
(declare-const bad_level String)
(declare-const bad_component String)
(declare-const bad_msg String)
(declare-const bad_hh String)
(declare-const bad_mm String)
(declare-const bad_ss String)

(assert (>= (str.num_splits bad_log_line " ") 5))
(assert (= bad_ts_date (str.split_at bad_log_line " " 0)))
(assert (= bad_ts_time (str.split_at bad_log_line " " 1)))
(assert (= bad_level (str.split_at bad_log_line " " 2)))
(assert (= bad_component (str.split_at bad_log_line " " 3)))
(assert (= bad_msg (str.split_rest bad_log_line " " 4)))

; Force a specific shape that will clash with additional constraints
(assert (= bad_log_line "2025-01-09 00:00:00 ERROR db: fail"))

; Extract time fields
(assert (= bad_hh (str.split_at bad_ts_time ":" 0)))
(assert (= bad_mm (str.split_at bad_ts_time ":" 1)))
(assert (= bad_ss (str.split_at bad_ts_time ":" 2)))
(assert (= 3 (str.num_splits bad_ts_time ":")))

; Contradiction: require hour to be exactly "00" and also "23"
(assert (= bad_hh "00"))
(assert (= bad_hh "23"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

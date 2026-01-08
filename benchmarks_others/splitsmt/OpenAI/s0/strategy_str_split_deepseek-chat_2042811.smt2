(set-logic ALL)

; Uninterpreted interface for string splitting

; -----------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks: timestamp format validation and log level extraction.
; -----------------------------

; Primary log line (intended SAT)
(declare-const log_line String)
(declare-const ts_token String)
(declare-const lvl_token String)
(declare-const component_token String)
(declare-const message_tail String)
(declare-const date_part String)
(declare-const time_part String)

; Secondary log line (intended UNSAT)
(declare-const bad_log_line String)
(declare-const bad_ts_token String)
(declare-const bad_date_part String)
(declare-const bad_time_part String)

; -----------------------------
; SAT instance constraints
; Expected structure (space-separated):
;   <timestamp> <level> <component>: <message...>
; Timestamp expected: YYYY-MM-DDTHH:MM:SSZ
; -----------------------------

(assert (= ts_token (str.split_at log_line " " 0)))
(assert (= lvl_token (str.split_at log_line " " 1)))
(assert (= component_token (str.split_at log_line " " 2)))
(assert (= message_tail (str.split_rest log_line " " 3)))

; At least 4 segments (timestamp, level, component:, message...)
(assert (>= (str.num_splits log_line " ") 4))

; Level token must be one of standard levels
(assert (or (= lvl_token "INFO") (= lvl_token "WARN") (= lvl_token "ERROR") (= lvl_token "DEBUG")))

; Component token ends with ':'
(assert (>= (str.len component_token) 2))
(assert (= (str.at component_token (- (str.len component_token) 1)) ":"))

; Message is non-empty and contains no newline
(assert (> (str.len message_tail) 0))
(assert (not (str.contains message_tail "\n")))

; Timestamp split by 'T' into date and timeZ
(assert (= date_part (str.split_at ts_token "T" 0)))
(assert (= time_part (str.split_at ts_token "T" 1)))
(assert (= (str.num_splits ts_token "T") 2))

; Date part: YYYY-MM-DD
(assert (str.in_re date_part (str.to_re "")))
(assert (= (str.len date_part) 10))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (str.in_re (str.substr date_part 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 5 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 8 2) (re.+ (re.range "0" "9"))))

; Time part: HH:MM:SSZ
(assert (= (str.len time_part) 9))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (= (str.at time_part 8) "Z"))
(assert (str.in_re (str.substr time_part 0 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr time_part 3 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr time_part 6 2) (re.+ (re.range "0" "9"))))

; Full timestamp regex (more strict shape check)
(assert (str.in_re ts_token (re.++ (re.loop (re.range "0" "9") 4 4)
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

; A concrete example witness to ensure satisfiable parsing
(assert (= log_line "2026-01-07T13:05:42Z INFO auth: login ok"))

; -----------------------------
; UNSAT instance constraints
; Same intended timestamp structure, but force a contradiction
; -----------------------------

(assert (= bad_ts_token (str.split_at bad_log_line " " 0)))
(assert (>= (str.num_splits bad_log_line " ") 2))

(assert (= bad_date_part (str.split_at bad_ts_token "T" 0)))
(assert (= bad_time_part (str.split_at bad_ts_token "T" 1)))
(assert (= (str.num_splits bad_ts_token "T") 2))

; Force the time part to end with Z, yet also force last char not Z (contradiction)
(assert (= (str.len bad_time_part) 9))
(assert (= (str.at bad_time_part 8) "Z"))
(assert (not (= (str.at bad_time_part 8) "Z")))

; Provide a concrete bad log line (still cannot satisfy due to contradiction above)
(assert (= bad_log_line "2026-01-07T13:05:42Z ERROR core: impossible"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

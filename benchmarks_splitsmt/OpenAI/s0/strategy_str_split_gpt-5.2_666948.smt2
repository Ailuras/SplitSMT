(set-logic ALL)

; Uninterpreted interface functions for string splitting

; ---------- SAT instance: well-formed log analysis ----------
(declare-const log_line String)
(declare-const timestamp String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_bracketed String)
(declare-const level String)
(declare-const module_tag String)
(declare-const message String)
(declare-const colon_after_level String)
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const HH String)
(declare-const MM String)
(declare-const SS String)
(declare-const dot_ms String)
(declare-const ms String)
(declare-const rest_after_module String)
(declare-const forced_example_level String)

; Structure: "<timestamp> <LEVEL>:<MODULE> <message...>"
(assert (>= (str.num_splits log_line " ") 3))
(assert (= timestamp (str.split_at log_line " " 0)))
(assert (= level_bracketed (str.split_at log_line " " 1)))
(assert (= module_tag (str.split_at log_line " " 2)))
(assert (= rest_after_module (str.split_rest log_line " " 3)))

; Message is everything after the third token, can be empty but typically present
(assert (= message rest_after_module))

; Timestamp: "YYYY-MM-DD HH:MM:SS.mmm" (space-separated date and time)
(assert (>= (str.num_splits timestamp " ") 2))
(assert (= date_part (str.split_at timestamp " " 0)))
(assert (= time_part (str.split_at timestamp " " 1)))

; Date: YYYY-MM-DD
(assert (= (str.len date_part) 10))
(assert (= yyyy (str.substr date_part 0 4)))
(assert (= mm (str.substr date_part 5 2)))
(assert (= dd (str.substr date_part 8 2)))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (str.in_re yyyy (re.+ (re.range "0" "9"))))
(assert (= (str.len yyyy) 4))
(assert (str.in_re mm (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re dd (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Time: HH:MM:SS.mmm
(assert (= (str.len time_part) 12))
(assert (= HH (str.substr time_part 0 2)))
(assert (= MM (str.substr time_part 3 2)))
(assert (= SS (str.substr time_part 6 2)))
(assert (= dot_ms (str.substr time_part 8 4)))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (= (str.at time_part 8) "."))
(assert (str.in_re HH (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re MM (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re SS (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (= ms (str.substr time_part 9 3)))
(assert (str.in_re ms (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9")))))

; Level extraction: token like "INFO:" or "ERROR:" (colon terminated)
(assert (>= (str.len level_bracketed) 2))
(assert (= colon_after_level (str.at level_bracketed (- (str.len level_bracketed) 1))))
(assert (= colon_after_level ":"))
(assert (= level (str.substr level_bracketed 0 (- (str.len level_bracketed) 1))))
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Module tag basic sanity: must not contain ':' and not be empty
(assert (>= (str.len module_tag) 1))
(assert (not (str.contains module_tag ":")))

; Additional SAT anchoring: make a concrete example consistent with constraints
(assert (= log_line "2025-01-09 13:45:27.123 INFO:auth User login success"))

; ---------- UNSAT instance: contradictory checks on another log line ----------
(declare-const bad_log_line String)
(declare-const bad_timestamp String)
(declare-const bad_level_token String)
(declare-const bad_level String)
(declare-const bad_time_part String)
(declare-const bad_date_part String)
(declare-const bad_colon_last String)

(assert (>= (str.num_splits bad_log_line " ") 2))
(assert (= bad_timestamp (str.split_at bad_log_line " " 0)))
(assert (= bad_level_token (str.split_at bad_log_line " " 1)))

; Force a specific bad line
(assert (= bad_log_line "2025-01-09 13:45:27.123 INFO:auth Something happened"))

; Extract timestamp components as above
(assert (>= (str.num_splits bad_timestamp " ") 2))
(assert (= bad_date_part (str.split_at bad_timestamp " " 0)))
(assert (= bad_time_part (str.split_at bad_timestamp " " 1)))

; Contradiction 1: require the time separator at position 2 to be '-' but also enforce it is ':'
(assert (= (str.at bad_time_part 2) ":"))
(assert (= (str.at bad_time_part 2) "-"))

; Contradiction 2: require level token to not end with ':' but also to end with ':'
(assert (>= (str.len bad_level_token) 2))
(assert (= bad_colon_last (str.at bad_level_token (- (str.len bad_level_token) 1))))
(assert (= bad_colon_last ":"))
(assert (not (= bad_colon_last ":")))

; Contradiction 3: enforce extracted level equals "INFO" but also "ERROR"
(assert (= bad_level (str.substr bad_level_token 0 (- (str.len bad_level_token) 1))))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

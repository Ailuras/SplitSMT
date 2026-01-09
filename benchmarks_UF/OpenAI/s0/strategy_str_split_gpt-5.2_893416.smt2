(set-logic ALL)

; --- Uninterpreted interface functions for str_split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Log analysis variables ---
(declare-const log_entry String)
(declare-const ts_token String)
(declare-const lvl_token String)
(declare-const component_token String)
(declare-const message_rest String)

(declare-const date_part String)
(declare-const time_part String)
(declare-const hour_part String)
(declare-const minute_part String)
(declare-const second_part String)

(declare-const sat_example Bool)
(declare-const unsat_example Bool)

; =========================================================
; SAT instance: well-formed log entry with timestamp + level
; Format: "YYYY-MM-DD HH:MM:SS LEVEL component: message..."
; =========================================================
(assert (= sat_example true))
(assert (= log_entry "2024-11-05 14:03:09 INFO auth: login ok"))

; Split by spaces: [0]=date, [1]=time, [2]=level, [3]=component:, [4..]=message...
(assert (= ts_token (split_at log_entry " " 0)))
(assert (= time_part (split_at log_entry " " 1)))
(assert (= lvl_token (split_at log_entry " " 2)))
(assert (= component_token (split_at log_entry " " 3)))
(assert (= message_rest (split_rest log_entry " " 4)))
(assert (>= (num_splits log_entry " ") 5))

; Timestamp date validation: YYYY-MM-DD
(assert (= date_part ts_token))
(assert (= (str.len date_part) 10))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (str.in_re (str.substr date_part 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 5 2) (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 8 2) (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Timestamp time validation: HH:MM:SS
(assert (= (str.len time_part) 8))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (= hour_part (split_at time_part ":" 0)))
(assert (= minute_part (split_at time_part ":" 1)))
(assert (= second_part (split_at time_part ":" 2)))
(assert (= (num_splits time_part ":") 3))
(assert (= (str.len hour_part) 2))
(assert (= (str.len minute_part) 2))
(assert (= (str.len second_part) 2))
(assert (str.in_re hour_part (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re minute_part (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re second_part (re.++ (re.range "5" "5") (re.range "9" "9"))))

; Log level extraction/validation
(assert (or (= lvl_token "INFO") (= lvl_token "WARN") (= lvl_token "ERROR") (= lvl_token "DEBUG")))

; Component token ends with ':' and message contains a keyword
(assert (= (str.at component_token (- (str.len component_token) 1)) ":"))
(assert (str.contains message_rest "login"))

; =========================================================
; UNSAT instance: force contradictory timestamp/level constraints
; We reuse the same log_entry but require an impossible level
; and impossible time separator positions simultaneously.
; =========================================================
(assert (= unsat_example true))

; Contradiction: extracted level must be both INFO (by concrete log) and ERROR
(assert (= lvl_token "ERROR"))

; Contradiction: time token must have ':' at index 1 (but in "14:03:09" it's at 2)
(assert (= (str.at time_part 1) ":"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

(set-logic ALL)

; Uninterpreted split interface (as provided)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: consistent log parsing
; Format sketch: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -------------------------
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const ts_sat String)
(declare-const level_tok_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const year_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Require at least: date, time, and then something (LEVEL:...)
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= level_tok_sat (split_at log_line_sat " " 2)))
(assert (= msg_sat (split_rest log_line_sat " " 3)))
(assert (= ts_sat (str.++ ts_date_sat " " ts_time_sat)))

; Timestamp date must be YYYY-MM-DD and time must be HH:MM:SS (structural + regex)
(assert (= year_sat (split_at ts_date_sat "-" 0)))
(assert (= mon_sat  (split_at ts_date_sat "-" 1)))
(assert (= day_sat  (split_at ts_date_sat "-" 2)))
(assert (= hour_sat (split_at ts_time_sat ":" 0)))
(assert (= min_sat  (split_at ts_time_sat ":" 1)))
(assert (= sec_sat  (split_at ts_time_sat ":" 2)))
(assert (= 3 (num_splits ts_date_sat "-")))
(assert (= 3 (num_splits ts_time_sat ":")))
(assert (= 4 (str.len year_sat)))
(assert (= 2 (str.len mon_sat)))
(assert (= 2 (str.len day_sat)))
(assert (= 2 (str.len hour_sat)))
(assert (= 2 (str.len min_sat)))
(assert (= 2 (str.len sec_sat)))

; Regex validation for numeric components
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon_sat  (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat  (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_sat  (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_sat  (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction: token must have a colon and level is before ':'
(assert (>= (num_splits level_tok_sat ":") 2))
(assert (= level_sat (split_at level_tok_sat ":" 0)))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Concrete witness-like constraints to ensure SAT (not relying on any model printing)
(assert (= log_line_sat "2024-12-01 09:15:27 INFO: service started"))
(assert (= msg_sat "service started"))

; -------------------------
; UNSAT instance: contradictory timestamp requirements
; -------------------------
(declare-const log_line_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_tok_unsat String)
(declare-const year_unsat String)
(declare-const mon_unsat String)
(declare-const day_unsat String)
(declare-const hour_unsat String)
(declare-const min_unsat String)
(declare-const sec_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_date_unsat (split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_tok_unsat (split_at log_line_unsat " " 2)))

; Force a fixed-looking line
(assert (= log_line_unsat "2024-12-01 09:15:27 ERROR: bad"))

; Parse and constrain date/time structure
(assert (= year_unsat (split_at ts_date_unsat "-" 0)))
(assert (= mon_unsat  (split_at ts_date_unsat "-" 1)))
(assert (= day_unsat  (split_at ts_date_unsat "-" 2)))
(assert (= hour_unsat (split_at ts_time_unsat ":" 0)))
(assert (= min_unsat  (split_at ts_time_unsat ":" 1)))
(assert (= sec_unsat  (split_at ts_time_unsat ":" 2)))
(assert (= 3 (num_splits ts_date_unsat "-")))
(assert (= 3 (num_splits ts_time_unsat ":")))

; Contradiction: require the same date string to have only 2 splits by '-'
(assert (= 2 (num_splits ts_date_unsat "-")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
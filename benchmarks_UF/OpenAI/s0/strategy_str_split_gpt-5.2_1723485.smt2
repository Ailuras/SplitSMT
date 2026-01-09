(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------------------
; SAT instance: well-formed log line
; Format (space-separated tokens):
;   <date> <time> <level>: <message...>
; Where <date> = YYYY-MM-DD, <time> = HH:MM:SS
; Example: 2026-01-09 13:45:07 INFO: service started
; ------------------------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const message_sat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)

(declare-const d1_sat String)
(declare-const d2_sat String)
(declare-const t1_sat String)
(declare-const t2_sat String)

(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= message_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Level token ends with ':' and extracted level is the prefix
(assert (str.suffixof ":" level_colon_sat))
(assert (= level_sat (str.substr level_colon_sat 0 (- (str.len level_colon_sat) 1))))

; Ensure level is one of common values
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Timestamp split checks
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= d1_sat (split_at date_sat "-" 3)))
(assert (>= (num_splits date_sat "-") 3))
(assert (= d1_sat ""))

(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))
(assert (= t1_sat (split_at time_sat ":" 3)))
(assert (>= (num_splits time_sat ":") 3))
(assert (= t1_sat ""))

; Length constraints for fixed-width timestamp fields
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Digit-only validation via regex
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Numeric range checks for time components
(assert (let ((H (str.to_int hour_sat)) (M (str.to_int minute_sat)) (S (str.to_int second_sat)))
  (and (>= H 0) (<= H 23) (>= M 0) (<= M 59) (>= S 0) (<= S 59))))

; Message should be non-empty and not contain newline
(assert (> (str.len message_sat) 0))
(assert (not (str.contains message_sat "\n")))

; Constructive witness to make SAT robust
(assert (= log_line_sat "2026-01-09 13:45:07 INFO: service started"))

(check-sat)

; ------------------------
; UNSAT instance: incompatible timestamp constraints
; Here we force HH=29 (out of range) while also requiring a valid-range hour.
; ------------------------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const hour_unsat String)
(declare-const minute_unsat String)
(declare-const second_unsat String)
(declare-const extra_time_seg_unsat String)

(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 3))

(assert (= hour_unsat (split_at time_unsat ":" 0)))
(assert (= minute_unsat (split_at time_unsat ":" 1)))
(assert (= second_unsat (split_at time_unsat ":" 2)))
(assert (= extra_time_seg_unsat (split_at time_unsat ":" 3)))
(assert (>= (num_splits time_unsat ":") 3))
(assert (= extra_time_seg_unsat ""))

(assert (= (str.len hour_unsat) 2))
(assert (str.in_re hour_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Force hour to be "29" but also require 0..23 => contradiction
(assert (= hour_unsat "29"))
(assert (let ((H (str.to_int hour_unsat))) (and (>= H 0) (<= H 23))))

; Provide a concrete-looking line to avoid vacuity
(assert (= log_line_unsat "2026-01-09 29:10:10 ERROR: impossible hour"))

(check-sat)



; [GENERATION STATUS: SUCCESS]
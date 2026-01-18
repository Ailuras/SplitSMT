(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface operations for string splitting

; -------------------------
; SAT instance: well-formed log line
; Format targeted (example): "2026-01-07 12:34:56 INFO:User login"
; Split by space => [date, time, rest]
; Then split rest by ":" => [level, message]
; -------------------------
(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const rest_part String)
(declare-const level_part String)
(declare-const message_part String)
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const HH String)
(declare-const MI String)
(declare-const SS String)

; Basic decomposition using split
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= rest_part (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 3))

; Level/message decomposition: "LEVEL:Message..."
(assert (= level_part (split_at rest_part ":" 0)))
(assert (= message_part (split_rest rest_part ":" 1)))
(assert (>= (num_splits rest_part ":") 2))

; Log level extraction constraints
(assert (or (= level_part "INFO") (= level_part "WARN") (= level_part "ERROR") (= level_part "DEBUG")))

; Message must be non-empty and not start with a colon (sanity)
(assert (> (str.len message_part) 0))
(assert (not (= (str.at message_part 0) ":")))

; Timestamp format validation (structural + digit regex checks)
; Date: YYYY-MM-DD
(assert (= yyyy (split_at date_part "-" 0)))
(assert (= mm   (split_at date_part "-" 1)))
(assert (= dd   (split_at date_part "-" 2)))
(assert (= (num_splits date_part "-") 3))
(assert (= (str.len yyyy) 4))
(assert (= (str.len mm) 2))
(assert (= (str.len dd) 2))
(assert (str.in_re yyyy (re.+ (re.range "0" "9"))))
(assert (str.in_re mm   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re dd   (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Time: HH:MI:SS
(assert (= HH (split_at time_part ":" 0)))
(assert (= MI (split_at time_part ":" 1)))
(assert (= SS (split_at time_part ":" 2)))
(assert (= (num_splits time_part ":") 3))
(assert (= (str.len HH) 2))
(assert (= (str.len MI) 2))
(assert (= (str.len SS) 2))
(assert (str.in_re HH (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re MI (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re SS (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Tie together with a concrete exemplar to ensure SAT
(assert (= log_line "2026-01-07 12:34:56 INFO:User login"))


; -------------------------
; UNSAT instance: conflicting constraints for another log line
; Enforces a wrong timestamp shape while also requiring strict split counts.
; -------------------------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_rest String)
(declare-const bad_level String)
(declare-const bad_msg String)

(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time (split_at bad_log_line " " 1)))
(assert (= bad_rest (split_rest bad_log_line " " 2)))
(assert (>= (num_splits bad_log_line " ") 3))

(assert (= bad_level (split_at bad_rest ":" 0)))
(assert (= bad_msg (split_rest bad_rest ":" 1)))
(assert (>= (num_splits bad_rest ":") 2))
(assert (= bad_level "ERROR"))

; Demand exact ISO date split by '-' into 3 parts
(assert (= (num_splits bad_date "-") 3))

; But also force the date to have no '-' characters (impossible with 3 splits)
(assert (not (str.contains bad_date "-")))

; Concrete bad log line (also inconsistent with the above)
(assert (= bad_log_line "20260107 99:99:99 ERROR:Bad timestamp"))

(check-sat)
(get-model)
(exit)

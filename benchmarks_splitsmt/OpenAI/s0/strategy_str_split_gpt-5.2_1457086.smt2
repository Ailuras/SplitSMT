(set-logic ALL)

; Uninterpreted interface: str_split

; Scenario: Log Analysis
; Format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message"

; Shared inputs
(declare-const log_entry String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_and_msg String)
(declare-const level_part String)
(declare-const msg_part String)

; Additional extracted fields
(declare-const year_s String)
(declare-const month_s String)
(declare-const day_s String)
(declare-const hour_s String)
(declare-const min_s String)
(declare-const sec_s String)

; Integer interpretations for range checks
(declare-const year Int)
(declare-const month Int)
(declare-const day Int)
(declare-const hour Int)
(declare-const minute Int)
(declare-const second Int)

; A second independent log entry to create an UNSAT instance
(declare-const bad_log_entry String)
(declare-const bad_level_part String)

; Basic split by spaces: [date] [time] [LEVEL:] [rest...]
(assert (>= (str.num_splits log_entry " ") 3))
(assert (= date_part (str.split_at log_entry " " 0)))
(assert (= time_part (str.split_at log_entry " " 1)))
(assert (= level_and_msg (str.split_rest log_entry " " 2)))

; Split level_and_msg by single space into "LEVEL:" and message prefix (message may contain spaces)
(assert (>= (str.num_splits level_and_msg " ") 1))
(assert (= level_part (str.split_at level_and_msg " " 0)))
(assert (= msg_part (str.split_rest level_and_msg " " 1)))

; Extract level token before ':' (LEVEL:)
(assert (>= (str.num_splits level_part ":") 1))
(assert (= (str.split_at level_part ":" 0) (str.split_at level_part ":" 0)))

; Constrain exact level format: must end with ':' and be one of INFO/WARN/ERROR/DEBUG
(assert (str.suffixof ":" level_part))
(assert (or (= (str.split_at level_part ":" 0) "INFO")
            (= (str.split_at level_part ":" 0) "WARN")
            (= (str.split_at level_part ":" 0) "ERROR")
            (= (str.split_at level_part ":" 0) "DEBUG")))

; Message should be non-empty and should not start with a space (since split_rest from 1)
(assert (>= (str.len msg_part) 1))
(assert (not (= (str.at msg_part 0) " ")))

; Timestamp structure checks using regex
; Date: YYYY-MM-DD
(assert (str.in_re date_part (re.++ (re.loop (str.to_re "0") 0 0) (str.to_re "") )))
; The above is a no-op placeholder avoidance is not needed, so provide the real constraint below
(assert (str.in_re date_part
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 4 4)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Time: HH:MM:SS
(assert (str.in_re time_part
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re ":")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re ":")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Further split date and time by '-' and ':' and interpret as integers
(assert (>= (str.num_splits date_part "-") 3))
(assert (= year_s (str.split_at date_part "-" 0)))
(assert (= month_s (str.split_at date_part "-" 1)))
(assert (= day_s (str.split_at date_part "-" 2)))

(assert (>= (str.num_splits time_part ":") 3))
(assert (= hour_s (str.split_at time_part ":" 0)))
(assert (= min_s (str.split_at time_part ":" 1)))
(assert (= sec_s (str.split_at time_part ":" 2)))

(assert (= year (str.to_int year_s)))
(assert (= month (str.to_int month_s)))
(assert (= day (str.to_int day_s)))
(assert (= hour (str.to_int hour_s)))
(assert (= minute (str.to_int min_s)))
(assert (= second (str.to_int sec_s)))

; Numeric range checks (simple validation)
(assert (and (>= year 1970) (<= year 2099)))
(assert (and (>= month 1) (<= month 12)))
(assert (and (>= day 1) (<= day 31)))
(assert (and (>= hour 0) (<= hour 23)))
(assert (and (>= minute 0) (<= minute 59)))
(assert (and (>= second 0) (<= second 59)))

; Cross-check that delimiter usage is plausible
(assert (>= (str.num_splits log_entry " ") 3))
(assert (= (str.len (str.split_at log_entry " " 0)) 10))
(assert (= (str.len (str.split_at log_entry " " 1)) 8))

; Ensure level_part has exactly one ':' at the end: i.e., splitting by ':' yields 2 segments and second is empty
(assert (= (str.num_splits level_part ":") 2))
(assert (= (str.split_at level_part ":" 1) ""))

; --- SAT instance anchoring: provide a concrete satisfiable example for log_entry ---
(assert (= log_entry "2024-01-09 13:45:07 INFO: service started"))

; --- UNSAT instance: an incompatible constraint set for bad_log_entry ---
; Intended: it claims to have level ERROR but also forces it to be INFO.
(assert (= bad_log_entry "2024-01-09 13:45:07 ERROR: something failed"))
(assert (>= (str.num_splits bad_log_entry " ") 3))
(assert (= bad_level_part (str.split_at (str.split_rest bad_log_entry " " 2) " " 0)))
(assert (str.suffixof ":" bad_level_part))
(assert (= (str.split_at bad_level_part ":" 0) "ERROR"))
(assert (= (str.split_at bad_level_part ":" 0) "INFO"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

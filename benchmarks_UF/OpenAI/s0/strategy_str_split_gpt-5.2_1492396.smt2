(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== SAT instance: structured log parsing ========== 
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts String)
(declare-const level_and_rest String)
(declare-const level_token String)
(declare-const msg String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Split log entry by spaces: "<date> <time> <LEVEL>: <message>"
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level_and_rest (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 3))

; Timestamp format validation: date and time shapes
(assert (str.in_re ts_date (str.to_re "2026-01-09")))
(assert (str.in_re ts_time (re.++ (re.range "0" "2") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9"))))
(assert (= ts (str.++ ts_date " " ts_time)))

; Further split time by ':' into hh:mm:ss
(assert (= hh (split_at ts_time ":" 0)))
(assert (= mm (split_at ts_time ":" 1)))
(assert (= ss (split_at ts_time ":" 2)))
(assert (= 3 (num_splits ts_time ":")))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Extract log level token from "LEVEL: ..." by splitting on ':'
(assert (= level_token (split_at level_and_rest ":" 0)))
(assert (>= (num_splits level_and_rest ":") 2))
(assert (str.in_re level_token (re.union (str.to_re "INFO")
                                         (re.union (str.to_re "WARN")
                                                   (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message is remainder after ':' (could start with a space)
(assert (= msg (split_rest level_and_rest ":" 1)))
(assert (>= (str.len msg) 1))

; Constrain a plausible concrete example to ensure SAT
(assert (= log_line "2026-01-09 12:34:56 INFO: disk check ok"))

(check-sat)

; ========== UNSAT instance: contradictory timestamp/level checks ========== 
(declare-const bad_log String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_and_rest String)
(declare-const bad_level String)

(assert (= bad_date (split_at bad_log " " 0)))
(assert (= bad_time (split_at bad_log " " 1)))
(assert (= bad_level_and_rest (split_rest bad_log " " 2)))
(assert (>= (num_splits bad_log " ") 3))

; Force a concrete bad log line
(assert (= bad_log "2026-13-40 99:99:99 TRACE: impossible"))

; Require a strict time regex that 99:99:99 cannot satisfy, plus require it equals the bad_time
(assert (str.in_re bad_time (re.++ (re.range "0" "2") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "5") (re.range "0" "9"))))

; Extract level; TRACE is not in the allowed set, but also require it equals extracted token
(assert (= bad_level (split_at bad_level_and_rest ":" 0)))
(assert (str.in_re bad_level (re.union (str.to_re "INFO")
                                       (re.union (str.to_re "WARN")
                                                 (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

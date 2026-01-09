(set-logic ALL)

; Uninterpreted functions for string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: log analysis parsing and validation
; =====================

(declare-const log_line_sat String)
(declare-const ts_part_sat String)
(declare-const rest_after_ts_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Split by single spaces: "<timestamp> <level>: <message>"
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_part_sat (split_at log_line_sat " " 0)))
(assert (= rest_after_ts_sat (split_rest log_line_sat " " 1)))
(assert (= level_sat (split_at rest_after_ts_sat " " 0)))
(assert (= msg_sat (split_rest rest_after_ts_sat " " 1)))

; Level should be "INFO:" | "WARN:" | "ERROR:" | "DEBUG:"
(assert (or (= level_sat "INFO:") (= level_sat "WARN:") (= level_sat "ERROR:") (= level_sat "DEBUG:")))

; Message must be non-empty and must not itself contain a newline
(assert (>= (str.len msg_sat) 1))
(assert (not (str.contains msg_sat "\n")))

; Timestamp format: YYYY-MM-DD:HH:MM:SS (split by colon)
(assert (>= (num_splits ts_part_sat ":") 4))
(assert (= date_sat (split_at ts_part_sat ":" 0)))
(assert (= hour_sat (split_at ts_part_sat ":" 1)))
(assert (= min_sat (split_at ts_part_sat ":" 2)))
(assert (= sec_sat (split_at ts_part_sat ":" 3)))
(assert (= time_sat (str.++ hour_sat ":" min_sat ":" sec_sat)))

; Validate date via regex: \d{4}-\d{2}-\d{2}
(assert (str.in_re date_sat (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")))))

; Validate time fields are exactly two digits
(assert (str.in_re hour_sat (re.++ ((_ re.loop 2 2) (re.range "0" "9")))))
(assert (str.in_re min_sat (re.++ ((_ re.loop 2 2) (re.range "0" "9")))))
(assert (str.in_re sec_sat (re.++ ((_ re.loop 2 2) (re.range "0" "9")))))

; Extra structural check: log line starts with the timestamp and a space
(assert (= log_line_sat (str.++ ts_part_sat " " rest_after_ts_sat)))

; Provide one concrete satisfiable witness to ensure SAT
(assert (= log_line_sat "2025-01-09:13:07:59 INFO: service started"))

; =====================
; UNSAT instance: conflicting constraints for log parsing
; =====================

(declare-const log_line_unsat String)
(declare-const ts_part_unsat String)
(declare-const rest_after_ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const hour_unsat String)
(declare-const min_unsat String)
(declare-const sec_unsat String)

(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_part_unsat (split_at log_line_unsat " " 0)))
(assert (= rest_after_ts_unsat (split_rest log_line_unsat " " 1)))
(assert (= level_unsat (split_at rest_after_ts_unsat " " 0)))

; Force a particular log line
(assert (= log_line_unsat "2025-01-09:13:07:59 INFO: bad"))

; Parse timestamp pieces
(assert (>= (num_splits ts_part_unsat ":") 4))
(assert (= date_unsat (split_at ts_part_unsat ":" 0)))
(assert (= hour_unsat (split_at ts_part_unsat ":" 1)))
(assert (= min_unsat (split_at ts_part_unsat ":" 2)))
(assert (= sec_unsat (split_at ts_part_unsat ":" 3)))

; Require level to be ERROR: but the concrete line has INFO:
(assert (= level_unsat "ERROR:"))

; Also require an impossible date shape (must contain a slash), contradicting the concrete date
(assert (str.contains date_unsat "/"))

; Additionally require hour to be 3 digits, contradicting the concrete time (and typical validation)
(assert (str.in_re hour_unsat (re.++ ((_ re.loop 3 3) (re.range "0" "9")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

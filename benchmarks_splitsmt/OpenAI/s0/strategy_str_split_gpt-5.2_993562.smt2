(set-logic ALL)

; Uninterpreted interface functions for split operations

; -----------------------------
; SAT instance: well-formed log parsing
; -----------------------------
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)
(declare-const date_re String)
(declare-const time_re String)
(declare-const level_re String)
(declare-const comp_re String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL Component: message..."
(assert (= ts_date_sat (str.split_at log_line_sat " " 0)))
(assert (= ts_time_sat (str.split_at log_line_sat " " 1)))
(assert (= level_sat   (str.split_at log_line_sat " " 2)))
(assert (= component_sat (str.split_at log_line_sat " " 3)))
(assert (= message_sat (str.split_rest log_line_sat " " 4)))
(assert (>= (str.num_splits log_line_sat " ") 5))

; Component ends with ':'
(assert (str.suffixof ":" component_sat))
(assert (>= (str.len component_sat) 2))

; Timestamp regex: date and time format checks
(assert (= date_re "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]"))
(assert (= time_re "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"))
(assert (str.in_re ts_date_sat (str.to_re date_re)))
(assert (str.in_re ts_time_sat (str.to_re time_re)))

; Further extraction of time parts
(assert (= hour_sat (str.split_at ts_time_sat ":" 0)))
(assert (= min_sat  (str.split_at ts_time_sat ":" 1)))
(assert (= sec_sat  (str.split_at ts_time_sat ":" 2)))
(assert (>= (str.num_splits ts_time_sat ":") 3))

; Log level is one of: INFO, WARN, ERROR, DEBUG
(assert (= level_re "(INFO|WARN|ERROR|DEBUG)"))
(assert (str.in_re level_sat (str.to_re level_re)))

; Component name pattern: letters/digits/underscore ending with ':'
(assert (= comp_re "[A-Za-z_][A-Za-z0-9_]*:"))
(assert (str.in_re component_sat (str.to_re comp_re)))

; Message basic sanity
(assert (>= (str.len message_sat) 1))
(assert (not (str.contains message_sat "\n")))

; Make the SAT instance concrete
(assert (= log_line_sat "2025-01-09 13:05:44 INFO AuthService: login ok"))

; -----------------------------
; UNSAT instance: contradictory parsing requirements
; -----------------------------
(declare-const log_line_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const level_unsat String)
(declare-const component_unsat String)
(declare-const message_unsat String)
(declare-const level_re2 String)
(declare-const time_re2 String)

(assert (= ts_date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_unsat   (str.split_at log_line_unsat " " 2)))
(assert (= component_unsat (str.split_at log_line_unsat " " 3)))
(assert (= message_unsat (str.split_rest log_line_unsat " " 4)))
(assert (>= (str.num_splits log_line_unsat " ") 5))

; Force a fixed (inconsistent) line
(assert (= log_line_unsat "2025-01-09 13:05:44 INFO AuthService: login ok"))

; Contradiction 1: time must match HH:MM:SS but also must not contain ':'
(assert (= time_re2 "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"))
(assert (str.in_re ts_time_unsat (str.to_re time_re2)))
(assert (not (str.contains ts_time_unsat ":")))

; Contradiction 2: level must be INFO but also must be ERROR
(assert (= level_re2 "INFO"))
(assert (str.in_re level_unsat (str.to_re level_re2)))
(assert (= level_unsat "ERROR"))

; Component must end with ':' but also must not contain ':'
(assert (str.suffixof ":" component_unsat))
(assert (not (str.contains component_unsat ":")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

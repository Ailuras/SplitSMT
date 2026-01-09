(set-logic ALL)

; Uninterpreted string-split interface

; =========================
; SAT instance: well-formed log parsing
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; =========================
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const message_sat String)

(declare-const y_sat String)
(declare-const m_sat String)
(declare-const d_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ss_sat String)

(assert (= date_sat (str.split_at log_line_sat " " 0)))
(assert (= time_sat (str.split_at log_line_sat " " 1)))
(assert (= level_colon_sat (str.split_at log_line_sat " " 2)))
(assert (= message_sat (str.split_rest log_line_sat " " 3)))
(assert (>= (str.num_splits log_line_sat " ") 4))

; Level extraction: "LEVEL:" then message begins after space
(assert (= level_sat (str.split_at level_colon_sat ":" 0)))
(assert (>= (str.num_splits level_colon_sat ":") 2))
(assert (= (str.split_at level_colon_sat ":" 1) ""))

; Timestamp validation via splitting
(assert (= y_sat (str.split_at date_sat "-" 0)))
(assert (= m_sat (str.split_at date_sat "-" 1)))
(assert (= d_sat (str.split_at date_sat "-" 2)))
(assert (= hh_sat (str.split_at time_sat ":" 0)))
(assert (= mm_sat (str.split_at time_sat ":" 1)))
(assert (= ss_sat (str.split_at time_sat ":" 2)))
(assert (= (str.num_splits date_sat "-") 3))
(assert (= (str.num_splits time_sat ":") 3))

; Length checks for fixed-width timestamp fields
(assert (= (str.len y_sat) 4))
(assert (= (str.len m_sat) 2))
(assert (= (str.len d_sat) 2))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Digit-only constraints using regex
(assert (str.in_re y_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re m_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re d_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Constrain numeric ranges (loose but meaningful)
(declare-const yi_sat Int)
(declare-const mi_sat Int)
(declare-const di_sat Int)
(declare-const hhi_sat Int)
(declare-const mmi_sat Int)
(declare-const ssi_sat Int)

(assert (= yi_sat (str.to_int y_sat)))
(assert (= mi_sat (str.to_int m_sat)))
(assert (= di_sat (str.to_int d_sat)))
(assert (= hhi_sat (str.to_int hh_sat)))
(assert (= mmi_sat (str.to_int mm_sat)))
(assert (= ssi_sat (str.to_int ss_sat)))

(assert (and (>= yi_sat 1970) (<= yi_sat 2099)))
(assert (and (>= mi_sat 1) (<= mi_sat 12)))
(assert (and (>= di_sat 1) (<= di_sat 31)))
(assert (and (>= hhi_sat 0) (<= hhi_sat 23)))
(assert (and (>= mmi_sat 0) (<= mmi_sat 59)))
(assert (and (>= ssi_sat 0) (<= ssi_sat 59)))

; Log level validation and message sanity
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))
(assert (>= (str.len message_sat) 1))
(assert (not (str.contains message_sat "\n")))

; Fix a concrete satisfying example
(assert (= log_line_sat "2025-01-09 07:05:30 INFO: service started"))

; =========================
; UNSAT instance: conflicting requirements for the same parsing constraints
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message..." but forced contradictions
; =========================
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)
(declare-const message_unsat String)

(declare-const y_unsat String)
(declare-const m_unsat String)
(declare-const d_unsat String)
(declare-const hh_unsat String)
(declare-const mm_unsat String)
(declare-const ss_unsat String)

(assert (= date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= time_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (str.split_at log_line_unsat " " 2)))
(assert (= message_unsat (str.split_rest log_line_unsat " " 3)))
(assert (>= (str.num_splits log_line_unsat " ") 4))

(assert (= level_unsat (str.split_at level_colon_unsat ":" 0)))
(assert (>= (str.num_splits level_colon_unsat ":") 2))
(assert (= (str.split_at level_colon_unsat ":" 1) ""))

(assert (= y_unsat (str.split_at date_unsat "-" 0)))
(assert (= m_unsat (str.split_at date_unsat "-" 1)))
(assert (= d_unsat (str.split_at date_unsat "-" 2)))
(assert (= hh_unsat (str.split_at time_unsat ":" 0)))
(assert (= mm_unsat (str.split_at time_unsat ":" 1)))
(assert (= ss_unsat (str.split_at time_unsat ":" 2)))
(assert (= (str.num_splits date_unsat "-") 3))
(assert (= (str.num_splits time_unsat ":") 3))

; Contradiction 1: y_unsat must be 4 digits but also equal to "20A5"
(assert (= (str.len y_unsat) 4))
(assert (str.in_re y_unsat (re.+ (re.range "0" "9"))))
(assert (= y_unsat "20A5"))

; Contradiction 2: level must be one of known set, but fixed to "TRACE"
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))
(assert (= level_unsat "TRACE"))

; Provide a concrete line (still should be inconsistent with constraints above)
(assert (= log_line_unsat "20A5-13-40 25:99:99 TRACE: impossible"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

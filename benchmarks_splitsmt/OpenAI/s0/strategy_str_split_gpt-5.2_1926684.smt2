(set-logic ALL)

; Uninterpreted split interface

; -----------------------------
; SAT instance: structured server log
; Format target (space-separated):
;   YYYY-MM-DDTHH:MM:SSZ <LEVEL>: <message>
; Example: 2025-01-09T13:05:59Z INFO: Service started
; -----------------------------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

(declare-const y_sat String)
(declare-const mo_sat String)
(declare-const d_sat String)
(declare-const hh_sat String)
(declare-const mi_sat String)
(declare-const ssZ_sat String)
(declare-const ss_sat String)

(assert (= log_line_sat "2025-01-09T13:05:59Z INFO: Service started"))

; Split by spaces: [timestamp, "INFO:", "Service", ...]
(assert (>= (str.num_splits log_line_sat " ") 3))
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= level_colon_sat (str.split_at log_line_sat " " 1)))
(assert (= msg_sat (str.split_rest log_line_sat " " 2)))

; Level extraction by splitting token like "INFO:" using ":"
(assert (>= (str.num_splits level_colon_sat ":") 2))
(assert (= level_sat (str.split_at level_colon_sat ":" 0)))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Timestamp structure checks
; ts = "YYYY-MM-DDTHH:MM:SSZ"
(assert (= (str.len ts_sat) 20))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) "T"))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))
(assert (= (str.at ts_sat 19) "Z"))

; Extract date/time components via split_at
(assert (>= (str.num_splits ts_sat "T") 2))
(assert (>= (str.num_splits ts_sat "-") 3))
(assert (= y_sat (str.split_at ts_sat "-" 0)))
(assert (= mo_sat (str.split_at ts_sat "-" 1)))
(assert (= d_sat (str.split_at (str.split_at ts_sat "T" 0) "-" 2)))
(assert (= hh_sat (str.split_at (str.split_at ts_sat "T" 1) ":" 0)))
(assert (= mi_sat (str.split_at (str.split_at ts_sat "T" 1) ":" 1)))
(assert (= ssZ_sat (str.split_at (str.split_at ts_sat "T" 1) ":" 2)))

(assert (>= (str.num_splits ssZ_sat "Z") 2))
(assert (= ss_sat (str.split_at ssZ_sat "Z" 0)))

; Length constraints for components
(assert (= (str.len y_sat) 4))
(assert (= (str.len mo_sat) 2))
(assert (= (str.len d_sat) 2))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mi_sat) 2))
(assert (= (str.len ss_sat) 2))

; Digit-only constraints for each component using regex
(assert (str.in_re y_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mo_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re d_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mi_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Numeric range checks using str.to_int (requires digit-only, satisfied above)
(declare-const y_i_sat Int)
(declare-const mo_i_sat Int)
(declare-const d_i_sat Int)
(declare-const hh_i_sat Int)
(declare-const mi_i_sat Int)
(declare-const ss_i_sat Int)
(assert (= y_i_sat (str.to_int y_sat)))
(assert (= mo_i_sat (str.to_int mo_sat)))
(assert (= d_i_sat (str.to_int d_sat)))
(assert (= hh_i_sat (str.to_int hh_sat)))
(assert (= mi_i_sat (str.to_int mi_sat)))
(assert (= ss_i_sat (str.to_int ss_sat)))
(assert (and (>= mo_i_sat 1) (<= mo_i_sat 12)))
(assert (and (>= d_i_sat 1) (<= d_i_sat 31)))
(assert (and (>= hh_i_sat 0) (<= hh_i_sat 23)))
(assert (and (>= mi_i_sat 0) (<= mi_i_sat 59)))
(assert (and (>= ss_i_sat 0) (<= ss_i_sat 59)))

; Message constraints
(assert (>= (str.len msg_sat) 1))
(assert (str.contains msg_sat "Service"))

(check-sat)

; -----------------------------
; UNSAT instance: conflicting checks on a malformed line
; Intentionally mismatched timestamp/level token constraints
; -----------------------------

(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_token_unsat String)
(declare-const level_unsat String)
(declare-const y_unsat String)
(declare-const mo_unsat String)
(declare-const d_unsat String)
(declare-const hh_unsat String)
(declare-const mi_unsat String)
(declare-const ssZ_unsat String)
(declare-const ss_unsat String)
(declare-const y_i_unsat Int)
(declare-const mo_i_unsat Int)
(declare-const d_i_unsat Int)
(declare-const hh_i_unsat Int)
(declare-const mi_i_unsat Int)
(declare-const ss_i_unsat Int)

; Malformed timestamp: uses space instead of 'T' and ends without 'Z'
(assert (= log_line_unsat "2025-01-09 13:05:59 INFO: Broken"))

(assert (>= (str.num_splits log_line_unsat " ") 3))
(assert (= ts_unsat (str.split_at log_line_unsat " " 0)))
(assert (= level_token_unsat (str.split_at log_line_unsat " " 2)))

; Require level token to be exactly "ERROR:" while the line has "INFO:" at position 2
(assert (= level_token_unsat "ERROR:"))
(assert (>= (str.num_splits level_token_unsat ":") 2))
(assert (= level_unsat (str.split_at level_token_unsat ":" 0)))
(assert (= level_unsat "ERROR"))

; Timestamp constraints that cannot hold for "2025-01-09" (length 10)
(assert (= (str.len ts_unsat) 20))
(assert (= (str.at ts_unsat 10) "T"))
(assert (= (str.at ts_unsat 19) "Z"))

; Attempt to parse components anyway and enforce strict ranges
(assert (>= (str.num_splits ts_unsat "T") 2))
(assert (>= (str.num_splits ts_unsat "-") 3))
(assert (= y_unsat (str.split_at ts_unsat "-" 0)))
(assert (= mo_unsat (str.split_at ts_unsat "-" 1)))
(assert (= d_unsat (str.split_at (str.split_at ts_unsat "T" 0) "-" 2)))
(assert (= hh_unsat (str.split_at (str.split_at ts_unsat "T" 1) ":" 0)))
(assert (= mi_unsat (str.split_at (str.split_at ts_unsat "T" 1) ":" 1)))
(assert (= ssZ_unsat (str.split_at (str.split_at ts_unsat "T" 1) ":" 2)))
(assert (>= (str.num_splits ssZ_unsat "Z") 2))
(assert (= ss_unsat (str.split_at ssZ_unsat "Z" 0)))

(assert (= y_i_unsat (str.to_int y_unsat)))
(assert (= mo_i_unsat (str.to_int mo_unsat)))
(assert (= d_i_unsat (str.to_int d_unsat)))
(assert (= hh_i_unsat (str.to_int hh_unsat)))
(assert (= mi_i_unsat (str.to_int mi_unsat)))
(assert (= ss_i_unsat (str.to_int ss_unsat)))

; Additional contradiction: force impossible month range
(assert (and (>= mo_i_unsat 13) (<= mo_i_unsat 12)))

(check-sat)
(exit)

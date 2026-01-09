(set-logic ALL)

; Uninterpreted interface operations for splitting

; Uninterpreted helpers for this scenario (non-primitive parsing/validation)
(declare-fun is_valid_timestamp (String) Bool)
(declare-fun is_valid_ip (String) Bool)
(declare-fun is_known_level (String) Bool)

; =========================
; SAT instance: consistent structured log entry
; Format (one possible):
;   "YYYY-MM-DD HH:MM:SS LEVEL component: message"
; Split by spaces to isolate timestamp date, time, level, etc.
; Split by ':' to isolate component and message
; =========================

(declare-const log_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const rest_after_level_sat String)
(declare-const comp_sat String)
(declare-const msg_sat String)
(declare-const comp_msg_sat String)

; Ensure at least 4 space-separated segments: date, time, level, and remainder
(assert (>= (str.num_splits log_sat " ") 4))
(assert (>= (str.num_splits log_sat ":") 2))

(assert (= date_sat (str.split_at log_sat " " 0)))
(assert (= time_sat (str.split_at log_sat " " 1)))
(assert (= level_sat (str.split_at log_sat " " 2)))
(assert (= rest_after_level_sat (str.split_rest log_sat " " 3)))

(assert (= ts_sat (str.++ date_sat " " time_sat)))

; Timestamp format validation via regex plus a semantic predicate
(assert (str.in_re date_sat (str.to_re (str.++ ""))))
(assert (str.in_re date_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re time_sat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))
(assert (is_valid_timestamp ts_sat))

; Level extraction checks
(assert (is_known_level level_sat))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Parse component/message around the first colon
(assert (= comp_sat (str.split_at rest_after_level_sat ":" 0)))
(assert (= msg_sat (str.split_rest rest_after_level_sat ":" 1)))
(assert (= comp_msg_sat (str.++ comp_sat ":" msg_sat)))
(assert (str.contains rest_after_level_sat ":"))

; Component constraints: non-empty and alphanumeric-ish with underscores/dashes
(assert (> (str.len comp_sat) 0))
(assert (str.in_re comp_sat (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "-"))))))))

; Message constraints: must mention status code pattern or keyword
(assert (or (str.contains msg_sat "status=") (str.contains msg_sat "timeout") (str.contains msg_sat "user=")))

; Provide concrete witness-like restrictions to keep it SAT
(assert (= date_sat "2025-01-09"))
(assert (= time_sat "13:05:07"))
(assert (= level_sat "INFO"))
(assert (= comp_sat "auth"))
(assert (= msg_sat " user=bob status=200"))
(assert (= log_sat (str.++ date_sat " " time_sat " " level_sat " " comp_sat ":" msg_sat)))

; =========================
; UNSAT instance: conflicting requirements on extracted log level
; =========================

(declare-const log_unsat String)
(declare-const level_unsat String)

(assert (>= (str.num_splits log_unsat " ") 3))
(assert (= level_unsat (str.split_at log_unsat " " 2)))

; Force two distinct levels simultaneously -> UNSAT
(assert (= level_unsat "ERROR"))
(assert (= level_unsat "INFO"))

; Also demand it be a known level (doesn't repair unsat, but adds realism)
(assert (is_known_level level_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

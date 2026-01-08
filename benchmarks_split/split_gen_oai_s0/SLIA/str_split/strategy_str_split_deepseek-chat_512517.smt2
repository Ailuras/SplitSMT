(set-logic ALL)

; Uninterpreted split interface (provided)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Uninterpreted helpers for log parsing
(declare-fun is_valid_timestamp (String) Bool)
(declare-fun is_valid_ipv4 (String) Bool)
(declare-fun is_log_level (String) Bool)

; -----------------------------
; SAT instance: consistent log analysis constraints
; Format (typical): "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; -----------------------------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const remainder_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= remainder_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Enforce timestamp structure via regex plus a semantic predicate
(assert (str.in_re date_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-")
                                  (re.range "0" "9") (re.range "0" "9") (str.to_re "-")
                                  (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re time_sat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "9") (re.range "0" "9"))))
(assert (is_valid_timestamp (str.++ date_sat " " time_sat)))

; Extract log level token before ':' by splitting the 3rd field by ':'
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (str.in_re level_sat (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))
(assert (is_log_level level_sat))

; Parse component and message from remainder: "component: message..."
(assert (= component_sat (split_at remainder_sat ":" 0)))
(assert (= message_sat (split_rest remainder_sat ":" 1)))
(assert (>= (num_splits remainder_sat ":") 2))

; Component is non-empty and alphanumeric/underscore/dash
(assert (>= (str.len component_sat) 1))
(assert (str.in_re component_sat (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))
                                      (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))))))

; Message constraints: must mention a keyword and have minimum length
(assert (>= (str.len message_sat) 10))
(assert (str.contains message_sat "request"))

; Concretize a satisfying example (still consistent with above constraints)
(assert (= log_line_sat "2025-01-07 13:45:02 INFO: auth: request accepted"))

; -----------------------------
; UNSAT instance: conflicting constraints for a malformed entry
; -----------------------------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)

(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 3))

; Require a valid-looking time, but also force an impossible length
(assert (str.in_re time_unsat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9"))))
(assert (= (str.len time_unsat) 7))

; Force extraction of level, but also force it to be non-level
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (str.in_re level_unsat (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))
(assert (not (is_log_level level_unsat)))

; Concretize a line that otherwise looks plausible
(assert (= log_line_unsat "2025-01-07 13:45:02 ERROR: db: request failed"))

; -----------------------------
; Additional SAT instance: log entry with IPv4 in message and colon-separated kv
; -----------------------------
(declare-const log_line2 String)
(declare-const date2 String)
(declare-const time2 String)
(declare-const level_colon2 String)
(declare-const level2 String)
(declare-const rest2 String)
(declare-const msg2 String)
(declare-const ip2 String)
(declare-const kv2 String)
(declare-const key2 String)
(declare-const val2 String)

(assert (= date2 (split_at log_line2 " " 0)))
(assert (= time2 (split_at log_line2 " " 1)))
(assert (= level_colon2 (split_at log_line2 " " 2)))
(assert (= rest2 (split_rest log_line2 " " 3)))
(assert (>= (num_splits log_line2 " ") 4))

(assert (is_valid_timestamp (str.++ date2 " " time2)))
(assert (= level2 (split_at level_colon2 ":" 0)))
(assert (is_log_level level2))

; Message part contains an IP and a kv token like "user:alice"
(assert (= msg2 rest2))
(assert (str.contains msg2 "ip="))
(assert (str.contains msg2 "user:"))

; Extract ip after "ip=" by splitting message on "ip=" then take first space token
(assert (= ip2 (split_at (split_rest msg2 "ip=" 1) " " 0)))
(assert (is_valid_ipv4 ip2))

; Extract first kv token after a space before "user:" occurrence (relaxed)
(assert (= kv2 (split_at (split_rest msg2 " " 1) " " 0)))
(assert (>= (num_splits kv2 ":") 2))
(assert (= key2 (split_at kv2 ":" 0)))
(assert (= val2 (split_at kv2 ":" 1)))
(assert (= key2 "user"))
(assert (>= (str.len val2) 1))

(assert (= log_line2 "2025-01-07 13:45:03 WARN: net: ip=192.168.0.10 user:alice request slow"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Uninterpreted helper functions (non-primitive)
(declare-fun is_valid_iso8601 (String) Bool)
(declare-fun is_known_level (String) Bool)

; -----------------------------
; SAT instance: consistent log parsing
; Format (space-separated):
;   <timestamp> <level>: <component>: <message>
; Example:
;   2026-01-09T12:34:56Z INFO: auth: login ok
; -----------------------------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const rest1_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const after_level_sat String)
(declare-const component_colon_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

; Split by spaces: timestamp then level-with-colon then the remainder
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= rest1_sat (split_rest log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 1)))
(assert (>= (num_splits log_line_sat " ") 3))

; Ensure level_with_colon is like "INFO:" by splitting on ":"
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (= "" (split_at level_colon_sat ":" 1)))
(assert (= 2 (num_splits level_colon_sat ":")))

; Remainder after the level: should start with <component>: <message>
(assert (= component_colon_sat (split_at rest1_sat " " 0)))
(assert (= after_level_sat (split_rest rest1_sat " " 1)))
(assert (>= (num_splits rest1_sat " ") 2))

; Component token must be like "auth:" (single trailing colon)
(assert (= component_sat (split_at component_colon_sat ":" 0)))
(assert (= "" (split_at component_colon_sat ":" 1)))
(assert (= 2 (num_splits component_colon_sat ":")))

; Message is the rest after component token
(assert (= message_sat after_level_sat))

; Timestamp validation via a regex (and optional uninterpreted checker)
(assert (str.in_re ts_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")
                               (str.to_re "-")
                               (re.range "0" "9") (re.range "0" "9")
                               (str.to_re "-")
                               (re.range "0" "9") (re.range "0" "9")
                               (str.to_re "T")
                               (re.range "0" "9") (re.range "0" "9")
                               (str.to_re ":")
                               (re.range "0" "9") (re.range "0" "9")
                               (str.to_re ":")
                               (re.range "0" "9") (re.range "0" "9")
                               (str.to_re "Z"))))
(assert (is_valid_iso8601 ts_sat))

; Level constraints and extraction checks
(assert (is_known_level level_sat))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Basic sanity for component and message
(assert (>= (str.len component_sat) 1))
(assert (not (str.contains component_sat " ")))
(assert (>= (str.len message_sat) 1))
(assert (str.contains message_sat " "))

; Provide one concrete satisfying example to anchor SAT
(assert (= log_line_sat "2026-01-09T12:34:56Z INFO: auth: login ok"))

(check-sat)

; -----------------------------
; UNSAT instance: conflicting constraints for log parsing
; Here we force a timestamp that matches ISO8601 regex but also violates it,
; and we force inconsistent split properties.
; -----------------------------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)
(declare-const rest_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 1)))
(assert (= rest_unsat (split_rest log_line_unsat " " 1)))
(assert (>= (num_splits log_line_unsat " ") 2))

; Force a well-formed timestamp by regex
(assert (str.in_re ts_unsat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "-")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "-")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "T")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re ":")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re ":")
                                 (re.range "0" "9") (re.range "0" "9")
                                 (str.to_re "Z"))))

; But also assert it is NOT valid via the uninterpreted predicate
(assert (not (is_valid_iso8601 ts_unsat)))

; Level extraction and contradictions: require both 2 splits and 3 splits on ':'
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (= 2 (num_splits level_colon_unsat ":")))
(assert (= 3 (num_splits level_colon_unsat ":")))

; Also force a concrete line that would normally be fine
(assert (= log_line_unsat "2026-01-09T12:34:56Z INFO: auth: ok"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
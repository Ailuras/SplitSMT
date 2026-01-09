(set-logic ALL)

; Uninterpreted split interface

; -----------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks: timestamp format validation and log level extraction.
; -----------------------------

; Common variables
(declare-const delim_space String)
(declare-const delim_colon String)
(assert (= delim_space " "))
(assert (= delim_colon ":"))

; =========
; SAT instance: well-formed log line
; Format (by spaces):
;   0: date "YYYY-MM-DD"
;   1: time "HH:MM:SS"
;   2: level (e.g., INFO)
;   3: component (e.g., auth)
;   4: message tail
; =========
(declare-const log_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const msg_sat String)

(assert (>= (str.num_splits log_sat delim_space) 5))
(assert (= date_sat (str.split_at log_sat delim_space 0)))
(assert (= time_sat (str.split_at log_sat delim_space 1)))
(assert (= level_sat (str.split_at log_sat delim_space 2)))
(assert (= component_sat (str.split_at log_sat delim_space 3)))
(assert (= msg_sat (str.split_rest log_sat delim_space 4)))

; Timestamp format checks (structural):
; date must be exactly 10 chars: YYYY-MM-DD with dashes at positions 4 and 7
(assert (= (str.len date_sat) 10))
(assert (= (str.at date_sat 4) "-"))
(assert (= (str.at date_sat 7) "-"))

; time must be exactly 8 chars: HH:MM:SS with colons at positions 2 and 5
(assert (= (str.len time_sat) 8))
(assert (= (str.at time_sat 2) ":"))
(assert (= (str.at time_sat 5) ":"))

; Decompose time by colons and require 3 segments
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)
(assert (>= (str.num_splits time_sat delim_colon) 3))
(assert (= hour_sat (str.split_at time_sat delim_colon 0)))
(assert (= min_sat (str.split_at time_sat delim_colon 1)))
(assert (= sec_sat (str.split_at time_sat delim_colon 2)))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Log level extraction: constrain to common levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Additional structural checks: component non-empty, message contains a colon-separated key-value somewhere
(assert (> (str.len component_sat) 0))
(assert (str.contains msg_sat ":"))

; Provide a concrete satisfiable example
(assert (= log_sat "2026-01-09 12:34:56 INFO auth user_id:42 login ok"))

(check-sat)

; =========
; UNSAT instance: contradictory timestamp constraints for a log line
; =========
(declare-const log_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_unsat String)

(assert (>= (str.num_splits log_unsat delim_space) 3))
(assert (= date_unsat (str.split_at log_unsat delim_space 0)))
(assert (= time_unsat (str.split_at log_unsat delim_space 1)))
(assert (= level_unsat (str.split_at log_unsat delim_space 2)))

; Intend date to be YYYY-MM-DD (len 10), but also force it to equal an 8-char string -> contradiction
(assert (= (str.len date_unsat) 10))
(assert (= date_unsat "20260109"))

; Intend time to be HH:MM:SS, but force wrong colon placement simultaneously
(assert (= (str.len time_unsat) 8))
(assert (= (str.at time_unsat 2) ":"))
(assert (= (str.at time_unsat 2) "-"))

; Any level, but constrain it anyway
(assert (or (= level_unsat "INFO") (= level_unsat "ERROR")))

; Give a plausible-looking log to ensure only constraints cause UNSAT
(assert (= log_unsat "20260109 12-34-56 INFO something"))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)

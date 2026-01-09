(set-logic ALL)

; Uninterpreted interface for split operations

; Scenario: Log Analysis
; Format target (example): "2026-01-09T12:34:56Z INFO: service: message"
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const payload String)
(declare-const service String)
(declare-const message String)

; Core structure preserved: use indexof/substr/contains and many nested boolean/ite checks
(declare-const ts_end Int)
(declare-const t_part String)

(assert (and
  ; basic presence checks (space-separated fields and colon markers)
  (not (= (ite (str.contains log_entry " ") 1 0) 0))
  (not (= (ite (str.contains log_entry ":") 1 0) 0))
  (not (not (= (ite (= (str.len log_entry) 0) 1 0) 0)))

  ; define split-derived pieces (uninterpreted but constrained)
  (= timestamp (str.split_at log_entry " " 0))
  (= level_with_colon (str.split_at log_entry " " 1))
  (= payload (str.split_rest log_entry " " 2))
  (>= (str.num_splits log_entry " ") 3)

  ; level_with_colon must end with ':' and level is level_with_colon without trailing ':'
  (>= (str.len level_with_colon) 2)
  (= (str.at level_with_colon (- (str.len level_with_colon) 1)) ":")
  (= level (str.substr level_with_colon 0 (- (str.len level_with_colon) 1)))

  ; level is one of common levels
  (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))

  ; payload must contain a service prefix followed by ':'
  (not (= (ite (str.contains payload ":") 1 0) 0))
  (= service (str.split_at payload ":" 0))
  (= message (str.split_rest payload ":" 1))
  (>= (str.num_splits payload ":") 2)
  (not (= (str.len service) 0))

  ; timestamp format validation using indexof/substr/at (YYYY-MM-DDThh:mm:ssZ)
  (= ts_end (str.len timestamp))
  (= t_part (str.substr timestamp 0 ts_end))
  (>= ts_end 20)
  (= (str.at t_part 4) "-")
  (= (str.at t_part 7) "-")
  (= (str.at t_part 10) "T")
  (= (str.at t_part 13) ":")
  (= (str.at t_part 16) ":")
  (= (str.at t_part 19) "Z")

  ; Ensure timestamp has no spaces and does not contain a colon prefix marker like "["
  (not (= (ite (str.contains timestamp " ") 1 0) 1))
  (not (not (= (ite (= (str.at timestamp 0) "[") 1 0) 0)))

  ; Mutated seed-like nested block: require timestamp to NOT contain any uppercase A..Q
  ; (keeps the "many nested (not (not (= (ite (str.contains ...) ...)))" structure)
  (and
    (not (not (= (ite (str.contains t_part "Q") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "P") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "O") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "N") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "M") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "L") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "K") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "J") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "I") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "H") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "G") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "F") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "E") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "D") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "C") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "B") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "A") 1 0) 0)))
  )

  ; bounds similar to seed style, but adapted
  (>= ts_end 0)
  (>= (str.indexof log_entry " " 0) 0)
  (>= (str.indexof payload ":" 0) 0)
  (>= (str.len message) 0)
))

; Add a deliberate UNSAT branch gated by a constant (forces inconsistency)
; Here, we assert timestamp ends with 'Z' above, and also assert it ends with 'X'.
(assert (= (str.at timestamp 19) "X"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

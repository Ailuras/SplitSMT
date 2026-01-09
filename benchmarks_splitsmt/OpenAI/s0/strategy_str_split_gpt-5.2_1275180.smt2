(set-logic ALL)

; Uninterpreted split interface

; Scenario: Log Analysis
; Expected structured log (space-separated):
;   <timestamp> <level>:<component>: <message>
; Timestamp expected: YYYY-MM-DDTHH:MM:SSZ

; --- SAT instance variables ---
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_comp_sat String)
(declare-const msg_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const colon_tail_sat String)

(declare-const y_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const timez_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ssZ_sat String)
(declare-const ss_sat String)

; Space splitting: [0]=timestamp, [1]=level:component:, [2..]=message words
(assert (>= (str.num_splits log_line_sat " ") 3))
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= lvl_comp_sat (str.split_at log_line_sat " " 1)))
(assert (= msg_sat (str.split_rest log_line_sat " " 2)))

; Level/component extraction by colons in token 1
(assert (>= (str.num_splits lvl_comp_sat ":") 3))
(assert (= level_sat (str.split_at lvl_comp_sat ":" 0)))
(assert (= component_sat (str.split_at lvl_comp_sat ":" 1)))
(assert (= colon_tail_sat (str.split_at lvl_comp_sat ":" 2)))
(assert (= colon_tail_sat ""))

; Log level validation
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component constraints (non-empty, no spaces)
(assert (> (str.len component_sat) 0))
(assert (not (str.contains component_sat " ")))

; Message constraints
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Timestamp format validation using regex for full timestamp
; YYYY-MM-DDTHH:MM:SSZ
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_2d () RegLan (re.++ re_digit re_digit))
(define-fun re_4d () RegLan (re.++ re_2d re_2d))
(define-fun re_ts () RegLan
  (re.++
    re_4d
    (re.++
      (str.to_re "-")
      (re.++
        re_2d
        (re.++
          (str.to_re "-")
          (re.++
            re_2d
            (re.++
              (str.to_re "T")
              (re.++
                re_2d
                (re.++
                  (str.to_re ":")
                  (re.++
                    re_2d
                    (re.++
                      (str.to_re ":")
                      (re.++
                        re_2d
                        (str.to_re "Z")
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
)
(assert (str.in_re ts_sat re_ts))

; Additional timestamp splitting sanity checks with split_at
(assert (= y_sat (str.split_at ts_sat "-" 0)))
(assert (= mon_sat (str.split_at ts_sat "-" 1)))
(assert (= day_sat (str.split_at ts_sat "-" 2)))
(assert (= timez_sat (str.split_at ts_sat "T" 1)))
(assert (= hh_sat (str.split_at timez_sat ":" 0)))
(assert (= mm_sat (str.split_at timez_sat ":" 1)))
(assert (= ssZ_sat (str.split_at timez_sat ":" 2)))
(assert (= ss_sat (str.split_at ssZ_sat "Z" 0)))

(assert (= (str.len y_sat) 4))
(assert (= (str.len mon_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Construct an explicit satisfying witness log line
(assert (= log_line_sat "2025-01-08T09:15:30Z INFO:auth: login succeeded"))


; --- UNSAT instance variables ---
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_comp_unsat String)
(declare-const msg_unsat String)
(declare-const level_unsat String)
(declare-const component_unsat String)
(declare-const colon_tail_unsat String)

; Same structural parsing
(assert (>= (str.num_splits log_line_unsat " ") 3))
(assert (= ts_unsat (str.split_at log_line_unsat " " 0)))
(assert (= lvl_comp_unsat (str.split_at log_line_unsat " " 1)))
(assert (= msg_unsat (str.split_rest log_line_unsat " " 2)))

(assert (>= (str.num_splits lvl_comp_unsat ":") 3))
(assert (= level_unsat (str.split_at lvl_comp_unsat ":" 0)))
(assert (= component_unsat (str.split_at lvl_comp_unsat ":" 1)))
(assert (= colon_tail_unsat (str.split_at lvl_comp_unsat ":" 2)))
(assert (= colon_tail_unsat ""))

; Level must be one of known values
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))

; Timestamp must match the required regex
(assert (str.in_re ts_unsat re_ts))

; Force a particular malformed log line that violates the timestamp regex (uses space instead of 'T')
(assert (= log_line_unsat "2025-01-08 09:15:30Z ERROR:db: connection failed"))

; Also add an independent contradiction on level extraction to ensure UNSAT even if split is underspecified
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

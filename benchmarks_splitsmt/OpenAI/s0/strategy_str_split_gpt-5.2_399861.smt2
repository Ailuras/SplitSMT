(set-logic ALL)

; Uninterpreted interface functions for str_split

; --- SAT instance: plausible structured log entry ---
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)

; Tokenization by space: "<timestamp> <level>: <message>"
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= level_sat (str.split_at log_line_sat " " 1)))
(assert (= msg_sat (str.split_rest log_line_sat " " 2)))
(assert (>= (str.num_splits log_line_sat " ") 3))

; Timestamp token is "YYYY-MM-DDTHH:MM:SS" (no timezone here)
(assert (= date_sat (str.split_at ts_sat "T" 0)))
(assert (= time_sat (str.split_at ts_sat "T" 1)))
(assert (= (str.num_splits ts_sat "T") 2))

; Date checks: YYYY-MM-DD with digit groups and basic ranges
(assert (= year_sat (str.split_at date_sat "-" 0)))
(assert (= month_sat (str.split_at date_sat "-" 1)))
(assert (= day_sat (str.split_at date_sat "-" 2)))
(assert (= (str.num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (= (str.len month_sat) 2))
(assert (str.in_re month_sat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (= (str.len day_sat) 2))
(assert (str.in_re day_sat (re.++ (re.range "0" "3") (re.range "0" "9"))))
(assert (let ((m (str.to_int month_sat))) (and (>= m 1) (<= m 12))))
(assert (let ((d (str.to_int day_sat))) (and (>= d 1) (<= d 31))))

; Time checks: HH:MM:SS with digit groups and ranges
(assert (= hour_sat (str.split_at time_sat ":" 0)))
(assert (= minute_sat (str.split_at time_sat ":" 1)))
(assert (= second_sat (str.split_at time_sat ":" 2)))
(assert (= (str.num_splits time_sat ":") 3))
(assert (= (str.len hour_sat) 2))
(assert (str.in_re hour_sat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (= (str.len minute_sat) 2))
(assert (str.in_re minute_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (= (str.len second_sat) 2))
(assert (str.in_re second_sat (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (let ((h (str.to_int hour_sat))) (and (>= h 0) (<= h 23))))
(assert (let ((mi (str.to_int minute_sat))) (and (>= mi 0) (<= mi 59))))
(assert (let ((s (str.to_int second_sat))) (and (>= s 0) (<= s 59))))

; Log level extraction: token like "INFO:" or "ERROR:" etc.
(assert (str.in_re level_sat (re.++ (re.union (str.to_re "INFO:") (str.to_re "WARN:") (str.to_re "ERROR:") (str.to_re "DEBUG:")) (re.* (str.to_re "")))))
; Ensure it ends with ':' and has at least 5 chars (e.g., "INFO:")
(assert (>= (str.len level_sat) 5))
(assert (= (str.at level_sat (- (str.len level_sat) 1)) ":"))

; Message constraints: non-empty and does not contain newline
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Provide a concrete satisfying witness shape
(assert (str.in_re log_line_sat
  (re.++
    (re.++
      (re.++
        (re.++
          (re.++
            (re.++ (re.+ (re.range "0" "9")) (str.to_re "-"))
            (re.+ (re.range "0" "9")))
          (str.to_re "T"))
        (re.+ (re.range "0" "9")))
      (str.to_re " "))
    (re.++ (re.union (str.to_re "INFO:") (str.to_re "WARN:") (str.to_re "ERROR:") (str.to_re "DEBUG:"))
           (re.++ (str.to_re " ") (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "_") (str.to_re "-") (str.to_re ".") (str.to_re "/"))))))))


; --- UNSAT instance: contradictory timestamp and level constraints ---
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const month_unsat String)
(declare-const hour_unsat String)

(assert (= ts_unsat (str.split_at log_line_unsat " " 0)))
(assert (= level_unsat (str.split_at log_line_unsat " " 1)))
(assert (= msg_unsat (str.split_rest log_line_unsat " " 2)))
(assert (>= (str.num_splits log_line_unsat " ") 3))

; Require a 'T' split
(assert (= date_unsat (str.split_at ts_unsat "T" 0)))
(assert (= time_unsat (str.split_at ts_unsat "T" 1)))
(assert (= (str.num_splits ts_unsat "T") 2))

; Month extracted but forced out of range (UNSAT when combined with range constraints)
(assert (= month_unsat (str.split_at date_unsat "-" 1)))
(assert (= (str.len month_unsat) 2))
(assert (str.in_re month_unsat (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (let ((m (str.to_int month_unsat))) (and (>= m 1) (<= m 12))))
(assert (= month_unsat "13"))

; Log level must be both INFO: and ERROR: simultaneously (UNSAT)
(assert (str.contains level_unsat "INFO:"))
(assert (str.contains level_unsat "ERROR:"))
(assert (= level_unsat "INFO:"))

; Hour extracted but forced invalid while also constrained valid
(assert (= hour_unsat (str.split_at time_unsat ":" 0)))
(assert (= (str.len hour_unsat) 2))
(assert (str.in_re hour_unsat (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (let ((h (str.to_int hour_unsat))) (and (>= h 0) (<= h 23))))
(assert (= hour_unsat "24"))

; Keep message non-empty to avoid trivial contradictions elsewhere
(assert (> (str.len msg_unsat) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

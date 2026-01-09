(set-logic ALL)

; Uninterpreted interface for string split operations

; ------------ SAT instance: valid-ish log parsing ------------
(declare-const log1 String)
(declare-const date1 String)
(declare-const time1 String)
(declare-const level1 String)
(declare-const message1 String)
(declare-const hh1 String)
(declare-const mm1 String)
(declare-const ss1 String)

; Overall structure: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (= date1 (str.split_at log1 " " 0)))
(assert (= time1 (str.split_at log1 " " 1)))
(assert (= level1 (str.split_at log1 " " 2)))
(assert (= message1 (str.split_rest log1 " " 3)))
(assert (>= (str.num_splits log1 " ") 4))

; date format: 4-2-2 digits with '-' separators
(assert (str.in_re date1 (re.++ (re.loop (re.range "0" "9") 4 4)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2))))

; time format: HH:MM:SS (2 digits each) using ':'
(assert (str.in_re time1 (re.++ (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2))))

; extract HH, MM, SS via split on ':'
(assert (= hh1 (str.split_at time1 ":" 0)))
(assert (= mm1 (str.split_at time1 ":" 1)))
(assert (= ss1 (str.split_at time1 ":" 2)))
(assert (>= (str.num_splits time1 ":") 3))

; constrain numeric ranges using string-to-int
(assert (str.in_re hh1 (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re mm1 (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re ss1 (re.loop (re.range "0" "9") 2 2)))
(assert (and (<= 0 (str.to_int hh1)) (<= (str.to_int hh1) 23)))
(assert (and (<= 0 (str.to_int mm1)) (<= (str.to_int mm1) 59)))
(assert (and (<= 0 (str.to_int ss1)) (<= (str.to_int ss1) 59)))

; log level token should end with ':' and contain only uppercase letters before ':'
(assert (str.in_re level1 (re.++ (re.+ (re.range "A" "Z")) (str.to_re ":"))))

; message exists and does not start with a space (basic sanity)
(assert (>= (str.len message1) 1))
(assert (not (= (str.at message1 0) " ")))

; Provide a concrete satisfying example (keeps this block SAT)
(assert (= log1 "2026-01-09 13:05:44 INFO: user=alice action=login ok"))

; ------------ UNSAT instance: contradictory checks for another log ------------
(declare-const log2 String)
(declare-const time2 String)
(declare-const hh2 String)

; Parse second token as time
(assert (= time2 (str.split_at log2 " " 1)))
(assert (>= (str.num_splits log2 " ") 2))

; Require HH:MM:SS shape, then force an impossible hour (>= 24) while also bounding to <= 23
(assert (str.in_re time2 (re.++ (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2))))
(assert (= hh2 (str.split_at time2 ":" 0)))
(assert (>= (str.num_splits time2 ":") 3))
(assert (str.in_re hh2 (re.loop (re.range "0" "9") 2 2)))
(assert (<= (str.to_int hh2) 23))
(assert (>= (str.to_int hh2) 24))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

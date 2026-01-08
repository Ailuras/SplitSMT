(set-logic ALL)

; Uninterpreted interface for string split reasoning

; Scenario: Log Analysis
; We parse log entries structured roughly as:
;   "YYYY-MM-DD HH:MM:SS LEVEL:message"
; Delimiters used: space " ", colon ":", dash "-"

; ----------------------
; SAT instance variables
; ----------------------
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time_and_rest String)
(declare-const ts_time String)
(declare-const level_and_msg String)
(declare-const level_token String)
(declare-const msg_token String)

(declare-const year String)
(declare-const month String)
(declare-const day String)

(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const level_len Int)

; Basic structural splitting by space
(assert (>= (str.num_splits log_line " ") 3))
(assert (= ts_date (str.split_at log_line " " 0)))
(assert (= ts_time (str.split_at log_line " " 1)))
(assert (= level_and_msg (str.split_rest log_line " " 2)))

; Further split LEVEL:message by colon
(assert (>= (str.num_splits level_and_msg ":") 2))
(assert (= level_token (str.split_at level_and_msg ":" 0)))
(assert (= msg_token (str.split_rest level_and_msg ":" 1)))

; Timestamp date validation via splitting YYYY-MM-DD
(assert (>= (str.num_splits ts_date "-") 3))
(assert (= year (str.split_at ts_date "-" 0)))
(assert (= month (str.split_at ts_date "-" 1)))
(assert (= day (str.split_at ts_date "-" 2)))

; Timestamp time validation via splitting HH:MM:SS
(assert (>= (str.num_splits ts_time ":") 3))
(assert (= hour (str.split_at ts_time ":" 0)))
(assert (= minute (str.split_at ts_time ":" 1)))
(assert (= second (str.split_at ts_time ":" 2)))

; Regex-based format checks
(assert (str.in_re year (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Ensure some plausible ranges using string comparisons via length + membership
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Constrain month to 01..12 and day to 01..31 using disjunctions
(assert (or (= month "01") (= month "02") (= month "03") (= month "04") (= month "05") (= month "06")
            (= month "07") (= month "08") (= month "09") (= month "10") (= month "11") (= month "12")))
(assert (or (= day "01") (= day "02") (= day "03") (= day "04") (= day "05") (= day "06") (= day "07") (= day "08") (= day "09")
            (= day "10") (= day "11") (= day "12") (= day "13") (= day "14") (= day "15") (= day "16") (= day "17") (= day "18") (= day "19")
            (= day "20") (= day "21") (= day "22") (= day "23") (= day "24") (= day "25") (= day "26") (= day "27") (= day "28") (= day "29")
            (= day "30") (= day "31")))

; Constrain hour 00..23, minute/second 00..59 (enumeration kept moderate)
(assert (or (= hour "00") (= hour "01") (= hour "02") (= hour "03") (= hour "04") (= hour "05") (= hour "06") (= hour "07") (= hour "08") (= hour "09")
            (= hour "10") (= hour "11") (= hour "12") (= hour "13") (= hour "14") (= hour "15") (= hour "16") (= hour "17") (= hour "18") (= hour "19")
            (= hour "20") (= hour "21") (= hour "22") (= hour "23")))
(assert (or (= minute "00") (= minute "01") (= minute "02") (= minute "03") (= minute "04") (= minute "05") (= minute "06") (= minute "07") (= minute "08") (= minute "09")
            (= minute "10") (= minute "11") (= minute "12") (= minute "13") (= minute "14") (= minute "15") (= minute "16") (= minute "17") (= minute "18") (= minute "19")
            (= minute "20") (= minute "21") (= minute "22") (= minute "23") (= minute "24") (= minute "25") (= minute "26") (= minute "27") (= minute "28") (= minute "29")
            (= minute "30") (= minute "31") (= minute "32") (= minute "33") (= minute "34") (= minute "35") (= minute "36") (= minute "37") (= minute "38") (= minute "39")
            (= minute "40") (= minute "41") (= minute "42") (= minute "43") (= minute "44") (= minute "45") (= minute "46") (= minute "47") (= minute "48") (= minute "49")
            (= minute "50") (= minute "51") (= minute "52") (= minute "53") (= minute "54") (= minute "55") (= minute "56") (= minute "57") (= minute "58") (= minute "59")))
(assert (or (= second "00") (= second "01") (= second "02") (= second "03") (= second "04") (= second "05") (= second "06") (= second "07") (= second "08") (= second "09")
            (= second "10") (= second "11") (= second "12") (= second "13") (= second "14") (= second "15") (= second "16") (= second "17") (= second "18") (= second "19")
            (= second "20") (= second "21") (= second "22") (= second "23") (= second "24") (= second "25") (= second "26") (= second "27") (= second "28") (= second "29")
            (= second "30") (= second "31") (= second "32") (= second "33") (= second "34") (= second "35") (= second "36") (= second "37") (= second "38") (= second "39")
            (= second "40") (= second "41") (= second "42") (= second "43") (= second "44") (= second "45") (= second "46") (= second "47") (= second "48") (= second "49")
            (= second "50") (= second "51") (= second "52") (= second "53") (= second "54") (= second "55") (= second "56") (= second "57") (= second "58") (= second "59")))

; Log level extraction constraints
(assert (= level_len (str.len level_token)))
(assert (>= level_len 3))
(assert (<= level_len 5))
(assert (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG")))

; Message sanity checks
(assert (>= (str.len msg_token) 1))
(assert (not (str.contains msg_token "\n")))

; Ensure that the overall line contains a colon introducing the message
(assert (str.contains log_line ":"))

; ------------------------
; UNSAT instance variables
; ------------------------
; A second log line constrained to be structurally valid, but with conflicting level constraints
(declare-const bad_log_line String)
(declare-const bad_level_and_msg String)
(declare-const bad_level_token String)
(declare-const bad_msg_token String)
(declare-const bad_ts_date String)
(declare-const bad_ts_time String)

(assert (>= (str.num_splits bad_log_line " ") 3))
(assert (= bad_ts_date (str.split_at bad_log_line " " 0)))
(assert (= bad_ts_time (str.split_at bad_log_line " " 1)))
(assert (= bad_level_and_msg (str.split_rest bad_log_line " " 2)))

(assert (>= (str.num_splits bad_level_and_msg ":") 2))
(assert (= bad_level_token (str.split_at bad_level_and_msg ":" 0)))
(assert (= bad_msg_token (str.split_rest bad_level_and_msg ":" 1)))

; Conflicting requirements: both INFO and ERROR simultaneously
(assert (= bad_level_token "INFO"))
(assert (= bad_level_token "ERROR"))

; Keep some additional plausible constraints (irrelevant due to conflict)
(assert (>= (str.len bad_msg_token) 1))
(assert (str.contains bad_log_line ":"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

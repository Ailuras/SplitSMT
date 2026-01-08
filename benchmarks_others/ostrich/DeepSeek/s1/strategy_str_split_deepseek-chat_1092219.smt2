; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)

; Declare string variables for log components
(declare-fun log_entry () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)
(declare-fun delimiter_space () String)
(declare-fun delimiter_colon () String)

; Declare integer variables for validation
(declare-fun year () Int)
(declare-fun month () Int)
(declare-fun day () Int)
(declare-fun hour () Int)
(declare-fun minute () Int)
(declare-fun second () Int)

; Declare boolean variables for checks
(declare-fun valid_timestamp_format () Bool)
(declare-fun valid_log_level () Bool)
(declare-fun overall_valid () Bool)

; Define delimiters
(assert (= delimiter_space " "))
(assert (= delimiter_colon ":"))

; Define split operations for log parsing
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Core log parsing constraints
(assert (= timestamp (split_at log_entry delimiter_space 0)))
(assert (= log_level (split_at log_entry delimiter_space 1)))
(assert (= message (split_rest log_entry delimiter_space 2)))
(assert (>= (num_splits log_entry delimiter_space) 3))

; Timestamp format validation: YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Extract timestamp components
(assert (= year (str.to_int (str.substr timestamp 0 4))))
(assert (= month (str.to_int (str.substr timestamp 5 2))))
(assert (= day (str.to_int (str.substr timestamp 8 2))))
(assert (= hour (str.to_int (str.substr timestamp 11 2))))
(assert (= minute (str.to_int (str.substr timestamp 14 2))))
(assert (= second (str.to_int (str.substr timestamp 17 2))))

; Validate timestamp ranges
(assert (and (>= year 2000) (<= year 2100)))
(assert (and (>= month 1) (<= month 12)))
(assert (and (>= day 1) (<= day 31)))
(assert (and (>= hour 0) (<= hour 23)))
(assert (and (>= minute 0) (<= minute 59)))
(assert (and (>= second 0) (<= second 59)))

; Combine timestamp validations
(assert (= valid_timestamp_format
    (and
        (= (str.len timestamp) 19)
        (= (str.at timestamp 4) "-")
        (= (str.at timestamp 7) "-")
        (= (str.at timestamp 10) " ")
        (= (str.at timestamp 13) ":")
        (= (str.at timestamp 16) ":")
        (>= year 2000) (<= year 2100)
        (>= month 1) (<= month 12)
        (>= day 1) (<= day 31)
        (>= hour 0) (<= hour 23)
        (>= minute 0) (<= minute 59)
        (>= second 0) (<= second 59)
    )
))

; Log level validation: Must be one of INFO, WARN, ERROR, DEBUG
(assert (= valid_log_level
    (or
        (= log_level "INFO")
        (= log_level "WARN")
        (= log_level "ERROR")
        (= log_level "DEBUG")
    )
))

; Message must not be empty
(assert (not (= message "")))

; Overall validation
(assert (= overall_valid (and valid_timestamp_format valid_log_level)))

; Create a SAT instance with specific constraints
(assert (= log_entry "2023-12-25 14:30:45 INFO User login successful"))
(assert overall_valid)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)

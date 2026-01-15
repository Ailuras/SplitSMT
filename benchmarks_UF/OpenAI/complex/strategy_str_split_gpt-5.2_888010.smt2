(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks: timestamp format validation and log level extraction.

(declare-const X String)
(declare-const delim_space String)
(declare-const delim_colon String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_full String)
(declare-const level String)
(declare-const component String)
(declare-const msg String)
(declare-const rest_after_ts String)
(declare-const rest_after_level String)
(declare-const rest_after_component String)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(assert (= delim_space " "))
(assert (= delim_colon ":"))

; Core structure preserved: keep the seed-style negative regex constraint, but adapt to log context
(assert (not (str.in_re X
  (re.++ (str.to_re "ConnectionUser-Agent:")
         (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))
         (str.to_re "www.fast-finder.com\u{a}")))))

; Split by spaces: expect at least 4 fields: timestamp, level, component:, message...
(assert (>= (num_splits X delim_space) 4))
(assert (= ts_full (split_at X delim_space 0)))
(assert (= level (split_at X delim_space 1)))
(assert (= component (split_at X delim_space 2)))
(assert (= msg (split_rest X delim_space 3)))

; Timestamp structured as YYYY-MM-DDTHH:MM:SSZ (no spaces)
(assert (= ts_date (split_at ts_full "T" 0)))
(assert (= ts_time (split_at ts_full "T" 1)))
(assert (= (num_splits ts_full "T") 2))
(assert (= (str.len ts_date) 10))
(assert (= (str.at ts_date 4) "-"))
(assert (= (str.at ts_date 7) "-"))

; Validate date digits where expected
(assert (str.in_re (str.substr ts_date 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_date 5 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_date 8 2) (re.+ (re.range "0" "9"))))

; Time part: HH:MM:SSZ
(assert (= (str.len ts_time) 9))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))
(assert (= (str.at ts_time 8) "Z"))
(assert (str.in_re (str.substr ts_time 0 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_time 3 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_time 6 2) (re.+ (re.range "0" "9"))))

; Log level extraction: must be one of common levels
(assert (str.in_re level (re.union (str.to_re "INFO")
                                  (re.union (str.to_re "WARN")
                                            (re.union (str.to_re "ERROR")
                                                      (str.to_re "DEBUG"))))))

; Component expected to end with ':' and have non-empty name before it
(assert (>= (str.len component) 2))
(assert (= (str.at component (- (str.len component) 1)) ":"))
(assert (not (= (str.substr component 0 (- (str.len component) 1)) "")))

; Message should not be empty and should not contain a newline
(assert (> (str.len msg) 0))
(assert (not (str.contains msg "\n")))

; Additional derived parsing: split rest by ':' to see if msg includes key:value pairs
(assert (= rest_after_ts (split_rest X delim_space 1)))
(assert (= rest_after_level (split_rest X delim_space 2)))
(assert (= rest_after_component (split_rest X delim_space 3)))

; Ensure the remainder after timestamp still contains the level and component token
(assert (str.contains rest_after_ts level))
(assert (str.contains rest_after_level component))

; Make a small UNSAT branch controlled by an explicit contradiction on log level length
; This forces an UNSAT instance when level is constrained to both INFO and ERROR.
(declare-const force_unsat Bool)
(assert (= force_unsat false))
(assert (=> force_unsat (and (= level "INFO") (= level "ERROR"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

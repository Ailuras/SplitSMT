(set-logic ALL)

; Scenario: Log Analysis
; Parse structured server log entries separated by spaces and colons.

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const logline String)
(declare-const timestamp String)
(declare-const level String)
(declare-const message String)
(declare-const datePart String)
(declare-const timePart String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Core structure preserved: keep a regex membership and a negated regex membership
(assert (str.in_re logline (re.++ (re.++ (str.to_re "EEE") re.allchar) re.allchar)))
(assert (not (str.in_re logline (re.++ (re.++ (str.to_re "EEEiii") (str.to_re "iii")) re.allchar))))

; Basic space-separated log format: "<timestamp> <LEVEL>: <message>"
(assert (= timestamp (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= message (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Require the level token to end with ':' and be one of common levels
(assert (str.in_re level (re.union (str.to_re "INFO:") (re.union (str.to_re "WARN:") (re.union (str.to_re "ERROR:") (str.to_re "DEBUG:"))))))

; Timestamp structure: "YYYY-MM-DDTHH:MM:SS"
(assert (= datePart (split_at timestamp "T" 0)))
(assert (= timePart (split_at timestamp "T" 1)))
(assert (= (num_splits timestamp "T") 2))

; Validate datePart with digits and separators
(assert (str.in_re datePart (re.++ (re.++ (re.++ (re.++ (re.loop (re.range "0" "9") 4 4) (str.to_re "-")) (re.loop (re.range "0" "9") 2 2)) (str.to_re "-")) (re.loop (re.range "0" "9") 2 2))))

; Validate timePart with digits and colons
(assert (str.in_re timePart (re.++ (re.++ (re.++ (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re ":")) (re.loop (re.range "0" "9") 2 2)) (str.to_re ":")) (re.loop (re.range "0" "9") 2 2))))

; Extract HH, MM, SS via split on ':'
(assert (= hour (split_at timePart ":" 0)))
(assert (= minute (split_at timePart ":" 1)))
(assert (= second (split_at timePart ":" 2)))
(assert (= (num_splits timePart ":") 3))

; Additional well-formedness checks
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; UNSAT twist: require an impossible minute token simultaneously
(assert (str.in_re minute (str.to_re "60")))
(assert (str.in_re minute (re.++ (re.range "0" "5") (re.range "0" "9"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
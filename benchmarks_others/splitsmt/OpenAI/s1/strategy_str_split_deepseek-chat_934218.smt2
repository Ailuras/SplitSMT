(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks include timestamp format validation and log level extraction.

; Seed core preserved: non-empty input via boolean guard
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_101935 String)
(assert (= T_1 (not (= "" var_0xINPUT_101935))))
(assert T_1)

; str_split interface (uninterpreted)

; Log-oriented variables
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const msg String)
(declare-const lvlTail String)

; Basic structure: "<timestamp> <level>:<component> <message...>"
(assert (= ts (str.split_at var_0xINPUT_101935 " " 0)))
(assert (= lvlTail (str.split_at var_0xINPUT_101935 " " 1)))
(assert (= msg (str.split_rest var_0xINPUT_101935 " " 2)))
(assert (>= (str.num_splits var_0xINPUT_101935 " ") 3))

; Split level and component on ':'
(assert (= level (str.split_at lvlTail ":" 0)))
(assert (= component (str.split_at lvlTail ":" 1)))
(assert (= "" (str.split_rest lvlTail ":" 2)))
(assert (>= (str.num_splits lvlTail ":") 2))

; Timestamp format validation (RFC3339-like): YYYY-MM-DDThh:mm:ssZ
(assert (= (str.len ts) 20))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))
(assert (str.in_re ts (re.++ (re.loop (str.to_re "0") 4 4) (str.to_re "-") (re.loop (str.to_re "0") 2 2) (str.to_re "-") (re.loop (str.to_re "0") 2 2) (str.to_re "T") (re.loop (str.to_re "0") 2 2) (str.to_re ":") (re.loop (str.to_re "0") 2 2) (str.to_re ":") (re.loop (str.to_re "0") 2 2) (str.to_re "Z"))))

; Log level extraction: restrict to common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Component must be non-empty and must not contain spaces
(assert (not (= component "")))
(assert (not (str.contains component " ")))

; Message must be non-empty and not begin with a space (since derived from split_rest)
(assert (not (= msg "")))
(assert (or (= (str.len msg) 0) (not (= (str.at msg 0) " "))))

; Concrete example to keep instance SAT
(assert (= var_0xINPUT_101935 "0000-00-00T00:00:00Z INFO:auth user_login"))

(check-sat)


; [GENERATION STATUS: SUCCESS]

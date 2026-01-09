(set-logic ALL)

; Log Analysis scenario: structured server log entries separated by spaces and colons

; Uninterpreted split interface

; Core variables
(declare-const X String)
(declare-const ts String)
(declare-const lvl String)
(declare-const hostField String)
(declare-const msg String)
(declare-const tDate String)
(declare-const tTime String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Preserve seed structure: keep characteristic membership constraints but adapt to log-analysis theme
(assert (not (str.in_re X (str.to_re "Host:toUser-Agent:ClientsConnected-\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "log={IP:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Pcast") (re.+ (re.range "0" "9")) (str.to_re "Host:ohgdhkzfhdzo/uwpOK\u{d}\u{a}Host:HWAEname.cnnic.cnRXnewads1.com\u{a}")))))

; Require X to contain a plausible log prefix with timestamp and level
(assert (str.contains X " "))
(assert (>= (str.num_splits X " ") 4))
(assert (= ts (str.split_at X " " 0)))
(assert (= lvl (str.split_at X " " 1)))
(assert (= hostField (str.split_at X " " 2)))
(assert (= msg (str.split_rest X " " 3)))

; Timestamp expected format: YYYY-MM-DDTHH:MM:SS
(assert (>= (str.num_splits ts "T") 2))
(assert (= tDate (str.split_at ts "T" 0)))
(assert (= tTime (str.split_at ts "T" 1)))

(assert (>= (str.num_splits tDate "-") 3))
(assert (= year (str.split_at tDate "-" 0)))
(assert (= month (str.split_at tDate "-" 1)))
(assert (= day (str.split_at tDate "-" 2)))

(assert (>= (str.num_splits tTime ":") 3))
(assert (= hour (str.split_at tTime ":" 0)))
(assert (= minute (str.split_at tTime ":" 1)))
(assert (= second (str.split_at tTime ":" 2)))

; Regex helpers for digits
(define-fun reDigit () RegLan (re.range "0" "9"))
(define-fun re2Digits () RegLan (re.++ reDigit reDigit))
(define-fun re4Digits () RegLan (re.++ re2Digits re2Digits))

; Timestamp components validation
(assert (str.in_re year re4Digits))
(assert (str.in_re month re2Digits))
(assert (str.in_re day re2Digits))
(assert (str.in_re hour re2Digits))
(assert (str.in_re minute re2Digits))
(assert (str.in_re second re2Digits))

; Accept only common log levels
(assert (str.in_re lvl (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Structured host field: "host:<token>"
(assert (str.in_re hostField (re.++ (str.to_re "host:") (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "-"))))))))

; Message must mention a key/value with colon to exercise parsing-by-colon scenario
(assert (str.contains msg ":"))

; UNSAT instance: force X to be exactly a long seed-like string that cannot satisfy the required timestamp prefix
(assert (str.in_re X (str.to_re "From:X-Mailer:\u{13}backtrust.comReferer:Supremewjpropqmlpohj/loLogsX-FILTERED-BY-GHOST:\u{a}")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

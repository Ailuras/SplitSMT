(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Uninterpreted split interface

; Log line and extracted fields
(declare-const logline String)
(declare-const ts String)          ; timestamp token (first space-separated field)
(declare-const levelTok String)    ; level token like "INFO:"
(declare-const level String)       ; extracted level without trailing ':'
(declare-const msg String)         ; rest of line after first two tokens
(declare-const levelHead String)
(declare-const levelTail String)

; Preserve core structure: keep two negative regex membership constraints (mutated)
(assert (not (str.in_re logline (str.to_re "MyAgentprotocolprotocolHost:/s(robert@blackcastlesoft.com)data2.activshopper.com\u{a}"))))
(assert (not (str.in_re logline (re.++ (str.to_re "//download.asp?p=") (re.range "0" "9") (str.to_re "/Ui\u{a}")))))

; Core split structure: space-separated tokens
(assert (= ts (str.split_at logline " " 0)))
(assert (= levelTok (str.split_at logline " " 1)))
(assert (= msg (str.split_rest logline " " 2)))
(assert (>= (str.num_splits logline " ") 3))

; Timestamp validation: YYYY-MM-DDTHH:MM:SSZ
; (simplified: fixed length and each position is a digit or a fixed separator)
(assert (= (str.len ts) 20))
(assert (str.in_re (str.at ts 0) (re.range "0" "9")))
(assert (str.in_re (str.at ts 1) (re.range "0" "9")))
(assert (str.in_re (str.at ts 2) (re.range "0" "9")))
(assert (str.in_re (str.at ts 3) (re.range "0" "9")))
(assert (= (str.at ts 4) "-"))
(assert (str.in_re (str.at ts 5) (re.range "0" "9")))
(assert (str.in_re (str.at ts 6) (re.range "0" "9")))
(assert (= (str.at ts 7) "-"))
(assert (str.in_re (str.at ts 8) (re.range "0" "9")))
(assert (str.in_re (str.at ts 9) (re.range "0" "9")))
(assert (= (str.at ts 10) "T"))
(assert (str.in_re (str.at ts 11) (re.range "0" "9")))
(assert (str.in_re (str.at ts 12) (re.range "0" "9")))
(assert (= (str.at ts 13) ":"))
(assert (str.in_re (str.at ts 14) (re.range "0" "9")))
(assert (str.in_re (str.at ts 15) (re.range "0" "9")))
(assert (= (str.at ts 16) ":"))
(assert (str.in_re (str.at ts 17) (re.range "0" "9")))
(assert (str.in_re (str.at ts 18) (re.range "0" "9")))
(assert (= (str.at ts 19) "Z"))

; Log level extraction: token is LEVEL: (colon-terminated)
(assert (= (str.at levelTok (- (str.len levelTok) 1)) ":"))
(assert (= (str.split_at levelTok ":" 0) level))
(assert (>= (str.num_splits levelTok ":") 2))

; Level must be one of common severities
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message should contain a module prefix "mod:" somewhere (colon-separated key)
(assert (str.contains msg "mod:"))

; Additional colon parsing within message: ensure at least one ':' split exists
(assert (>= (str.num_splits msg ":") 2))

; UNSAT twist: contradict extracted level by forcing it to be both INFO and ERROR
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

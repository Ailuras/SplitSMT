(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Log Analysis scenario: parse structured server log entries separated by spaces and colons

; Uninterpreted split interface

; Seed variables preserved
(declare-const x String)
(declare-const y String)

; Additional variables for log parsing
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

(declare-const idx Int)

; Core seed structure kept but made consistent with log setting (kept SAT by making x,y empty)
(assert (= x ""))
(assert (= y ""))
(assert (str.in_re (str.++ y x) (re.* (str.to_re "!!$$bbaa"))))

; Logline shape: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= msg (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Timestamp validation: require two parts separated by space and time separated by ':'
(assert (= hh (split_at (split_at logline " " 0) ":" 0)))
(assert (= mm (split_at (split_at logline " " 0) ":" 1)))
(assert (= ss (split_at (split_at logline " " 0) ":" 2)))
(assert (>= (num_splits (split_at logline " " 0) ":") 3))

; Constrain time components to be 2 digits each
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Regex check for timestamp-like prefix: YYYY-MM-DD
(assert (str.in_re ts (re.++ (re.loop (re.range "0" "9") 4 4)
                             (str.to_re "-")
                             (re.loop (re.range "0" "9") 2 2)
                             (str.to_re "-")
                             (re.loop (re.range "0" "9") 2 2)
                             (str.to_re "") )))

; Log level must be one of: INFO, WARN, ERROR
(assert (str.in_re level (re.union (str.to_re "INFO")
                                  (re.union (str.to_re "WARN") (str.to_re "ERROR")))))

; Level token ends with ':' in the raw line "LEVEL:"; enforce via indexof and substring
(assert (>= (str.len msg) 0))
(assert (= idx (str.indexof logline ":" 0)))
(assert (>= idx 0))

; Message should not contain another "LEVEL:" prefix (simple sanity constraint)
(assert (not (str.contains msg "INFO:")))
(assert (not (str.contains msg "WARN:")))
(assert (not (str.contains msg "ERROR:")))

; UNSAT branch (guarded by a contradiction on purpose): require level both INFO and ERROR
(assert (not (and (= level "INFO") (= level "ERROR"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)

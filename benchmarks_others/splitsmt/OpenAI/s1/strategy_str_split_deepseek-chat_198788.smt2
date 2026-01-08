(set-logic ALL)

; --- Uninterpreted interface for string splitting ---

; --- Log analysis scenario variables ---
(declare-const X String)              ; entire log line
(declare-const ts String)             ; timestamp token
(declare-const level String)          ; log level token
(declare-const component String)      ; component token
(declare-const msg String)            ; remainder message
(declare-const datePart String)
(declare-const timePart String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Preserve core structure: keep the original negated membership constraint
(assert (not (str.in_re X (re.++
  (str.to_re "Spy")
  (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
  (str.to_re "\u{d}\u{a}")
  (re.* re.allchar)
  (str.to_re "YAHOOdestroyed!Host:\u{a}")
))))

; --- Tokenization by spaces: "<timestamp> <level> <component>: <message...>" ---
(assert (>= (str.num_splits X " ") 4))
(assert (= ts (str.split_at X " " 0)))
(assert (= level (str.split_at X " " 1)))
(assert (= component (str.split_at X " " 2)))
(assert (= msg (str.split_rest X " " 3)))

; Component token should contain a trailing ':' like "auth:" and message should be non-empty
(assert (str.in_re component (re.++ (re.+ re.allchar) (str.to_re ":"))))
(assert (>= (str.len msg) 1))

; --- Log level extraction and restriction ---
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; --- Timestamp format validation: "YYYY-MM-DDTHH:MM:SS" (basic structural checks) ---
(assert (>= (str.num_splits ts "T") 2))
(assert (= datePart (str.split_at ts "T" 0)))
(assert (= timePart (str.split_at ts "T" 1)))

; datePart: 3 splits by '-' -> YYYY, MM, DD
(assert (= 3 (str.num_splits datePart "-")))
(assert (= 4 (str.len (str.split_at datePart "-" 0))))
(assert (= 2 (str.len (str.split_at datePart "-" 1))))
(assert (= 2 (str.len (str.split_at datePart "-" 2))))

; timePart: 3 splits by ':' -> HH, MM, SS
(assert (= 3 (str.num_splits timePart ":")))
(assert (= hh (str.split_at timePart ":" 0)))
(assert (= mm (str.split_at timePart ":" 1)))
(assert (= ss (str.split_at timePart ":" 2)))
(assert (= 2 (str.len hh)))
(assert (= 2 (str.len mm)))
(assert (= 2 (str.len ss)))

; Digit-only constraints using regex
(assert (str.in_re (str.split_at datePart "-" 0) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.split_at datePart "-" 1) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.split_at datePart "-" 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Additional log-structure checks
(assert (str.contains X level))
(assert (not (str.contains msg "\n")))

; --- Create an UNSAT side-condition (conflicting requirements on log level) ---
(assert (and (= level "INFO") (= level "ERROR")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
